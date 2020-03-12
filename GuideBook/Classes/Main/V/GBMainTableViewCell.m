//
//  GBMainTableViewCell.m
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBMainTableViewCell.h"

@implementation GBMainTableViewCell{
    UIImageView *cellImage;
    UILabel *titleLab;
    UILabel *troduceLab;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        [self.contentView setBackgroundColor:HexColor(@"345c07")];
        [self setView];
    }
    return self;
}

- (void)setView{
    if (!cellImage) {
        cellImage = [UIImageView new];
        [cellImage setContentMode:(UIViewContentModeScaleToFill)];
        cellImage.layer.cornerRadius = 4;
        cellImage.layer.masksToBounds = YES;
        [cellImage setImage:[UIImage imageNamed:@"bgimage1"]];
        [self.contentView addSubview:cellImage];
        cellImage.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 10).bottomSpaceToView(self.contentView, 10).widthEqualToHeight();
    }
    
    if (!titleLab) {
        titleLab = [UILabel new];
        [titleLab setText:@"控球训练"];
        [titleLab setTextAlignment:(NSTextAlignmentCenter)];
        [titleLab setFont:[UIFont systemFontOfSize:16]];
        [titleLab setTextColor:HexColor(@"FFFFFF")];
        [titleLab setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:titleLab];
        titleLab.sd_layout.leftSpaceToView(cellImage, 10).topSpaceToView(self.contentView, 20).heightIs(18).rightSpaceToView(self.contentView, 20);
    }
    
    if (!troduceLab) {
        troduceLab = [UILabel new];
        [troduceLab setText:@"现在的训练更结构化一些，因为毕竟最终我们是要运用带球技巧的，所以节奏感非常重要，就像这样从左到右，从右到左，内侧外侧，内侧外侧。你知道该怎么做，训练时姿势要正确，速度要快。重要的是要始终保持控球，从左到右，两只脚都要用，时不时可以加入点其他有趣的内容。"];
        [troduceLab setFont:[UIFont systemFontOfSize:14]];
        [troduceLab setTextColor:HexColor(@"DDDDDD")];
        [troduceLab setBackgroundColor:[UIColor clearColor]];
        [troduceLab setNumberOfLines:3];
        [self.contentView addSubview:troduceLab];
        troduceLab.sd_layout.leftEqualToView(titleLab).rightEqualToView(titleLab).topSpaceToView(titleLab, 10).bottomSpaceToView(self.contentView, 20);
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
