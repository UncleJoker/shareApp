//
//  GuiBAddViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GuiBAddViewController.h"
#import "LMJDropdownMenu.h"
#import "CXDatePickerView.h"
#import "GuiBAddTrainModel.h"

@interface GuiBAddViewController ()<LMJDropdownMenuDataSource,LMJDropdownMenuDelegate>

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *trainImage; // 训练图片

@property (nonatomic, strong) UIButton *timeBtn;// 时间选择

@property (nonatomic, strong) UITextField *addressTF;// 地点输入

@property (nonatomic, strong) UIImageView *trainGif;// 动态图

@property (nonatomic, strong) UILabel *trduceLab;// 训练介绍

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) NSMutableArray *trianArr;

@property (nonatomic, strong) NSMutableArray *saveTrainArr;

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation GuiBAddViewController
{
    LMJDropdownMenu * menu1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex = -1;
    [self setupForDismissKeyboard];
    [self setUI];
    [self getData];
    // Do any additional setup after loading the view.
}

- (void)getData{
    NSDictionary *trainDic = [GBMethodTools readLocalFileWithName:TRainDataJSON];
    [self.trianArr addObjectsFromArray:[trainDic valueForKey:@"TrainArr"]];
    [menu1 reloadOptionsData];
}

- (void)setUI{
    
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
    
    [self.backView addSubview:self.trainGif];
    self.trainGif.sd_layout.leftSpaceToView(self.backView, 40).topSpaceToView(self.trainImage, 20).rightSpaceToView(self.backView, 40);
    
    [self.backView addSubview:self.trduceLab];
    self.trduceLab.sd_layout.leftSpaceToView(self.backView, 10).rightSpaceToView(self.backView, 10).topSpaceToView(self.trainGif, 20).bottomSpaceToView(self.backView, 100);
    
    [self.backView addSubview:self.commitBtn];
    self.commitBtn.sd_layout.leftSpaceToView(self.backView, 20).heightIs(40).bottomSpaceToView(self.backView, 60).widthIs(GB_ScreenWidth/2-40);
    
    [self.backView addSubview:self.closeBtn];
    self.closeBtn.sd_layout.rightSpaceToView(self.backView, 20).heightIs(40).bottomSpaceToView(self.backView, 60).widthIs(GB_ScreenWidth/2-40);
}

#pragma mark - action
- (void)selectAction:(UIButton *)sender{
    [self.addressTF resignFirstResponder];
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
    
    if (self.selectIndex == -1) {
        [LCProgressHUD showFailure:@"请选择训练项目"];
        return;
    }
    
    if ([self.timeBtn.titleLabel.text isEqualToString:@"选择时间"]) {
        [LCProgressHUD showFailure:@"请选择训练时间"];
        return;
    }
    
    if ([self.addressTF.text isEqualToString:@""]) {
        [LCProgressHUD showFailure:@"请输入训练场地"];
        return;
    }
    
    GuiBAddTrainModel *model = [GuiBAddTrainModel new];
    model.trainDic = self.trianArr[self.selectIndex];
    model.trainTitle = [self.trianArr[self.selectIndex] valueForKey:@"title"];
    model.time = self.timeBtn.titleLabel.text;
    model.trainAddress = self.addressTF.text;
    model.isFinish = NO;
    
    [self.saveTrainArr addObject:model];
    [self.saveTrainArr bg_saveArrayWithName:SaveTrainName];
    
    [LCProgressHUD showSuccess:@"添加训练成功,请按时训练"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AddSunccessNotice object:nil userInfo:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - LMJDropdownMenu DataSource
- (NSUInteger)numberOfOptionsInDropdownMenu:(LMJDropdownMenu *)menu{
    return self.trianArr.count;
}
- (CGFloat)dropdownMenu:(LMJDropdownMenu *)menu heightForOptionAtIndex:(NSUInteger)index{
    return 40;
}
- (NSString *)dropdownMenu:(LMJDropdownMenu *)menu titleForOptionAtIndex:(NSUInteger)index{
    return [self.trianArr[index] valueForKey:@"title"];
}

- (UIImage *)dropdownMenu:(LMJDropdownMenu *)menu iconForOptionAtIndex:(NSUInteger)index{
    return [UIImage imageNamed:@"football_icon"];
}

#pragma mark - LMJDropdownMenu Delegate
- (void)dropdownMenu:(LMJDropdownMenu *)menu didSelectOptionAtIndex:(NSUInteger)index optionTitle:(NSString *)title{
    self.selectIndex = index;
    [self.trduceLab setText:[self.trianArr[index] valueForKey:@"troduce"]];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[self.trianArr[index] valueForKey:@"gif"] ofType:@"gif"];
    NSURL * url = [[NSURL alloc]initFileURLWithPath:imagePath];
    [self.trainGif yh_setImage:url];
}

- (void)dropdownMenuWillShow:(LMJDropdownMenu *)menu{
    
}
- (void)dropdownMenuDidShow:(LMJDropdownMenu *)menu{
    
}

- (void)dropdownMenuWillHidden:(LMJDropdownMenu *)menu{
    
}
- (void)dropdownMenuDidHidden:(LMJDropdownMenu *)menu{
    
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
        [_timeBtn setTitleColor:Main_TitleColor forState:(UIControlStateNormal)];
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


- (UIImageView *)trainGif{
    if (!_trainGif) {
        _trainGif = [[UIImageView alloc] init];
    }
    return _trainGif;
}


- (UILabel *)trduceLab{
    if (!_trduceLab) {
        _trduceLab = [UILabel new];
        [_trduceLab setText:@"请选择一个训练项目,此处将会显示训练要求与技巧!"];
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
        [_commitBtn setTitleColor:Main_TitleColor forState:(UIControlStateNormal)];
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
        [_closeBtn setTitleColor:Main_TitleColor forState:(UIControlStateNormal)];
        [_closeBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        _closeBtn.layer.cornerRadius = 8;
        [_closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _closeBtn;
}

- (NSMutableArray *)trianArr{
    if (!_trianArr){
        _trianArr = [NSMutableArray array];
    }
    return _trianArr;
}

- (NSMutableArray *)saveTrainArr{
    if (!_saveTrainArr){
        _saveTrainArr = [NSMutableArray array];
    }
    return _saveTrainArr;
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
