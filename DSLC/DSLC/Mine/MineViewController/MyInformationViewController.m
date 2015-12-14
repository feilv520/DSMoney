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
    
    UILabel *labelBingPhone;
    UILabel *labelBingEmail;
    UILabel *labelBingRealName;
}

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic) UIImagePickerController *imagePicker;

@property (nonatomic, strong) NSDictionary *flagLogin;

@property (nonatomic, strong) UIImageView *imageView;
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
                cell.labelPan.text = [DES3Util decrypt:[self.dataDic objectForKey:@"userAccount"]];
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
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
    [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
    
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
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]] || responseObject == nil) {
            NSLog(@"134897189374987342987243789423");
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
        
        [_tableView reloadData];
        
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
