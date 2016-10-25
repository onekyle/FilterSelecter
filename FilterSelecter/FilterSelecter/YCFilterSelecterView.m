//
//  YCFilterSelecterView.m
//  FilterSelecter
//
//  Created by Durand on 25/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "YCFilterSelecterView.h"

#import "YCFiltesCollectionViewCell.h"

#define kCollectionViewWidth ([UIScreen mainScreen].bounds.size.width)
#define kCollectionViewHeight (kCollectionViewWidth / 375 * 120)

static NSString *testCellID = @"testCellID";
static NSString *YCFiltersCollectionviewCellID = @"YCFiltersCollectionviewCellID";
@interface YCFilterSelecterView () <UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation YCFilterSelecterView
- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout alloc];
    flowLayout.itemSize = CGSizeMake(kCollectionViewWidth, kCollectionViewHeight);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    // 构造函数，完成之后内部属性才会被创建
    self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.pagingEnabled = YES;
    self.bounces = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.dataSource = self;
    self.delegate = self;
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:testCellID];
    [self registerClass:[YCFiltesCollectionViewCell class] forCellWithReuseIdentifier:YCFiltersCollectionviewCellID];
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark -delegate
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuserID = indexPath.item ? testCellID : YCFiltersCollectionviewCellID;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuserID forIndexPath:indexPath];
    cell.backgroundColor = [self randomColor];
    return cell;
}


-(UIColor *)randomColor
{
    CGFloat r  = (arc4random() % 256) / 255.0;
    CGFloat g = (arc4random() % 256) / 255.0;
    CGFloat b = (arc4random() % 256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}


@end
