//
//  InformationPersonalPageCell2.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/23.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>
//三张图片
@interface InformationPersonalPageCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *timeLine;
@property (weak, nonatomic) IBOutlet UIView *timeLineBall;
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *lookCount;
@property (weak, nonatomic) IBOutlet UILabel *publishTime;
@property (weak, nonatomic) IBOutlet UIImageView *contentImg1;
@property (weak, nonatomic) IBOutlet UIImageView *contentImg2;
@property (weak, nonatomic) IBOutlet UIImageView *contentImg3;

+(instancetype)createCellWithTableView:(UITableView *)tableView;
@end
