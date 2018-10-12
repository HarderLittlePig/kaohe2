//
//  ClassVCCell.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/8.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClassModel;

@interface ClassContentCell1 : UITableViewCell
@property(nonatomic,strong)ClassModel *model;
+(instancetype)createCellWithTableView:(UITableView *)tableView;

@end
