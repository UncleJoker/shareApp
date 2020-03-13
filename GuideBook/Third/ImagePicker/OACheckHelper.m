//
//  OACheckHelper.m
//  dpw
//
//  Created by senlin wang on 16/9/9.
//  Copyright © 2016年 qzpay. All rights reserved.
//

#import "OACheckHelper.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
@implementation OACheckHelper

/*!
 *  检测是否有通讯录的权限
 *
 *  @return yes就是有权限，no就是没有权限
 */
+(BOOL)CheckAddressBookAuthorization
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    
    __block BOOL result = YES;
    if (authStatus != kABAuthorizationStatusAuthorized)
    {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         if (error)
                                                         {
                                                             result = NO;
                                                         }
                                                         else if (!granted)
                                                         {
                                                             
                                                             result = NO;
                                                         }
                                                         else
                                                         {
                                                             result = YES;
                                                         }
                                                     });  
                                                 });  
    }
    else
    {
        result = YES;
    }
    return result;

}

/*!
 *  检测是否有定位的权限
 *
 *  @return yes就是有权限，no就是没有权限
 */
+ (BOOL)CheckLocationAuthorization {
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        //定位功能可用
        return YES;
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        //定位不能用
        return NO;
    }
    return NO;
}

/*!
 *  检测是否有拍照的权限
 *
 *  @return yes就是有权限，no就是没有权限
 */
+ (void)CheckCameraAuthorization:(void (^)(bool isAuthorized))block
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        block(NO);
    } else {
        block(YES);
    }
}


@end
