//
//  ClassVCCell.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/8.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "ClassContentCell1.h"
#import "ClassModel.h"

@implementation ClassContentCell1

+(instancetype)createCellWithTableView:(UITableView *)tableView{
    [tableView registerClass:[ClassContentCell1 class] forCellReuseIdentifier:NSStringFromClass(ClassContentCell1.class)];
    return [[self alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass(ClassContentCell1.class)];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        
        
        
        UIImageView *contentImage = [[UIImageView alloc] init];
        contentImage.backgroundColor = kORANGECOLOR;
        [self addSubview:contentImage];
        [contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(15);
            make.right.offset(-15);
            make.bottom.offset(-15);
            make.width.offset(105);
        }];
        
        
        NSMutableParagraphStyle *style = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
        style.lineSpacing = 4;
        NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"习近平寄语...青少年儿童人生的扣子从一开始就要扣好" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSParagraphStyleAttributeName:style}];
        UILabel *contentTitle = [[UILabel alloc] init];
        contentTitle.numberOfLines = 2;
        contentTitle.attributedText = string;
        contentTitle.font = kFONT(17);
        contentTitle.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
        [self.contentView addSubview:contentTitle];
        [contentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(15);
            make.left.offset(10);
            make.right.equalTo(contentImage.mas_left).offset(-10.5);
        }];
        
        
//        UIButton *contentTopping = [[UIButton alloc] init];
//        [contentTopping setTitle:@"置顶" forState:UIControlStateNormal];
//        contentTopping.titleLabel.font = kFONT(11);
//        [contentTopping setBackgroundImage:[UIImage imageNamed:@"xwzx_zd"] forState:UIControlStateNormal];
//        [contentTopping setTitleColor:[UIColor colorWithRed:237/255.0 green:49/255.0 blue:49/255.0 alpha:1] forState:UIControlStateNormal];
//        [self.contentView addSubview:contentTopping];
//        [contentTopping mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(contentTitle.mas_bottom).offset(25);
//            make.left.offset(10);
//            make.width.offset(33);
//            make.height.offset(15);
//        }];
//        [contentTopping sizeToFit];
        
        
        UIButton *contentPopular = [[UIButton alloc] init];
//        contentPopular.backgroundColor = kORANGECOLOR;
//        [contentPopular setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
//        [contentPopular setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [contentPopular setTitle:@" 热门" forState:UIControlStateNormal];
        contentPopular.titleLabel.font = kFONT(11);
        [contentPopular setTitleColor:[UIColor colorWithRed:237/255.0 green:49/255.0 blue:49/255.0 alpha:1] forState:UIControlStateNormal];
        [contentPopular setImage:[UIImage imageNamed:@"xwzx_rm"] forState:UIControlStateNormal];
        [self.contentView addSubview:contentPopular];
        [contentPopular mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentTitle.mas_bottom).offset(25);
            make.left.offset(10);
            make.width.offset(46);
            make.height.offset(15);
        }];
        [contentPopular sizeToFit];
        
        
        UIButton *contentCount = [[UIButton alloc] init];
//        contentCount.backgroundColor = kORANGECOLOR;
//        [contentCount setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
//        [contentCount setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [contentCount setTitle:@" 126次" forState:UIControlStateNormal];
        [contentCount setImage:[UIImage imageNamed:@"xwzx_yd"] forState:UIControlStateNormal];
        contentCount.titleLabel.font = kFONT(11);
        [contentCount setTitleColor:[UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1] forState:UIControlStateNormal];
        [self.contentView addSubview:contentCount];
        [contentCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentTitle.mas_bottom).offset(25);
            make.left.equalTo(contentPopular.mas_right).offset(15);
            make.width.offset(60);
            make.height.offset(15);
        }];
        
        
        UILabel *contentTime = [[UILabel alloc] init];
        contentTime.text = @"1小时前";
        contentTime.font = kFONT(11);
        contentTime.textColor = [UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1];
        [self.contentView addSubview:contentTime];
        [contentTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentTitle.mas_bottom).offset(25);
            make.left.equalTo(contentCount.mas_right).offset(15);
            make.height.offset(15);
        }];
    }
    return self;
}
-(void)setFrame:(CGRect)frame{
    CGRect fram = frame;
    fram.origin.x += 10;
    fram.origin.y += 8;
    fram.size.width -= 20;
    fram.size.height -= 16;
    frame = fram;
    return [super setFrame:frame];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
