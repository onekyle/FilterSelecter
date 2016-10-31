//
//  YCFiltersCommonCell.h
//  FilterSelecter
//
//  Created by Durand on 28/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YCFiltersType) {
    YCFiltersTypeLvJing, // 滤镜
    YCFiltersTypeNenFu, // 嫩肤
    YCFiltersTypeDaYan, // 大眼
    YCFiltersTypeShouLian, // 瘦脸
};

@protocol YCFiltersCommonCellDelegate <NSObject>

- (void)didSelectedCommonCellWithType:(YCFiltersType)type index:(NSUInteger)index forFilterNameKey:(NSString *)key;

@end

@interface YCFiltersCommonCell : UICollectionViewCell
{
    NSDictionary *_dataDict;
    NSString *_userDefaultKeyName;
    UILabel *_titleLabel;
}
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,copy) NSDictionary *dataDict;
@property (nonatomic,copy) NSString *userDefaultKeyName;
@property (nonatomic,weak) id<YCFiltersCommonCellDelegate> delegate;
@property (nonatomic,assign) YCFiltersType type;
@end
