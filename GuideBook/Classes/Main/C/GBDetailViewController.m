//
//  GBDetailViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/13.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBDetailViewController.h"
#import "GBDetailHeadView.h"
#import "TPKeyboardAvoidingScrollView.h"
@interface GBDetailViewController ()
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollview;
@property (nonatomic, strong) GBDetailHeadView *headView;



@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation GBDetailViewController{
    UIView *numView;
    UILabel *numTitle;
    UILabel *numberLab;
    
    UIView *descView;
    UILabel *descLab;
    
    UIImageView *timeIcon;
    UIView *timeView;
    UILabel *timeLab;
    
    UIImageView *addressIcon;
    UIView *addressView;
    UILabel *addressLab;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setModel:(GBAddTrainModel *)model{
    _model = model;
    self.navigationItem.title = model.trainTitle;
    self.headView.headImagestr = [model.trainDic valueForKey:@"thumb"];
}

- (void)setUI{
    
    [self setNavigationRightItemWithTitle:@"完成" target:self action:@selector(finishAction)];
    
    _scrollview=[[TPKeyboardAvoidingScrollView alloc]init];
    _scrollview.frame = CGRectMake(0, 0, GB_ScreenWidth, GB_ScreenHeight-NaviH);
    [self.view addSubview:_scrollview];
    [self.scrollview addSubview:self.headView];
    
    numView = [UIView new];
    [numView setBackgroundColor:[UIColor whiteColor]];
    [self.scrollview addSubview:numView];
    numView.sd_layout.topSpaceToView(self.headView, 0).leftEqualToView(self.scrollview).rightEqualToView(self.scrollview).heightIs(50);
    
    numTitle = [UILabel new];
    [numTitle setText:@"训练总次数"];
    [numTitle setTextColor:Main_TitleColor];
    [numTitle setFont:FONT_SIZE_15];
    [numView addSubview:numTitle];
    numTitle.sd_layout.leftSpaceToView(numView, 25).centerYEqualToView(numView).heightIs(15);
    [numTitle setSingleLineAutoResizeWithMaxWidth:200];
    
    numberLab = [UILabel new];
    [numberLab setText:@"123次"];
    [numberLab setTextColor:Main_ContentColor];
    [numberLab setFont:FONT_SIZE_13_R];
    [numView addSubview:numberLab];
    numberLab.sd_layout.rightSpaceToView(numView, 15).centerYEqualToView(numView).heightIs(15);
    [numberLab setSingleLineAutoResizeWithMaxWidth:200];
    
    descView = [UIView new];
    [descView setBackgroundColor:[UIColor whiteColor]];
    [self.scrollview addSubview:descView];
    descView.sd_layout.leftEqualToView(self.scrollview).rightEqualToView(self.scrollview).topSpaceToView(numView, 40).heightIs(120);
    
    descLab = [UILabel new];
    [descLab setText:[self.model.trainDic valueForKey:@"troduce"]];
    [descLab setTextColor:Main_ContentColor];
    [descLab setFont:FONT_SIZE_15_R];
    [descLab setNumberOfLines:0];
    [descView addSubview:descLab];
    descLab.sd_layout.leftSpaceToView(descView, 25).rightSpaceToView(descView, 25).topSpaceToView(descView, 10).bottomSpaceToView(descView, 10);
    
    
    timeView = [UIView new];
    [timeView setBackgroundColor:[UIColor whiteColor]];
    [self.scrollview addSubview:timeView];
    timeView.sd_layout.leftEqualToView(self.scrollview).rightEqualToView(self.scrollview).topSpaceToView(descView, 40).heightIs(44);
    
    timeIcon = [UIImageView new];
    [timeIcon setImage:IMG(@"time_icon")];
    [timeView addSubview:timeIcon];
    timeIcon.sd_layout.leftSpaceToView(timeView, 20).heightIs(20).widthEqualToHeight().centerYEqualToView(timeView);
    
    timeLab = [UILabel new];
    [timeLab setText:self.model.time];
    [timeLab setTextColor:Main_ContentColor];
    [timeLab setFont:FONT_SIZE_15_R];
    [timeLab setNumberOfLines:0];
    [timeView addSubview:timeLab];
    timeLab.sd_layout.spaceToSuperView(UIEdgeInsetsMake(5, 50, 5, 5));
    
    
    addressView = [UIView new];
    [addressView setBackgroundColor:[UIColor whiteColor]];
    [self.scrollview addSubview:addressView];
    addressView.sd_layout.leftEqualToView(self.scrollview).rightEqualToView(self.scrollview).topSpaceToView(timeView, 40).heightIs(44);
    
    addressIcon = [UIImageView new];
    [addressIcon setImage:IMG(@"address_icon")];
    [addressView addSubview:addressIcon];
    addressIcon.sd_layout.leftSpaceToView(addressView, 20).heightIs(20).widthEqualToHeight().centerYEqualToView(addressView);
    
    addressLab = [UILabel new];
    [addressLab setText:self.model.trainAddress];
    [addressLab setTextColor:Main_ContentColor];
    [addressLab setFont:FONT_SIZE_15_R];
    [addressLab setNumberOfLines:0];
    [addressView addSubview:addressLab];
    addressLab.sd_layout.spaceToSuperView(UIEdgeInsetsMake(5, 50, 5, 5));
    
}

- (void)finishAction{
    if (self.model.isFinish) {
        [LCProgressHUD showSuccess:@"您已经完成训练,无需再次完成"];
        return;
    }
    HX_AlertView *alert = [[HX_AlertView alloc] initWithTitle:@"完成训练" message:@"是否已经完成训练项目" parentControl:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" cancelButtonBlock:^{
        return ;
    } otherButtonBlock:^{
        self.model.isFinish = YES;
        [NSArray bg_updateObjectWithName:SaveTrainName Object:self.model Index:self.selectIndex];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert showAlertInView];
}


#pragma mark - setters getters
- (GBDetailHeadView *)headView{
    if (!_headView) {
        _headView = [[GBDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, GB_ScreenWidth, 220)];
    }
    return _headView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
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
