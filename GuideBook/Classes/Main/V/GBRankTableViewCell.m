//
//  GBRankTableViewCell.m
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBRankTableViewCell.h"

@implementation GBRankTableViewCell{
    UIView *backView;
    UIImageView *cellImage;
    UILabel *titleLab;
    UILabel *troduceLab;
    UILabel *likeLab;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        backView = [UIView new];
        [backView setBackgroundColor:Main_BackGroundColor];
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
        cellImage.layer.cornerRadius = 10;
        cellImage.layer.masksToBounds = YES;
        [backView addSubview:cellImage];
        cellImage.sd_layout.leftSpaceToView(backView, 10).topSpaceToView(backView, 10).bottomSpaceToView(backView, 10).widthEqualToHeight();
    }
    
    if (!titleLab) {
        titleLab = [UILabel new];
        [titleLab setFont:[UIFont systemFontOfSize:16 weight:(UIFontWeightBold)]];
        [titleLab setTextAlignment:(NSTextAlignmentCenter)];
        [titleLab setTextColor:HexColor(@"FFFFFF")];
        [backView addSubview:titleLab];
        titleLab.sd_layout.leftSpaceToView(cellImage, 20).rightSpaceToView(backView, 20).topSpaceToView(backView, 15).heightIs(18);
    }
    
    if (!troduceLab) {
        troduceLab = [UILabel new];
        troduceLab.numberOfLines = 0;
        [troduceLab setFont:[UIFont systemFontOfSize:13 weight:(UIFontWeightMedium)]];
        [troduceLab setTextColor:HexColor(@"EEEEEE")];
        [backView addSubview:troduceLab];
        troduceLab.sd_layout.leftSpaceToView(cellImage, 20).rightSpaceToView(backView, 20).topSpaceToView(titleLab, 10).bottomSpaceToView(backView, 10);
    }
}

- (void)setDataDic:(NSDictionary *)dataDic{
    [cellImage setImage:IMG([dataDic valueForKey:@"image"])];
    [titleLab setText:[dataDic valueForKey:@"trainTitle"]];
    [troduceLab setText:[dataDic valueForKey:@"trainTroduce"]];
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
