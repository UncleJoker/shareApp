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
        [self.contentView addSubview:cellImage];
        cellImage.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 10).bottomSpaceToView(self.contentView, 10).widthEqualToHeight();
    }
    
    if (!titleLab) {
        titleLab = [UILabel new];
        [titleLab setTextAlignment:(NSTextAlignmentCenter)];
        [titleLab setFont:[UIFont systemFontOfSize:16]];
        [titleLab setTextColor:HexColor(@"FFFFFF")];
        [titleLab setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:titleLab];
        titleLab.sd_layout.leftSpaceToView(cellImage, 10).topSpaceToView(self.contentView, 20).heightIs(18).rightSpaceToView(self.contentView, 20);
    }
    
    if (!troduceLab) {
        troduceLab = [UILabel new];
        [troduceLab setFont:[UIFont systemFontOfSize:14]];
        [troduceLab setTextColor:HexColor(@"DDDDDD")];
        [troduceLab setBackgroundColor:[UIColor clearColor]];
        [troduceLab setNumberOfLines:3];
        [self.contentView addSubview:troduceLab];
        troduceLab.sd_layout.leftEqualToView(titleLab).rightEqualToView(titleLab).topSpaceToView(titleLab, 10).bottomSpaceToView(self.contentView, 20);
    }
}

- (void)setModel:(id)model{
    _model = model;
    if ([model isKindOfClass:[GBAddTrainModel class]]) {
        GBAddTrainModel *item = model;
        [titleLab setText:[item.trainDic valueForKey:@"title"]];
        [cellImage setImage:[UIImage imageNamed:[item.trainDic valueForKey:@"image"]]];
        [troduceLab setText:[item.trainDic valueForKey:@"troduce"]];
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
