//
//  GuiBAboutUSViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/13.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GuiBAboutUSViewController.h"

@interface GuiBAboutUSViewController ()

@end

@implementation GuiBAboutUSViewController{
    UIImageView *appicon;
    UILabel *titleLab;
    UILabel *descLab;
    UILabel *coyLab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setUI{
    self.navigationItem.title = AboutTitle;
    
    appicon = [UIImageView new];
    [appicon setImage:IMG(@"AppIcon")];
    [self.view addSubview:appicon];
    appicon.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view, 30).widthIs(60).heightEqualToWidth();
    appicon.layer.cornerRadius = 30;
    appicon.layer.masksToBounds = YES;
    
    titleLab = [UILabel new];
    [titleLab setTextColor:Main_TitleColor];
    [titleLab setText:AboutHeadTitle];
    [titleLab setTextAlignment:(NSTextAlignmentCenter)];
    [titleLab setFont:[UIFont systemFontOfSize:20 weight:(UIFontWeightBold)]];
    [self.view addSubview:titleLab];
    titleLab.sd_layout.centerXEqualToView(self.view).topSpaceToView(appicon, 15).heightIs(22);
    [titleLab setSingleLineAutoResizeWithMaxWidth:GB_ScreenWidth];
    
    descLab = [UILabel new];
    [descLab setText:AboutContent];
    [descLab setTextColor:Main_ContentColor];
    descLab.numberOfLines = 0;
    [descLab setFont:[UIFont systemFontOfSize:16 weight:(UIFontWeightMedium)]];
    [self.view addSubview:descLab];
    descLab.sd_layout.leftSpaceToView(self.view, 30).rightSpaceToView(self.view, 30).topSpaceToView(titleLab, 20).heightIs(100);
    
    coyLab = [UILabel new];
    [coyLab setText:AboutVersion];
    [coyLab setTextColor:HexColor(@"8e8e8e")];
    [coyLab setFont:[UIFont systemFontOfSize:13 weight:(UIFontWeightBold)]];
    [coyLab setTextAlignment:(NSTextAlignmentCenter)];
    [self.view addSubview:coyLab];
    coyLab.sd_layout.centerXEqualToView(self.view).bottomSpaceToView(self.view, 40).heightIs(15);
    [coyLab setSingleLineAutoResizeWithMaxWidth:GB_ScreenWidth];
    
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
