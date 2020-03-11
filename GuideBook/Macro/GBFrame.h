
//
//  GBFrame.h
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#ifndef GBFrame_h
#define GBFrame_h

#define GB_ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define GB_ScreenHeight ([[UIScreen mainScreen] bounds].size.height)

#define GB_isIphonex (GB_ScreenHeight >= 812 ? YES : NO)
#define NaviH (GB_ScreenHeight >= 812 ? 88 : 64)

#endif /* GBFrame_h */
