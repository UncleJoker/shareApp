//
//  GBSetViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBSetViewController.h"
#import "YAWaveView.h"
#import "GBSetTableHeadView.h"
#import "GBSetTableViewCell.h"
#import "GBFeedbackViewController.h"
#import <StoreKit/StoreKit.h>
#import <MessageUI/MessageUI.h>
#import "GBAboutUSViewController.h"
#import "CustomActivity.h"
#import "GBEditUserInfoViewController.h"

@interface GBSetViewController ()<YAWaveViewDelegate,UITableViewDelegate,UITableViewDataSource,HeadViewDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UITableView *list;

@property (nonatomic, strong) GBSetTableHeadView *tableHead;

@property (nonatomic, strong) UILabel *percentLab;

@property (nonatomic, strong) UILabel *waveLab;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation GBSetViewController
{
    YAWaveView *customWave;
    YAWaveView *_rectWave;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self getData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)getData{
    // 获取用户头像
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/footBallHead.png"];
    if (![UIImage imageWithContentsOfFile:filePath]) {
        // 没设置用户头像 默认用户头像
    }else{
        self.tableHead.avatar = [UIImage imageWithContentsOfFile:filePath];
    }
    
    [self.tableHead reloadHeadData];
    
    NSString *num = [[NSUserDefaults standardUserDefaults] objectForKey:TrainNumbers];
    if (!num) {
        return;
    }
    NSInteger nowNum = [NSArray bg_countWithName:SaveTrainName];
    CGFloat percent = [[NSNumber numberWithInteger:nowNum] floatValue]/[num floatValue];
    self.waveLab.text = [NSString stringWithFormat:@"总共需要%@次训练/当前训练次数 %ld次",num,(long)nowNum];
    self.percentLab.text = [NSString stringWithFormat:@"%.2f%%",percent*100];
    customWave.percent = percent;
    [customWave reset];
    [customWave startWave];
    [customWave bringSubviewToFront:self.percentLab];
}

- (void)setUI{
    self.navigationItem.title = @"设置中心";
    [self setNavigationRightItemWithTitle:@"训练目标" target:self action:@selector(setTargetNumbers)];
    [self addWaveView];
    [self.view addSubview:self.waveLab];
    self.waveLab.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view, 130).heightIs(22);
    [self.waveLab setSingleLineAutoResizeWithMaxWidth:GB_ScreenWidth];
    
    [self.view addSubview:self.list];
    self.list.sd_layout.topSpaceToView(self.waveLab, 10).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
    
    [self.list setTableHeaderView:self.tableHead];
}

- (void)addWaveView{
    
    NSArray *colors = @[(__bridge id)HexColor(@"#00FF99").CGColor, (__bridge id)HexColor(@"#00CC00").CGColor];  //里
    NSArray *sColors = @[(__bridge id)HexColor(@"#00CC33").CGColor, (__bridge id)HexColor(@"#00FF00").CGColor];  //外
    CGFloat waveWidth = 95;
    //自定义背景渐变-圆形波浪
    customWave = [[YAWaveView alloc]initWithFrame:CGRectMake(self.view.width/2-waveWidth/2, 20, waveWidth, waveWidth)];
    [self.view addSubview:customWave];
    customWave.layer.cornerRadius = waveWidth/2;
    customWave.clipsToBounds = YES;
    customWave.colors = colors;
    customWave.sColors = sColors;
    customWave.percent = 0;
    customWave.delegate = self;
    [customWave startWave];
    [customWave addSubview:self.percentLab];
    self.percentLab.sd_layout
    .centerXEqualToView(customWave)
    .centerYEqualToView(customWave)
    .heightIs(20);
    [self.percentLab setSingleLineAutoResizeWithMaxWidth:120];
}

//自定义背景渐变
- (void)drawBgGradient:(YAWaveView *)waveView context:(CGContextRef)context {
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    CGFloat compoents[8]={
        1.0,1.0,1.0,1.0,
        255/255.0,245/255.0,213/255.0,1
    };
    
    CGFloat locations[2]={0,0.7};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 2);
    
    CGFloat width = CGRectGetWidth(waveView.frame);
    CGFloat height = CGRectGetHeight(waveView.frame);
    CGPoint center = CGPointMake(width/2, height/2);
    
    if (waveView == _rectWave) {
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(width, height), kCGGradientDrawsAfterEndLocation);
    } else {
        CGContextDrawRadialGradient(context, gradient, center,0, center, width/2, kCGGradientDrawsAfterEndLocation);
    }
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

#pragma mark -- action
- (void)setTargetNumbers{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入想要训练的总次数" message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *numberTF = alertController.textFields.firstObject;
        [[NSUserDefaults standardUserDefaults] setObject:numberTF.text forKey:TrainNumbers];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self getData];
    }]];
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入训练总次数";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    [self presentViewController:alertController animated:true completion:nil];
}

- (void)tapHeadView{
    // 修改用户资料
    GBEditUserInfoViewController *userInfo = [GBEditUserInfoViewController new];
    [self.navigationController pushViewController:userInfo animated:YES];
}

#pragma mark -- uitableview delegate  datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GBSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setTableCell" forIndexPath:indexPath];
    [cell setDic:self.dataArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self tapCellWith:indexPath.row];
    
}

- (void)tapCellWith:(NSInteger)index{
    switch (index) {
        case 0:
        {
            GBFeedbackViewController *feedbackVC = [GBFeedbackViewController new];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
            break;
        case 1:
        {
            if (@available(iOS 10.3, *)) {
                [SKStoreReviewController requestReview];
            } else {
                // Fallback on earlier versions
            }
        }
            break;
        case 2:
        {
            [self sendEmail];
        }
            break;
        case 3:
        {
            GBAboutUSViewController *aboutVC = [GBAboutUSViewController new];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        case 4:
        {
            NSString *shareText = @"分享的标题";
            UIImage *shareImage = [UIImage imageNamed:@"football"];
            NSArray *activityItemsArray = @[shareText,shareImage];
            // 自定义的CustomActivity，继承自UIActivity
            CustomActivity *customActivity = [[CustomActivity alloc]initWithTitle:shareText ActivityImage:[UIImage imageNamed:@"custom.png"] URL:nil ActivityType:@"Custom"];
            NSArray *activityArray = @[customActivity];
            UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItemsArray applicationActivities:activityArray];
            activityVC.modalInPopover = YES;
            if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
                // ios8.0 之后用此方法回调
                UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
                    NSLog(@"activityType == %@",activityType);
                    if (completed == YES) {
                        NSLog(@"completed");
                    }else{
                        NSLog(@"cancel");
                    }
                };
                activityVC.completionWithItemsHandler = itemsBlock;
            }else{
                // ios8.0 之前用此方法回调
                UIActivityViewControllerCompletionHandler handlerBlock = ^(UIActivityType __nullable activityType, BOOL completed){
                    NSLog(@"activityType == %@",activityType);
                    if (completed == YES) {
                        NSLog(@"completed");
                    }else{
                        NSLog(@"cancel");
                    }
                };
                activityVC.completionHandler = handlerBlock;
            }
            [self presentViewController:activityVC animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

- (void)sendEmail{
    BOOL canSend = [MFMailComposeViewController canSendMail];
    if (canSend) {
        [self sendEmailAction];
    }else{
        //提示用户添加邮件账户
        HX_AlertView *alert = [[HX_AlertView alloc]initWithTitle:@"请添加邮箱账户" message:@"没有添加邮箱账户,无法发送邮件" parentControl:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认" cancelButtonBlock:^{
        } otherButtonBlock:^{
        }];
        [alert showAlertInView];
    }
}

- (void)sendEmailAction
{
  // 邮件服务器
  MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
  // 设置邮件代理
  [mailCompose setMailComposeDelegate:self];
  // 设置邮件主题
  [mailCompose setSubject:@"反馈意见"];
  // 设置收件人
  [mailCompose setToRecipients:@[@"guidebook_share@gmail.com"]];
  // 设置抄送人
  [mailCompose setCcRecipients:@[@"guidebook_share@gmail.com"]];
  // 设置密抄送
  [mailCompose setBccRecipients:@[@"guidebook_share@gmail.com"]];
  /**
   *  设置邮件的正文内容
   */
  NSString *emailContent = @"请填写反馈内容";
  // 是否为HTML格式
  [mailCompose setMessageBody:emailContent isHTML:NO];
  
  // 弹出邮件发送视图
  [self presentViewController:mailCompose animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
      didFinishWithResult:(MFMailComposeResult)result
            error:(NSError *)error
{
  switch (result)
  {
    case MFMailComposeResultCancelled: // 用户取消编辑
      break;
    case MFMailComposeResultSaved: // 用户保存邮件
      break;
    case MFMailComposeResultSent: // 用户点击发送
      break;
    case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
      break;
  }
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- setters

- (UITableView *)list{
    if (!_list) {
        _list = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, GB_ScreenWidth, self.view.height-130) style:(UITableViewStylePlain)];
        [_list setDelegate:self];
        [_list setDataSource:self];
        [_list setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
        [_list registerClass:[GBSetTableViewCell class] forCellReuseIdentifier:@"setTableCell"];
        [_list setTableFooterView:[UIView new]];
    }
    return _list;
}

- (GBSetTableHeadView *)tableHead{
    if (!_tableHead) {
        _tableHead = [GBSetTableHeadView new];
        [_tableHead setFrame:CGRectMake(0, 0, GB_ScreenWidth, 120)];
        _tableHead.headDelegate = self;
    }
    return _tableHead;
}


- (UILabel *)percentLab
{
    if (!_percentLab) {
        _percentLab = [UILabel new];
        _percentLab.text = @"0%";
        _percentLab.textColor = HexColor(@"#FFFFFF");
        _percentLab.font = FONT_SIZE_18;
        _percentLab.attributedText = [_percentLab.text addShadowWtihString:_percentLab.text color:@"#894000"];
    }
    return _percentLab;
}

- (UILabel *)waveLab{
    if (!_waveLab) {
        _waveLab = [[UILabel alloc] init];
        _waveLab.text = @"暂未添加训练次数";
        [_waveLab setTextColor:Main_TitleColor];
        [_waveLab setFont:[UIFont systemFontOfSize:18 weight:(UIFontWeightBold)]];
        [_waveLab setTextAlignment:(NSTextAlignmentCenter)];
    }
    return _waveLab;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr){
        _dataArr = [NSMutableArray arrayWithObjects:@{@"title":@"反馈意见",@"img":@"back"},@{@"title":@"点赞鼓励",@"img":@"good"},@{@"title":@"联系我们",@"img":@"chat"},@{@"title":@"关于我们",@"img":@"about"},@{@"title":@"分享好友",@"img":@"share"}, nil];
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
