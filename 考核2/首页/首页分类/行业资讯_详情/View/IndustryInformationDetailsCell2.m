//
//  IndustryInformationDetailsCell2.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/17.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "IndustryInformationDetailsCell2.h"

@implementation IndustryInformationDetailsCell2

+(instancetype)createCellWithTableView:(UITableView *)tableView{
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(IndustryInformationDetailsCell2.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(IndustryInformationDetailsCell2.class)];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(IndustryInformationDetailsCell2.class)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.bgView.layer.shadowColor = kGRAYCOLOR.CGColor;
    self.bgView.layer.shadowOpacity = 0.8;
    self.bgView.layer.shadowRadius = 5;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    self.bgView.layer.cornerRadius = 5;
//    self.bgView.layer.masksToBounds = YES;
    self.bgView.backgroundColor = kWHITECOLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    self.title.font = kFONT(14);
    self.title.textColor = [UIColor colorWithRed:22/255.0 green:26/255.0 blue:36/255.0 alpha:1];
//    NSMutableParagraphStyle *style = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
//    style.lineSpacing = 10;
//    NSDictionary *dic = @{NSFontAttributeName:kFONT(14),NSParagraphStyleAttributeName:style};
//    NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"北京开放式共享办公空间，轻奢舒适，配套齐全周边环境高大上..." attributes:dic];
//    self.title.attributedText = string;
    
    
    self.adIdentification.titleLabel.font = kFONT(11);
    [self.adIdentification setTitleColor:[UIColor colorWithRed:42/255.0 green:132/255.0 blue:233/255.0 alpha:1] forState:UIControlStateNormal];
    
    self.adWeb.font = kFONT(11);
    self.adWeb.textColor = [UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
