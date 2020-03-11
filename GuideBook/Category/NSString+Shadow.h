//
//  NSString+Shadow.h
//  TechProject
//
//  Created by ck on 2019/3/28.
//  Copyright © 2019年 ZJE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Shadow)

- (NSMutableAttributedString *)addShadowWtihString:(NSString *)str color:(NSString *)hexColor;

- (NSMutableAttributedString *)addShadowColor:(NSString *)hexColor Font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
