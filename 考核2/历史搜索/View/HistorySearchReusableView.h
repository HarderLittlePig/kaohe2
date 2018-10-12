//
//  HistorySearchReusableView.h
//  考核2
//
//  Created by iOS 开发 on 2018/10/12.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteBlock) (void);
@interface HistorySearchReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *sectionImg;
@property (weak, nonatomic) IBOutlet UILabel *sectionLab;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property(nonatomic,copy)DeleteBlock deleteBlock;
@end
