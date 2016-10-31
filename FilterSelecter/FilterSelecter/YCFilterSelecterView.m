//
//  YCFilterSelecterView.m
//  FilterSelecter
//
//  Created by Durand on 25/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "YCFilterSelecterView.h"

#import "YCFiltersCommonCell.h"
#import "YCFiltersCollectionViewCell.h"
#import "YCBeautyFilterCollectionViewCell.h"


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
    [self registerClass:[YCFiltersCollectionViewCell class] forCellWithReuseIdentifier:YCFiltersCollectionviewCellID];
    [self registerClass:[YCBeautyFilterCollectionViewCell class] forCellWithReuseIdentifier:YCBeautyFilterCollectionViewCellID];

    
    return self;
}

-(void)setDataSourceArray:(NSArray *)dataSourceArray
{
    _dataSourceArray = dataSourceArray;
    [self reloadData];
}

#pragma mark -delegate

#pragma mark - datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.item;
    NSString *reuserID = index ? YCBeautyFilterCollectionViewCellID : YCFiltersCollectionviewCellID;
    YCFiltersCommonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuserID forIndexPath:indexPath];
    cell.delegate = _selectHandler;
    cell.type = index;
    if (index) {
        ((YCBeautyFilterCollectionViewCell *) cell).dataDict = _dataSourceArray[index];
    }
    else
    {
        ((YCFiltersCollectionViewCell *) cell).dataDict = _dataSourceArray[index];
    }
    return cell;
}


@end
