//
//  ClassAdCell.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/8.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClassModel;

typedef void(^JumpBlock)(void);
@interface ClassAdCell : UITableViewCell
@property(nonatomic,strong)ClassModel *model;
@property(nonatomic,copy)JumpBlock jumpBlock;

@property (weak, nonatomic) IBOutlet UILabel *adTitle;
@property (weak, nonatomic) IBOutlet UIImageView *adImage;
@property (weak, nonatomic) IBOutlet UIButton *adLabel;
@property (weak, nonatomic) IBOutlet UILabel *adWeb;
@property (weak, nonatomic) IBOutlet UIButton *adLearn1;
@property (weak, nonatomic) IBOutlet UIButton *adLearn2;
+(instancetype)createCellWithTableView:(UITableView *)tableView;

@end
