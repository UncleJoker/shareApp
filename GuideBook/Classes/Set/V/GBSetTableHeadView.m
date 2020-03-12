//
//  GBSetTableHeadView.m
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBSetTableHeadView.h"

@implementation GBSetTableHeadView{
    UIImageView *headImage;
    UILabel *nameLab;
    UILabel *sayingLab;
    UIView *lineView;
    UIButton *singelBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    if (!headImage) {
        headImage = [UIImageView new];
        [headImage setImage:IMG(@"headImage")];
        [self addSubview:headImage];
        headImage.sd_layout.topSpaceToView(self, 20).leftSpaceToView(self, 30).heightIs(80).widthEqualToHeight();
        headImage.layer.cornerRadius = 40;
        headImage.layer.masksToBounds= YES;
    }
    
    if (!nameLab) {
        nameLab = [UILabel new];
        [nameLab setText:@"足球先生"];
        [nameLab setTextColor:HexColor(@"333333")];
        [nameLab setFont:[UIFont systemFontOfSize:20 weight:(UIFontWeightBold)]];
        [nameLab setTextAlignment:(NSTextAlignmentCenter)];
        [self addSubview:nameLab];
        nameLab.sd_layout.leftSpaceToView(headImage, 20).rightSpaceToView(self, 20).topSpaceToView(self, 25).heightIs(22);
    }
    
    if (!sayingLab) {
        sayingLab = [UILabel new];
        [sayingLab setText:@"有志者事竞争成"];
        [sayingLab setTextColor:HexColor(@"888888")];
        [sayingLab setFont:[UIFont systemFontOfSize:16 weight:(UIFontWeightMedium)]];
        [sayingLab setTextAlignment:(NSTextAlignmentCenter)];
        [self addSubview:sayingLab];
        sayingLab.sd_layout.leftEqualToView(nameLab).rightEqualToView(nameLab).heightIs(18).topSpaceToView(nameLab, 25);
    }
    
    lineView = [UIView new];
    [lineView setBackgroundColor:Commom_BackgroundColor];
    [self addSubview:lineView];
    lineView.sd_layout.leftSpaceToView(self, 20).rightSpaceToView(self, 20).bottomSpaceToView(self, 2).heightIs(1);
    
    
    if (!singelBtn) {
        singelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [singelBtn setBackgroundColor:[UIColor clearColor]];
        [singelBtn addTarget:self action:@selector(editUserInfo) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:singelBtn];
        singelBtn.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    
}

- (void)editUserInfo{
    if ([_headDelegate respondsToSelector:@selector(tapHeadView)]) {
        [_headDelegate tapHeadView];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
