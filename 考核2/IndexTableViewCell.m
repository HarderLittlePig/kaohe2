//
//  IndexTableViewCell.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/24.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "IndexTableViewCell.h"

@implementation IndexTableViewCell

+(instancetype)createCellWithTableView:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(IndexTableViewCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(IndexTableViewCell.class)];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(IndexTableViewCell.class)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = kWHITECOLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.title.font = kFONT(10);
    self.title.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];

    //
    self.title.layer.cornerRadius = (15-3)*0.5;
    self.title.backgroundColor = kWHITECOLOR;
    self.title.layer.masksToBounds = YES;
    
    
//    UIView *bg = [[UIView alloc]initWithFrame:self.bounds];
//    bg.backgroundColor = kWHITECOLOR;
//    self.selectedBackgroundView = bg;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
