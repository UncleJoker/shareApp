//
//  GuiBRankTableViewCell.m
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GuiBRankTableViewCell.h"

@implementation GuiBRankTableViewCell{
    UIView *backView;
    UIImageView *cellImage;
    UILabel *titleLab;
    UILabel *troduceLab;
    UILabel *likeLab;
    UIImageView *likeImg;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        backView = [UIView new];
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
        [titleLab setTextColor:Main_TitleColor];
        [backView addSubview:titleLab];
        titleLab.sd_layout.leftSpaceToView(cellImage, 20).topSpaceToView(backView, 15).heightIs(18);
        [titleLab setSingleLineAutoResizeWithMaxWidth:200];
    }
    
    if (!troduceLab) {
        troduceLab = [UILabel new];
        troduceLab.numberOfLines = 0;
        [troduceLab setFont:[UIFont systemFontOfSize:13 weight:(UIFontWeightMedium)]];
        [troduceLab setTextColor:Main_ContentColor];
        [backView addSubview:troduceLab];
        troduceLab.sd_layout.leftSpaceToView(cellImage, 20).rightSpaceToView(backView, 20).topSpaceToView(titleLab, 10).bottomSpaceToView(backView, 10);
    }
    
    if (!likeImg) {
        likeImg = [UIImageView new];
        [likeImg setImage:IMG(@"like_img")];
        [backView addSubview:likeImg];
        likeImg.sd_layout.rightSpaceToView(backView, 20).heightIs(15).widthEqualToHeight().centerYEqualToView(titleLab);
    }
    
    if (!likeLab) {
        likeLab = [UILabel new];
        [likeLab setTextColor:Main_ContentColor];
        [likeLab setTextAlignment:(NSTextAlignmentRight)];
        [likeLab setFont:[UIFont systemFontOfSize:13 weight:(UIFontWeightRegular)]];
        [backView addSubview:likeLab];
        likeLab.sd_layout.rightSpaceToView(likeImg, 5).leftSpaceToView(titleLab, 20).centerYEqualToView(titleLab).heightIs(15);
    }
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    [cellImage setImage:IMG([dataDic valueForKey:@"image"])];
    [titleLab setText:[dataDic valueForKey:@"trainTitle"]];
    [troduceLab setText:[dataDic valueForKey:@"trainTroduce"]];
    [likeLab setText:[dataDic valueForKey:@"trainPeo"]];
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
