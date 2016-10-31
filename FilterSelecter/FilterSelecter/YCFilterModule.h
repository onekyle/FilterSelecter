//
//  YCFilterModule.h
//  FilterSelecter
//
//  Created by Durand on 26/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCFiltersCommonCell.h"

@interface YCFilterModule : UIView

@property (nonatomic,copy) NSArray *filtersViewData;
@property (nonatomic,copy) NSArray *choseBarData;

@property (nonatomic,copy) void(^selectedCellBlcok)(YCFiltersType type,NSUInteger index,NSString *key);

-(void)showInView:(UIView *)backView;
-(void)showInView:(UIView *)backView animated:(BOOL)animated;
-(void)disMiss;
@end
