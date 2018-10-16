//
//  InformationPersonalPageCell1.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/16.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "InformationPersonalPageCell1.h"

@implementation InformationPersonalPageCell1


+(instancetype)createCellWithTableView:(UITableView *)tableView{
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(InformationPersonalPageCell1.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(InformationPersonalPageCell1.class)];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(InformationPersonalPageCell1.class)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kWHITECOLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.timeLine.backgroundColor = [UIColor colorWithRed:217/255.0 green:221/255.0 blue:225/255.0 alpha:1];
    self.timeLineBall.backgroundColor = [UIColor colorWithRed:217/255.0 green:221/255.0 blue:225/255.0 alpha:1];
    self.timeLineBall.layer.cornerRadius = 9*0.5;
    self.timeLineBall.layer.masksToBounds = YES;
    
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"xwzx_grzy_bg"];
    // 设置左边端盖宽度
    NSInteger leftCapWidth = image.size.width * 0.5;
    // 设置上边端盖高度
    NSInteger topCapHeight = image.size.height * 0.5;
    UIImage *newImage = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    self.bgView.image = newImage;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
