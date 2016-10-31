//
//  UIView+BlurBack.m
//  FilterSelecter
//
//  Created by Durand on 27/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import "UIView+BlurBack.h"

@implementation UIView (BlurBack)
- (void)setBlurBackground:(UIBlurEffectStyle)effectStyle {
    UIVisualEffectView * blurEffectView = (UIVisualEffectView *)[self viewWithTag:30002];
    if (blurEffectView) {
        return;
    }
    
    if (NSClassFromString(@"UIBlurEffect")) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (!window) {
            window = [[UIApplication sharedApplication].windows objectAtIndex:0];
        }
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        //初始化 模糊效果的 UIVisualEffectView
        UIVisualEffectView * blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.tag = 30002;
        //////////////////////////////////////////////////////////////////////////
        //设置 blurEffectView 的 frame
        //        blurEffectView.frame = self.view.bounds;
        blurEffectView.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(window.frame), CGRectGetHeight(self.frame)) ;
        
        //添加 blurEffectView 到 self.View 上,如果只是做模糊效果，那么到这一步已经完了
        [self insertSubview:blurEffectView atIndex:0];
        //        [_headView_back addSubview:blurEffectView];
        
        //初始化 Vibrancy 类型的 UIVisualEffect，vibrancyEffect 也是UIVisualEffect 的子类，而且初始化这个 Effect 需要用到 blurEffect，我们就还用上面的好了，假如重新初始化一个 blurEffect，要注意这个新的 blurEffect 的 style 要和上面的保持一致，不然就实现不了 Vibrancy效果
        UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
        
        //初始化 Vibrancy 效果的 UIVisualEffectView
        UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
        
        //设置 vibrancyEffectView 的frame
        vibrancyEffectView.frame = blurEffectView.bounds;
        
        
        //注意是 blurEffectView.contentView. 苹果官方注释说了  Do not add subviews directly to UIVisualEffectView, use this view instead
        [blurEffectView.contentView addSubview:vibrancyEffectView];
        //////////////////////////////////////////////////////////////////////////
        //    [self addSubview:self.contentView];
        //        [blurEffectView.contentView addSubview:_headView_back];
    } else {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85f];
    }
}

- (void)setBlurBackgroundWithDarkStyle {
    [self setBlurBackground:UIBlurEffectStyleDark];
}
@end
