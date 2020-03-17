//
//  GuiBIntroductionViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GuiBIntroductionViewController.h"

@interface GuiBIntroductionViewController ()

@end

@implementation GuiBIntroductionViewController{
    UIImageView *footImage;
    UILabel *titleLab;
    UIImageView *footGif;
    UILabel *troduceLab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setUI{
    self.navigationItem.title = TroduceTitle;
    
    footImage =  [UIImageView new];
    [footImage setImage:IMG(@"football")];
    [self.view addSubview:footImage];
    footImage.sd_layout.topSpaceToView(self.view, 20).centerXEqualToView(self.view).widthIs(100).heightIs(100);
    
    titleLab = [UILabel new];
    [titleLab setText:TroduceHeadT];
    [titleLab setTextColor:Main_TitleColor];
    [titleLab setFont:[UIFont systemFontOfSize:18 weight:(UIFontWeightBold)]];
    [self.view addSubview:titleLab];
    titleLab.sd_layout.centerXEqualToView(self.view).topSpaceToView(footImage, 15).heightIs(25);
    [titleLab setSingleLineAutoResizeWithMaxWidth:GB_ScreenWidth];
    
    footGif = [UIImageView new];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"football_tro" ofType:@"gif"];
    NSURL * url = [[NSURL alloc]initFileURLWithPath:imagePath];
    [footGif yh_setImage:url];
    [self.view addSubview:footGif];
    footGif.sd_layout.topSpaceToView(titleLab, 20).heightIs(200).leftSpaceToView(self.view, 20).rightSpaceToView(self.view, 20);
    
    troduceLab = [UILabel new];
    [troduceLab setTextColor:HexColor(@"3f3f3f")];
    troduceLab.numberOfLines = 0;
    [troduceLab setFont:[UIFont systemFontOfSize:14 weight:(UIFontWeightMedium)]];
    [troduceLab setText:TroduceContent];
    [self.view addSubview:troduceLab];
    troduceLab.sd_layout.leftSpaceToView(self.view, 20).topSpaceToView(footGif, 10).rightSpaceToView(self.view, 20).bottomSpaceToView(self.view, 20);
    
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
