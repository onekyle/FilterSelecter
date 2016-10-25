//
//  YCFiltesCollectionViewCell.m
//  FilterSelecter
//
//  Created by Durand on 25/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "YCFiltesCollectionViewCell.h"

@interface YCSingleFilterCell : UICollectionViewCell
@property (nonatomic,copy) NSString *filterName;
@property (nonatomic,strong) UIView *filterIconView;
@property (nonatomic,strong) UILabel *filterNameLabel;
@end

@implementation YCSingleFilterCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _filterIconView = ({
            _filterIconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, kFilterCollectionViewCellSize)];
            _filterIconView.backgroundColor = [self randomColor];
            [self.contentView addSubview:_filterIconView];
            _filterIconView;
        });
        
        _filterNameLabel = ({
            CGFloat labelH = 30;
            _filterNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - labelH, frame.size.width, labelH)];
            _filterNameLabel.textColor = [UIColor blackColor];
            _filterNameLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:_filterNameLabel];
            _filterNameLabel;
        });
    }
    return self;
}

-(void)setFilterName:(NSString *)filterName
{
    _filterNameLabel.text = filterName;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        _filterIconView.layer.borderColor = [UIColor cyanColor].CGColor;
        _filterIconView.layer.borderWidth = 3;
        _filterIconView.layer.cornerRadius = 2;
        _filterIconView.layer.masksToBounds = YES;
        _filterNameLabel.textColor = [UIColor cyanColor];
    }
    else {
        _filterIconView.layer.borderColor = nil;
        _filterIconView.layer.borderWidth = 0;
        _filterIconView.layer.cornerRadius = 0;
        _filterIconView.layer.masksToBounds = NO;
        _filterNameLabel.textColor = [UIColor blackColor];
    }
}

-(UIColor *)randomColor
{
    CGFloat r  = (arc4random() % 256) / 255.0;
    CGFloat g = (arc4random() % 256) / 255.0;
    CGFloat b = (arc4random() % 256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}



@end

static NSString *YCSingleFilterCellID = @"YCSingleFilterCellID";

@interface YCFiltersCollectionView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,assign) NSUInteger currentIndex;
@end

@implementation YCFiltersCollectionView
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[YCSingleFilterCell class] forCellWithReuseIdentifier:YCSingleFilterCellID];
    }
    return self;
}

#pragma mark -delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == _currentIndex) {
        return;
    }
    UICollectionViewCell *oldCell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0]];
    UICollectionViewCell *currentCell = [collectionView cellForItemAtIndexPath:indexPath];
    _currentIndex = indexPath.item;
    currentCell.selected = YES;
    oldCell.selected = NO;
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}

#pragma mark - datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YCSingleFilterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YCSingleFilterCellID forIndexPath:indexPath];
    cell.filterName = [NSString stringWithFormat:@"第%zd个",indexPath.item];
    return cell;
}


@end

@interface YCFiltesCollectionViewCell ()
@property (nonatomic,strong) YCFiltersCollectionView *filtesCollectionView;
@end

@implementation YCFiltesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout alloc];
        flowLayout.itemSize = CGSizeMake(60, 90);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 5;
        
        _filtesCollectionView = [[YCFiltersCollectionView alloc] initWithFrame:CGRectMake(0, 35, kCollectionViewWidth, 90) collectionViewLayout:flowLayout];
        _filtesCollectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _filtesCollectionView.pagingEnabled = NO;
        _filtesCollectionView.bounces = NO;
        _filtesCollectionView.showsHorizontalScrollIndicator = NO;
        _filtesCollectionView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_filtesCollectionView];
    }
    return self;
}


@end
