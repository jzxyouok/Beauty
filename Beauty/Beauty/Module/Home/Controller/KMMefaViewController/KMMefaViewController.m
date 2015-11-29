//
//  KMMefaViewController.m
//  Beauty
//
//  Created by SoloKM on 15/11/28.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#import "KMMefaViewController.h"
#import "KMProductsViewController.h"
#import "KMLayoutTools.h"
@interface KMMefaViewController ()<UIScrollViewDelegate>

/** 头部 */
@property (weak, nonatomic) UISegmentedControl *header;
/** 选项卡 */
@property (weak, nonatomic) UIView *checkView;
@property (weak, nonatomic)  UIScrollView *scrollView;

@end

@implementation KMMefaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNav];
    
    [self setupChildVcs];
    [self setupScrollView];
    [self setupHeader];
    [self setupCheckView];
    self.view.backgroundColor = [UIColor yellowColor];

}
- (void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.frame = CGRectMake(0, 64 , self.view.width, self.view.height);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    [self.view addSubview:scrollView];
    
    self.scrollView = scrollView;
    
    // 指定默认现实的控制器
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
- (void)setupChildVcs
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =  CGSizeMake(ScreenW * 0.5 - 3, 150);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
  
    KMProductsViewController *vc = [[KMProductsViewController alloc] initWithCollectionViewLayout:layout];
    [self addChildViewController:vc];

    KMProductsViewController *vc2 = [[KMProductsViewController alloc] initWithCollectionViewLayout:[KMLayoutTools chooseLayoutWithCol:2 height:150 space:2]];
    
    [self addChildViewController:vc2];
}

- (void) setupNav
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"icon_ad" highImage:@"icon_ad" target:self action:@selector(leftBtnClick)];

}
- (void) setupHeader{
    NSArray *segmentedArray = @[@"发型",@"设计师"];
   UISegmentedControl *header = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    self.header = header;
    self.header.backgroundColor = kGlobalTitleColor;
    self.header.tintColor = [UIColor whiteColor];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [self.header setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    [self.header addTarget:self action:@selector(headerChange) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.header;
    [self.header setSelectedSegmentIndex:0];
}
- (void)setupCheckView
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0,0, ScreenW, 44);
    view.backgroundColor = [UIColor redColor];
    self.checkView = view;

    [self.scrollView addSubview:view];
    UIView *view2 = [[UIView alloc] init];
    view2.frame = CGRectMake(ScreenW,0, ScreenW, 44);
    view2.backgroundColor = [UIColor orangeColor];
     [self.scrollView addSubview:view2];
}

#pragma mark - 事件

- (void)headerChange
{
   CGPoint point = CGPointMake(self.header.selectedSegmentIndex * self.scrollView.width, 0);
    [self.scrollView setContentOffset:point animated:YES];
}

- (void)leftBtnClick
{
    LogFunc;
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    int index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *willShowChildVc = self.childViewControllers[index];
    
    // 如果控制器的view已经被创建过，就直接返回,避免重复加载
    
    if (willShowChildVc.isViewLoaded) return;

    CGRect frame = scrollView.bounds;
    
    frame.origin.y += 44;
    
    willShowChildVc.view.frame = frame;
    [scrollView addSubview:willShowChildVc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    int index = scrollView.contentOffset.x / scrollView.width;
    self.header.selectedSegmentIndex = index;
}

@end
