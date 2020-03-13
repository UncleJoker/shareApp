//
//  GBMainTableViewCell.m
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBMainTableViewCell.h"

@implementation GBMainTableViewCell{
    UIView *backView;
    UIImageView *cellImage;
    UILabel *titleLab;
    UIImageView *statuImg;// 完成状态
    UILabel *troduceLab;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:Commom_BackgroundColor];
        backView = [UIView new];
        [backView setBackgroundColor:[UIColor whiteColor]];
        backView.layer.cornerRadius = 8;
        backView.layer.masksToBounds = YES;
        [self.contentView addSubview:backView];
        backView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(10, 10, 10, 10));
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
        [backView addSubview:cellImage];
        cellImage.sd_layout.leftSpaceToView(backView, 10).topSpaceToView(backView, 10).bottomSpaceToView(backView, 10).widthEqualToHeight();
    }
    
    if (!titleLab) {
        titleLab = [UILabel new];
        [titleLab setFont:[UIFont systemFontOfSize:16]];
        [titleLab setTextColor:Main_TitleColor];
        [titleLab setBackgroundColor:[UIColor clearColor]];
        [backView addSubview:titleLab];
        titleLab.sd_layout.leftSpaceToView(cellImage, 10).topSpaceToView(backView, 15).heightIs(18);
        [titleLab setSingleLineAutoResizeWithMaxWidth:299];
    }
    
    if (!statuImg) {
        statuImg = [UIImageView new];
        [backView addSubview:statuImg];
        statuImg.sd_layout.rightSpaceToView(backView, 20).heightIs(20).widthEqualToHeight().centerYEqualToView(titleLab);
    }
    
    if (!troduceLab) {
        troduceLab = [UILabel new];
        [troduceLab setFont:[UIFont systemFontOfSize:14]];
        [troduceLab setTextColor:Main_ContentColor];
        [troduceLab setBackgroundColor:[UIColor clearColor]];
        [troduceLab setNumberOfLines:3];
        [backView addSubview:troduceLab];
        troduceLab.sd_layout.leftEqualToView(titleLab).rightSpaceToView(backView, 20).topSpaceToView(titleLab, 5).bottomSpaceToView(backView, 10);
    }
}

- (void)setModel:(id)model{
    _model = model;
    if ([model isKindOfClass:[GBAddTrainModel class]]) {
        GBAddTrainModel *item = model;
        [titleLab setText:[item.trainDic valueForKey:@"title"]];
        [cellImage setImage:[UIImage imageNamed:[item.trainDic valueForKey:@"image"]]];
        [troduceLab setText:[item.trainDic valueForKey:@"troduce"]];
        [statuImg setImage:IMG(item.isFinish ? @"complete_icon" : @"no_complete")];
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
