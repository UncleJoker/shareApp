//
//  OACheckHelper.h
//  dpw
//
//  Created by senlin wang on 16/9/9.
//  Copyright © 2016年 qzpay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OACheckHelper : NSObject

/*!
 *  检测是否有通讯录的权限
 *
 *  @return yes就是有权限，no就是没有权限
 */
+(BOOL)CheckAddressBookAuthorization;

/*!
 *  检测是否有定位的权限
 *
 *  @return yes就是有权限，no就是没有权限
 */
+(BOOL)CheckLocationAuthorization;

/*!
 *  检测是否有拍照的权限
 *
 *  @return yes就是有权限，no就是没有权限
 */
+ (void)CheckCameraAuthorization:(void (^)(bool isAuthorized))block;


@end
