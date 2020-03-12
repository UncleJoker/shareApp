//
//  GBAddTrainModel.h
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBTrainModel.h"
#import "BGDB.h"
NS_ASSUME_NONNULL_BEGIN

@interface GBAddTrainModel : NSObject

@property (nonatomic, copy) NSString *trainTitle;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *trainAddress;

@property (nonatomic, strong) NSDictionary *trainDic;

@end

NS_ASSUME_NONNULL_END
