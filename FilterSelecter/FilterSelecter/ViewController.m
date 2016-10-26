//
//  ViewController.m
//  FilterSelecter
//
//  Created by Durand on 25/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "ViewController.h"
#import "YCFilterSelecterView.h"
@interface ViewController ()
@property (nonatomic,strong) YCFilterSelecterView *flterView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = ({
        btn = [UIButton new];
        [btn setTitle:@"showFilter" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showFilter) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(150, 100, 100, 50);
        [self.view addSubview:btn];
        btn;
    });
    
    _flterView = ({
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout alloc];
        flowLayout.itemSize = CGSizeMake(kCollectionViewWidth, kCollectionViewHeight);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flterView = [[YCFilterSelecterView alloc] init];
        _flterView.frame = CGRectMake(0, self.view.frame.size.height - kCollectionViewHeight, kCollectionViewWidth, kCollectionViewHeight);
        [self.view addSubview:_flterView];
        _flterView;
    });
    
}

- (void)showFilter
{
    NSArray *array = @[
                       @{@"CellTitle": @"滤镜", @"userDefaultKeyName": @"LvJing"},
                       @{@"CellTitle": @"嫩肤", @"userDefaultKeyName": @"NenFu"},
                       @{@"CellTitle": @"大眼", @"userDefaultKeyName": @"DaYan"},
                       @{@"CellTitle": @"瘦脸", @"userDefaultKeyName": @"ShouLian"}
                       ];
    _flterView.dataSourceArray = array;
}

@end
