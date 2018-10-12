//
//  MyChannelCell.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/9.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "MyChannelCell.h"

@implementation MyChannelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = kWHITECOLOR;
    self.title.font = kFONT(15);
    self.title.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
}

@end
