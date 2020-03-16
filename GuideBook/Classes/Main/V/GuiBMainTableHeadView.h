//
//  GuiBMainTableHeadView.h
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GBMainBtnDelegate <NSObject>

// 轮播图点击事件
- (void)tapCycleImageIndex:(NSInteger)tapIndex;

// 功能按钮点击事件
- (void)tapFunctionIndex:(NSInteger)selectIndex;

@end

@interface GuiBMainTableHeadView : UIView
@property (nonatomic, weak) id<GBMainBtnDelegate> btnDelegate;
@end

NS_ASSUME_NONNULL_END
