//
//  NSString+Shadow.m
//  TechProject
//
//  Created by ck on 2019/3/28.
//  Copyright © 2019年 ZJE. All rights reserved.
//

#import "NSString+Shadow.h"

@implementation NSString (Shadow)
- (NSMutableAttributedString *)addShadowWtihString:(NSString *)str color:(NSString *)hexColor
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 1.0;
    shadow.shadowColor = HexColor(hexColor);
    shadow.shadowOffset = CGSizeMake(1,1 );
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName: [UIFont fontWithName:@"MicrosoftYaHei" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0], NSShadowAttributeName: shadow}];
    return string;
}

- (NSMutableAttributedString *)addShadowColor:(NSString *)hexColor Font:(UIFont *)font
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 1.0;
    shadow.shadowColor = HexColor(hexColor);
    shadow.shadowOffset = CGSizeMake(1,1 );
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName: font,NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0], NSShadowAttributeName: shadow}];
    return string;
}

@end
