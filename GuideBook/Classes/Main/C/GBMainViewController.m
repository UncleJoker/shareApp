//
//  GBMainViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBMainViewController.h"
#import "GBMainTableHeadView.h"
#import "GBMainTableViewCell.h"
#import "GBAddViewController.h"
#import "GBIntroductionViewController.h"
#import "GBRankingViewController.h"
#import "GBTutorialViewController.h"
#import "GBOtherViewController.h"

@interface GBMainViewController ()<UITableViewDelegate,UITableViewDataSource,GBMainBtnDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *list;

@property (nonatomic, strong) GBMainTableHeadView *headView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation GBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:AddSunccessNotice object:nil];
    [self setUI];
    [self addMJRefresh];
    [self getData];
    // Do any additional setup after loading the view.
}

- (void)getData{
    if (self.dataArr.count > 0) {
        [self.dataArr removeAllObjects];
    }
    
    [self.dataArr addObjectsFromArray:[NSArray bg_arrayWithName:SaveTrainName]];
    [self.list reloadData];
    [self.list.mj_header endRefreshing];
}

- (void)setUI{
    self.navigationItem.title = @"训练项目";
    [self setNavigationRightItemWithTitle:@"清空" target:self action:@selector(clearAllData)];
    [self.view addSubview:self.list];
    [self.list setTableHeaderView:self.headView];
    
    self.list.emptyDataSetSource = self;
    self.list.emptyDataSetDelegate = self;
}

- (void)addMJRefresh{
    WEAKSELF(weakSelf);
    self.list.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getData];
    }];
}

#pragma mark -- uitableview delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GBMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainTableCell" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark - btnDelegate

- (void)tapCycleImageIndex:(NSInteger)tapIndex{
    
    
}

- (void)tapFunctionIndex:(NSInteger)selectIndex{
    switch (selectIndex) {
        case 0:
        {
            GBIntroductionViewController *troduceVC = [GBIntroductionViewController new];
            [self.navigationController pushViewController:troduceVC animated:YES];
        }
            break;
        case 1:
        {
            GBRankingViewController *rankVC = [GBRankingViewController new];
            [self.navigationController pushViewController:rankVC animated:YES];
        }
            break;
        case 2:
        {
            GBTutorialViewController *tutorVC = [GBTutorialViewController new];
            [self.navigationController pushViewController:tutorVC animated:YES];
        }
            break;
        case 3:
        {
            GBOtherViewController *otherVC = [GBOtherViewController new];
            [self.navigationController pushViewController:otherVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂无训练项目";
    return [[NSAttributedString alloc] initWithString:text attributes:nil];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSString *text = [NSString stringWithFormat:@"请添加新的训练项目,然后回来查看详情"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:nil];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0] range:[attributedString.string rangeOfString:@"查看详情"]];
    
    return attributedString;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSString *text = @"添加新的训练项目";
    UIFont *font = [UIFont systemFontOfSize:16.0];
    UIColor *textColor = HexColor(@"007aff");
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return 64.0;
}

#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    [self presentViewController:[GBAddViewController new] animated:YES completion:nil];
}


#pragma mark - action
- (void)clearAllData{
    
    HX_AlertView *alert = [[HX_AlertView alloc]initWithTitle:@"清空内容" message:@"返回将清空内容，是否继续" parentControl:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认" cancelButtonBlock:^{
    } otherButtonBlock:^{
        [NSArray bg_clearArrayWithName:SaveTrainName];
        [self getData];
    }];
    [alert showAlertInView];
}

#pragma mark - setters

- (UITableView *)list{
    if (!_list) {
        _list = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GB_ScreenWidth, GB_ScreenHeight-NaviH) style:(UITableViewStylePlain)];
        [_list setDelegate:self];
        [_list setDataSource:self];
        [_list registerClass:[GBMainTableViewCell class] forCellReuseIdentifier:@"mainTableCell"];
        [_list setTableFooterView:[UIView new]];
    }
    return _list;
}

- (GBMainTableHeadView *)headView{
    if (!_headView) {
        _headView = [[GBMainTableHeadView alloc] initWithFrame:CGRectMake(0, 0, GB_ScreenWidth, 320)];
        _headView.btnDelegate = self;
    }
    return _headView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
