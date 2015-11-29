//
//  KMMineViewController.m
//  Beauty
//
//  Created by SoloKM on 15/11/28.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//
#define HeadH 200
#define HeadMinH 64
#import "KMMineViewController.h"
#import <Masonry.h>

@interface KMMineViewController ()
/** 初始偏移量y */
@property (assign, nonatomic) CGFloat lastOffsetY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewConstraint;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end


@implementation KMMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.lastOffsetY = - HeadH;
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
}



#pragma mark - tableView数据源
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6 ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.navigationController.navigationBar.hidden = NO;
    // 设置头部变化
    CGPoint offset = scrollView.contentOffset;
    CGFloat distanceY = offset.y - _lastOffsetY;
    NSLog(@"%f",distanceY);
    CGFloat headH = HeadH  - distanceY;
    (headH < HeadMinH) ? (headH = HeadMinH) :(headH);
    self.headerViewConstraint.constant = headH;
    [self.headerView layoutIfNeeded];
    // 设置导航条透明速度
    (distanceY < 0 ) ? (distanceY = 0) : (distanceY);
    CGFloat alpha = 1.0 * distanceY /(HeadH - HeadMinH);
    (alpha < 0 ) ?(alpha = 0.99) : alpha ;
    self.navigationController.navigationBar.alpha = alpha;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    LogFunc;
}
@end
