//
//  KMHomeViewController.m
//  Beauty
//
//  Created by SoloKM on 15/11/28.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//


#import "KMHomeViewController.h"
#import "KMCarouselView.h"
#import "KMMefaViewController.h"
#import "KMHomeTypeView.h"
#import "KMHomeItem.h"
@interface KMHomeViewController ()<KMCarouselDelegate,KMHomeTypeViewDelegate>

@property (weak, nonatomic) IBOutlet KMCarouselView *carouselView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet KMHomeTypeView *typeView;

/** 数据 */
@property (nonatomic ,copy) NSArray *types;
@end

@implementation KMHomeViewController
- (NSArray *)types
{
    if (_types == nil) {
        
        KMHomeItem *meifa = [[KMHomeItem alloc] init];
        meifa.title = @"美发";
        meifa.image =[UIImage imageNamed:@"main_v3_icon_knife"];
        meifa.count = @"137款发型";
        
        
        KMHomeItem *meijia= [[KMHomeItem alloc] init];
        meijia.title = @"美甲";
        meijia.image =[UIImage imageNamed:@"main_v3_icon_zhijia"];
        meijia.count = @"777款作品";
        
        
        KMHomeItem *meizhuang = [[KMHomeItem alloc] init];
        meizhuang.title = @"美妆";
        meizhuang.image =[UIImage imageNamed:@"main_v3_icon_huazhuang"];
        meizhuang.count = @"137款美妆";
        
        
        KMHomeItem *meijie = [[KMHomeItem alloc] init];
        meijie.title = @"美睫";
        meijie.image =[UIImage imageNamed:@"main_v3_icon_jiemao"];
        meijie.count = @"14款作品";
        
        NSArray *arry = @[meifa,meijie,meizhuang,meijie];
        
        _types = [arry copy];
    }
    
    return _types;
    
}


#pragma mark - 生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCarouselView];
    [self setupPageControl];
    [self setupNav];
    [self setupTypeView];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
}



-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void) setupNav

{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"main_v3_icon_address" highImage:@"icon_ad" target:self action:@selector(leftBtnClick)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_v3_icon_logo"]];
    
}
- (void) setupTypeView
{
    self.typeView.TypeViewdelegate = self;
    self.typeView.types = self.types;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.carouselView startMoving];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.carouselView stopMoving];
}

#pragma mark - 按钮点击
- (void)leftBtnClick
{
    LogFunc;
}

 
#pragma mark - Private Method

- (void)setupCarouselView
{
    self.carouselView.imageURLs = [self imageURLs];
    self.carouselView.placeholderImage = [UIImage imageNamed:@"main_v3_icon_loadding_default"];
    self.carouselView.pageDelegate = self;
    self.carouselView.autoMoving = YES;
    self.carouselView.movingTimeInterval = 2.0f;
    
}

- (void)setupPageControl
{
    self.pageControl.numberOfPages = [[self imageURLs] count];
    self.pageControl.pageIndicatorTintColor  = kGlobalTitleColor;
    
}

- (NSArray *)imageURLs
{
    NSString *image1 = @"http://tupian.enterdesk.com/2015/gha/11/2705/02.jpg";
    NSString *image2 =@"http://d.hiphotos.baidu.com/zhidao/pic/item/c83d70cf3bc79f3ddbb74c91bba1cd11728b2938.jpg";
    return @[[NSURL URLWithString:image1],
             [NSURL URLWithString:image2]];
}

#pragma mark - KMCarouselDelegate

- (void)carousel:(KMCarouselView *)carousel didMoveToPage:(NSUInteger)page
{
    self.pageControl.currentPage = page;
    
}

- (void)carousel:(KMCarouselView *)carousel didTouchPage:(NSUInteger)page
{
    self.pageControl.currentPage = page;
}
#pragma mark - KMHomeTypeViewDelegate
- (void)typeView:(KMHomeTypeView *)typeView chooseType:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        NSLog(@"美发");
        KMMefaViewController *vc = [[KMMefaViewController alloc] init];;
                                    
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.item == 1) {
        NSLog(@"美甲");
        KMMefaViewController *vc = [[KMMefaViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.item == 2) {
        NSLog(@"美妆");
        KMMefaViewController *vc = [[KMMefaViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.item == 3) {
        NSLog(@"美睫毛");
        KMMefaViewController *vc = [[KMMefaViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
