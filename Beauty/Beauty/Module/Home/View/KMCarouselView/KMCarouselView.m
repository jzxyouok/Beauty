//
//  KMCarouselView.m
//  Beauty
//
//  Created by SoloKM on 15/11/28.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width

#define MIN_MOVING_TIMEINTERVAL       0.1 //最小滚动时间间隔
#define DEFAULT_MOVING_TIMEINTERVAL   3.0 //默认滚动时间间隔
#import "KMCarouselCell.h"
#import "KMCarouselView.h"
#import <UIImageView+WebCache.h>

@interface KMCarouselView()<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,getter=isNeedRefresh) BOOL needRefresh;

@end


NSString *const cellID = @"KMCarouselCell";

@implementation KMCarouselView
@synthesize imageURLs = _imageURLs;

#pragma mark - Life Cycle

- (void)awakeFromNib
{
    self.delegate = self;
    self.dataSource = self;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    if ([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]])
    {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
    }
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([KMCarouselCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
    [self registerNofitication];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isNeedRefresh)
    {
        //最左边一张图其实是最后一张图，因此移动到第二张图，也就是imageURL的第一个URL的图。
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        self.needRefresh = NO;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public Method

- (void)startMoving
{
    [self addTimer];
}

- (void)stopMoving
{
    [self removeTimer];
}

#pragma mark - Private Method


- (void)addTimer
{
    [self removeTimer];
    NSTimeInterval speed = self.movingTimeInterval < MIN_MOVING_TIMEINTERVAL ? DEFAULT_MOVING_TIMEINTERVAL : self.movingTimeInterval;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:speed target:self selector:@selector(moveToNextPage) userInfo:nil repeats:YES];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)moveToNextPage
{
    CGPoint newContentOffset = (CGPoint){self.contentOffset.x + SCREEN_WIDTH,0};
    [self setContentOffset:newContentOffset animated:YES];
}

- (void)adjustCurrentPage:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / SCREEN_WIDTH - 1;
    
    if (scrollView.contentOffset.x < SCREEN_WIDTH)
    {
        page = [self.imageURLs count] - 3;
    }
    else if (scrollView.contentOffset.x > SCREEN_WIDTH * ([self.imageURLs count] - 1))
    {
        page = 0;
    }
    if ([self.pageDelegate respondsToSelector:@selector(carousel:didMoveToPage:)])
    {
        [self.pageDelegate carousel:self didMoveToPage:page];
    }
}

- (void)registerNofitication
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}


#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return MAX([self.imageURLs count],1);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KMCarouselCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    if (![self.imageURLs count])
    {
        [cell.imagView setImage:self.placeholder];
        return cell;
    }
    
    [cell.imagView sd_setImageWithURL:[self.imageURLs objectAtIndex:indexPath.item] placeholderImage:self.placeholder];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger page = 0;
    NSUInteger lastIndex = [self.imageURLs count] - 3;
    
    if (indexPath.item == 0)
    {
        page = lastIndex;
    }
    else if (indexPath.item == lastIndex)
    {
        page = 0;
    }
    else
    {
        page = indexPath.item - 1;
    }
    if ([self.pageDelegate respondsToSelector:@selector(carousel:didTouchPage:)])
    {
        [self.pageDelegate carousel:self didTouchPage:page];
    }
}


#pragma mark - UIScrollerViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == ([self.imageURLs count] - 1) * SCREEN_WIDTH )
    {
        [self setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    }
    
    //轮播滚动的时候 移动到了哪一页
    [self adjustCurrentPage:scrollView];
    
}

//用户手动拖拽，暂停一下自动轮播
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

//用户拖拽完成，恢复自动轮播（如果需要的话）并依据滑动方向来进行相对应的界面变化
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.isAutoMoving)
    {
        [self addTimer];
    }
    
    //向左滑动时切换imageView
    if (scrollView.contentOffset.x < SCREEN_WIDTH )
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self.imageURLs count] - 2 inSection:0];
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    
    //向右滑动时切换imageView
    if (scrollView.contentOffset.x  > ([self.imageURLs count] - 1) * SCREEN_WIDTH - 10)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    
    //用户手动拖拽的时候 移动到了哪一页
    [self adjustCurrentPage:scrollView];
    
}


#pragma mark - Notification
//程序被暂停的时候，应该停止计时器
- (void)applicationWillResignActive
{
    [self stopMoving];
}

//程序从暂停状态回归的时候，重新启动计时器
- (void)applicationDidBecomeActive
{
    if (self.isAutoMoving)
    {
        [self startMoving];
    }
}

#pragma mark - Getter and Setter

- (NSArray *)imageURLs
{
    if (!_imageURLs)
    {
        _imageURLs = [NSArray array];
    }
    return _imageURLs;
}

- (void)setImageURLs:(NSArray *)imageURLs
{
    _imageURLs = imageURLs;
    if ([imageURLs count])
    {
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:[imageURLs lastObject]];
        [arr addObjectsFromArray:imageURLs];
        [arr addObject:[imageURLs firstObject]];
        _imageURLs = [NSArray arrayWithArray:arr];
    }
    [self reloadData];
    _needRefresh = YES;
}
@end