//
//  GBTutorialViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/12.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GBTutorialViewController.h"
#import "GBTutorTableViewCell.h"
@interface GBTutorialViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *list;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation GBTutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self getData];
    // Do any additional setup after loading the view.
}

- (void)getData{
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"turo" ofType:@"json"]];
    [self.dataArr addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil]];
    [self.list reloadData];
}

- (void)setUI{
    self.navigationItem.title = @"动态教程";
    [self.view addSubview:self.list];
}

#pragma mark tableview delegate datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GBTutorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TutorialCell" forIndexPath:indexPath];
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    cell.cellDic = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark setters getters
- (UITableView *)list{
    if (!_list) {
        _list = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GB_ScreenWidth, GB_ScreenHeight-NaviH) style:(UITableViewStylePlain)];
        [_list setDelegate:self];
        [_list setDataSource:self];
        [_list setTableFooterView:[UIView new]];
        [_list registerClass:[GBTutorTableViewCell class] forCellReuseIdentifier:@"TutorialCell"];
    }
    return _list;
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
