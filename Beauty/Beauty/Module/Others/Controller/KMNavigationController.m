//
//  KMNavigationController.m
//  Kitchen
//
//  Created by SoloKM on 15/11/26.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#import "KMNavigationController.h"

@interface KMNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation KMNavigationController


+ (void)initialize
{
    /** 设置UINavigationBar */
    UINavigationBar *bar = [UINavigationBar appearance];
    // 设置背景
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    // 设置标题文字属性
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    barAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    barAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [bar setTitleTextAttributes:barAttrs];
    
    /** 设置UIBarButtonItem */
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // UIControlStateNormal
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    // UIControlStateDisabled
    NSMutableDictionary *disabledAttrs = [NSMutableDictionary dictionary];
    disabledAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:disabledAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.view.backgroundColor = kGlobalBg;
    self.navigationBar.barTintColor = kGlobalTitleColor;
    
    
}

/**
 * 拦截所有push进来的子控制器
 * @param viewController 每一次push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    if (不是第一个push进来的子控制器) {
    if (self.childViewControllers.count >= 1) {
        // 左上角的返回
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
////        [backButton setTitle:@"返回" forState:UIControlStateNormal];
//        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton setImage:[UIImage imageNamed:@"ico_goback"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"ico_goback_hl"] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>
/**
 * 每当用户触发[返回手势]时都会调用一次这个方法
 * 返回值:返回YES,手势有效; 返回NO,手势失效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 如果当前显示的是第一个子控制器,就应该禁止掉[返回手势]
    //    if (self.childViewControllers.count == 1) return NO;
    //    return YES;
    return self.childViewControllers.count > 1;
}

@end
