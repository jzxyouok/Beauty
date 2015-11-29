//
//  KMHomeTypeView.h
//  Beauty
//
//  Created by SoloKM on 15/11/28.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KMHomeTypeView;

@protocol KMHomeTypeViewDelegate <NSObject>
- (void)typeView:(KMHomeTypeView *)typeView chooseType:(NSIndexPath *)indexPath;

@end

@interface KMHomeTypeView : UICollectionView
/** 选择界面代理  */
@property (nonatomic ,weak) id<KMHomeTypeViewDelegate> TypeViewdelegate;
@end
