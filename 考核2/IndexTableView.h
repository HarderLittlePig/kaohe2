//
//  IndexTableView.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/24.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *array;
@property(nonatomic,copy)void(^clickIndexBlock)(NSInteger sectionIndex);
@end
