//
//  KMHomeTypeView.m
//  Beauty
//
//  Created by SoloKM on 15/11/28.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#import "KMHomeTypeView.h"
#import "KMHomeTypeCell.h"
#import "KMHomeItem.h"
@interface KMHomeTypeView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@end




@implementation KMHomeTypeView

NSString *const KMHomeTypeCellID = @"KMHomeTypeCell";

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
        self.backgroundColor = kGlobalBg;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void) setup
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize =  CGSizeMake(ScreenW* 0.5 - 0.5, self.height * 0.5 - 0.5);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 0.5;
    
    self.collectionViewLayout = layout;
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([KMHomeTypeCell class]) bundle:nil] forCellWithReuseIdentifier:KMHomeTypeCellID];
    
   
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.types.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    KMHomeTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KMHomeTypeCellID forIndexPath:indexPath];
    
    cell.type = self.types[indexPath.item];
    
 
    
    
    return cell;
}





#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ( [self.TypeViewdelegate respondsToSelector:@selector(typeView:chooseType:)]) {
        
        [self.TypeViewdelegate  typeView:self chooseType:indexPath];
    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end
