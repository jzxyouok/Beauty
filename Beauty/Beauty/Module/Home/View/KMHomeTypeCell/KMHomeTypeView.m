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
/** 数据 */
@property (nonatomic ,strong) NSArray *types;


@end
@implementation KMHomeTypeView

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
    
    layout.itemSize =  CGSizeMake(self.width * 0.5 - 0.5, self.height * 0.5 - 0.5);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 0.5;
    
    self.collectionViewLayout = layout;
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([KMHomeTypeCell class]) bundle:nil] forCellWithReuseIdentifier:@"cellID"];
    
   
}

- (NSArray *)types
{
    if (_types == nil) {
        
        KMHomeItem *meifa = [[KMHomeItem alloc] init];
        meifa.title = @"美发";
        meifa.image =[UIImage imageNamed:@"main_v3_icon_knife"];
        meifa.count = @"137款发型";
    
        
        KMHomeItem *meijia= [[KMHomeItem alloc] init];
        meijia.title = @"美甲";
        meijia.image =[UIImage imageNamed:@"main_v3_icon_zhijia"];
        meijia.count = @"777款作品";
      
        
        KMHomeItem *meizhuang = [[KMHomeItem alloc] init];
        meizhuang.title = @"美妆";
        meizhuang.image =[UIImage imageNamed:@"main_v3_icon_huazhuang"];
        meizhuang.count = @"137款美妆";
       
        
        KMHomeItem *meijie = [[KMHomeItem alloc] init];
        meijie.title = @"美睫";
        meijie.image =[UIImage imageNamed:@"main_v3_icon_jiemao"];
        meijie.count = @"14款作品";
        
        NSArray *arry = @[meifa,meijie,meizhuang,meijie];
        
        _types = arry;
    }
    
    return _types;
    
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
    
    KMHomeTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
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
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
