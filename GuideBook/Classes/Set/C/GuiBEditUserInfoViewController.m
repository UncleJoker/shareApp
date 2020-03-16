//
//  GuiBEditUserInfoViewController.m
//  GuideBook
//
//  Created by Apple on 2020/3/13.
//  Copyright © 2020 Design. All rights reserved.
//

#import "GuiBEditUserInfoViewController.h"
#import "GuiBUserInfoTableViewCell.h"
#import "OAImagePickUtil.h"
#import "YYImageClipViewController.h"

@interface GuiBEditUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,OAImagePickUtilDelegate,YYImageClipDelegate>
@property (nonatomic, strong) UITableView *list;
@property (nonatomic, strong) NSArray *cellArr;
@property (nonatomic, strong) NSString *imageFile;
@property (nonatomic, copy) NSString *nameSr;
@property (nonatomic, copy) NSString *sayingStr;
@end

@implementation GuiBEditUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)initData{
    self.imageFile = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/footBallHead.png"];
    self.cellArr = [NSArray arrayWithObjects:@"修改头像",@"昵称",@"名言", nil];
    self.nameSr = [[NSUserDefaults standardUserDefaults] objectForKey:UserName] ? [[NSUserDefaults standardUserDefaults] objectForKey:UserName] : @"足球先生";
    self.sayingStr = [[NSUserDefaults standardUserDefaults] objectForKey:UserSaying] ? [[NSUserDefaults standardUserDefaults] objectForKey:UserSaying] : @"编辑名言";
    [self.list reloadData];
}

- (void)setUI{
    self.navigationItem.title = @"修改用户信息";
    [self.view addSubview:self.list];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GuiBUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell" forIndexPath:indexPath];
    [cell showCellImage:indexPath.row == 0 ? NO : YES];
    [cell setCellTitle:self.cellArr[indexPath.row]];
    if (indexPath.row == 0) {
        [cell setHeadImage:self.imageFile];
    }
    if (indexPath.row == 1) {
        [cell setDescString:self.nameSr];
    }
    if (indexPath.row == 2) {
        [cell setDescString:self.sayingStr];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row == 0 ?  88 : 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dealWithIndex:indexPath.row];
}

- (void)dealWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            OAImagePickUtil *pickUtil = [OAImagePickUtil sharedManager];
            pickUtil.delegate = self;
            [pickUtil showSheet:self withImageCount:1];
        }
            break;
        case 1:
        {
            [self showAlertInputTitle:@"修改昵称" message:@"请输入昵称" saveKey:UserName];
        }
            break;
        case 2:
        {
            [self showAlertInputTitle:@"修改名言" message:@"请输入名言警句" saveKey:UserSaying];
        }
            break;
            
        default:
            break;
    }
}


- (void)showAlertInputTitle:(NSString *)title message:(NSString *)message saveKey:(NSString *)saveKey{
    //提示框添加文本输入框
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         //得到文本信息
                                                         for(UITextField *text in alert.textFields){
                                                             if ([text.text isEqualToString:@""]) {
                                                                 [LCProgressHUD showFailure:message];
                                                                 return ;
                                                             }
                                                             [[NSUserDefaults standardUserDefaults] setObject:text.text forKey:saveKey];
                                                             [self initData];
                                                         }
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                         }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = message;
    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - OAImagePickUtilDelegate
- (void)pickPhotoWithImage:(NSArray *)imgsAry
{
    if (imgsAry.count > 0) {
        
        if (imgsAry.count > 0) {
            YYImageClipViewController *imgCropperVC = [[YYImageClipViewController alloc] initWithImage:imgsAry[0] cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
            imgCropperVC.delegate = self;
            [self presentViewController:imgCropperVC animated:YES completion:^{
            }];
        }
    }
}

#pragma mark - YYImageCropperDelegate
- (void)imageCropper:(YYImageClipViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    [self saveImage:editedImage];
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropperDidCancel:(YYImageClipViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void) saveImage:(UIImage *)currentImage {
    //设置照片的品质
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1);
    // 获取沙盒目录
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/footBallHead.png"];
    // 将图片写入文件
    [imageData writeToFile:filePath atomically:NO];
    [self initData];
}

#pragma mark -- setters getters
- (UITableView *)list{
    if (!_list) {
        _list = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GB_ScreenWidth, GB_ScreenHeight-NaviH) style:(UITableViewStylePlain)];
        [_list setDelegate:self];
        [_list setDataSource:self];
        [_list registerClass:[GuiBUserInfoTableViewCell class] forCellReuseIdentifier:@"UserInfoCell"];
        [_list setTableFooterView:[UIView new]];
    }
    return _list;
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
