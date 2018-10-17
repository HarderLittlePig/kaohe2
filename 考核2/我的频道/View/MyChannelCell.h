//
//  MyChannelCell.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/9.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteBlock)(void);
@interface MyChannelCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property(nonatomic,copy)DeleteBlock deleteBlock;
@end
