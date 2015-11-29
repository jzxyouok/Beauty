//
//  KMTabBarController.m
//  Kitchen
//
//  Created by SoloKM on 15/11/26.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#import "KMTabBarController.h"
#import "KMNavigationController.h"
#import "KMHomeViewController.h"
#import "KMMineViewController.h"
@interface KMTabBarController ()

@end

@implementation KMTabBarController
+ (void)initialize
{

    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = kGlobalTitleColor;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllVc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 初始化子控制器

/**
 * 初始化所有子控制器
 */
- (void)setupAllVc
{
    self.tabBar.backgroundImage = [self ImageFromColor:[UIColor blackColor]];
    
    [self setupChildVc:[KMHomeViewController loadFormSb] title:@"首页" image:@"tab_home" selectedImage:@"tab_home_sel"];
    
    [self setupChildVc:[[UIViewController alloc] init] title:@"约会" image:@"tab_appointment" selectedImage:@"tab_appointment_sel"];
    
    
    [self setupChildVc:[[UIViewController alloc] init] title:@"发现" image:@"tab_discovery" selectedImage:@"tab_discovery_sel"];
  
    [self setupChildVc:[KMMineViewController loadFormSb] title:@"我" image:@"tab_mine" selectedImage:@"tab_mine_sel"];
}

/**
 * 初始化一个子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
   
    KMNavigationController *nav = [[KMNavigationController alloc] initWithRootViewController:vc];
        [self addChildViewController:nav];
    
}
- (UIImage *)ImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, 44);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
