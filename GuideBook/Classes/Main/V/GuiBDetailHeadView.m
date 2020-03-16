//
//  GuiBDetailHeadView.m
//  GuideBook
//
//  Created by Apple on 2020/3/13.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GuiBDetailHeadView.h"

@implementation GuiBDetailHeadView{
    UIImageView *headImage;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    headImage = [UIImageView new];
    [headImage setContentMode:(UIViewContentModeScaleToFill)];
    [self addSubview:headImage];
    headImage.sd_layout.leftEqualToView(self).rightEqualToView(self).topEqualToView(self).bottomEqualToView(self);
}

- (void)setHeadImagestr:(NSString *)headImagestr{
    [headImage setImage:IMG(headImagestr)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
