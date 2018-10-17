//
//  IndustryInformationDetailsCell1.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/16.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "IndustryInformationDetailsCell1.h"

@implementation IndustryInformationDetailsCell1

+(instancetype)createCellWithTableView:(UITableView *)tableView{
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(IndustryInformationDetailsCell1.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(IndustryInformationDetailsCell1.class)];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(IndustryInformationDetailsCell1.class)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.title.textColor = [UIColor colorWithRed:22/255.0 green:26/255.0 blue:36/255.0 alpha:1];
    
    NSMutableParagraphStyle *style1 = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style1.lineSpacing = 16.5;
    NSString *text1 = @"如懿传中嘉嫔费劲千辛万苦生的五阿哥，结果为何要送给皇后抚养";
    NSDictionary *dict1 = @{NSFontAttributeName:[UIFont systemFontOfSize:22], NSParagraphStyleAttributeName:style1};
    NSAttributedString *string1 = [[NSAttributedString alloc]initWithString:text1 attributes:dict1];
    self.title.attributedText = string1;
    CGFloat height1 = [self.title.text boundingRectWithSize:CGSizeMake(kSCREENWIDTH - 18*2, MAXFLOAT) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:dict1 context:nil].size.height;
    
    self.userIcon.image = [UIImage imageNamed:@"moment_pic_2"];
    self.userIcon.layer.cornerRadius = 31*0.5;
    self.userIcon.layer.masksToBounds = YES;
    
    self.userName.font = kFONT(13);
    self.userName.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
    
    self.time.textColor = [UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1];
    self.time.font = kFONT(11);
    self.browseCount.textColor = [UIColor colorWithRed:157/255.0 green:167/255.0 blue:174/255.0 alpha:1];
    self.browseCount.font = kFONT(11);
    
    self.content.textColor = [UIColor colorWithRed:22/255.0 green:26/255.0 blue:36/255.0 alpha:1];
    NSMutableParagraphStyle *style2 = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style2.lineSpacing = 15;
    NSString *text2 = @"说到最近公元1735年乾隆（霍建华饰）即位，与他少年相知的侧福晋如懿（周迅饰）也依礼进宫为妃。从此，二人在宫廷里演绎了一段从恩爱相知到迷失破灭的婚姻历程。新帝登基，如懿因与乾隆青梅竹马的情分成为娴妃，由此受到众人排挤，而太后（邬君梅饰)又与如懿家族有世仇，如懿危机四伏。此时，乾隆也同样面对太后掌权和老臣把持朝政的难题。\
    权力更迭过程中，乾隆与如懿互相扶持，共同渡过难关，直到二人扫清障碍。乾隆经过多年努力也如愿将如懿推到皇后位置，与他共有天下。然而做了皇后的如懿却发现，乾隆已从少年夫君成长为成熟帝王，他的多疑善变以及帝王自私不断显露，两人间的情意信任渐渐破灭。但如懿依旧坚守美好回忆，恪守皇后职责，直到去世";
    NSDictionary *dict2 = @{NSFontAttributeName:[UIFont systemFontOfSize:18], NSParagraphStyleAttributeName:style2};
    NSAttributedString *string2 = [[NSAttributedString alloc]initWithString:text2 attributes:dict2];
    self.content.attributedText = string2;
    CGFloat height2 = [text2 boundingRectWithSize:CGSizeMake(kSCREENWIDTH - 18*2, MAXFLOAT) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:dict2 context:nil].size.height;
    
    
    self.dutyEditor.font = kFONT(14);
    self.dutyEditor.textColor = [UIColor colorWithRed:139/255.0 green:150/255.0 blue:158/255.0 alpha:1];
    
    
//    CGFloat cellHeight = height1 + 31.0 + 29.0 + 31.0 + 35.0 + height2 + 20.0 + 14.0 + 25.0;
//    NSLog(@"👌%f ",cellHeight);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
