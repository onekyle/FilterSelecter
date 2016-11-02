//
//  YCFilterModule.h
//  FilterSelecter
//
//  Created by Durand on 26/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "YCFiltersCommonCell.h"

@protocol YCFilterModuleDelegate <NSObject>

- (void)didSelectedFiltesWithType:(YCFiltersType)type index:(NSUInteger)index forFilterNameKey:(NSString *)key;

@end

@interface YCFilterModule : UIView

@property (nonatomic,weak) id<YCFilterModuleDelegate> delegate;
@property (nonatomic,copy) NSArray *filtersViewData;
@property (nonatomic,copy) NSArray *choseBarData;

@property (nonatomic,strong) UIControl *backControl;

@property (nonatomic,copy) void(^selectedCellBlcok)(YCFiltersType type,NSUInteger index,NSString *key);

-(void)showInView:(UIView *)backView;
-(void)showInView:(UIView *)backView animated:(BOOL)animated;
-(void)disMiss;
@end
