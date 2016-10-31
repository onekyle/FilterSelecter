//
//  YCChoseBarCollectionView.m
//  FilterSelecter
//
//  Created by Durand on 28/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "YCChoseBarCollectionView.h"

@interface YCChoseBarCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *selectedImageName;
@end

@implementation YCChoseBarCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconImageView = ({
            _iconImageView = [[UIImageView  alloc] initWithFrame:self.bounds];
            _iconImageView.contentMode = UIViewContentModeCenter;
//            _iconImageView.backgroundColor = [UIColor blackColor];
//            _iconImageView.userInteractionEnabled = YES;
            _iconImageView;
        });
        [self.contentView addSubview:_iconImageView];
    }
    return self;
}

-(void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    _iconImageView.image = [UIImage imageNamed:imageName];
    _selectedImageName = [imageName stringByAppendingString:@"_selected"];
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    NSString *currentImageName = selected ? _selectedImageName : _imageName;
    _iconImageView.image = [UIImage imageNamed:currentImageName];
}

@end

static NSString *YCChoseBarCellID = @"YCChoseBarCellID";

@implementation YCChoseBarCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout alloc];
    flowLayout.itemSize = CGSizeMake(frame.size.width/4, frame.size.height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        // 构造函数，完成之后内部属性才会被创建
        self.pagingEnabled = YES;
        self.bounces = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        //    self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        _isFirstShow = YES;
        [self registerClass:[YCChoseBarCell class] forCellWithReuseIdentifier:YCChoseBarCellID];
        UIView *seperatorView = ({
            seperatorView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, frame.size.width - 30, 1)];
            seperatorView.backgroundColor = [UIColor darkGrayColor];
            seperatorView;
        });
        [self addSubview:seperatorView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_isFirstShow) {
        _isFirstShow = NO;
        [self selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YCChoseBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YCChoseBarCellID forIndexPath:indexPath];
    NSInteger index = indexPath.item;
    cell.imageName = _dataSourceArray[index];

    return cell;
}

@end
