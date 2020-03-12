//

#import "ZJECyclePagerViewCell.h"

@interface ZJECyclePagerViewCell ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation ZJECyclePagerViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
        [self addImgView];
    }
    return self;
}

- (void)addLabel
{
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.label];
}

- (void)addImgView
{
    self.adImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.adImgView];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.bounds;
    self.adImgView.frame = self.bounds;
}

- (UILabel *)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

- (UIImageView *)adImgView
{
    if (!_adImgView){
        _adImgView = [[UIImageView alloc] init];
        [_adImgView setContentMode:(UIViewContentModeScaleAspectFit)];
    }
    return _adImgView;
}



@end
