//
//  ViewController.m
//  FilterSelecter
//
//  Created by Durand on 25/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "ViewController.h"
#import "YCFilterModule.h"
@interface ViewController ()<YCFilterModuleDelegate>
@property (nonatomic,strong) YCFilterModule *filterView;
@property (nonatomic,copy) NSArray *lvjingFilters;
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
    
}

- (void)showFilter
{
    [self.filterView showInView:self.view.window];
}

#pragma mark - YCFilterModuleDelegate
-(void)didSelectedFiltesWithType:(YCFiltersType)type index:(NSUInteger)index forFilterNameKey:(NSString *)key
{
    NSLog(@"didClickType:%zd, index: %zd, key: %@",type,index,key);
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:key];
}


-(YCFilterModule *)filterView
{
    if (!_filterView) {
        _filterView = [[YCFilterModule alloc] init];
        _filterView.delegate = self;
        NSArray *filtersArray = @[
                                  @{@"CellTitle": @"滤镜", @"userDefaultKeyName": @"LvJing",
                                    @"sonCellTitles":@[
                                            @"原图",
                                            @"甜昔",
                                            @"春光",
                                            @"清风",
                                            @"粉黛",
                                            @"海滩",
                                            @"晨曦",
                                            @"白露",
                                            @"嫩枝",
                                            @"薄暮",
                                            @"胶片",
                                            @"橘彩",
                                            @"魅影",
                                            @"暖茶",
                                            @"夜梦",
                                            ],
                                    @"sonCellImageNames":self.lvjingFilters,
                                    },
                                  @{@"CellTitle": @"嫩肤", @"userDefaultKeyName": @"NenFu"},
                                  @{@"CellTitle": @"大眼", @"userDefaultKeyName": @"DaYan"},
                                  @{@"CellTitle": @"瘦脸", @"userDefaultKeyName": @"ShouLian"}
                                  ];
        NSArray *choseBarArray = @[
                                   @"lvjing",
                                   @"nenfu",
                                   @"dayan",
                                   @"shoulian",
                                   ];
        _filterView.filtersViewData = filtersArray;
        _filterView.choseBarData = choseBarArray;
    }
    return _filterView;
}


-(NSArray *)lvjingFilters
{
    if (!_lvjingFilters) {
        _lvjingFilters = @[
                           @"10000_4",
                           @"10001_4",
                           @"10002_4",
                           @"10003_4",
                           @"10004_4",
                           @"10005_4",
                           @"10014_3",
                           @"10015_4",
                           @"10016_4",
                           @"10020_4",
                           @"10021_4",
                           @"10022_2",
                           @"10023_5",
                           @"10024_3",
                           @"10026_2",
                           ];
    }
    return _lvjingFilters;
}



@end
