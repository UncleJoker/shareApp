//
//  GBRankingViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBRankingViewController.h"
#import "GBRankTableViewCell.h"
@interface GBRankingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *list;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation GBRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self getData];
    // Do any additional setup after loading the view.
}

- (void)getData{
    if (self.dataArr.count > 0) {
        [self.dataArr removeAllObjects];
    }
    
    NSDictionary *rankDic = [GBMethodTools readLocalFileWithName:RankTrainJSON];
    [self.dataArr addObjectsFromArray:[rankDic valueForKey:@"rankArr"]];
    [self.list reloadData];
}

- (void)setUI{
    self.navigationItem.title = @"训练排行";
    
    [self.view addSubview:self.list];
    
}

#pragma mark - tableview delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GBRankTableViewCell *cel = [tableView dequeueReusableCellWithIdentifier:@"rankTableViewCell" forIndexPath:indexPath];
    [cel setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    cel.dataDic = self.dataArr[indexPath.row];
    return cel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - setters getters
- (UITableView *)list{
    if (!_list) {
        _list = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GB_ScreenWidth, self.view.height-NaviH) style:(UITableViewStylePlain)];
        [_list setTableFooterView:[UIView new]];
        [_list setDelegate: self];
        [_list setDataSource:self];
        [_list registerClass:[GBRankTableViewCell class] forCellReuseIdentifier:@"rankTableViewCell"];
    }
    return _list;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
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
