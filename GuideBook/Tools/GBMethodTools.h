//
//  GBMethodTools.h
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GBMethodTools : NSObject

+ (UIColor *) colorFromHexString:(NSString *)hexString;

+ (UIImage *) createImageWithColor: (UIColor *) color;

@end

NS_ASSUME_NONNULL_END
