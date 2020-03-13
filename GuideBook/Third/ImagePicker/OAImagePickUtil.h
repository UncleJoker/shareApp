//
//  OAImagePickUtil.h
//  dpwOA
//
//  Created by wsl on 16/5/26.
//  Copyright © 2016年 wsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  OAImagePickUtilDelegate<NSObject>

@optional
//imgsAry返回的内容是uiimage
- (void)pickPhotoWithImage:(NSArray *)imgsAry;

//imgsAry返回的内容是uiimage的URL
- (void)pickPhotoWithImageUrl:(NSArray *)urlAry;

//一键截取图片
- (void)capturePic;

@end

@interface OAImagePickUtil : NSObject
+ (OAImagePickUtil *)sharedManager;
- (void)showSheet:(UIViewController *)parentControl withImageCount:(NSInteger)count;
@property (nonatomic, weak) id<OAImagePickUtilDelegate>delegate;
//是否有一键截取图片功能
@property (nonatomic, assign) BOOL isCapturePic;

@end
