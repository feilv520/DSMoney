//
//  MyInformationViewController.m
//  DSLC
//
//  Created by ios on 15/10/16.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyInformationViewController.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "define.h"
#import "MyInformationCell.h"
#import "MyBankViewController.h"
#import "BindingPhoneViewController.h"
#import "RealNameViewController.h"
#import "MeCell.h"
#import "MendLoginViewController.h"
#import "MendDealViewController.h"
#import "EmailViewController.h"
#import "MyAfHTTPClient.h"
#import "MyInformation.h"
#import "LoginViewController.h"
#import "SetDealSecret.h"
#import "MyAlreadyBindingBank.h"
#import "AddBankViewController.h"

@interface MyInformationViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
    UISwitch *switchLeft;
    NSString *path;
    UIButton *butBlack;
    UIView *viewDown;
    
    UIImage *imageChange;
    
    UIButton *indexButton;
}

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic) UIImagePickerController *imagePicker;

@property (nonatomic, strong) NSDictionary *flagLogin;
//@property (nonatomic, strong) NSDictionary *flagDic;

@end

@implementation MyInformationViewController

- (NSDictionary *)flagLogin{
    if (_flagLogin == nil) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
        self.flagLogin = dic;
    }
    return _flagLogin;
}

//- (NSDictionary *)flagDic{
//    if (_flagDic == nil) {
//        
//        if (![FileOfManage ExistOfFile:@"Flag.plist"]) {
//            [FileOfManage createWithFile:@"Flag.plist"];
//            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"FlagWithVC",@"YES",@"FristOpen",nil];
//            [dic writeToFile:[FileOfManage PathOfFile:@"Flag.plist"] atomically:YES];
//        }
//        
//        NSDictionary *dics = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Flag.plist"]];
//        _flagDic = dics;
//    }
//    return _flagDic;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"我的资料"];
    
    [self tableViewShow];
    [self getData];
}

//tableView展示
- (void)tableViewShow
{
    titleArr = @[@[@"我的银行卡"],
                 @[@"更换手机", @"绑定邮箱", @"实名认证"],
                 @[@"登录密码", @"交易密码", @"手势密码", @"修改手势密码"]];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    
    _tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100)];
    _tableView.tableFooterView = view;
    view.backgroundColor = [UIColor huibai];
    [_tableView registerNib:[UINib nibWithNibName:@"MyInformationCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"MeCell" bundle:nil] forCellReuseIdentifier:@"reuseMe"];
    
    switchLeft = [[UISwitch alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT * (64.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (10.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (50.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (30.0 / 667.0))];
    
    NSDictionary *dic = self.flagDic;
    
    NSString *flag = [dic objectForKey:@"FlagWithVC"];
    
    [switchLeft setOn:[flag isEqualToString:@"YES"]?YES:NO];

    [switchLeft addTarget:self action:@selector(showSwitchGetOnOrOff:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *butExit = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 60, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"退出登录"];
    [view addSubview:butExit];
    [butExit setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [butExit setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [butExit addTarget:self action:@selector(buttonExit:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0.1;
        
    } else {
        
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    } else if (section == 1) {
        
        return 1;
        
    } else if (section == 2) {
        
        return 3;
        
    } else {
        
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        MeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseMe"];
        
        cell.imageHeadPic.image = [UIImage imageNamed:@"组-4-拷贝"];
        cell.imageRight.image = [UIImage imageNamed:@"arrow"];
        
        cell.labelName.text = [self.dataDic objectForKey:@"userRealname"];
        cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
    
    MyInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *rowArr = [titleArr objectAtIndex:indexPath.section - 1];
    cell.labelTitle.text = [rowArr objectAtIndex:indexPath.row];
    cell.labelTitle.font = [UIFont systemFontOfSize:15];
    
    cell.imageRight.image = [UIImage imageNamed:@"arrow"];
    
//    if (indexPath.section == 3) {
//        
//        if (indexPath.row == 2) {
//            
//            cell.imageRight.hidden = YES;
//            
//            [cell addSubview:switchLeft];
//        }
//        
//     }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        
//        如果没有绑定银行卡 需要跳转到绑定银行卡页面
        AddBankViewController *addBankVC = [[AddBankViewController alloc] init];
        [self.navigationController pushViewController:addBankVC animated:YES];
        
//        如果已经绑定了银行卡 跳转的是所绑定的银行卡页面
//        MyAlreadyBindingBank *already = [[MyAlreadyBindingBank alloc] init];
//        [self.navigationController pushViewController:already animated:YES];
        
    } else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            BindingPhoneViewController *bindindVC = [[BindingPhoneViewController alloc] init];
            [self.navigationController pushViewController:bindindVC animated:YES];
            
        } else if (indexPath.row == 2) {
            
            RealNameViewController *realNameVC = [[RealNameViewController alloc] init];
            [self.navigationController pushViewController:realNameVC animated:YES];
            
        } else if (indexPath.row == 1) {
            
            EmailViewController *emailVC = [[EmailViewController alloc] init];
            [self.navigationController pushViewController:emailVC animated:YES];
        }
        
    } else if (indexPath.section == 0) {
        
        butBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app.tabBarVC.view addSubview:butBlack];
        butBlack.alpha = 0.3;
        [butBlack addTarget:self action:@selector(buttonBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
        
        viewDown = [CreatView creatViewWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 180, WIDTH_CONTROLLER_DEFAULT, 160) backgroundColor:[UIColor huibai]];
        [app.tabBarVC.view addSubview:viewDown];
        
        [self viewDownShow];
        
    } else if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
            
            MendLoginViewController *mendLoginVC = [[MendLoginViewController alloc] init];
            [self.navigationController pushViewController:mendLoginVC animated:YES];
            
        } else if (indexPath.row == 1) {
            
//            如果已经设置交易密码 跳转的是修改交易密码
//            MendDealViewController *mendDeal = [[MendDealViewController alloc] init];
//            [self.navigationController pushViewController:mendDeal animated:YES];
            
//            如果没有设置交易密码 需要设置交易密码
            SetDealSecret *setDeal = [[SetDealSecret alloc] init];
            [self.navigationController pushViewController:setDeal animated:YES];
            
        }
        
    }
}

//弹出框
- (void)viewDownShow
{
    UIButton *butCamera = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"拍照"];
    [viewDown addSubview:butCamera];
    butCamera.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butCamera addTarget:self action:@selector(takeCamera:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelLine1 = [CreatView creatWithLabelFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [butCamera addSubview:labelLine1];
    labelLine1.alpha = 0.2;
    
    UIButton *butPicture = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 50, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"从手机相册选择"];
    [viewDown addSubview:butPicture];
    butPicture.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butPicture addTarget:self action:@selector(chooseFromPicture:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 110, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"取消"];
    [viewDown addSubview:butCancle];
    butCancle.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butCancle addTarget:self action:@selector(buttonCancle:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelLine2 = [CreatView creatWithLabelFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [butPicture addSubview:labelLine2];
    labelLine2.alpha = 0.3;
    
    UILabel *labelLine3 = [CreatView creatWithLabelFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [butCancle addSubview:labelLine3];
    labelLine3.alpha = 0.3;
}

//拍照
- (void)takeCamera:(UIButton *)button
{
    NSLog(@"拍照");
}

//从相册选择
- (void)chooseFromPicture:(UIButton *)button
{
    NSLog(@"从相册选择");
    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        
//        _imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//        _imagePicker.delegate = self;
//        _imagePicker.allowsEditing = YES;
//        [self presentViewController:_imagePicker animated:YES completion:nil];
//    }
//
//    [butBlack removeFromSuperview];
//    [viewDown removeFromSuperview];
//    
//    butBlack = nil;
//    viewDown = nil;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
        
        UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
        imageChange = editImage;
        [_imagePicker dismissViewControllerAnimated:YES completion:nil];
    }
}

//取消按钮
- (void)buttonCancle:(UIButton *)button
{
    [butBlack removeFromSuperview];
    [viewDown removeFromSuperview];
    
    butBlack = nil;
    viewDown = nil;
}

//黑色遮罩层消失
- (void)buttonBlackDisappear:(UIButton *)button
{
    [button removeFromSuperview];
    [viewDown removeFromSuperview];
    
    viewDown = nil;
    button = nil;
}

//手势密码开关
- (void)showSwitchGetOnOrOff:(UISwitch *)switchOn
{
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:[FileOfManage PathOfFile:@"Flag.plist"]];
    //设置属性值,没有的数据就新建，已有的数据就修改。
    [usersDic setObject:[NSString stringWithFormat:@"%@",switchOn.on?@"YES":@"NO"] forKey:@"FlagWithVC"];
    //写入文件
    [usersDic writeToFile:[FileOfManage PathOfFile:@"Flag.plist"] atomically:YES];
}

// 退出按钮的动作
- (void)buttonExit:(UIButton *)button
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
    [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC.tabScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    indexButton = app.tabBarVC.tabButtonArray[0];
    
    for (UIButton *tempButton in app.tabBarVC.tabButtonArray) {
        
        if (indexButton.tag != tempButton.tag) {
            NSLog(@"%ld",tempButton.tag);
            [tempButton setSelected:NO];
        }
    }
    
    [indexButton setSelected:YES];

    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideWithTabbar" object:nil];
    
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
    
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getData
{
    NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getUserInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        self.dataDic = [NSDictionary dictionary];
        self.dataDic = [responseObject objectForKey:@"User"];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
