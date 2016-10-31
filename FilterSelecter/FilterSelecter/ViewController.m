//
//  ViewController.m
//  FilterSelecter
//
//  Created by Durand on 25/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "ViewController.h"
#import "YCFilterModule.h"
@interface ViewController ()
@property (nonatomic,strong) YCFilterModule *flterView;
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
        _flterView = [[YCFilterModule alloc] init];
        [_flterView setSelectedCellBlcok:^(YCFiltersType type, NSUInteger index, NSString *key) {
            NSLog(@"didClickType:%zd, index: %zd, key: %@",type,index,key);
            [[NSUserDefaults standardUserDefaults] setInteger:index forKey:key];
        }];
        _flterView;
    });
    
}

- (void)showFilter
{
    NSArray *filtersArray = @[
                       @{@"CellTitle": @"滤镜", @"userDefaultKeyName": @"LvJing"},
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
    _flterView.filtersViewData = filtersArray;
    _flterView.choseBarData = choseBarArray;
    [_flterView showInView:self.view.window];
}

@end
