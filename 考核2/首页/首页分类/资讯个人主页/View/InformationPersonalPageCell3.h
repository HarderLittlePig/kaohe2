//
//  InformationPersonalPageCell3.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/23.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>
//没有图片
@interface InformationPersonalPageCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *timeLine;
@property (weak, nonatomic) IBOutlet UIView *timeLineBall;
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *lookCount;
@property (weak, nonatomic) IBOutlet UILabel *publishTime;

+(instancetype)createCellWithTableView:(UITableView *)tableView;
@end
