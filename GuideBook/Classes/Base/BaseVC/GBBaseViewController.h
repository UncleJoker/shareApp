//
//  BaseViewController.h
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GBBaseViewController : UIViewController
/**
 *   *  根据标题navigationRightItem
 *
 *  @param title  title description
 *  @param target target description
 *  @param action action description
 */
- (void)setNavigationRightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;


@end

NS_ASSUME_NONNULL_END
