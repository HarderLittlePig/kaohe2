//
//  HistorySearchReusableView.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/12.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "HistorySearchReusableView.h"

@implementation HistorySearchReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sectionLab.font = kFONT(14);
    self.sectionLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    
    [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)deleteAction{
    self.deleteBlock ? self.deleteBlock() : nil;
}
@end
