//
//  KMProductsViewController.m
//  Beauty
//
//  Created by SoloKM on 15/11/29.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#import "KMProductsViewController.h"
#import "KMProductCell.h"

@interface KMProductsViewController ()


@end

@implementation KMProductsViewController
NSString *const KMProductCellID = @"KMProductCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.backgroundColor = kGlobalBg;
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setup
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KMProductCell class]) bundle:nil] forCellWithReuseIdentifier:KMProductCellID];
    self.collectionView.contentInset = UIEdgeInsetsMake(4, 0, 0, 0);
    
    self.collectionView.mj_header = [KMRefreshHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_header endRefreshing];
        });
    }];
    
 
    
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    KMProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KMProductCellID forIndexPath:indexPath];
    
//    cell.type = self.types[indexPath.item];
    
    
    
    
    return cell;
}





#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if ( [self.TypeViewdelegate respondsToSelector:@selector(typeView:chooseType:)]) {
//        
//        [self.TypeViewdelegate  typeView:self chooseType:indexPath];
//    }
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
