//
//  KMHomeTypeCell.m
//  Beauty
//
//  Created by SoloKM on 15/11/28.
//  Copyright © 2015年 cornerAnt. All rights reserved.
//

#import "KMHomeTypeCell.h"
#import "KMHomeItem.h"

@interface KMHomeTypeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end

@implementation KMHomeTypeCell


-(void)setHighlighted:(BOOL)highlighted
{
    if (highlighted) {
        self.backgroundColor = kGlobalBg;
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}
- (void)setType:(KMHomeItem *)type
{
    _type = type;
    
    self.imageView.image = type.image;
    self.titleLabel.text = type.title;
    self.countLabel.text = type.count;
}
@end
