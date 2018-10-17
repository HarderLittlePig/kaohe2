//
//  ClassContentCell2.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/9.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "ClassContentCell2.h"
#import "ClassModel.h"

@implementation ClassContentCell2

+(instancetype)createCellWithTableView:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(ClassContentCell2.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(ClassContentCell2.class)];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ClassContentCell2.class)];
}

-(void)setModel:(ClassModel *)model{
    _model = model;
    
    NSMutableParagraphStyle *style = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
    style.lineSpacing = 4;
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:model.title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSParagraphStyleAttributeName:style}];
    _contentTitle.attributedText = string;

    [_contentCount setTitle:model.lookCount forState:UIControlStateNormal];
    _contentTime.text = model.publishTime;

    
    if (!model.isTopping && !model.isPopular) {
        
        self.contentPopular.hidden = YES;
        [self.contentCount mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
        }];
    }else if (model.isTopping){
        [self.contentCount setTitle:@"置顶" forState:UIControlStateNormal];
        [self.contentCount setBackgroundImage:[UIImage imageNamed:@"xwzx_zd"] forState:UIControlStateNormal];
    }else if (model.isPopular){
        [self.contentCount setTitle:@" 热门" forState:UIControlStateNormal];
        [self.contentCount setImage:[UIImage imageNamed:@"xwzx_rm"] forState:UIControlStateNormal];
    }
    
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
    
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    
    _contentTitle.font = kFONT(17);
    NSMutableParagraphStyle *style = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
    style.lineSpacing = 4;
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"习近平寄语...青少年儿童人生的扣子从一开始就要扣好" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17], NSParagraphStyleAttributeName:style}];
    _contentTitle.numberOfLines = 2;
    _contentTitle.attributedText = string;
    _contentTitle.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
    
    
    _contentPopular.titleLabel.font = kFONT(11);
    [_contentPopular setTitleColor:[UIColor colorWithRed:237/255.0 green:49/255.0 blue:49/255.0 alpha:1] forState:UIControlStateNormal];
    
    _contentCount.titleLabel.font = kFONT(11);
    [_contentCount setTitleColor:[UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1] forState:UIControlStateNormal];
    
    _contentTime.font = kFONT(11);
    _contentTime.textColor = [UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
