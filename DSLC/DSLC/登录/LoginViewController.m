//
//  LoginViewController.m
//  DSLC
//
//  Created by ios on 15/10/27.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginCell.h"
#import "MineViewController.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "CreatView.h"
#import "RegisterViewController.h"
#import "ForgetSecretViewController.h"
#import "SelectionViewController.h"

@interface LoginViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
    NSArray *ImageArr;
    NSArray *placeholderArr;
    UIButton *butLogin;
    UITextField *textField1;
    UITextField *textField2;
    
    UIButton *indexButton;
    AppDelegate *app;
    
    NSString *flagString;
}

@property (nonatomic, strong) NSDictionary *flagLogin;
@property (nonatomic, strong) NSDictionary *flagUserInfo;

@end

@implementation LoginViewController

// 用户信息文件
- (NSDictionary *)flagUserInfo{
    if (_flagUserInfo == nil) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
        self.flagUserInfo = dic;
    }
    return _flagUserInfo;
}

- (NSDictionary *)flagLogin{
    if (_flagLogin == nil) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
        self.flagLogin = dic;
    }
    return _flagLogin;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (![flagString isEqualToString:@"MCM"]) {
        app = [[UIApplication sharedApplication] delegate];
        [app.tabBarVC setSuppurtGestureTransition:NO];
        [app.tabBarVC setTabbarViewHidden:NO];
        [app.tabBarVC setLabelLineHidden:NO];
    }
    
}

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [app.tabBarVC.tabScrollView setContentOffset:CGPointMake(indexButton.tag * WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
    
    for (UIButton *tempButton in app.tabBarVC.tabButtonArray) {
        
        if (indexButton.tag != tempButton.tag) {
            NSLog(@"%ld",tempButton.tag);
            [tempButton setSelected:NO];
        }
    }
    
    [indexButton setSelected:YES];
    
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[self.flagLogin objectForKey:@"loginFlag"] isEqualToString:@"YES"]) {
        [self autoLogin];
    }
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self tableviewShow];
    [self navigationControllerShow];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideWithTabbarView:) name:@"hideWithTabbarView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beforeWithViewhideWithTabbarView:) name:@"beforeWithView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addWithNotifiacationCenter:) name:@"hideWithTabbar" object:nil];
    
}

- (void)beforeWithViewhideWithTabbarView:(NSNotification *)not{
    
    flagString = [not object];
    
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}

- (void)addWithNotifiacationCenter:(NSNotification *)not{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideWithTabbarView:) name:@"hideWithTabbarView" object:nil];
}

- (void)hideWithTabbarView:(NSNotification *)not{
    
    indexButton = [not object];
    
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}

- (void)navigationControllerShow
{
    [self.navigationItem setTitle:@"登录大圣理财"];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//    注册按钮修改颜色 大小
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItem:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
}

//注册按钮点击事件
- (void)leftBarButtonItem:(UIBarButtonItem *)bar
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)tableviewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"LoginCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    titleArr = @[@"手机号", @"密码"];
    ImageArr = @[@"iconfont-phone", @"iconfont-mima"];
    placeholderArr = @[@"请输入手机号", @"请输入密码"];
    
    [self bottomContent];
}

- (void)bottomContent
{
    UIButton *butForget = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 67, 105, 60, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor chongzhiColor] titleText:@"忘记密码?"];
    [self.view addSubview:butForget];
    butForget.titleLabel.font = [UIFont systemFontOfSize:12];
    [butForget addTarget:self action:@selector(forgetSecretButton:) forControlEvents:UIControlEventTouchUpInside];
    
    butLogin = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 160, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor qianhuise] textColor:[UIColor whiteColor] titleText:@"登录"];
    [self.view addSubview:butLogin];
    [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butLogin addTarget:self action:@selector(loginButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[LoginCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    cell.labelPhoneNum.text = [titleArr objectAtIndex:indexPath.row];
    cell.labelPhoneNum.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.textField.placeholder = [placeholderArr objectAtIndex:indexPath.row];
    cell.textField.font = [UIFont fontWithName:@"placeholder" size:14];
    cell.textField.tintColor = [UIColor grayColor];
    cell.textField.delegate = self;
    cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    cell.textField.tag = 1000 + indexPath.row;
    cell.textField.textColor = [UIColor zitihui];
    
    if (indexPath.row == 1) {
        cell.textField.secureTextEntry = YES;
    }
    
    [cell.textField addTarget:self action:@selector(editContent:) forControlEvents:UIControlEventEditingChanged];
    
    cell.imageLeft.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [ImageArr objectAtIndex:indexPath.row]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1000) {
        
        if (range.location == 11) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else {
        
        if (range.location == 3) {
            
            return NO;
            
        } else {
            
            return YES;
        }
    }
}

- (void)editContent:(UITextField *)textField
{
    textField1 = (UITextField *)[self.view viewWithTag:1000];
    textField2 = (UITextField *)[self.view viewWithTag:1001];
    
    if (textField1.text.length == 11 && textField2.text.length == 3) {
        
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

// 登录按钮执行方法
- (void)loginButton:(id)sender
{
    [self.view endEditing:YES];
    textField1 = (UITextField *)[self.view viewWithTag:1000];
    textField2 = (UITextField *)[self.view viewWithTag:1001];
    
    if (textField1.text.length == 11 && textField2.text.length == 3) {
        
//        NSDictionary *parameter = @{@"phone":@"15955454588",@"password":@"123"};
        NSDictionary *parameter = @{@"phone":textField1.text,@"password":textField2.text};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/login" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                // 判断是否存在Member.plist文件
                if (![FileOfManage ExistOfFile:@"Member.plist"]) {
                    [FileOfManage createWithFile:@"Member.plist"];
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                         textField2.text,@"password",
                                         [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                         [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                         [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                         [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                         [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                         [responseObject objectForKey:@"token"],@"token",nil];
                    [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                } else {
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                         textField2.text,@"password",
                                         [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                         [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                         [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                         [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                         [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                         [responseObject objectForKey:@"token"],@"token",nil];
                    [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                }
                // 判断是否存在isLogin.plist文件
                if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                    [FileOfManage createWithFile:@"isLogin.plist"];
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                    [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
                } else {
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
                    [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
                }
                [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
                MineViewController *mineVC = [[MineViewController alloc] init];
                [self.navigationController pushViewController:mineVC animated:NO];
                [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideWithTabbarView" object:nil];
                
                textField1.text = @"";
                textField2.text = @"";
                
            } else {
                [ProgressHUD showMessage:@"手机号或密码错误" Width:100 High:20];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
    } else {
        
        
    }
    
}

//忘记密码
- (void)forgetSecretButton:(UIButton *)button
{
    ForgetSecretViewController *forgetSecretVC = [[ForgetSecretViewController alloc] init];
    forgetSecretVC.typeString = @"login";
    [self.navigationController pushViewController:forgetSecretVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

// 自动登录方法
- (void)autoLogin{
    NSDictionary *parameter = @{@"phone":[self.flagUserInfo objectForKey:@"userPhone"],@"password":[self.flagUserInfo objectForKey:@"password"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/login" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self.view endEditing:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {

            NSLog(@"AutoLogin = %@",responseObject);
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [self.flagUserInfo objectForKey:@"password"],@"password",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                 [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                 [responseObject objectForKey:@"token"],@"token",nil];
            [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            
            MineViewController *mineVC = [[MineViewController alloc] init];
            [self.navigationController pushViewController:mineVC animated:NO];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideWithTabbarView" object:nil];
        
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
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
