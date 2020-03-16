//
//  GuiBUserInfoTableViewCell.m
//  GuideBook
//
//  Created by Apple on 2020/3/13.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GuiBUserInfoTableViewCell.h"

@implementation GuiBUserInfoTableViewCell{
    UIImageView *cellImage;
    UILabel *cellLab;
    UIImageView *nextImg;
    UILabel *descLab;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    cellImage = [UIImageView new];
    [cellImage setImage:IMG(@"headImage")];
    [cellImage setHidden:YES];
    [self.contentView addSubview:cellImage];
    cellImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 15).bottomSpaceToView(self.contentView, 15).widthIs(0);
    cellImage.layer.cornerRadius = 58/2;
    cellImage.layer.masksToBounds = YES;
    
    cellLab = [UILabel new];
    [cellLab setText:@"修改头像"];
    [cellLab setTextColor:Main_TitleColor];
    [cellLab setFont:[UIFont systemFontOfSize:16 weight:(UIFontWeightMedium)]];
    [self.contentView addSubview:cellLab];
    cellLab.sd_layout.leftSpaceToView(cellImage, 15).centerYEqualToView(self.contentView).heightIs(18);
    [cellLab setSingleLineAutoResizeWithMaxWidth:200];
    
    nextImg = [UIImageView new];
    [nextImg setContentMode:(UIViewContentModeScaleAspectFill)];
    [nextImg setImage:IMG(@"next_icon")];
    [self.contentView addSubview:nextImg];
    nextImg.sd_layout.rightSpaceToView(self.contentView, 25).centerYEqualToView(self.contentView).widthIs(10).heightIs(15);
    
    descLab = [UILabel new];
    [descLab setHidden:YES];
    [descLab setTextColor:Main_ContentColor];
    [descLab setTextAlignment:(NSTextAlignmentRight)];
    [descLab setFont:[UIFont systemFontOfSize:13 weight:(UIFontWeightMedium)]];
    [self.contentView addSubview:descLab];
    descLab.sd_layout.rightSpaceToView(nextImg, 15).centerYEqualToView(self.contentView).heightIs(15).leftSpaceToView(cellLab, 15);
    
}

- (void)showCellImage:(BOOL)isShow{
    cellImage.hidden = isShow;
    descLab.hidden = !isShow;
    if (!isShow) {
        cellImage.sd_layout.widthEqualToHeight();
    }
}

- (void)setHeadImage:(NSString *)imageFile{
    if (![UIImage imageWithContentsOfFile:imageFile]) {
        // 没设置用户头像 默认用户头像
    }else{
        [cellImage setImage:[UIImage imageWithContentsOfFile:imageFile]];
    }
}

- (void)setCellTitle:(NSString *)title{
    cellLab.text = title;
}

- (void)setDescString:(NSString *)desc{
    descLab.text = desc;
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
