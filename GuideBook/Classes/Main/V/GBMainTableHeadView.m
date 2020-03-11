//
//  GBMainTableHeadView.m
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBMainTableHeadView.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "ZJECyclePagerViewCell.h"
@interface GBMainTableHeadView ()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation GBMainTableHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView{
    [self addSubview:self.pagerView];
    self.pagerView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .heightIs(122);
    [self.pagerView addSubview:self.pageControl];
    self.pageControl.sd_layout
    .bottomSpaceToView(self.pagerView, 0)
    .heightIs(26)
    .leftEqualToView(self.pagerView)
    .rightEqualToView(self.pagerView);
    
}


#pragma mark TYCyclePagerViewDataSource TYCyclePagerViewDelegate
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    ZJECyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.label.text = [NSString stringWithFormat:@"index->%ld",index];
    [cell.adImgView setImage:[UIImage imageNamed:self.dataArr[index]]];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame), CGRectGetHeight(pageView.frame));
    layout.itemSpacing = 0;
//    layout.minimumAlpha = 0.3;
    //    layout.itemHorizontalCenter = _horCenterSwitch.isOn;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index
{
    // 选中轮播图
    
}

#pragma mark - setters and getters
- (TYCyclePagerView *)pagerView
{
    if (!_pagerView) {
        _pagerView = [[TYCyclePagerView alloc] init];
        _pagerView.isInfiniteLoop = YES;
        _pagerView.autoScrollInterval = 3.0;
        _pagerView.dataSource = self;
        _pagerView.delegate = self;
        [_pagerView registerClass:[ZJECyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    }
    return _pagerView;
}

- (TYPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[TYPageControl alloc]init];
        _pageControl.currentPageIndicatorSize = CGSizeMake(9, 9);
        _pageControl.pageIndicatorSize = CGSizeMake(9, 9);
        _pageControl.currentPageIndicatorTintColor = HexColor(@"#FF7F00");
        _pageControl.pageIndicatorTintColor = HexColor(@"FFFFFF");
    }
    return _pageControl;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        [_dataArr addObjectsFromArray:@[@"image1",@"image2",@"image3"]];
    }
    return _dataArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
