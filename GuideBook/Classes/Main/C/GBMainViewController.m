//
//  GBMainViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/11.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBMainViewController.h"
#import "GBMainTableHeadView.h"

@interface GBMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *list;
@property (nonatomic, strong) GBMainTableHeadView *headView;
@end

@implementation GBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)setUI{
    self.navigationItem.title = @"训练项目";
    [self.view addSubview:self.list];
    [self.list setTableHeaderView:self.headView];
}

#pragma mark -- uitableview delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainTableCell" forIndexPath:indexPath];
    
    cell.textLabel.text = @"222";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - setters

- (UITableView *)list{
    if (!_list) {
        _list = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GB_ScreenWidth, GB_ScreenHeight-NaviH) style:(UITableViewStylePlain)];
        [_list setDelegate:self];
        [_list setDataSource:self];
        [_list registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mainTableCell"];
    }
    return _list;
}

- (GBMainTableHeadView *)headView{
    if (!_headView) {
        _headView = [[GBMainTableHeadView alloc] initWithFrame:CGRectMake(0, 0, GB_ScreenWidth, 120)];
    }
    return _headView;
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
