//
//  ClassVCCell.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/8.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "ClassContentCell1.h"
#import "ClassModel.h"

@interface ClassContentCell1()
@property(nonatomic,weak)UILabel *contentTitle;
@property(nonatomic,weak)UIButton *contentTopping;
//@property(nonatomic,weak)UIButton *contentPopular;
@property(nonatomic,weak)UILabel *contentTime;
@property(nonatomic,weak)UIButton *contentCount;

@end

@implementation ClassContentCell1

+(instancetype)createCellWithTableView:(UITableView *)tableView{
    [tableView registerClass:[ClassContentCell1 class] forCellReuseIdentifier:NSStringFromClass(ClassContentCell1.class)];
    return [[self alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass(ClassContentCell1.class)];
}

-(void)setModel:(ClassModel *)model{
    _model = model;
    
    NSMutableParagraphStyle *style = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
    style.lineSpacing = 4;
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:model.title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSParagraphStyleAttributeName:style}];
    _contentTitle.attributedText = string;
    
    
    [_contentCount setTitle:[NSString stringWithFormat:@" %@",model.lookCount] forState:UIControlStateNormal];
    _contentTime.text = model.publishTime;
    
    
    if (model.isTopping) {
        [self.contentTopping setTitle:@"置顶" forState:UIControlStateNormal];
        [self.contentTopping setBackgroundImage:[UIImage imageNamed:@"xwzx_zd"] forState:UIControlStateNormal];
    }
    if (model.isPopular) {
        [self.contentTopping setTitle:@" 热门" forState:UIControlStateNormal];
        [self.contentTopping setImage:[UIImage imageNamed:@"xwzx_rm"] forState:UIControlStateNormal];
        [self.contentTopping setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
    //热门和置顶都被隐藏了
    if (!model.isTopping && !model.isPopular) {
        
        self.contentTopping.hidden = YES;
        [self.contentCount mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
        }];
    }
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
        
        
        UILabel *contentTitle = [[UILabel alloc] init];
        contentTitle.numberOfLines = 2;
        contentTitle.font = kFONT(17);
        contentTitle.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
        [self.contentView addSubview:contentTitle];
        [contentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(15);
            make.left.offset(10);
            make.right.equalTo(contentImage.mas_left).offset(-10.5);
        }];
        self.contentTitle = contentTitle;
        
        
        
        UIButton *contentTopping = [[UIButton alloc] init];
        [contentTopping setTitle:@"置顶" forState:UIControlStateNormal];
        contentTopping.titleLabel.font = kFONT(11);
        [contentTopping setBackgroundImage:[UIImage imageNamed:@"xwzx_zd"] forState:UIControlStateNormal];
        [contentTopping setTitleColor:[UIColor colorWithRed:237/255.0 green:49/255.0 blue:49/255.0 alpha:1] forState:UIControlStateNormal];
        [self.contentView addSubview:contentTopping];
        [contentTopping mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentTitle.mas_bottom).offset(25);
            make.left.offset(10);
            make.width.offset(36);
            make.height.offset(15);
        }];
        [contentTopping sizeToFit];
        self.contentTopping = contentTopping;
        

        UIButton *contentCount = [[UIButton alloc] init];
        contentCount.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [contentCount setImage:[UIImage imageNamed:@"xwzx_yd"] forState:UIControlStateNormal];
        contentCount.titleLabel.font = kFONT(11);
        [contentCount setTitleColor:[UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1] forState:UIControlStateNormal];
        [self.contentView addSubview:contentCount];
        [contentCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentTitle.mas_bottom).offset(25);
            make.left.equalTo(contentTopping.mas_right).offset(10);
            make.width.offset(46);
            make.height.offset(15);
        }];
        self.contentCount = contentCount;
        
        UILabel *contentTime = [[UILabel alloc] init];
        contentTime.text = @"1小时前";
        contentTime.font = kFONT(11);
        contentTime.textColor = [UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1];
        [self.contentView addSubview:contentTime];
        [contentTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentTitle.mas_bottom).offset(25);
            make.left.equalTo(contentCount.mas_right).offset(5);
            make.height.offset(15);
        }];
        self.contentTime = contentTime;
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    CGRect fram = frame;
    fram.origin.x += 10;
    fram.origin.y += 8;
    fram.size.width -= 20;
    fram.size.height -= 8;
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
