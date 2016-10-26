//
//  YCBeautyFilterCollectionViewCell.m
//  FilterSelecter
//
//  Created by Durand on 26/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "YCBeautyFilterCollectionViewCell.h"

#define kLevelCount 5

@interface YCBeautyFilterCollectionViewCell ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,weak) UIButton *currentSelectedBtn;
@property (nonatomic,copy) NSString *userDefaultKeyName;
@end

@implementation YCBeautyFilterCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIWithFrame:frame];
    }
    return self;
}

- (void)setupUIWithFrame:(CGRect)frame
{
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
    
    CGFloat sideMargin = 15;
    CGFloat btnWH = 50;
    CGFloat btnGap = ((w - 2 * 15) - 50 * kLevelCount) / (kLevelCount - 1);
    CGFloat btnY = CGRectGetMaxY(_titleLabel.frame) + 20;
    for (int i = 0; i < kLevelCount; i ++) {
        UIButton *btn = ({
            btn = [[UIButton alloc] initWithFrame:CGRectMake(sideMargin + i * (btnWH + btnGap), btnY, btnWH, btnWH)];
            btn.tag = 1000 + i;
            btn.layer.cornerRadius = btnWH / 2;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = PEACHBLOWCOLOR.CGColor;
            btn.layer.masksToBounds = YES;
            [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            [btn setTitleColor:PEACHBLOWCOLOR forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:18];
            [btn addTarget:self action:@selector(didClickBeutyFilter:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
        [self.contentView addSubview:btn];
    }
}

-(void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    _userDefaultKeyName = dataDict[@"userDefaultKeyName"];
    if (_userDefaultKeyName) {
        NSInteger tag = [[NSUserDefaults standardUserDefaults] integerForKey:_userDefaultKeyName];
        tag = tag ? tag : 1000;
        UIButton *btn = [self.contentView viewWithTag:tag];
        _currentSelectedBtn.selected = NO;
        btn.selected = YES;
        _currentSelectedBtn = btn;
    }
    _titleLabel.text = dataDict[@"CellTitle"];
}


-(void)didClickBeutyFilter:(UIButton *)sender
{
    if ([_currentSelectedBtn isEqual:sender]) {
        return;
    }
    _currentSelectedBtn.selected = NO;
    sender.selected = YES;
    _currentSelectedBtn = sender;
    [[NSUserDefaults standardUserDefaults] setInteger:sender.tag forKey:_userDefaultKeyName];
//    NSLog(@"sender: %zd",sender.tag);
}
@end
