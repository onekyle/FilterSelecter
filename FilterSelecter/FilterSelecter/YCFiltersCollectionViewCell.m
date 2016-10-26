//
//  YCFiltersCollectionViewCell.m
//  FilterSelecter
//
//  Created by Durand on 25/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "YCFiltersCollectionViewCell.h"

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
@property (nonatomic,copy) NSString *userDefaultKeyName;
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
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.item forKey:_userDefaultKeyName];
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

@interface YCFiltersCollectionViewCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) YCFiltersCollectionView *filtesCollectionView;
@property (nonatomic,copy) NSString *userDefaultKeyName;
@end

@implementation YCFiltersCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat w,h;
        w = frame.size.width;
        h = frame.size.height;
        _titleLabel = ({
            CGFloat labelW = 100;
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((w - labelW) / 2, 10, labelW, 16)];
            titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.7];
            titleLabel.font = [UIFont systemFontOfSize:14];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel;
        });
        [self.contentView addSubview:_titleLabel];
        
        
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout alloc];
        flowLayout.itemSize = CGSizeMake(60, 90);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 5;
        
        _filtesCollectionView = [[YCFiltersCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame) + 10, kCollectionViewWidth, 90) collectionViewLayout:flowLayout];
        _filtesCollectionView.contentInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _filtesCollectionView.pagingEnabled = NO;
        _filtesCollectionView.bounces = NO;
        _filtesCollectionView.showsHorizontalScrollIndicator = NO;
        _filtesCollectionView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_filtesCollectionView];
    }
    return self;
}

-(void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    _userDefaultKeyName = dataDict[@"userDefaultKeyName"];
    if (_userDefaultKeyName) {
        _filtesCollectionView.userDefaultKeyName = _userDefaultKeyName;
        NSInteger tag = [[NSUserDefaults standardUserDefaults] integerForKey:_userDefaultKeyName];
        [_filtesCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:tag inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    _titleLabel.text = dataDict[@"CellTitle"];
}

@end
