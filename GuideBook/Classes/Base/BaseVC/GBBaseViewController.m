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
    UIImage *bgImage = [GBMethodTools createImageWithColor:HexColor(@"#567237")];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    [navBar setBackgroundImage:bgImage forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HexColor(@"#EEEEEE")}];
    [navBar setTintColor:[UIColor blackColor]];
    
    //添加返回按钮
    if (self.navigationController.viewControllers.count > 1) {  //首页不加返回按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 50, 50);
        [btn setImage:[UIImage imageNamed:@"icon_white_left"] forState:UIControlStateNormal];
        [btn setTitle:@"         " forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backController) forControlEvents:UIControlEventTouchUpInside];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(12, 0, 12, -3)];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

// 返回
- (void)backController
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

/**
 *   *  根据标题navigationRightItem
 *
 *  @param title  title description
 *  @param target target description
 *  @param action action description
 */
- (void)setNavigationRightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 20);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:Commom_BackgroundColor forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
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
