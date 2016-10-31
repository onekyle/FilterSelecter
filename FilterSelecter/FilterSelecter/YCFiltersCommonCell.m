//
//  YCFiltersCommonCell.m
//  FilterSelecter
//
//  Created by Durand on 28/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "YCFiltersCommonCell.h"

@implementation YCFiltersCommonCell
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
    }
    return self;
}

-(void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    _userDefaultKeyName = dataDict[@"userDefaultKeyName"];
    _titleLabel.text = dataDict[@"CellTitle"];
}

@end
