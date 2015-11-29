//
//  UIImage+Extension.h
//  Beauty
//
//  Created by SoloKM on 15/11/29.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 * 返回一张圆形图片
 */
- (instancetype)circleImage;

/**
 * 返回一张圆形图片
 */
+ (instancetype)circleImageNamed:(NSString *)name;
@end
