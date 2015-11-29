//
//  UIBarButtonItem+Extension.h
//  Beauty
//
//  Created by SoloKM on 15/11/29.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action title:(NSString *)title;
@end
