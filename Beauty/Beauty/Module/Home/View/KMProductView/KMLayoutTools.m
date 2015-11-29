//
//  KMLayoutTools.m
//  Beauty
//
//  Created by SoloKM on 15/11/29.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#import "KMLayoutTools.h"

@implementation KMLayoutTools
+(UICollectionViewFlowLayout *)chooseLayoutWithCol:(int)col height :(CGFloat)height space:(CGFloat)space
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =  CGSizeMake(ScreenW / (col * 1.0) - space, height);
    layout.minimumLineSpacing = space;
    layout.minimumInteritemSpacing = space;

    return layout;
}

@end
