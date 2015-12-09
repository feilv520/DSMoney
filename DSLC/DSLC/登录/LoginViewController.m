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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideWithTabbarView:) name:@"hideWithTabbarView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beforeWithViewhideWithTabbarView:) name:@"beforeWithView" object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addWithNotifiacationCenter:) name:@"hideWithTabbar" object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideWithTabbarView" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"beforeWithView" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideWithTabbar" object:nil];
}

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [self.view endEditing:YES];
    [app.tabBarVC.tabScrollView setContentOffset:CGPointMake(indexButton.tag * WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
    
    for (UIButton *tempButton in app.tabBarVC.tabButtonArray) {
        
        if (indexButton.tag != tempButton.tag) {
            NSLog(@"%ld",(long)tempButton.tag);
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
//        cell.textField.text = @"123456";
        cell.textField.secureTextEntry = YES;
        cell.textField.keyboardType = UIKeyboardTypeDefault;
    } else {
//        cell.textField.text = @"15955454591";
    }
    
    [cell.textField addTarget:self action:@selector(editContent:) forControlEvents:UIControlEventEditingChanged];
    
    cell.imageLeft.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [ImageArr objectAtIndex:indexPath.row]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1000) {
        
        if (range.location < 11) {
            
            return YES;
            
        } else {
            
            return NO;
        }
        
    } else {
        
        if (range.location < 12) {
            
            return YES;
            
        } else {
            
            return NO;
        }
    }
}

- (void)editContent:(UITextField *)textField
{
    textField1 = (UITextField *)[self.view viewWithTag:1000];
    textField2 = (UITextField *)[self.view viewWithTag:1001];
    
    if (textField1.text.length == 0) {
        
//        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入..."];
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (textField1.text.length != 11) {
        
//        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (textField2.text.length < 6) {
        
//        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"登录密码错误"];
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    }
    
}

// 登录按钮执行方法
- (void)loginButton:(id)sender
{
    [self.view endEditing:YES];
    textField1 = (UITextField *)[self.view viewWithTag:1000];
    textField2 = (UITextField *)[self.view viewWithTag:1001];
    
    if (textField1.text.length == 11 && (textField2.text.length >= 6 && textField2.text.length <= 12)) {
        if (![NSString validatePassword:textField2.text]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"首字母开头"];
        } else if ([NSString validateMobile:textField1.text]) {
            NSDictionary *parameter = @{@"phone":textField1.text,@"password":textField2.text};
            [[MyAfHTTPClient sharedClient] postWithURLString:@"app/login" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
                
                if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                    // 判断是否存在Member.plist文件
                    [MobClick profileSignInWithPUID:[[responseObject objectForKey:@"User"] objectForKey:@"id"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToPickProduct" object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToProductList" object:nil];
                    if (![FileOfManage ExistOfFile:@"Member.plist"]) {
                        [FileOfManage createWithFile:@"Member.plist"];
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [DES3Util encrypt:textField2.text],@"password",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                             [responseObject objectForKey:@"token"],@"token",nil];
                        [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                    } else {
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [DES3Util encrypt:textField2.text],@"password",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"id"],@"id",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userNickname"],@"userNickname",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"avatarImg"],@"avatarImg",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userAccount"],@"userAccount",
                                             [[responseObject objectForKey:@"User"] objectForKey:@"userPhone"],@"userPhone",
                                             [responseObject objectForKey:@"token"],@"token",nil];
                        [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                        NSLog(@"%@",[responseObject objectForKey:@"token"]);
                    }
                    // 判断是否存在isLogin.plist文件
                    if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                        [FileOfManage createWithFile:@"isLogin.plist"];
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
                        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
                    } else {
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",@"loginFlag",nil];
                        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
                    }
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
                    MineViewController *mineVC = [[MineViewController alloc] init];
                    [self.navigationController pushViewController:mineVC animated:NO];
                    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideWithTabbarView" object:nil];
                    
                    textField1.text = @"";
                    textField2.text = @"";
                    
                } else {
                    
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
        } else {
            [ProgressHUD showMessage:@"手机号格式错误" Width:100 High:20];
        }
        
    } else if(textField1.text.length == 0) {
        
        [ProgressHUD showMessage:@"请输入手机号" Width:100 High:20];
        
    } else if(textField1.text.length < 11) {
        
        [ProgressHUD showMessage:@"手机号格式错误" Width:100 High:20];
        
    } else if (textField2.text.length == 0) {
        
        [ProgressHUD showMessage:@"请输入密码" Width:100 High:20];
        
    } else if (textField2.text.length < 6) {
        
        [ProgressHUD showMessage:@"6~20位字符，至少包含字母和数字两种" Width:100 High:20];
        
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
    
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
//    
//    NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"]};
//    
//    NSLog(@"%@",parameter);
//    
//    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getMyAccountInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
//        
//        NSLog(@"autoLogin = %@",responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"%@", error);
//        
//    }];

    
    NSLog(@"password = %@",[DES3Util decrypt:[self.flagUserInfo objectForKey:@"password"]]);
    
    NSDictionary *parameter = @{@"phone":[DES3Util decrypt:[self.flagUserInfo objectForKey:@"userPhone"]],@"password":[DES3Util decrypt:[self.flagUserInfo objectForKey:@"password"]]};
    NSLog(@"loginParameter = %@",parameter);
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/login" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self.view endEditing:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {

            [MobClick profileSignInWithPUID:[[responseObject objectForKey:@"User"] objectForKey:@"id"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToPickProduct" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToProductList" object:nil];
            NSLog(@"AutoLogin = %@",responseObject);
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [DES3Util encrypt:[self.flagUserInfo objectForKey:@"password"]],@"password",
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
