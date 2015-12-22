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
#import "BankName.h"

@interface MyInformationViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
    UISwitch *switchLeft;
    NSString *path;
    UIButton *butBlack;
    UIView *viewDown;
    BankName *bank;
    
    UIImage *imageChange;
    
    UIButton *indexButton;
    
    UILabel *labelBingPhone;
    UILabel *labelBingEmail;
    UILabel *labelBingRealName;
    
    UILabel *labelPhone;
    NSMutableArray *bankArray;
}

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic) UIImagePickerController *imagePicker;

@property (nonatomic, strong) NSDictionary *flagLogin;

@property (nonatomic, strong) UIImageView *imageView;
//@property (nonatomic, strong) NSDictionary *flagDic;
@property (nonatomic) LLPaySdk *sdk;
@property (nonatomic) NSMutableDictionary *orderDic;

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
    
    self.orderDic = [self createOrder];
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"我的资料"];
    
    [self tableViewShow];
    [self getData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:@"reload" object:nil];
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 130)];
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
        
        if ([[self.dataDic objectForKey:@"avatarImg"] isEqualToString:@""]) {
            cell.imageHeadPic.image = [UIImage imageNamed:@"默认头像"];
        } else {
            cell.imageHeadPic.yy_imageURL = [self.dataDic objectForKey:@"avatarImg"];
        }
        cell.imageHeadPic.tag = 9908;
        cell.imageHeadPic.layer.masksToBounds = YES;
        cell.imageHeadPic.layer.cornerRadius = 20.0f;
        
        cell.imageRight.image = [UIImage imageNamed:@"arrow"];
        
        cell.labelName.text = [DES3Util decrypt:[self.dataDic objectForKey:@"userRealname"]];
        cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
    
        MyInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        cell.labelPan.hidden = YES;
        
        NSArray *rowArr = [titleArr objectAtIndex:indexPath.section - 1];
        cell.labelTitle.text = [rowArr objectAtIndex:indexPath.row];
        cell.labelTitle.font = [UIFont systemFontOfSize:15];
        
        cell.imageRight.image = [UIImage imageNamed:@"arrow"];
        
        if (indexPath.section == 2) {
            
            cell.labelPan.hidden = NO;
            cell.labelPan.font = [UIFont fontWithName:@"CenturyGothic" size:12];
            cell.labelPan.textColor = [UIColor chongzhiColor];
            cell.labelPan.tag = indexPath.row + 900;
            
            if (indexPath.row == 1) {
                cell.labelPan.text = @"未绑定";
                
                if ([[[self.dataDic objectForKey:@"emailStatus"] description] isEqualToString:@"2"]) {
                    NSLog(@"是否有绑定:%@", [self.dataDic objectForKey:@"emailStatus"]);
                    cell.labelPan.text = @"已绑定";
                }
                
            } else if (indexPath.row == 2) {
                cell.labelPan.text = @"未认证";
                
                NSString *shifou = [self.dataDic objectForKey:@"realNameStatus"];
                NSLog(@"是否有实名认证:%@", shifou);
                
                if ([[shifou description] isEqualToString:@"2"]) {
                    
                    cell.labelPan.text = @"已认证";
                }
                
            } else {
                
                cell.labelPan.tag = 1388;
                
            }
        }
    
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
        
        if ([[[self.dataDic objectForKey:@"realNameStatus"] description] isEqualToString:@"2"]) {
            
            NSMutableArray *bankArr = [self.dataDic objectForKey:@"BankCard"];
            if (bankArr.count != 0) {
                
                [self bankCardData];
                //如果已经绑定了银行卡 跳转的是所绑定的银行卡页面
                MyAlreadyBindingBank *already = [[MyAlreadyBindingBank alloc] init];
                already.bankName = bank;
                [self.navigationController pushViewController:already animated:YES];
                
            } else {
                
                //如果没有绑定银行卡 需要跳转到绑定银行卡页面
                AddBankViewController *addBankVC = [[AddBankViewController alloc] init];
                addBankVC.realNameStatus = YES;
                [self.navigationController pushViewController:addBankVC animated:YES];
                
            }
            
        } else {
            
                            
            RealNameViewController *realName = [[RealNameViewController alloc] init];
            realName.realNamePan = NO;
            [self.navigationController pushViewController:realName animated:YES];
                
            
        }
        
    } else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            BindingPhoneViewController *bindindVC = [[BindingPhoneViewController alloc] init];
            [self.navigationController pushViewController:bindindVC animated:YES];
            
        } else if (indexPath.row == 2) {
            
            if ([[[self.dataDic objectForKey:@"realNameStatus"] description] isEqualToString:@"2"]) {
                [self showTanKuangWithMode:MBProgressHUDModeText Text:@"已认证"];
                
            } else {
                
                RealNameViewController *realNameVC = [[RealNameViewController alloc] init];
                realNameVC.realNamePan = YES;
                [self.navigationController pushViewController:realNameVC animated:YES];
            }
            
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
            
            NSString *design = [[self.dataDic objectForKey:@"setPayPwd"] description];
            NSLog(@"设置没有:%@", design);
            
            if ([design isEqualToString:@"1"]) {
                
                MendDealViewController *mendDeal = [[MendDealViewController alloc] init];
                [self.navigationController pushViewController:mendDeal animated:YES];
                
            } else {
                
                SetDealSecret *setDeal = [[SetDealSecret alloc] init];
                [self.navigationController pushViewController:setDeal animated:YES];

            }
        }
    }
}

//银行卡数据
- (void)bankCardData
{
    NSDictionary *temoDic = [self.dataDic objectForKey:@"BankCard"];
    bank = [[BankName alloc] init];
    [bank setValuesForKeysWithDictionary:temoDic];
    
}

- (void)reloadData:(NSNotification *)notice
{
    [self getData];
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
    
    [butBlack removeFromSuperview];
    [viewDown removeFromSuperview];
    
    butBlack = nil;
    viewDown = nil;
    
    NSLog(@"拍照");
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
//        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
//            sourceType = UIImagePickerControllerSourceTypeCamera;
//        }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
}

//从相册选择
- (void)chooseFromPicture:(UIButton *)button
{
    [butBlack removeFromSuperview];
    [viewDown removeFromSuperview];
    
    butBlack = nil;
    viewDown = nil;
    
    NSLog(@"从相册选择");
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    }
    
    pickerImage.delegate = self;

    pickerImage.navigationBar.barTintColor = [UIColor colorWithRed:223.0/255 green:74.0/255 blue:67.0/255 alpha:1];
    
    pickerImage.allowsEditing = NO;
    [self presentViewController:pickerImage animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imageView = (UIImageView *)[self.view viewWithTag:9908];
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地，方法见下文
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    [self.imageView setImage:savedImage];
    
    [[MyAfHTTPClient sharedClient] uploadFile:savedImage];
}

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
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
    
    [self logout];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
    [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToPickProduct" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refrushToProductList" object:nil];
    
    NSMutableDictionary *usersDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    //设置属性值,没有的数据就新建，已有的数据就修改。
    [usersDic setObject:@"mcm" forKey:@"token"];
    
    [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:nil];
    
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getData
{
    NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getUserInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"asasasasasa%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]] || responseObject == nil) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
            [self.navigationController popToRootViewControllerAnimated:NO];
            return ;
        }
        NSLog(@"%@",responseObject);
        
        self.dataDic = [NSDictionary dictionary];
        self.dataDic = [responseObject objectForKey:@"User"];
        
        labelPhone = (UILabel *)[self.view viewWithTag:1388];
        NSString *phoneStr = [DES3Util decrypt:[self.dataDic objectForKey:@"userAccount"]];
        labelPhone.text = [phoneStr stringByReplacingCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)logout
{
    NSDictionary *parameter = @{@"userId":[self.flagDic objectForKey:@"id"]};
    
    NSLog(@"%@",parameter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/logout" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"asasasasasa%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"已退出"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

#pragma mark 连连支付按钮
#pragma mark --------------------------------

#pragma mark - 订单支付
- (void)pay:(id)sender{
    
    LLPayUtil *payUtil = [[LLPayUtil alloc] init];
    
    // 进行签名
    NSDictionary *signedOrder = [payUtil signedOrderDic:self.orderDic
                                             andSignKey:kLLPartnerKey];
    
    
    //    [LLPaySdk sharedSdk].sdkDelegate = self;
    
    // TODO: 根据需要使用特定支付方式
    
    // 快捷支付
    //        [[LLPaySdk sharedSdk] presentQuickPaySdkInViewController:self withTraderInfo:signedOrder];
    
    // 认证支付
    //    [[LLPaySdk sharedSdk] presentVerifyPaySdkInViewController:self withTraderInfo:signedOrder];
    
    // 预授权
    //  [self.sdk presentPreAuthPaySdkInViewController:self withTraderInfo:signedOrder];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    self.sdk = [[LLPaySdk alloc] init];
    self.sdk.sdkDelegate = self;
    [self.sdk presentVerifyPaySdkInViewController:app.tabBarVC withTraderInfo:signedOrder];
    
}

#pragma -mark 支付结果 LLPaySdkDelegate
// 订单支付结果返回，主要是异常和成功的不同状态
// TODO: 开发人员需要根据实际业务调整逻辑
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic
{
    NSString *msg = @"支付异常";
    switch (resultCode) {
        case kLLPayResultSuccess:
        {
            msg = @"支付成功";
            
            NSString* result_pay = dic[@"result_pay"];
            if ([result_pay isEqualToString:@"SUCCESS"])
            {
                //
                //NSString *payBackAgreeNo = dic[@"agreementno"];
                // TODO: 协议号
                //[self.navigationController popToRootViewControllerAnimated:YES];
            }
            else if ([result_pay isEqualToString:@"PROCESSING"])
            {
                msg = @"支付单处理中";
            }
            else if ([result_pay isEqualToString:@"FAILURE"])
            {
                msg = @"支付单失败";
            }
            else if ([result_pay isEqualToString:@"REFUND"])
            {
                msg = @"支付单已退款";
            }
        }
            break;
        case kLLPayResultFail:
        {
            msg = @"支付失败";
        }
            break;
        case kLLPayResultCancel:
        {
            msg = @"支付取消";
        }
            break;
        case kLLPayResultInitError:
        {
            msg = @"sdk初始化异常";
        }
            break;
        case kLLPayResultInitParamError:
        {
            msg = dic[@"ret_msg"];
        }
            break;
        default:
            break;
    }
    
    NSString *showMsg = [msg stringByAppendingString:[LLPayUtil jsonStringOfObj:dic]];
    
    [[[UIAlertView alloc] initWithTitle:@"结果"
                                message:showMsg
                               delegate:nil
                      cancelButtonTitle:@"确认"
                      otherButtonTitles:nil] show];
}

- (NSMutableDictionary *)createOrder{
    
    NSString *partnerPrefix = @"GCCT"; // TODO: 修改成自己公司前缀
    
    NSString *signType = @"MD5";    // MD5 || RSA || HMAC
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSString *user_id = [NSString stringWithFormat:@"gcctdslcandroid%@",[dic objectForKey:@"id"]]; //
    // user_id，一个user_id标示一个用户
    // user_id为必传项，需要关联商户里的用户编号，一个user_id下的所有支付银行卡，身份证必须相同
    // demo中需要开发测试自己填入user_id, 可以先用自己的手机号作为标示，正式上线请使用商户内的用户编号
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *simOrder = [dateFormater stringFromDate:[NSDate date]];
    
    // TODO: 请开发人员修改下面订单的所有信息，以匹配实际需求
    // TODO: 请开发人员修改下面订单的所有信息，以匹配实际需求
    [param setDictionary:@{
                           @"sign_type":signType,
                           //签名方式	partner_sign_type	是	String	RSA  或者 MD5
                           @"busi_partner":@"101001",
                           //商户业务类型	busi_partner	是	String(6)	虚拟商品销售：101001
                           @"dt_order":simOrder,
                           //商户订单时间	dt_order	是	String(14)	格式：YYYYMMDDH24MISS  14位数字，精确到秒
                           //                           @"money_order":@"0.10",
                           //交易金额	money_order	是	Number(8,2)	该笔订单的资金总额，单位为RMB-元。大于0的数字，精确到小数点后两位。 如：49.65
                           @"money_order" : @"0.01",
                           
                           @"no_order":[NSString stringWithFormat:@"%@%@",partnerPrefix,  simOrder],
                           //商户唯一订单号	no_order	是	String(32)	商户系统唯一订单号
                           @"name_goods":@"订单名",
                           //商品名称	name_goods	否	String(40)
                           @"info_order":simOrder,
                           //订单附加信息	info_order	否	String(255)	商户订单的备注信息
                           @"valid_order":@"10080",
                           //分钟为单位，默认为10080分钟（7天），从创建时间开始，过了此订单有效时间此笔订单就会被设置为失败状态不能再重新进行支付。
                           //                           @"shareing_data":@"201412030000035903^101001^10^分账说明1|201310102000003524^101001^11^分账说明2|201307232000003510^109001^12^分账说明3"
                           // 分账信息数据 shareing_data  否 变(1024)
                           
                           @"notify_url":@"http://www.baidu.com",
                           //服务器异步通知地址	notify_url	是	String(64)	连连钱包支付平台在用户支付成功后通知商户服务端的地址，如：http://payhttp.xiaofubao.com/back.shtml
                           
                           
                           //                           @"risk_item":@"{\"user_info_bind_phone\":\"13958069593\",\"user_info_dt_register\":\"20131030122130\"}",
                           //风险控制参数 否 此字段填写风控参数，采用json串的模式传入，字段名和字段内容彼此对应好
                           @"risk_item" : [LLPayUtil jsonStringOfObj:@{@"user_info_dt_register":@"20131030122130"}],
                           
                           @"user_id": user_id,
                           //商户用户唯一编号 否 该用户在商户系统中的唯一编号，要求是该编号在商户系统中唯一标识该用户
                           
                           
                           //                           @"flag_modify":@"1",
                           //修改标记 flag_modify 否 String 0-可以修改，默认为0, 1-不允许修改 与id_type,id_no,acct_name配合使用，如果该用户在商户系统已经实名认证过了，则在绑定银行卡的输入信息不能修改，否则可以修改
                           
                           //                           @"card_no":@"6227000783011133646",
                           //银行卡号 card_no 否 银行卡号前置，卡号可以在商户的页面输入
                           
                           //                           @"no_agree":@"2014070900123076",
                           //签约协议号 否 String(16) 已经记录快捷银行卡的用户，商户在调用的时候可以与pay_type一块配合使用
                           }];
    
    BOOL isIsVerifyPay = YES;
    
    if (isIsVerifyPay) {
        
        [param addEntriesFromDictionary:@{
                                          
                                          @"id_no":[dic objectForKey:@"cardNumber"],
                                          //证件号码 id_no 否 String
                                          @"acct_name":[dic objectForKey:@"realName"],
                                          //银行账号姓名 acct_name 否 String
                                          
                                          //                                          @"id_no":@"140621199212052213",
                                          //                                          //证件号码 id_no 否 String
                                          //                                          @"acct_name":@"杨磊磊",
                                          //                                          //银行账号姓名 acct_name 否 String
                                          }];
        NSLog(@"======身份证号:%@", [dic objectForKey:@"cardNumber"]);
    }
    
    
    
    
    param[@"oid_partner"] = kLLOidPartner;
    
    
    return param;
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
