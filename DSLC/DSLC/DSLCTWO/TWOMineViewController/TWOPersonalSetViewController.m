//
//  TWOPersonalSetViewController.m
//  DSLC
//
//  Created by ios on 16/5/13.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOPersonalSetViewController.h"
#import "TWOPersonalSetCell.h"
#import "TWOAddBankCardViewController.h"
#import "TWOAlreadyBankCardViewController.h"
#import "TWONoRealNameViewController.h"
#import "TWORealNameIngViewController.h"
#import "TWOPhoneNumViewController.h"
#import "TWOEmailViewController.h"
#import "TWOSafeSetViewController.h"
#import "TWOAboutDSLCViewController.h"
#import "TWOFinancialPlannerListViewController.h"
#import "TWOMyOwnerPlannerViewController.h"
#import "TWOMyClientViewController.h"
#import "TWOAddressManageViewController.h"
#import "TWOAddressAlreadySetViewController.h"
#import "TWOPersonalSetModel.h"
#import "TWORealNameH5ViewController.h"
#import "TWOProductHuiFuViewController.h"

@interface TWOPersonalSetViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    NSDictionary *userDic;
    NSMutableArray *informationArray;
    UIButton *indexButton;
    TWOPersonalSetModel *personalModel;
    
    UIButton *buttBlack;
    UIView *viewThirdOpen;
    
    // 提交表单loading
    MBProgressHUD *hud;
}

@end

@implementation TWOPersonalSetViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"账户设置"];
    informationArray = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nsnotice:) name:@"reload" object:nil];
    
    [self getDataInformation];
    [self tableViewShow];
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
}

- (void)nsnotice:(NSNotification *)notice
{
    [self getDataInformation];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"TWOPersonalSetCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 130.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    _tableView.tableFooterView.backgroundColor = [UIColor clearColor];
    
//    退出登录按钮
    UIButton *butExitLogin = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(11, _tableView.tableFooterView.frame.size.height - 40 - 15, WIDTH_CONTROLLER_DEFAULT - 22, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"退出登录"];
    [_tableView.tableFooterView addSubview:butExitLogin];
    butExitLogin.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butExitLogin.layer.cornerRadius = 5;
    butExitLogin.layer.masksToBounds = YES;
    [butExitLogin addTarget:self action:@selector(buttonExitLoginClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        butExitLogin.frame = CGRectMake(11, _tableView.tableFooterView.frame.size.height - 40 - 15 - 25, WIDTH_CONTROLLER_DEFAULT - 22, 40);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOPersonalSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *titleArray = @[@[@"银行卡", @"实名认证", @"手机号", @"邮箱绑定", @"安全设置", @"地址设置"], @[@"我的理财师", @"关于大圣理财"]];
    NSArray *titleAnArray = @[@[@"银行卡", @"实名认证", @"手机号", @"邮箱绑定", @"安全设置", @"地址设置"], @[@"我的客户", @"关于大圣理财"]];
    
//    判断是理财师还是普通用户
    if ([self.whoAreYou isEqualToString:@"1"]) {
        cell.labelTitle.text = [[titleAnArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    } else {
        cell.labelTitle.text = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    cell.imageRight.image = [UIImage imageNamed:@"righticon"];
    
    if (indexPath.section == 1) {
        
        cell.labelStates.hidden = YES;
        cell.imagePic.hidden = YES;
        
    } else {
        if (indexPath.row == 4) {
            cell.labelStates.hidden = YES;
            cell.imagePic.hidden = YES;
        } else {
            cell.labelStates.hidden = NO;
            cell.imagePic.hidden = YES;
            
            if (indexPath.row == 0) {
                
//                是否绑卡判断
                if ([[[personalModel hasBankCard] description] isEqualToString:@"2"]) {
                    cell.labelStates.text = @"已绑定";
                    cell.labelStates.textColor = [UIColor findZiTiColor];
                    cell.imagePic.hidden = NO;
                    cell.imagePic.image = [UIImage imageNamed:@"bangding"];
                } else {
                    cell.labelStates.text = @"未绑定";
                    cell.labelStates.textColor = [UIColor profitColor];
                    cell.imagePic.hidden = YES;
                }
                
            } else if (indexPath.row == 1) {
                
//                是否实名认证
                if ([[[personalModel realNameStatus] description] isEqualToString:@"2"]) {
                    cell.labelStates.text = @"已认证";
                    cell.labelStates.textColor = [UIColor findZiTiColor];
                    cell.imagePic.hidden = NO;
                    cell.imagePic.image = [UIImage imageNamed:@"renzheng"];
                } else {
                    cell.labelStates.text = @"未认证";
                    cell.labelStates.textColor = [UIColor profitColor];
                    cell.imagePic.hidden = YES;
                }
                
            } else if (indexPath.row == 2) {
                
                NSString *phoneString = [personalModel userPhone];
                cell.labelStates.text = [phoneString stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                
            } else if (indexPath.row == 3) {
                
                //是否绑定邮箱
                if ([[[personalModel emailStatus] description] isEqualToString:@"2"]) {
                    cell.labelStates.text = [personalModel userEmail];
                    cell.imageRight.hidden = YES;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                } else {
                    cell.imageRight.hidden = NO;
                    cell.labelStates.text = @"未绑定";
                    cell.labelStates.textColor = [UIColor profitColor];
                }
                
            } else if (indexPath.row == 5) {
                cell.labelStates.hidden = YES;
            }
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 9;
    } else {
        return 0.1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            if ([[[personalModel hasBankCard] description] isEqualToString:@"2"]) {
//            已经绑卡页面
                TWOAlreadyBankCardViewController *alreadyBankCard = [[TWOAlreadyBankCardViewController alloc] init];
                [self.navigationController pushViewController:alreadyBankCard animated:YES];
            } else {
//            添加银行卡页面
                TWOAddBankCardViewController *addBankCardVC = [[TWOAddBankCardViewController alloc] init];
                [self.navigationController pushViewController:addBankCardVC animated:YES];
            }
            
        } else if (indexPath.row == 1) {
            
            if ([[[personalModel realNameStatus] description] isEqualToString:@"2"]) {
                //已经实名认证页面
                TWORealNameIngViewController *realNameIng = [[TWORealNameIngViewController alloc] init];
                realNameIng.name = [DES3Util decrypt:[personalModel userRealname]];
                realNameIng.cardNumber = [personalModel cardNumber];
                [self.navigationController pushViewController:realNameIng animated:YES];
            } else {
                //未实名认证页面
//                TWORealNameH5ViewController *noRealNameVC = [[TWORealNameH5ViewController alloc] init];
//                [self.navigationController pushViewController:noRealNameVC animated:YES];
                if ([[self.flagDic objectForKey:@"chinaPnrAcc"] isEqualToString:@""]) {
                    
                    [self registThirdShow];
                    return;
                }
                
            }
            
        } else if (indexPath.row == 2) {
//            手机号
            TWOPhoneNumViewController *phoneNumVC = [[TWOPhoneNumViewController alloc] init];
            phoneNumVC.phoneNum = [personalModel userPhone];
            [self.navigationController pushViewController:phoneNumVC animated:YES];
            
        } else if (indexPath.row == 3) {
            
//            邮箱绑定
            if ([[[personalModel emailStatus] description] isEqualToString:@"2"]) {
                
            } else {
                TWOEmailViewController *emailVC = [[TWOEmailViewController alloc] init];
                [self.navigationController pushViewController:emailVC animated:YES];
            }
            
        } else if (indexPath.row == 4) {
            
//            安全设置
            TWOSafeSetViewController *safeSetVC = [[TWOSafeSetViewController alloc] init];
            safeSetVC.setPassWord = [[personalModel isSetPwd] description];
//            传手机号 如果没有设置登录密码 设置登录密码需要显示手机号
            safeSetVC.phoneString = [personalModel userPhone];
            [self.navigationController pushViewController:safeSetVC animated:YES];
            
        } else {
            
            if ([[personalModel address] isEqualToString:@""]) {
//            地址设置
                TWOAddressManageViewController *addressManager = [[TWOAddressManageViewController alloc] init];
                pushVC(addressManager);
            } else {
//            已设置页面
                TWOAddressAlreadySetViewController *addAlreadySet = [[TWOAddressAlreadySetViewController alloc] init];
                addAlreadySet.addressString = [personalModel address];
                pushVC(addAlreadySet);
            }
        }
    } else {
        if (indexPath.row == 0) {
            
//            判断是1理财师身份 0为普通用户
            if ([self.whoAreYou isEqualToString:@"1"]) {
                //我的客户列表
                TWOMyClientViewController *myClientVC = [[TWOMyClientViewController alloc] init];
                pushVC(myClientVC);
            } else {
                //状态为0表示没有申请理财师,为1有申请理财师
                if ([[[personalModel myFinPlanner] description] isEqualToString:@"1"]) {
                    //我的理财师
                    TWOMyOwnerPlannerViewController *myOwnerPlanner = [[TWOMyOwnerPlannerViewController alloc] init];
                    myOwnerPlanner.stateShow = YES;
                    pushVC(myOwnerPlanner);
                } else {
                    //理财师列表页
                    TWOFinancialPlannerListViewController *financialPlannerVC = [[TWOFinancialPlannerListViewController alloc] init];
                    pushVC(financialPlannerVC);
                }
            }
            
        } else {
//            关于大圣理财
            TWOAboutDSLCViewController *aboutDSLC = [[TWOAboutDSLCViewController alloc] init];
            [self.navigationController pushViewController:aboutDSLC animated:YES];
        }
    }
}

//退出登录按钮方法
- (void)buttonExitLoginClicked:(UIButton *)button
{
    [self logoutFuction];
}

#pragma mark 对接退出接口
#pragma mark --------------------------------

- (void)logoutFuction{
    NSDictionary *parmeter = @{@"userId":[self.flagDic objectForKey:@"phone"]};
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    hud = [MBProgressHUD showHUDAddedTo:app.window animated:YES];
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"logout" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"register = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:@200]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            
            [hud hide:YES];
            
            if (![FileOfManage ExistOfFile:@"Member.plist"]) {
                [FileOfManage createWithFile:@"Member.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"1",@"password",
                                     @"1",@"phone",
                                     @"",@"key",
                                     @"",@"id",
                                     @"",@"userNickname",
                                     @"",@"avatarImg",
                                     @"",@"userAccount",
                                     @"",@"userPhone",
                                     @"",@"accBalance",
                                     @"",@"realnameStatus",
                                     @"",@"realName",
                                     @"",@"chinaPnrAcc",
                                     @"",@"token",
                                     @"",@"registerTime",
                                     @"",@"newHand",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"1",@"password",
                                     @"1",@"phone",
                                     @"",@"key",
                                     @"",@"id",
                                     @"",@"userNickname",
                                     @"",@"avatarImg",
                                     @"",@"userAccount",
                                     @"",@"userPhone",
                                     @"",@"accBalance",
                                     @"",@"realnameStatus",
                                     @"",@"realName",
                                     @"",@"chinaPnrAcc",
                                     @"",@"token",
                                     @"",@"registerTime",
                                     @"",@"newHand",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
                NSLog(@"%@",[responseObject objectForKey:@"token"]);
            }
            
            NSLog(@"phoneUser = %@",[self.flagDic objectForKey:@"phone"]);
            
            // 判断是否存在isLogin.plist文件
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }

            
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app.tabBarVC.tabScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            
            [app.tabBarVC setSuppurtGestureTransition:NO];
            [app.tabBarVC setTabbarViewHidden:NO];
            [app.tabBarVC setLabelLineHidden:NO];
            
            indexButton = app.tabBarVC.tabButtonArray[0];
            
            for (UIButton *tempButton in app.tabBarVC.tabButtonArray) {
                
                if (indexButton.tag != tempButton.tag) {
                    NSLog(@"%ld",(long)tempButton.tag);
                    [tempButton setSelected:NO];
                }
            }
            
            [indexButton setSelected:YES];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            // 刷新产品列表
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToProductList" object:nil];
            // 刷新固收页面数据
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BillVC" object:nil];
            // 刷新首页三个产品
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getSelectionVC" object:nil];
            
        } else {
            [ProgressHUD showMessage:[responseObject objectForKey:@"resultMsg"] Width:100 High:20];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        _tableView.scrollEnabled = NO;
    } else {
        _tableView.scrollEnabled = YES;
    }
}

- (void)getDataInformation
{
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/getUserInfo" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"账户设置>>>>>>>>>%@", responseObject);
        [self loadingWithHidden:YES];
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            userDic = [responseObject objectForKey:@"User"];
            personalModel = [[TWOPersonalSetModel alloc] init];
            [personalModel setValuesForKeysWithDictionary:userDic];
            [_tableView reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"账户设置>>>>>>>>>%@", error);
    }];
}

//开通托管账户弹框
- (void)registThirdShow
{
    AppDelegate *app  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    buttBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [app.tabBarVC.view addSubview:buttBlack];
    buttBlack.alpha = 0.5;
    [buttBlack addTarget:self action:@selector(buttonViewDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    viewThirdOpen = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 310/2, HEIGHT_CONTROLLER_DEFAULT/3, 310, 228) backgroundColor:[UIColor whiteColor]];
    [app.tabBarVC.view addSubview:viewThirdOpen];
    viewThirdOpen.layer.cornerRadius = 4;
    viewThirdOpen.layer.masksToBounds = YES;
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 0, viewThirdOpen.frame.size.width, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:@"您还未开通托管账户"];
    [viewThirdOpen addSubview:labelAlert];
    
    UIImageView *imageImg = [CreatView creatImageViewWithFrame:CGRectMake(viewThirdOpen.frame.size.width/2 - 314/2/2, 45, 314/2, 234/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"thirdimg"]];
    [viewThirdOpen addSubview:imageImg];
    
    UIButton *buttonok = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(12, 45 + imageImg.frame.size.height + 15, viewThirdOpen.frame.size.width - 24, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"去开户"];
    [viewThirdOpen addSubview:buttonok];
    buttonok.layer.cornerRadius = 4;
    buttonok.layer.masksToBounds = YES;
    buttonok.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonok addTarget:self action:@selector(buttonOpenThirdOK:) forControlEvents:UIControlEventTouchUpInside];
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [viewThirdOpen.layer addAnimation:animation forKey:nil];
}

//开通三方确定按钮
- (void)buttonOpenThirdOK:(UIButton *)button
{
    [buttBlack removeFromSuperview];
    [viewThirdOpen removeFromSuperview];
    
    buttBlack = nil;
    viewThirdOpen = nil;
    
    TWOProductHuiFuViewController *productHuiFuVC = [[TWOProductHuiFuViewController alloc] init];
    productHuiFuVC.fuctionName = @"userReg";
    pushVC(productHuiFuVC);
    
}

//开通三方弹框点击消失
- (void)buttonViewDisappear:(UIButton *)button
{
    [buttBlack removeFromSuperview];
    [viewThirdOpen removeFromSuperview];
    
    buttBlack = nil;
    viewThirdOpen = nil;
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
