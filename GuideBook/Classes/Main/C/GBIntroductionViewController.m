//
//  GBIntroductionViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBIntroductionViewController.h"

@interface GBIntroductionViewController ()

@end

@implementation GBIntroductionViewController{
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
    self.navigationItem.title =  @"简介";
    
    footImage =  [UIImageView new];
    [footImage setImage:IMG(@"football")];
    [self.view addSubview:footImage];
    footImage.sd_layout.topSpaceToView(self.view, 20).centerXEqualToView(self.view).widthIs(100).heightIs(100);
    
    titleLab = [UILabel new];
    [titleLab setText:@"足球 (Football)"];
    [titleLab setTextColor:HexColor(@"333333")];
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
    [troduceLab setText:@"足球，英文football，被誉为“世界第一运动”，全球体育界最具影响力的体育运动。\n标准的11人制足球比赛由两队各派10名球员与1名守门员，总共22人，在长方形的草地球场上对抗、防守、进攻。\n\n比赛时尽量将足球射入对方的球门内，每射入一球就可以得到一分，当比赛完毕后，得分多的一队则胜出。如果在比赛规定时间内得分相同，则须看比赛章则而定，可以抽签、加时再赛或互射点球（十二码）等形式比赛分高下。\n  足球比赛中除了守门员可以在己方禁区内利用手部接触足球外，球场上每名球员只可以利用手以外的身体其他部分控制足球（开界外球例外）。\n当今世界足球水平最高的联赛是欧洲足球五大联赛。分别是西甲联赛，英超联赛，意甲联赛，德甲联赛，法甲联赛。"];
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
