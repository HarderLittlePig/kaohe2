//
//  HistorySearchCell.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/12.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "HistorySearchCell.h"

@implementation HistorySearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title.font = kFONT(12);
    self.title.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    
    self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.layer.cornerRadius = 5;
}

@end
