//
//  GBSetTableViewCell.m
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBSetTableViewCell.h"

@implementation GBSetTableViewCell{
    UIImageView *setImage;
    UILabel *title;
    UILabel *decLab;
    UIImageView *cellImage;
    UIView *line;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    if (!setImage) {
        setImage = [UIImageView new];
        [setImage setContentMode:(UIViewContentModeScaleAspectFit)];
        [setImage setImage:IMG(@"set_icon")];
        [self.contentView addSubview:setImage];
        setImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 10).bottomSpaceToView(self.contentView, 10).widthEqualToHeight();
    }
    
    if (!title) {
        title = [UILabel new];
        [title setText:@"设置选项"];
        [title setTextColor:HexColor(@"333333")];
        [title setFont:[UIFont systemFontOfSize:16 weight:(UIFontWeightMedium)]];
        [self.contentView addSubview:title];
        title.sd_layout.leftSpaceToView(setImage, 20).topSpaceToView(self.contentView, 10).bottomSpaceToView(self.contentView, 10);
        [title setSingleLineAutoResizeWithMaxWidth:200];
    }
    
    if (!cellImage) {
        cellImage = [UIImageView new];
        [cellImage setImage:IMG(@"next_icon")];
        [self.contentView addSubview:cellImage];
        cellImage.sd_layout.rightSpaceToView(self.contentView, 15).widthIs(20).topSpaceToView(self.contentView, 14).bottomSpaceToView(self.contentView, 14);
    }
    
    if (!line) {
        line = [UIView new];
        [line setBackgroundColor:Commom_BackgroundColor];
        [self.contentView addSubview:line];
        line.sd_layout.bottomSpaceToView(self.contentView, 1).heightIs(1).leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10);
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
