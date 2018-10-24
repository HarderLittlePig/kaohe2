//
//  IndexTableView.m
//  考核2
//
//  Created by iOS 开发 on 2018/10/24.
//  Copyright © 2018年 iOS 开发. All rights reserved.
//

#import "IndexTableView.h"
#import "IndexTableViewCell.h"

@implementation IndexTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 15;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
//        NSArray *testArr = @[@"悟空",@"沙僧",@"八戒", @"吴进", @"悟能", @"唐僧", @"诸葛亮", @"赵子龙",@"air", @"Asia", @"crash", @"basic", @"阿里郎"];
        self.array = [NSArray array];
        UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
        self.array = collation.sectionTitles;
        
//        collation.sectionIndexTitles
        //1.获取获取section标题
//        NSArray *titles = collation.sectionTitles;
        
        //2.构建每个section数组
//        NSMutableArray *secionArray = [NSMutableArray arrayWithCapacity:titles.count];
//        for (int i = 0; i < titles.count; i++) {
//            NSMutableArray *subArr = [NSMutableArray array];
//            [secionArray addObject:subArr];
//        }
        
        //3.排序
        //3.1 按照将需要排序的对象放入到对应分区数组
//        for (Person *person in personArr) {
//            NSInteger section = [collation sectionForObject:person collationStringSelector:@selector(name)];
//            NSMutableArray *subArr = secionArray[section];
//
//            [subArr addObject:person];
//        }
        
        //3.2 分别对分区进行排序
//        for (NSMutableArray *subArr in secionArray) {
//            NSArray *sortArr = [collation sortedArrayFromArray:subArr collationStringSelector:@selector(name)];
//            [subArr removeAllObjects];
//            [subArr addObjectsFromArray:sortArr];
//        }
    
    
    }
    return self;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
//}
//
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
//}



//- (NSInteger)sectionForSectionIndexTitleAtIndex:(NSInteger)indexTitleIndex;
//
//// Returns the index of the section that will contain the object.
//// selector must not take any arguments and return an NSString.
//- (NSInteger)sectionForObject:(id)object collationStringSelector:(SEL)selector;
//
//// Used for sorting objects within the same section.
//// selector must not take any arguments and return an NSString.
//// In the process of sorting the array, each object may receive
//// selector multiple times, so this method should be fast.
//- (NSArray *)sortedArrayFromArray:(NSArray *)array collationStringSelector:(SEL)selector;




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IndexTableViewCell *cell = [IndexTableViewCell createCellWithTableView:tableView];
    cell.title.text = self.array[indexPath.section];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    IndexTableViewCell *cell = [tableView cellForRowAtIndexPath:path];
    cell.title.backgroundColor = [UIColor colorWithRed:219/255.0 green:49/255.0 blue:23/255.0 alpha:1];
    cell.title.textColor = kWHITECOLOR;
    
//    [self.rightTable scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:NO];
//    [self.rightTable selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionTop];
//    NSLog(@"121313123232");
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    IndexTableViewCell *cell = [tableView cellForRowAtIndexPath:path];
    cell.title.backgroundColor = kWHITECOLOR;
    cell.title.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
}
@end
