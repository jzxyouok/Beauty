//
//  UIViewController+Extension.m
//  Beauty
//
//  Created by SoloKM on 15/11/28.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)
+(instancetype)loadFormSb{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil];
    return [sb instantiateInitialViewController];
}
@end
