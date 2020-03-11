//
//  GBMainTabbarViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBMainTabbarViewController.h"
#import "GBBaseNaviViewController.h"

#import "GBMainViewController.h"
#import "GBSetViewController.h"

@interface GBMainTabbarViewController ()<AxcAE_TabBarDelegate>

@end

@implementation GBMainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllers];
    // Do any additional setup after loading the view.
}

- (void)addChildViewControllers{
    // x创建选项a卡
    GBBaseNaviViewController *mainVC = [[GBBaseNaviViewController alloc] initWithRootViewController:[GBMainViewController new]];
    GBBaseNaviViewController *setVC = [[GBBaseNaviViewController alloc] initWithRootViewController:[GBSetViewController new]];
    
    NSArray <NSDictionary *>*VCArray = @[
    @{@"vc":mainVC,@"normalImg":@"main_normal",@"selectImg":@"main_select",@"itemTitle":@"首页"},
    @{@"vc":[UIViewController new],@"normalImg":@"",@"selectImg":@"",@"itemTitle":@"发布"},
    @{@"vc":setVC,@"normalImg":@"set_normal",@"selectImg":@"set_select",@"itemTitle":@"消息"}];
    
        NSMutableArray *tabBarConfs = @[].mutableCopy;
        NSMutableArray *tabBarVCs = @[].mutableCopy;
        [VCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
            model.itemTitle = [obj objectForKey:@"itemTitle"];
            model.selectImageName = [obj objectForKey:@"selectImg"];
            model.normalImageName = [obj objectForKey:@"normalImg"];
            model.selectColor = [UIColor blackColor];
            model.normalColor = [UIColor blackColor];
            model.automaticHidden = YES;
            
            if (idx == 1 ) {
                // 如果是中间的
                // 设置凸出 矩形
                model.bulgeStyle = AxcAE_TabBarConfigBulgeStyleSquare;
                // 设置凸出高度
                model.bulgeHeight = 20;
                // 设置成图片文字展示
                model.itemLayoutStyle = AxcAE_TabBarItemLayoutStyleTopPictureBottomTitle;
                // 设置图片
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
                model.selectBackgroundColor = AxcAE_TabBarRGBA(248, 248, 248, 1);
                model.normalBackgroundColor = [UIColor clearColor];
            }
            UIViewController *vc = [obj objectForKey:@"vc"];
            [tabBarVCs addObject:vc];
            [tabBarConfs addObject:model];
        }];
        GBAddButton *gbAddButton = [GBAddButton new];
        [self setValue:gbAddButton forKey:@"tabBar"];
        self.viewControllers = tabBarVCs;
        self.axcTabBar = [AxcAE_TabBar new] ;
        self.axcTabBar.tabBarConfig = tabBarConfs;
        self.axcTabBar.delegate = self;
        self.axcTabBar.backgroundColor = [UIColor whiteColor];
        [self.tabBar addSubview:self.axcTabBar];
        [self addLayoutTabBar];
    
}

- (void)addLayoutTabBar{
    // 使用重载viewDidLayoutSubviews实时计算坐标 （下边的 -viewDidLayoutSubviews 函数）
    // 能兼容转屏时的自动布局
}


static NSInteger lastIdx = 0;
- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    
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
