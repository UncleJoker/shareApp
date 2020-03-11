//
//  AddButton.m
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBAddButton.h"
#import "AxcAE_TabBar.h"

@implementation GBAddButton

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (self.isHidden == NO) {
        for (UIView *subView in self.subviews) {
            CGPoint myPoint = [subView convertPoint:point fromView:self];
            if (myPoint.y < 0) {
                if ([subView isKindOfClass:[AxcAE_TabBar class]]) {
                    for (UIView *axcTabBarItem in subView.subviews) {
                        if ([axcTabBarItem isKindOfClass:[AxcAE_TabBarItem class]]) {
                            if (CGRectContainsPoint(axcTabBarItem.frame, myPoint)) {
                                return axcTabBarItem;
                            }
                        }
                    }
                }
            }
        }
        return view;
    } else {
        return view;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
