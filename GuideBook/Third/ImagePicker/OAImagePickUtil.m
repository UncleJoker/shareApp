//
//  OAImagePickUtil.m
//  dpwOA
//
//  Created by wsl on 16/5/26.
//  Copyright © 2016年 wsl. All rights reserved.
//

#import "OAImagePickUtil.h"
#import "JXActionSheet.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/ALAsset.h>
#import "HX_AlertView.h"
#import "OACheckHelper.h"
#import "TZImagePickerController.h"
@interface  OAImagePickUtil()<UIImagePickerControllerDelegate,TZImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *_imgsArray;
    
}
@property(nonatomic, weak)  UIViewController *control;
@property(nonatomic, strong)  UIImagePickerController *picker;

@end


@implementation OAImagePickUtil

+ (OAImagePickUtil *)sharedManager
{
    
    static OAImagePickUtil *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}


- (void)showSheet:(UIViewController *)parentControl withImageCount:(NSInteger)count
{
    _control = parentControl;
    
    if (_isCapturePic) {
        
        JXActionSheet *sheet = [[JXActionSheet alloc] initWithTitle:@"" cancelTitle:@"取消" otherTitles:@[@"从手机选择",@"拍照",@"一键抓图"]];
        
        [sheet showView];
        [sheet dismissForCompletionHandle:^(NSInteger clickedIndex, BOOL isCancel) {
            if (clickedIndex == 0) {
                
                TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count columnNumber:4 delegate:self];
                
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
                imagePickerVc.isSelectOriginalPhoto = YES;
                
                
                // 1.设置目前已经选中的图片数组
                //            imagePickerVc.selectedAssets = self.selectedAssets; // 目前已经选中的图片数组
                
                
                // 2. Set the appearance
                // 2. 在这里设置imagePickerVc的外观
                // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
                // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
                // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
                
                // 3. Set allow picking video & photo & originalPhoto or not
                // 3. 设置是否可以选择视频/图片/原图
                
                imagePickerVc.allowPickingImage = YES;
                imagePickerVc.allowPickingOriginalPhoto = YES;
                imagePickerVc.allowPickingVideo = NO;
                
                // 4. 照片排列按修改时间升序
                imagePickerVc.sortAscendingByModificationDate = YES;
#pragma mark - 到这里为止
                
                // You can get the photos by block, the same as by delegate.
                // 你可以通过block或者代理，来得到用户选择的照片.
                [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                    
                }];
                
                [self->_control presentViewController:imagePickerVc animated:YES completion:nil];
                
            }
            if (clickedIndex == 1) {
                /**
                 *  2016.9.3 韦朋新增
                 */
                
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
                    [OACheckHelper CheckCameraAuthorization:^(bool isAuthorized) {
                        if (isAuthorized == YES) {
                            self.picker = [[UIImagePickerController alloc] init];
                            [self.picker setDelegate:self];
                            [self.picker setSourceType:UIImagePickerControllerSourceTypeCamera];
                            [self.picker setAllowsEditing:YES];
                            //设置拍照后的图片可被编辑
                            self.picker.allowsEditing = NO;
                            self.picker.sourceType = sourceType;
                            [self->_control presentViewController:self.picker animated:YES completion:nil];
                        } else {
                            HX_AlertView *alertView = [[HX_AlertView alloc]initWithTitle:@"鉴权失败" message:@"拍照权限没有打开是否到设置-隐私界面打开它" parentControl:self->_control cancelButtonTitle:@"取消" otherButtonTitles:@"去设置" cancelButtonBlock:^{
                                
                            } otherButtonBlock:^{

                                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                }
                            }];
                            [alertView showAlertInView];
                        }
                    }];
                    
                }else{
                    NSLog(@"模拟无效,请真机测试");
                }
            }
            if (clickedIndex == 2) {
                //一键截取图片
                [self.delegate capturePic];
            }
        }];
    } else {
        
        JXActionSheet *sheet = [[JXActionSheet alloc] initWithTitle:@"" cancelTitle:@"取消" otherTitles:@[@"从手机选择",@"拍照"]];
        
        [sheet showView];
        [sheet dismissForCompletionHandle:^(NSInteger clickedIndex, BOOL isCancel) {
            if (clickedIndex == 0) {
                
                TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count columnNumber:4 delegate:self];
                
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
                imagePickerVc.isSelectOriginalPhoto = YES;
                
                
                // 1.设置目前已经选中的图片数组
                //            imagePickerVc.selectedAssets = self.selectedAssets; // 目前已经选中的图片数组
                
                
                // 2. Set the appearance
                // 2. 在这里设置imagePickerVc的外观
                // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
                // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
                // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
                
                // 3. Set allow picking video & photo & originalPhoto or not
                // 3. 设置是否可以选择视频/图片/原图
                
                imagePickerVc.allowPickingImage = YES;
                imagePickerVc.allowPickingOriginalPhoto = YES;
                imagePickerVc.allowPickingVideo = NO;
                
                // 4. 照片排列按修改时间升序
                imagePickerVc.sortAscendingByModificationDate = YES;
#pragma mark - 到这里为止
                
                // You can get the photos by block, the same as by delegate.
                // 你可以通过block或者代理，来得到用户选择的照片.
                [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                    
                }];
                
                [self->_control presentViewController:imagePickerVc animated:YES completion:nil];
                
            }
            if (clickedIndex == 1) {
                /**
                 *  2016.9.3 韦朋新增
                 */
                
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
                    [OACheckHelper CheckCameraAuthorization:^(bool isAuthorized) {
                        if (isAuthorized == YES) {
                            self.picker = [[UIImagePickerController alloc] init];
                            [self.picker setDelegate:self];
//                            [self.picker setSourceType:UIImagePickerControllerSourceTypeCamera];
//                            [self.picker setAllowsEditing:YES];
                            //设置拍照后的图片可被编辑
                            self.picker.allowsEditing = NO;
                            self.picker.sourceType = sourceType;
                            //                        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                            //                        self.picker.mediaTypes = @[(NSString *)kUTTypeMovie];
                            //                        [self.picker setCameraDevice:UIImagePickerControllerCameraDeviceFront];
                            //                picker.modalTransitionStyle = UIModalPresentationOverCurrentContext;
                            
                            [self->_control presentViewController:self.picker animated:YES completion:nil];
                        } else {
                            HX_AlertView *alertView = [[HX_AlertView alloc]initWithTitle:@"鉴权失败" message:@"拍照权限没有打开是否到设置-隐私界面打开它" parentControl:self->_control cancelButtonTitle:@"取消" otherButtonTitles:@"去设置" cancelButtonBlock:^{
                                
                            } otherButtonBlock:^{

                                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                }
                            }];
                            [alertView showAlertInView];
                        }
                    }];
                    
                }else{
                    NSLog(@"模拟无效,请真机测试");
                }
            }

        }];
    }
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
   [self.imgsArray removeAllObjects];
    
    [self.imgsArray addObjectsFromArray:photos];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickPhotoWithImage:)]) {
        
        [self.delegate pickPhotoWithImage:_imgsArray];
        
    }
    
}


#pragma mark - ELCImagePickerControllerDelegate


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    [self.imgsArray removeAllObjects];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.imgsArray addObject:image];
        if (self.delegate && [self.delegate respondsToSelector:@selector(pickPhotoWithImage:)]) {
//            [_control dismissViewControllerAnimated:YES completion:nil];
            [self.delegate pickPhotoWithImage:self->_imgsArray];
        }
    }];



}

-(NSMutableArray*)imgsArray {
    
    if (_imgsArray == nil) {
        
        _imgsArray = [NSMutableArray new];
    }
    
    return _imgsArray;
}

//- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}

@end
