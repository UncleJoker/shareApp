//
//  GuiBMainTabbarViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GuiBMainTabbarViewController.h"
#import "GuiBBaseNaviViewController.h"

#import "GuiBMainViewController.h"
#import "GuiBSetViewController.h"
#import "GuiBAddViewController.h"

@interface GuiBMainTabbarViewController ()<AxcAE_TabBarDelegate>

@end

@implementation GuiBMainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllers];
    // Do any additional setup after loading the view.
}

- (void)addChildViewControllers{
    // x创建选项a卡
    GuiBBaseNaviViewController *mainVC = [[GuiBBaseNaviViewController alloc] initWithRootViewController:[GuiBMainViewController new]];
    GuiBBaseNaviViewController *setVC = [[GuiBBaseNaviViewController alloc] initWithRootViewController:[GuiBSetViewController new]];
    
    NSArray <NSDictionary *>*VCArray = @[
    @{@"vc":mainVC,@"normalImg":@"main_normal",@"selectImg":@"main_select",@"itemTitle":MainTabbarItem1},
    @{@"vc":[UIViewController new],@"normalImg":@"",@"selectImg":@"",@"itemTitle":@""},
    @{@"vc":setVC,@"normalImg":@"set_normal",@"selectImg":@"set_select",@"itemTitle":MainTabbarItem2}];
    
    NSMutableArray *tabBarConfs = @[].mutableCopy;
    NSMutableArray *tabBarVCs = @[].mutableCopy;
    [VCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        model.selectImageName = [obj objectForKey:@"selectImg"];
        model.normalImageName = [obj objectForKey:@"normalImg"];
        model.selectColor = HexColor(@"1296db");
        model.normalColor = [UIColor whiteColor];
        model.automaticHidden = YES;
        
        if (idx == 1 ) {
            model.bulgeStyle = AxcAE_TabBarConfigBulgeStyleSquare;
            model.bulgeHeight = 20;
            model.itemLayoutStyle = AxcAE_TabBarItemLayoutStyleTopPictureBottomTitle;
            model.selectImageName = @"add_highlight";
            model.normalImageName = @"add_highlight";
            model.selectBackgroundColor = model.normalBackgroundColor = [UIColor clearColor];
            model.backgroundImageView.hidden = YES;
            model.componentMargin = UIEdgeInsetsMake(0, 0, 0, 0 );
            model.icomImgViewSize = CGSizeMake(self.tabBar.frame.size.width / 5, 50);
            model.titleLabelSize = CGSizeMake(self.tabBar.frame.size.width / 5, 20);
            model.pictureWordsMargin = 0;
            model.titleLabel.font = [UIFont systemFontOfSize:11];
            model.itemSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 5.0 ,self.tabBar.frame.size.height + 20);
        }else{
            model.interactionEffectStyle = AxcAE_TabBarInteractionEffectStyleSpring;
            model.selectBackgroundColor = [UIColor clearColor];
            model.normalBackgroundColor = [UIColor clearColor];
        }
        UIViewController *vc = [obj objectForKey:@"vc"];
        [tabBarVCs addObject:vc];
        [tabBarConfs addObject:model];
    }];
    GuiBAddButton *gbAddButton = [GuiBAddButton new];
    [self setValue:gbAddButton forKey:@"tabBar"];
    self.viewControllers = tabBarVCs;
    self.axcTabBar = [AxcAE_TabBar new] ;
    self.axcTabBar.tabBarConfig = tabBarConfs;
    self.axcTabBar.delegate = self;
    self.axcTabBar.backgroundColor = Main_BackGroundColor;
    [self.tabBar addSubview:self.axcTabBar];
}

static NSInteger lastIdx = 0;
- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    if (index != 1) {
        lastIdx = index;
        [self setSelectedIndex:index];
    }else{
        [self.axcTabBar setSelectIndex:lastIdx WithAnimation:NO];
        [self presentViewController:[GuiBAddViewController new] animated:YES completion:nil];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    if(self.axcTabBar){
        self.axcTabBar.selectIndex = selectedIndex;
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.axcTabBar.frame = self.tabBar.bounds;
    [self.axcTabBar viewDidLayoutItems];
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
