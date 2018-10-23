//
//  ClassContentCell3.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/23.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClassModel;
@interface ClassContentCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentTitle;
@property (weak, nonatomic) IBOutlet UIButton *contentCount;
@property (weak, nonatomic) IBOutlet UILabel *contentTime;

@property(nonatomic,strong)ClassModel *model;

+(instancetype)createCellWithTableView:(UITableView *)tableView;
@end
