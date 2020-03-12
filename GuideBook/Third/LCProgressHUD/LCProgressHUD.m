

#import "LCProgressHUD.h"

// 背景视图的宽度/高度
#define BGVIEW_WIDTH 100.0f
// 文字大小
#define TEXT_SIZE    16.0f

@implementation LCProgressHUD

+ (instancetype)sharedHUD {
    
    static LCProgressHUD *hud;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        hud = [[LCProgressHUD alloc] initWithFrame:CGRectMake(0, NaviH, GB_ScreenWidth,GB_ScreenHeight - NaviH)];
     
        
        
    });
    return hud;
}

+ (void)showStatus:(LCProgressHUDStatus)status text:(NSString *)text toView:(UIView *)view{
    
    LCProgressHUD *hud = [LCProgressHUD sharedHUD];
    [hud show:YES];
    [hud setShowNow:YES];
    [hud setLabelText:text];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setLabelFont:[UIFont systemFontOfSize:TEXT_SIZE]];
    [hud setMinSize:CGSizeMake(BGVIEW_WIDTH, BGVIEW_WIDTH)];
    if (view == nil) {
     [[[UIApplication sharedApplication].delegate window] addSubview:hud];
    
    } else {
      [view  addSubview:hud];
    }

    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"LCProgressHUD" ofType:@"bundle"];
    
    switch (status) {
            
        case LCProgressHUDStatusSuccess: {
            
            NSString *sucPath = [bundlePath stringByAppendingPathComponent:@"hud_success@2x.png"];
            UIImage *sucImage = [UIImage imageWithContentsOfFile:sucPath];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *sucView = [[UIImageView alloc] initWithImage:sucImage];
            hud.customView = sucView;
            [hud hide:YES afterDelay:2.0f];
        }
            break;
            
        case LCProgressHUDStatusError: {
            
            NSString *errPath = [bundlePath stringByAppendingPathComponent:@"hud_error@2x.png"];
            UIImage *errImage = [UIImage imageWithContentsOfFile:errPath];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:errImage];
            hud.customView = errView;
            [hud hide:YES afterDelay:2.0f];
        }
            break;
            
        case LCProgressHUDStatusWaitting: {
            
            hud.mode = MBProgressHUDModeIndeterminate;
        }
            break;
            
        case LCProgressHUDStatusInfo: {
            
            NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"hud_info@2x.png"];
            UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
            hud.customView = infoView;
            [hud hide:YES afterDelay:2.0f];
        }
            break;
        case LCProgressHUDStatusCustomType1: {
            
            [hud setMinSize:CGSizeMake(BGVIEW_WIDTH, 35)];
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:nil];
            hud.customView = infoView;
            [hud hide:YES afterDelay:2.0f];
        }
            break;
        default:
            break;
    }
}

+ (void)showMessage:(NSString *)text toView:(UIView *)view {
    
    LCProgressHUD *hud = [LCProgressHUD sharedHUD];
    [hud show:YES];
    [hud setShowNow:YES];
    [hud setLabelText:text];
    [hud setMinSize:CGSizeZero];
    [hud setMode:MBProgressHUDModeText];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setLabelFont:[UIFont boldSystemFontOfSize:TEXT_SIZE]];
    if (view == nil) {
        [[[UIApplication sharedApplication].delegate window] addSubview:hud];
        
    } else {
        [view addSubview:hud];
    }

    //[[[UIApplication sharedApplication].delegate window] addSubview:hud];

}

+ (void)showMessage:(NSString *)text
{

    LCProgressHUD *hud = [LCProgressHUD sharedHUD];
    [hud show:YES];
    [hud setShowNow:YES];
    [hud setLabelText:text];
    [hud setMinSize:CGSizeZero];
    [hud setMode:MBProgressHUDModeText];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setLabelFont:[UIFont boldSystemFontOfSize:TEXT_SIZE]];
    [[[UIApplication sharedApplication].delegate window] addSubview:hud];
    

}

+ (void)showInfoMsg:(NSString *)text toView:(UIView *)view {
    
    [self showStatus:LCProgressHUDStatusInfo text:text toView:view];
}

+ (void)showInfoMsg:(NSString *)text {
    
    [self showStatus:LCProgressHUDStatusInfo text:text toView:nil];
}

+ (void)showFailure:(NSString *)text {
    
    [self showStatus:LCProgressHUDStatusError text:text toView:nil];
}

+ (void)showSuccess:(NSString *)text {
    
    [self showStatus:LCProgressHUDStatusSuccess text:text toView:nil];
}

+ (void)showLoading:(NSString *)text toView:(UIView *)view{
    
    [self showStatus:LCProgressHUDStatusWaitting text:text toView:view];
}

+ (void)showLoading:(NSString *)text {
    
    [self showStatus:LCProgressHUDStatusWaitting text:text toView:nil];
}


//自定义
+ (void)showInfoMsgCustom:(NSString *)text{
    [self showStatus:LCProgressHUDStatusCustomType1 text:text toView:nil];
}




+ (void)hide {
    
    [[LCProgressHUD sharedHUD] setShowNow:NO];
    [[LCProgressHUD sharedHUD] hide:YES];
}




/**
 *  zzy 2016.8.18 添加
 *
 *  @param text
 *  @param view
 *  @param withY  偏移量
 */

+ (void)showXYInfoMessage:(NSString *)text toView:(UIView *)view withY:(float)offset_Y{
    [self showXYInfoWithText:text toView:view withY:offset_Y];
}

+ (void)showXYInfoMessage:(NSString *)text withY:(float)offset_Y{
    [self showXYInfoWithText:text toView:nil withY:offset_Y];
}

+ (void)showXYInfoWithText:(NSString *)text toView:(UIView *)view withY:(float)offset_Y{
    LCProgressHUD *hud = [LCProgressHUD sharedHUD];
    [hud show:YES];
    [hud setShowNow:YES];
    [hud setLabelText:text];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setLabelFont:[UIFont systemFontOfSize:TEXT_SIZE]];
    [hud setMinSize:CGSizeMake(BGVIEW_WIDTH, BGVIEW_WIDTH)];
    hud.yOffset = offset_Y;
    if (view == nil) {
        [[[UIApplication sharedApplication].delegate window] addSubview:hud];
        
    } else {
        [view  addSubview:hud];
    }
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"LCProgressHUD" ofType:@"bundle"];

    NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"hud_info@2x.png"];
    UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
    
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
    hud.customView = infoView;
    [hud hide:YES afterDelay:2.0f];
}

+ (void)showToastMessage:(NSString *)message {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (!keyWindow)
        keyWindow = [[UIApplication sharedApplication] windows][0];
    
    float MaxWidth = keyWindow.bounds.size.width - 80;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
    CGSize size = [message boundingRectWithSize:CGSizeMake(MaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, size.width + 40, size.height + 20);
    bgView.center = keyWindow.center;
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    
    UILabel *label = [[UILabel alloc]  init];
    label.frame = CGRectMake(20, 10, size.width, size.height);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = message;
    label.numberOfLines =0;
    label.font = [UIFont systemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    
    [bgView addSubview:label];
    [keyWindow addSubview:bgView];
    
    [UIView animateWithDuration:3 animations:^{
        bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
    }];
}

+ (void)showToastMessage:(NSString *)message offsize:(float)offsize {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (!keyWindow)
        keyWindow = [[UIApplication sharedApplication] windows][0];
    
    float MaxWidth = keyWindow.bounds.size.width - 80;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
    CGSize size = [message boundingRectWithSize:CGSizeMake(MaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, size.width + 40, size.height + 20);
    bgView.center = CGPointMake(keyWindow.center.x, keyWindow.center.y + offsize / 2.0);
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    
    UILabel *label = [[UILabel alloc]  init];
    label.frame = CGRectMake(20, 10, size.width, size.height);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = message;
    label.numberOfLines =0;
    label.font = [UIFont systemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    
    [bgView addSubview:label];
    [keyWindow addSubview:bgView];
    
    [UIView animateWithDuration:3 animations:^{
        bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
    }];
}

@end
