//
//  NSDate+Extension.h
//  Beauty
//
//  Created by SoloKM on 15/11/29.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
- (NSDateComponents *)intervalToDate:(NSDate *)date;
- (NSDateComponents *)intervalToNow;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;

/**
 * 是否为明天
 */
- (BOOL)isTomorrow;
@end
