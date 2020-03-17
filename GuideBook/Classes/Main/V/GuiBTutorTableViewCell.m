//
//  GuiBTutorTableViewCell.m
//  GuideBook
//
//  Created by Apple on 2020/3/13.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GuiBTutorTableViewCell.h"

@implementation GuiBTutorTableViewCell{
    UILabel *titleLab;
    UIImageView *gif;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    titleLab = [UILabel new];
    [titleLab setTextColor:Main_TitleColor];
    [titleLab setFont:[UIFont systemFontOfSize:18 weight:(UIFontWeightBold)]];
    [self.contentView addSubview:titleLab];
    titleLab.sd_layout.leftSpaceToView(self.contentView, 20).heightIs(20).topSpaceToView(self.contentView, 15);
    [titleLab setSingleLineAutoResizeWithMaxWidth:GB_ScreenWidth-40];
    
    gif = [UIImageView new];
    [gif setContentMode:(UIViewContentModeScaleToFill)];
    [self.contentView addSubview:gif];
    gif.sd_layout.topSpaceToView(titleLab, 14).bottomSpaceToView(self.contentView, 14).leftSpaceToView(self.contentView, 20).rightSpaceToView(self.contentView, 20);
    
}

- (void)setCellDic:(NSDictionary *)cellDic{
    [titleLab setText:[cellDic valueForKey:@"title"]];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[cellDic valueForKey:@"gif"] ofType:@"gif"];
   NSURL * url = [[NSURL alloc]initFileURLWithPath:imagePath];
   [gif yh_setImage:url];
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
