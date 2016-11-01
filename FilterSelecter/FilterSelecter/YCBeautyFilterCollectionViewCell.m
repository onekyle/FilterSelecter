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
@property (nonatomic,weak) UIButton *currentSelectedBtn;
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
    
    CGFloat sideMargin = 15;
    CGFloat btnWH = 50;
    CGFloat btnGap = ((w - 2 * 15) - 50 * kLevelCount) / (kLevelCount - 1);
    CGFloat btnY = CGRectGetMaxY(_titleLabel.frame) + 20;
    UIImage *normalImg = [UIImage imageNamed:@"Oval"];
    UIImage *selectedImg = [UIImage imageNamed:@"Oval_selected"];
    for (int i = 0; i < kLevelCount; i ++) {
        UIButton *btn = ({
            btn = [[UIButton alloc] initWithFrame:CGRectMake(sideMargin + i * (btnWH + btnGap), btnY, btnWH, btnWH)];
            btn.tag = 1000 + i;
//            btn.layer.cornerRadius = btnWH / 2;
//            btn.layer.borderWidth = 1;
//            btn.layer.borderColor = PEACHBLOWCOLOR.CGColor;
//            btn.layer.masksToBounds = YES;
            [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            [btn setTitleColor:PEACHBLOWCOLOR forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setBackgroundImage:normalImg forState:UIControlStateNormal];
            [btn setBackgroundImage:selectedImg forState:UIControlStateSelected];
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
        tag = tag + 1000;
        UIButton *btn = [self.contentView viewWithTag:tag];
//        [self changeBtnSelectedStatusTo:NO button:_currentSelectedBtn];
//        [self changeBtnSelectedStatusTo:YES button:btn];
        _currentSelectedBtn.selected = NO;
        btn.selected = YES;
        _currentSelectedBtn = btn;
    }
    _titleLabel.text = dataDict[@"CellTitle"];
}

//-(void)changeBtnSelectedStatusTo:(BOOL)selected button:(UIButton *)btn
//{
//    btn.selected = selected;
//    btn.backgroundColor = selected ? _btnSelectedColor : [UIColor clearColor];
//}

-(void)didClickBeutyFilter:(UIButton *)sender
{
    if ([_currentSelectedBtn isEqual:sender]) {
        return;
    }
//    [self changeBtnSelectedStatusTo:NO button:_currentSelectedBtn];
//    [self changeBtnSelectedStatusTo:YES button:sender];
    _currentSelectedBtn.selected = NO;
    sender.selected = YES;
    _currentSelectedBtn = sender;
    [self.delegate didSelectedCommonCellWithType:self.type index:(sender.tag - 1000) forFilterNameKey:_userDefaultKeyName];
//    [[NSUserDefaults standardUserDefaults] setInteger:sender.tag forKey:_userDefaultKeyName];
//    NSLog(@"sender: %zd",sender.tag);
}
@end
