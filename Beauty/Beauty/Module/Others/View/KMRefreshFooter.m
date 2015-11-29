//
//  KMRefreshFooter.m
//  Beauty
//
//  Created by SoloKM on 15/11/29.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#import "KMRefreshFooter.h"

@interface KMRefreshFooter ()
@property (weak, nonatomic) UIImageView *refreshImage;
@end

@implementation KMRefreshFooter



#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    UIImageView *refreshImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_img_refresh"]];
    refreshImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:refreshImage];
    self.refreshImage = refreshImage;
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
   
    self.refreshImage.bounds = CGRectMake(0, 0, 28 , 28);
    self.refreshImage.center = CGPointMake(self.width * 0.5, - self.refreshImage.height * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            [self stopRefresh];
            break;
        case MJRefreshStatePulling:
            [self stopRefresh];
            break;
        case MJRefreshStateRefreshing:
            [self startRefresh];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    self.refreshImage.transform = CGAffineTransformMakeRotation(M_2_PI * pullingPercent);
}

- (void)startRefresh
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 10;
    
    [self.refreshImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
- (void)stopRefresh
{
    [self.refreshImage.layer removeAllAnimations];
}
@end
