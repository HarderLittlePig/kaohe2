//
//  HistoryRecordReusableView.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/9.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "HistoryRecordReusableView.h"

@implementation HistoryRecordReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kWHITECOLOR;
    self.line.backgroundColor = [UIColor colorWithRed:219/255.0 green:49/255.0 blue:0/255.0 alpha:1];
    self.line.layer.cornerRadius = 2;
    
    self.title.text = @"历史记录";
    self.title.font = kFONT(15);
    self.title.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
    [self.deleteBtn addTarget:self action:@selector(deleteHistoryRecord) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)deleteHistoryRecord{
    self.deleteBlock ? self.deleteBlock() : nil;
}
@end
