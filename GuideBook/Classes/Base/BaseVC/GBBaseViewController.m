//
//  BaseViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBBaseViewController.h"

@interface GBBaseViewController ()

@end

@implementation GBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self resetUI];
    
    
    // Do any additional setup after loading the view.
}

- (void)resetUI{
    
    [self.view setBackgroundColor:Commom_BackgroundColor];
    UIImage *bgImage = [GBMethodTools createImageWithColor:HexColor(@"#00CC00")];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    [navBar setBackgroundImage:bgImage forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HexColor(@"#000000")}];
    [navBar setTintColor:[UIColor blackColor]];
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
