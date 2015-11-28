//
//  KMHomeViewController.m
//  Beauty
//
//  Created by SoloKM on 15/11/28.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//
#define IMAGE_URLSTRING0  @"http://pic.58pic.com/58pic/13/18/14/87m58PICVvM_1024.jpg"
#define IMAGE_URLSTRING1  @"http://pic.58pic.com/58pic/13/56/99/88f58PICuBh_1024.jpg"
#define PLACEHOLDER_IMAGE [UIImage imageNamed:@"placeholder"]
#import "KMHomeViewController.h"
#import "KMCarouselView.h"
@interface KMHomeViewController ()<KMCarouselDelegate>

@property (weak, nonatomic) IBOutlet KMCarouselView *carouselView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation KMHomeViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_v3_icon_logo"]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCarouselView];
    [self setupPageControl];
    [self setupNav];
    
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

#pragma mark - Private Method

- (void)setupCarouselView
{
    self.carouselView.imageURLs = [self imageURLs];
    self.carouselView.placeholder = PLACEHOLDER_IMAGE;
    self.carouselView.pageDelegate = self;
    self.carouselView.autoMoving = YES;
    self.carouselView.movingTimeInterval = 1.5f;
}

- (void)setupPageControl
{
    self.pageControl.numberOfPages = [[self imageURLs] count];
    self.pageControl.tintColor = kGlobalTitleColor;
    
}

- (NSArray *)imageURLs
{
    return @[[NSURL URLWithString:IMAGE_URLSTRING0],
             [NSURL URLWithString:IMAGE_URLSTRING1]];
}

#pragma mark - PSCarouselDelegate

- (void)carousel:(KMCarouselView *)carousel didMoveToPage:(NSUInteger)page
{
    self.pageControl.currentPage = page;
    
}

- (void)carousel:(KMCarouselView *)carousel didTouchPage:(NSUInteger)page
{
    self.pageControl.currentPage = page;
}
@end
