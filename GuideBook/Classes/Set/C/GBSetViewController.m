//
//  GBSetViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBSetViewController.h"
#import "YAWaveView.h"

@interface GBSetViewController ()<YAWaveViewDelegate>
@property (nonatomic, strong) UILabel *percentLab;
@end

@implementation GBSetViewController
{
    YAWaveView *_rectWave;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setUI{
    self.navigationItem.title = @"设置中心";
    [self addWaveView];
}

- (void)addWaveView{
    
    NSArray *colors = @[(__bridge id)HexColor(@"#00FF99").CGColor, (__bridge id)HexColor(@"#00CC00").CGColor];  //里
    NSArray *sColors = @[(__bridge id)HexColor(@"#00CC33").CGColor, (__bridge id)HexColor(@"#00FF00").CGColor];  //外
    CGFloat waveWidth = 95;
    //自定义背景渐变-圆形波浪
    YAWaveView *customWave = [[YAWaveView alloc]initWithFrame:CGRectMake(self.view.width/2-waveWidth/2, 20, waveWidth, waveWidth)];
    [self.view addSubview:customWave];
    customWave.layer.cornerRadius = waveWidth/2;
    customWave.clipsToBounds = YES;
    customWave.colors = colors;
    customWave.sColors = sColors;
    customWave.percent = 0.7;
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
        //线性渐变
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(width, height), kCGGradientDrawsAfterEndLocation);
    } else {
        //径向渐变
        CGContextDrawRadialGradient(context, gradient, center,0, center, width/2, kCGGradientDrawsAfterEndLocation);
    }
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

#pragma mark -- setters

- (UILabel *)percentLab
{
    if (!_percentLab) {
        _percentLab = [UILabel new];
        _percentLab.text = @"70%";
        _percentLab.textColor = HexColor(@"#FFFFFF");
        _percentLab.font = FONT_SIZE_18;
        _percentLab.attributedText = [_percentLab.text addShadowWtihString:_percentLab.text color:@"#894000"];
    }
    return _percentLab;
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
