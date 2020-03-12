//
//  GBAddViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBAddViewController.h"
#import "LMJDropdownMenu.h"
#import "CXDatePickerView.h"
#import "UIViewController+GBDismissKeyboard.h"

@interface GBAddViewController ()<LMJDropdownMenuDataSource,LMJDropdownMenuDelegate>

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *trainImage; // 训练图片

@property (nonatomic, strong) UIButton *timeBtn;// 时间选择

@property (nonatomic, strong) UITextField *addressTF;// 地点输入

@property (nonatomic, strong) UILabel *trduceLab;// 训练介绍

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation GBAddViewController
{
    LMJDropdownMenu * menu1;
    NSArray * _menu1OptionTitles;
    NSArray * _menu1OptionIcons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setUI{
    
    /* LMJDropdownMenu */
    // ----------------------- menu1 ---------------------------
    _menu1OptionTitles = @[@"控球训练",@"颠球训练",@"传球训练",@"停球训练",@"射门训练"];
    _menu1OptionIcons = @[@"icon1",@"icon2",@"icon3",@"icon4",@"icon5"];
    menu1 = [[LMJDropdownMenu alloc] init];
    [menu1 setFrame:CGRectMake(self.view.centerX-60, 20, 120, 40)];
    menu1.dataSource = self;
    menu1.delegate   = self;
    menu1.layer.borderColor  = [UIColor whiteColor].CGColor;
    menu1.layer.borderWidth  = 1;
    menu1.layer.cornerRadius = 3;
    menu1.title           = @"请选择训练";
    menu1.titleBgColor    = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:1];
    menu1.titleFont       = [UIFont boldSystemFontOfSize:15];
    menu1.titleColor      = [UIColor whiteColor];
    menu1.titleAlignment  = NSTextAlignmentLeft;
    menu1.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    menu1.rotateIcon      = [UIImage imageNamed:@"arrowIcon3"];
    menu1.rotateIconSize  = CGSizeMake(15, 15);
    menu1.optionBgColor       = [UIColor colorWithRed:64/255.f green:151/255.f blue:255/255.f alpha:0.5];
    menu1.optionFont          = [UIFont systemFontOfSize:13];
    menu1.optionTextColor     = [UIColor blackColor];
    menu1.optionTextAlignment = NSTextAlignmentLeft;
    menu1.optionNumberOfLines = 0;
    menu1.optionLineColor     = [UIColor whiteColor];
    menu1.optionIconSize      = CGSizeMake(15, 15);
    [self.view addSubview:menu1];
    
    [self.view addSubview:self.backView];
    self.backView.sd_layout.leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).topSpaceToView(menu1, 20).bottomSpaceToView(self.view, 20);
    
    [self.backView addSubview:self.trainImage];
    self.trainImage.sd_layout.topSpaceToView(self.backView, 20).leftSpaceToView(self.backView, 20).widthIs(100).heightIs(100);
    self.trainImage.layer.cornerRadius = 50;
    self.trainImage.layer.masksToBounds = YES;
    
    [self.backView addSubview:self.timeBtn];
    self.timeBtn.sd_layout.leftSpaceToView(self.trainImage, 20).topSpaceToView(self.backView, 20).heightIs(35).rightSpaceToView(self.backView, 20);
    
    [self.backView addSubview:self.addressTF];
    self.addressTF.sd_layout.leftEqualToView(self.timeBtn).rightEqualToView(self.timeBtn).heightIs(35).topSpaceToView(self.timeBtn, 20);
    
    [self.backView addSubview:self.trduceLab];
    self.trduceLab.sd_layout.leftSpaceToView(self.backView, 10).rightSpaceToView(self.backView, 10).topSpaceToView(self.trainImage, 20).bottomSpaceToView(self.backView, 100);
    
    [self.backView addSubview:self.commitBtn];
    self.commitBtn.sd_layout.leftSpaceToView(self.backView, 20).heightIs(40).bottomSpaceToView(self.backView, 80).widthIs(GB_ScreenWidth/2-40);
    
    [self.backView addSubview:self.closeBtn];
    self.closeBtn.sd_layout.rightSpaceToView(self.backView, 20).heightIs(40).bottomSpaceToView(self.backView, 80).widthIs(GB_ScreenWidth/2-40);
}

#pragma mark - action
- (void)selectAction:(UIButton *)sender{
    CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        [sender setTitle:dateString forState:UIControlStateNormal];
    }];
    datepicker.minLimitDate = [NSDate date];
    datepicker.dateLabelColor = Main_BackGroundColor;//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.headerViewColor = Main_BackGroundColor; // 顶部视图背景颜色
    datepicker.doneButtonColor = [UIColor whiteColor]; // 确认按钮字体颜色
    datepicker.cancelButtonColor = [UIColor whiteColor]; // 取消按钮颜色
    datepicker.shadeViewAlphaWhenShow = 0.3;
    datepicker.showAnimationTime = 0.4;
    [datepicker show];
}

- (void)commitBtnAction{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - LMJDropdownMenu DataSource
- (NSUInteger)numberOfOptionsInDropdownMenu:(LMJDropdownMenu *)menu{
    return _menu1OptionTitles.count;
}
- (CGFloat)dropdownMenu:(LMJDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index{
    return 40;
}
- (NSString *)dropdownMenu:(LMJDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index{
    return _menu1OptionTitles[index];
}
- (UIImage *)dropdownMenu:(LMJDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index{
    return [UIImage imageNamed:_menu1OptionIcons[index]];
}
#pragma mark - LMJDropdownMenu Delegate
- (void)dropdownMenu:(LMJDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title{
    NSLog(@"你选择了(you selected)：menu1，index: %ld - title: %@", index, title);
}

- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu{
    NSLog(@"--将要显示(will appear)--menu1");
}
- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu{
    NSLog(@"--已经显示(did appear)--menu1");
}

- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{
    NSLog(@"--将要隐藏(will disappear)--menu1");
}
- (void)dropdownMenuDidHidden:(LMJDropdownMenu *)menu{
    NSLog(@"--已经隐藏(did disappear)--menu1");
}

#pragma mark -- setters

- (UIImageView *)trainImage{
    if (!_trainImage) {
        _trainImage = [UIImageView new];
        [_trainImage setImage:[UIImage imageNamed:@"bgimage1"]];
    }
    return _trainImage;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [UIView new];
        [_backView setBackgroundColor:Main_BackGroundColor];
        _backView.layer.cornerRadius = 10;
        _backView.layer.masksToBounds =  YES;
    }
    return _backView;
}

- (UIButton *)timeBtn{
    if (!_timeBtn) {
        _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeBtn.tag = 1000;
        _timeBtn.layer.cornerRadius = 5;
        _timeBtn.backgroundColor = [UIColor whiteColor];
        [_timeBtn setTitle:@"选择时间" forState:UIControlStateNormal];
        [_timeBtn setTitleColor:HexColor(@"333333") forState:(UIControlStateNormal)];
        [_timeBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeBtn;
}

- (UITextField *)addressTF{
    if (!_addressTF) {
        _addressTF = [UITextField new];
        [_addressTF setPlaceholder:@"       请输入训练地址"];
        [_addressTF setFont:[UIFont systemFontOfSize:16]];
        [_addressTF setBackgroundColor:[UIColor whiteColor]];
        _addressTF.layer.masksToBounds = YES;
        _addressTF.layer.cornerRadius = 5;
    }
    return _addressTF;
}

- (UILabel *)trduceLab{
    if (!_trduceLab) {
        _trduceLab = [UILabel new];
        [_trduceLab setText:@"熟练了以后我们可以继续挑战，将球颠起到头以上的高度，然后接住正常低位颠几次之后再次颠起过头部。即使你已经到了中等水平，每天也可以花五分钟时间进行训练，把这些内容融合在一周甚至一个月的训练中是非常必要的。现在的训练更结构化一些，因为毕竟最终我们是要运用带球技巧的，所以节奏感非常重要，就像这样从左到右，从右到左，内侧外侧，内侧外侧。你知道该怎么做，训练时姿势要正确，速度要快。"];
        _trduceLab.numberOfLines = 0;
        [_trduceLab setFont:[UIFont systemFontOfSize:16]];
        _trduceLab.textColor =  HexColor(@"FFFFFF");
    }
    return _trduceLab;
}

- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_commitBtn setBackgroundColor:[UIColor whiteColor]];
        [_commitBtn setTitleColor:HexColor(@"333333") forState:(UIControlStateNormal)];
        [_commitBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        _commitBtn.layer.cornerRadius = 8;
        [_commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _commitBtn;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_closeBtn setBackgroundColor:[UIColor whiteColor]];
        [_closeBtn setTitleColor:HexColor(@"333333") forState:(UIControlStateNormal)];
        [_closeBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        _closeBtn.layer.cornerRadius = 8;
        [_closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _closeBtn;
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
