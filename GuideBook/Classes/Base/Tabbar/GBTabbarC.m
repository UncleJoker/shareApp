//
//  GBTabbarC.m
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBTabbarC.h"

@interface GBTabbarC ()

@end

@implementation GBTabbarC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    if (GB_isIphonex) {
        CGRect frame = self.tabBar.frame;
        frame.size.height = 49;
        frame.origin.y = self.view.frame.size.height - frame.size.height;
        self.tabBar.frame = frame;
        for (UITabBarItem *item in self.tabBar.items) {
            item.imageInsets = UIEdgeInsetsMake(15,0, -15, 0);
            [item setTitlePositionAdjustment:UIOffsetMake(0, 32)];
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
