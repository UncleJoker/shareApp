
//
//  Function.h
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#ifndef Function_h
#define Function_h


#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

#define IMG(__IMAGENAME)    [UIImage imageNamed:__IMAGENAME]

#define TRainDataJSON @"TrainData"
#define RankTrainJSON @"RankTrain"
#define SaveTrainName @"SaveTrainArr"
#define AddSunccessNotice @"SaveSuccess"
#define TrainNumbers @"TrainNumbers"
#define UserName @"userName"
#define UserSaying @"userSaying"

#define WEAKSELF(weakSelf)  __weak __typeof(self)weakSelf = self;

#endif /* Function_h */
