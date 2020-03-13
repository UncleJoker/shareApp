//
//  GBUserInfoTableViewCell.h
//  GuideBook
//
//  Created by Apple on 2020/3/13.
//  Copyright © 2020 Design. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GBUserInfoTableViewCell : UITableViewCell

- (void)showCellImage:(BOOL)isShow;

- (void)setHeadImage:(NSString *)imageFile;

- (void)setCellTitle:(NSString *)title;

- (void)setDescString:(NSString *)desc;

@end

NS_ASSUME_NONNULL_END
