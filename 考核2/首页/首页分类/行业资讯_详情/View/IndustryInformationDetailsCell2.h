//
//  IndustryInformationDetailsCell2.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/17.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndustryInformationDetailsCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *adImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *adIdentification;
@property (weak, nonatomic) IBOutlet UILabel *adWeb;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

+(instancetype)createCellWithTableView:(UITableView *)tableView;
@end
