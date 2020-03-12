//
//  GBSetTableHeadView.h
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HeadViewDelegate <NSObject>

- (void)tapHeadView;

@end 

@interface GBSetTableHeadView : UIView
@property (nonatomic, strong) id<HeadViewDelegate> headDelegate;
@end

NS_ASSUME_NONNULL_END
