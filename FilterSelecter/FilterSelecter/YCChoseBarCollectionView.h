//
//  YCChoseBarCollectionView.h
//  FilterSelecter
//
//  Created by Durand on 28/10/16.
//  Copyright © 2016年 com.Durand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCChoseBarCollectionView : UICollectionView<UICollectionViewDataSource>
@property (nonatomic,copy) NSArray<NSString *> *dataSourceArray;
@property (nonatomic,assign) BOOL isFirstShow;
@end

