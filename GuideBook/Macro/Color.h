
//
//  Color.h
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#ifndef Color_h
#define Color_h

#define HexColor(__HEX)    [GBMethodTools colorFromHexString:__HEX]

#define Commom_BackgroundColor RGB(236, 239, 241)
#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define Main_BackGroundColor HexColor(@"#567237")

#endif /* Color_h */
