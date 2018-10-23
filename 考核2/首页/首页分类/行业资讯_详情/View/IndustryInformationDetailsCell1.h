//
//  IndustryInformationDetailsCell1.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/16.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JumpBlock)(void);

@class IndustryInformationDetailsModel;

@interface IndustryInformationDetailsCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *browseCount;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *dutyEditor;
@property(nonatomic,copy)JumpBlock jumpBlock;

@property(nonatomic,strong)IndustryInformationDetailsModel *model;

+(instancetype)createCellWithTableView:(UITableView *)tableView;
@end
