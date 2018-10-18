//
//  HistoryRecordCell.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/10.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *redLine;
@property (weak, nonatomic) IBOutlet UILabel *title;
+(instancetype)createCellWithTableView:(UITableView *)tableView;
@end
