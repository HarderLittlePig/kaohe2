//
//  ClassAdCell.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/8.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "ClassAdCell.h"

@implementation ClassAdCell


+(instancetype)createCellWithTableView:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(ClassAdCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(ClassAdCell.class)];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ClassAdCell.class)];
}


-(void)setFrame:(CGRect)frame{
    CGRect fram = frame;
    fram.origin.x += 10;
    fram.size.width -= 20;
    fram.origin.y += 8;
    fram.size.height -= 8;
    frame = fram;
    return [super setFrame:frame];
}

- (void)setModel:(ClassModel *)model{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    
    self.adImage.layer.cornerRadius = 4.0f;
    self.adImage.layer.masksToBounds = YES;
    
    
    _adTitle.font = kFONT(17);
    NSMutableParagraphStyle *style = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
    style.lineSpacing = 4;
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"习近平寄语...青少年儿童人生的扣子从一开始就要扣好" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSParagraphStyleAttributeName:style}];
    _adTitle.numberOfLines = 2;
    _adTitle.attributedText = string;
    _adTitle.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
    
    
    _adImage.backgroundColor = kORANGECOLOR;
    
    _adLabel.titleLabel.font = kFONT(11);
    [_adLabel setTitleColor:[UIColor colorWithRed:42/255.0 green:132/255.0 blue:233/255.0 alpha:1] forState:UIControlStateNormal];

    _adWeb.font = kFONT(11);
    _adWeb.textColor = [UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1];
    
    _adLearn1.titleLabel.font = kFONT(11);
    [_adLearn1 setTitleColor:[UIColor colorWithRed:42/255.0 green:132/255.0 blue:233/255.0 alpha:1] forState:UIControlStateNormal];
    
    [_adLearn1 addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
    [_adLearn2 addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)jumpAction{
    self.jumpBlock ? self.jumpBlock() : nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
