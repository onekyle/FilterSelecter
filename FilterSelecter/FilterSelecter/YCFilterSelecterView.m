//
//  YCFilterSelecterView.m
//  FilterSelecter
//
//  Created by Durand on 25/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "YCFilterSelecterView.h"

#import "YCFiltersCollectionViewCell.h"
#import "YCBeautyFilterCollectionViewCell.h"


static NSString *testCellID = @"testCellID";
static NSString *YCFiltersCollectionviewCellID = @"YCFiltersCollectionviewCellID";
static NSString *YCBeautyFilterCollectionViewCellID = @"YCBeautyFilterCollectionViewCellID";

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
    self.backgroundColor = [UIColor darkGrayColor];
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:testCellID];
    [self registerClass:[YCFiltersCollectionViewCell class] forCellWithReuseIdentifier:YCFiltersCollectionviewCellID];
    [self registerClass:[YCBeautyFilterCollectionViewCell class] forCellWithReuseIdentifier:YCBeautyFilterCollectionViewCellID];

    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setDataSourceArray:(NSArray *)dataSourceArray
{
    _dataSourceArray = dataSourceArray;
    [self reloadData];
}
#pragma mark -delegate
//-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

#pragma mark - datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuserID = indexPath.item ? YCBeautyFilterCollectionViewCellID : YCFiltersCollectionviewCellID;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuserID forIndexPath:indexPath];
    if (indexPath.item) {
        ((YCBeautyFilterCollectionViewCell *) cell).dataDict = _dataSourceArray[indexPath.item];
    }
    else
    {
        ((YCFiltersCollectionViewCell *) cell).dataDict = _dataSourceArray[indexPath.item];
    }
    return cell;
}


@end
