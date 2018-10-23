//
//  InformationPersonalPageCell2.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/23.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "InformationPersonalPageCell2.h"

@implementation InformationPersonalPageCell2

+(instancetype)createCellWithTableView:(UITableView *)tableView{
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(InformationPersonalPageCell2.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(InformationPersonalPageCell2.class)];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(InformationPersonalPageCell2.class)];
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
    
    self.title.font = [UIFont fontWithName:@"HiraginoSansGB-W3" size:17];
    self.title.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
    self.title.numberOfLines = 2;
    
    NSMutableParagraphStyle *style1 = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style1.lineSpacing = 7;
    NSString *text1 = @"杨贵妃没有死？去了日本还有后代！日本女星拿出家谱证明！";
    NSDictionary *dict1 = @{NSFontAttributeName:kFONT(17), NSParagraphStyleAttributeName:style1};
    NSAttributedString *string1 = [[NSAttributedString alloc]initWithString:text1 attributes:dict1];
    self.title.attributedText = string1;
    
    self.contentImg1.layer.cornerRadius = 4.0f;
    self.contentImg1.layer.masksToBounds = YES;
    self.contentImg2.layer.cornerRadius = 4.0f;
    self.contentImg2.layer.masksToBounds = YES;
    self.contentImg3.layer.cornerRadius = 4.0f;
    self.contentImg3.layer.masksToBounds = YES;
    
    [self.lookCount setTitleColor:[UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1] forState:UIControlStateNormal];
    self.lookCount.titleLabel.font = kFONT(11);
    
    self.publishTime.textColor = [UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1];
    self.publishTime.font = kFONT(11);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
