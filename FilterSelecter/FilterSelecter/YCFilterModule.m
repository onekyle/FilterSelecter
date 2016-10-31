//
//  YCFilterModule.m
//  FilterSelecter
//
//  Created by Durand on 26/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "YCFilterModule.h"

#import "YCFilterSelecterView.h"
#import "YCChoseBarCollectionView.h"

@interface YCFilterModule ()<YCFiltersCommonCellDelegate,UICollectionViewDelegate>
@property (nonatomic,strong) YCFilterSelecterView *flterView;
@property (nonatomic,strong) YCChoseBarCollectionView *choseBar;
@property (nonatomic,strong) UIControl *backControl;
@property (nonatomic,assign) BOOL isShowing;
@property (nonatomic,strong) NSIndexPath *indexPathOfCentralCell;

@end

@implementation YCFilterModule

- (instancetype)init
{
    self = [super init];
    if (self) {
        _flterView = ({
            _flterView = [[YCFilterSelecterView alloc] init];
            _flterView.frame = CGRectMake(0, 0, kCollectionViewWidth, kCollectionViewHeight);
            _flterView.selectHandler = self;
            _flterView.delegate = self;
            _flterView;
        });
        [self addSubview:_flterView];
        
        _choseBar = ({
            _choseBar = [[YCChoseBarCollectionView alloc] initWithFrame:CGRectMake(0, kCollectionViewHeight, kCollectionViewWidth, 44)];
            _choseBar.delegate = self;
            _choseBar;
        });
        [self addSubview:_choseBar];
        
        _backControl = ({
            _backControl = [[UIControl alloc] init];
            _backControl.backgroundColor = [UIColor clearColor];
            [_backControl addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
            _backControl;
        });
    }
    return self;
}

-(void)setFiltersViewData:(NSArray *)filtersViewData
{
    _flterView.dataSourceArray = filtersViewData;
}

-(void)setChoseBarData:(NSArray *)choseBarData
{
    _choseBar.dataSourceArray = choseBarData;
}

-(void)showInView:(UIView *)backView;
{
    [self showInView:backView animated:YES];
}

-(void)showInView:(UIView *)backView animated:(BOOL)animated
{
    if (_isShowing) {
        return;
    }
    CGRect backFrame = backView.bounds;
    _backControl.frame = backFrame;
    [backView addSubview:_backControl];
    [backView addSubview:self];
    if (CGRectIsEmpty(self.frame)) {
        CGRect rect = backFrame;
        rect.origin.y = rect.size.height;
        self.frame = rect;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat h = kCollectionViewHeight + 44;
        self.frame = CGRectMake(0, backFrame.size.height - h, backFrame.size.width, h);
    } completion:^(BOOL finished) {
        _isShowing = YES;
    }];
}

-(void)disMiss
{
    if (!_isShowing) {
        return;
    }
    [_backControl removeFromSuperview];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.frame;
        rect.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _isShowing = NO;
    }];
}

#pragma mark YCFiltersCommonCellDelegate
-(void)didSelectedCommonCellWithType:(YCFiltersType)type index:(NSUInteger)index forFilterNameKey:(NSString *)key
{
    if (_selectedCellBlcok) {
        _selectedCellBlcok(type,index,key);
    }
}

#pragma mark CollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:_choseBar]) {
        [_flterView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_flterView]) {
        CGPoint centerPoint = CGPointMake(_flterView.frame.size.width / 2 + scrollView.contentOffset.x, 0);
        _indexPathOfCentralCell = [_flterView indexPathForItemAtPoint:centerPoint];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_flterView] ) {
        [_choseBar selectItemAtIndexPath:_indexPathOfCentralCell animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
}

@end
