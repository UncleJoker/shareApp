//
//  GuiBDetailViewController.h
//  GuideBook
//
//  Created by Apple on 2020/3/13.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GuiBBaseViewController.h"
#import "GuiBAddTrainModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GuiBDetailViewController : GuiBBaseViewController
@property (nonatomic, strong) GuiBAddTrainModel *model;
@property (nonatomic, assign) NSInteger selectIndex;// 当前处于那个数据
@end

NS_ASSUME_NONNULL_END
