//
//  GuiBFeedbackViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/13.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GuiBFeedbackViewController.h"

@interface GuiBFeedbackViewController ()

@end

@implementation GuiBFeedbackViewController{
    UILabel *titleLab;
    UITextView *textView;
    UIButton *sendBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setUI{
    self.navigationItem.title = @"反馈意见";
    
    if (!titleLab) {
        titleLab = [UILabel new];
        [titleLab setText:@"发送反馈内容"];
        [titleLab setFont:[UIFont systemFontOfSize:16 weight:(UIFontWeightBold)]];
        [titleLab setTextAlignment:(NSTextAlignmentCenter)];
        [titleLab setTextColor:[UIColor whiteColor]];
        [titleLab setBackgroundColor:Main_BackGroundColor];
        titleLab.layer.cornerRadius = 8;
        titleLab.layer.masksToBounds = YES;
        [self.view addSubview:titleLab];
        titleLab.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view, 20).heightIs(44).widthIs(120);
    }
    
    if (!textView) {
        textView = [UITextView new];
        [textView setFont:[UIFont systemFontOfSize:13 weight:(UIFontWeightMedium)]];
        [textView setTextColor:Main_ContentColor];
        textView.layer.cornerRadius = 4;
        textView.layer.masksToBounds = YES;
        [self.view addSubview:textView];
        textView.sd_layout.leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).topSpaceToView(titleLab, 20).bottomSpaceToView(self.view, 100);
    }
    
    if (!sendBtn) {
        sendBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [sendBtn setTitle:@"发送" forState:(UIControlStateNormal)];
        [sendBtn setBackgroundColor:Main_BackGroundColor];
        [sendBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [sendBtn addTarget:self action:@selector(sendBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:sendBtn];
        sendBtn.sd_layout.leftSpaceToView(self.view, 40).rightSpaceToView(self.view, 40).heightIs(44).topSpaceToView(textView, 20);
        sendBtn.layer.cornerRadius = 22;
        sendBtn.layer.masksToBounds = YES;
    }
    
}

- (void)sendBtnAction{
    if ([textView.text isEqualToString:@""]) {
        [LCProgressHUD showFailure:@"请输入反馈内容"];
        return;
    }
    [LCProgressHUD showSuccess:@"多谢你的反馈!"];
    [self.navigationController popViewControllerAnimated:YES];
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
