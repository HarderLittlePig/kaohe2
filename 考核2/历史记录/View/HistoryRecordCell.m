//
//  HistoryRecordCell.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/10.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "HistoryRecordCell.h"

@implementation HistoryRecordCell

+(instancetype)createCellWithTableView:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(HistoryRecordCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(HistoryRecordCell.class)];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HistoryRecordCell.class)];
}

- (void)awakeFromNib {
    [super awakeFromNib];

//    self.redLine.backgroundColor = [UIColor colorWithRed:219/255.0 green:49/255.0 blue:0/255.0 alpha:1];
    self.redLine.textColor = [UIColor clearColor];
    
    self.redLine.hidden = YES;
    self.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    
    self.title.font = kFONT(15);
    self.title.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.title.highlightedTextColor = [UIColor colorWithRed:219/255.0 green:49/255.0 blue:23/255.0 alpha:1];
    
    self.title.hidden = YES;
//    self.redLine.textColor = [UIColor clearColor];
//    self.redLine.highlightedTextColor = [UIColor colorWithRed:219/255.0 green:49/255.0 blue:23/255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
