//
//  InformationPersonalPageCell1.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/16.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>
//单张图片  普通类型
@interface InformationPersonalPageCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *timeLine;
@property (weak, nonatomic) IBOutlet UIView *timeLineBall;
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *title;

+(instancetype)createCellWithTableView:(UITableView *)tableView;
@end
