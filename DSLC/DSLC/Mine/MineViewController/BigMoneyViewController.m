//
//  BigMoneyViewController.m
//  DSLC
//
//  Created by ios on 15/10/21.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BigMoneyViewController.h"
#import "BaseViewController.h"
#import "MendDealCell.h"
#import "HistoryMemoryViewController.h"
#import "ApplyScheduleViewController.h"
#import "ChooseOpenAnAccountBank.h"
#import "BankName.h"
#import "ChooseBusViewController.h"
#import "RealNameViewController.h"

@interface BigMoneyViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

{
    UITableView *_tableView;
    
    NSArray *nameArray;
    NSArray *textArray;
    
    UIButton *buttonApply;
    UIImageView *imageRight;
    UIImageView *imageBusness;
    UIImageView *imagePos;
    
    UITextField *fileldName;
    UITextField *fieldBank;
    UITextField *fieldBankCard;
    UITextField *fieldPhoneNum;
    UITextField *fieldMoney;
    UITextField *fieldBusness;
    UITextField *fieldTime;
    UITextField *fieldPos;
    
    UIImageView *imageView;
    NSData *finaCard;
    
    NSInteger countIns;
}

@end

@implementation BigMoneyViewController

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getVData];
    countIns = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setTitleString:@"大额充值申请"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"历史记录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBar:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:15], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnBankName:) name:@"bank" object:nil];
    
    self.imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:nil setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonReturn:)];
    [self.imageReturn addGestureRecognizer:tap];
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
    _tableView.hidden = YES;
}

- (void)buttonReturn:(UIBarButtonItem *)bar
{
    if (self.big == NO) {
        
        NSArray *arr = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[arr objectAtIndex:1] animated:YES];
        
    } else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 130)];
    [_tableView registerNib:[UINib nibWithNibName:@"MendDealCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    nameArray = @[@"真实姓名", @"开户银行", @"银行卡号", @"手机号码", @"刷卡时间", @"商户", @"充值金额", @"上传POS单照片"];
    textArray = @[@"输入持卡人姓名", @"输入开户银行", @"银行卡号", @"请输入手机号", @"时间格式2016010101010", @"请选择商户", @"请输入充值金额", @"请上传POS单照片"];
    
    buttonApply = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 60, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"提交申请"];
    [_tableView.tableFooterView addSubview:buttonApply];
    buttonApply.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonApply setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonApply setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonApply addTarget:self action:@selector(applyBigMoney:) forControlEvents:UIControlEventTouchUpInside];
    
    imageRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 10 - 13, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"jiantou"]];
    
    imageBusness = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 10 - 13, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"jiantou"]];
    
    imagePos = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 10 - 13, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"jiantou"]];
    
    imageView = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 66, 5, 40, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"Pos"]];
    imageView.layer.cornerRadius = 3;
    imageView.layer.masksToBounds = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MendDealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelLeft.text = [nameArray objectAtIndex:indexPath.row];
    cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.textField.placeholder = [textArray objectAtIndex:indexPath.row];
    cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.textField.textColor = [UIColor zitihui];
    cell.textField.tintColor = [UIColor grayColor];
    cell.textField.delegate = self;
    cell.textField.tag = indexPath.row + 600;
    [cell.textField addTarget:self action:@selector(bigMoneyCashMoney:) forControlEvents:UIControlEventEditingChanged];
    
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
        
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    } else if(indexPath.row == 6){
        cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    
    if (indexPath.row == 1) {
        
        [cell addSubview:imageRight];
        cell.textField.enabled = NO;
    }
    
    if (indexPath.row == 5) {
        
        [cell addSubview:imageBusness];
        cell.textField.enabled = NO;

    }
    
    if (indexPath.row == 7) {
        
        cell.textField.enabled = NO;
        [cell addSubview:imagePos];
        [cell addSubview:imageView];
        imageView.tag = 19999;
    }
    
    if (indexPath.row == 4) {
        
        cell.textField.clearButtonMode = YES;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        ChooseOpenAnAccountBank *chooseOAAB = [[ChooseOpenAnAccountBank alloc] init];
        chooseOAAB.flagSelect = @"2";
        [self.navigationController pushViewController:chooseOAAB animated:YES];
        
    } else if (indexPath.row == 7) {
        
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
        
    } else if (indexPath.row == 5) {
        
        ChooseBusViewController *chooseBusness = [[ChooseBusViewController alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nsnoticeBusness:) name:@"busness" object:nil];
        [self.view endEditing:YES];
        [self.navigationController pushViewController:chooseBusness animated:YES];
    }
}

- (void)nsnoticeBusness:(NSNotification *)notice
{
    NSString *busnessStr = [notice object];
    fieldBusness = (UITextField *)[self.view viewWithTag:605];
    fieldBusness.text = busnessStr;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    imageView = (UIImageView *)[self.view viewWithTag:19999];
    
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
    [self saveImage:image withName:@"posImage.png"];
    fieldPos = (UITextField *)[self.view viewWithTag:607];
    fieldPos.text = @"已上传POS单照片";
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"posImage.png"];
    
    NSLog(@"%@",fullPath);
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    [imageView setImage:savedImage];
    
//    [[MyAfHTTPClient sharedClient] uploadFile:savedImage];
}

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

- (void)posData
{
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"posImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    finaCard = [[MyAfHTTPClient sharedClient] resetSizeOfImageData:savedImage maxSize:1024 * 2];
    
    fileldName = (UITextField *)[self.view viewWithTag:600];
    fieldBank = (UITextField *)[self.view viewWithTag:601];
    fieldBankCard = (UITextField *)[self.view viewWithTag:602];
    fieldPhoneNum = (UITextField *)[self.view viewWithTag:603];
    fieldTime = (UITextField *)[self.view viewWithTag:604];
    fieldBusness = (UITextField *)[self.view viewWithTag:605];
    fieldMoney = (UITextField *)[self.view viewWithTag:606];
    fieldPos = (UITextField *)[self.view viewWithTag:607];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    NSDictionary *parameter = @{@"realName":fileldName.text, @"bankName":fieldBank.text, @"account":fieldBankCard.text, @"phone":fieldPhoneNum.text, @"money":fieldMoney.text, @"busName":fieldBusness.text, @"posTime":fieldTime.text, @"posImg":finaCard, @"token":[dic objectForKey:@"token"]};
    
    NSString *URLPostString = [NSString stringWithFormat:@"%@%@",MYAFHTTP_BASEURL,@"app/user/bigPutOn"];
    
    [[MyAfHTTPClient sharedClient] POST:URLPostString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        [formData appendPartWithFileData:finaCard name:@"posImg" fileName:fileName mimeType:@"application/octet-stream"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSData *doubi = responseObject;
        NSMutableString *responseString = [[NSMutableString alloc] initWithData:doubi encoding:NSUTF8StringEncoding];
        
        NSString *character = nil;
        for (int i = 0; i < responseString.length; i ++) {
            character = [responseString substringWithRange:NSMakeRange(i, 1)];
            if ([character isEqualToString:@"\\"])
                [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
        }
        responseString = [[responseString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]] copy];
        
        NSLog(@"上传pos单照片接口:eeeee%@",responseString);
        
        NSDictionary *responseDic = [MyAfHTTPClient parseJSONStringToNSDictionary:responseString];
        
        NSLog(@"%@",responseDic);
        
        [self loadingWithHidden:YES];
        if ([[responseDic objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            [self submitLoadingWithHidden:YES];
            
            NSString *IDstr = [[responseDic objectForKey:@"id"] description];
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseDic objectForKey:@"resultMsg"]];
            ApplyScheduleViewController *scheduleVC = [[ApplyScheduleViewController alloc] init];
            scheduleVC.ID = IDstr;
            NSLog(@"1:%@", IDstr);
            scheduleVC.doOr = YES;
            [self.navigationController pushViewController:scheduleVC animated:YES];
            // 刷新我的账户数据
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
            
        } else {
            [self submitLoadingWithHidden:YES];
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseDic objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self submitLoadingWithHidden:YES];
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"网络超时,请再次提交"];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 602) {

        if (range.location == 19) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else if (textField.tag == 603) {

        if (range.location == 11) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else if (textField.tag == 604) {
        
        if (range.location < 14) {
            
            return YES;
            
        } else if (range.location == 19){
            
            return YES;
        } else {
            return NO;
        }
    }
    
    else {
        
        return YES;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField.tag == 604) {
        if ([textField.text isEqualToString:@""]) {
            return YES;
        } else {
            NSLog(@"0000000000%@",[textField.text substringWithRange:NSMakeRange(4, 1)]);
            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
            if (![[textField.text substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"-"]) {
                [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
                NSDate* inputDate = [inputFormatter dateFromString:textField.text];
                
                NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                [outputFormatter setLocale:[NSLocale currentLocale]];
                [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *str = [outputFormatter stringFromDate:inputDate];
                NSLog(@"9999999999%@",str);
                
                if (str == nil) {
                    [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入14位无符号无空格正确时间格式"];
                } else {
                    textField.text = str;
                }
            }
        }
    }
    return YES;
}

//编辑绑定判断
- (void)bigMoneyCashMoney:(UITextField *)textField
{
    fileldName = (UITextField *)[self.view viewWithTag:600];
    fieldBank = (UITextField *)[self.view viewWithTag:601];
    fieldBankCard = (UITextField *)[self.view viewWithTag:602];
    fieldPhoneNum = (UITextField *)[self.view viewWithTag:603];
    fieldTime = (UITextField *)[self.view viewWithTag:604];
    fieldBusness = (UITextField *)[self.view viewWithTag:605];
    fieldMoney = (UITextField *)[self.view viewWithTag:606];
    
    if (fileldName.text.length > 0 && fieldBank.text.length > 0 && fieldBankCard.text.length > 0 && fieldPhoneNum.text.length == 11 && fieldMoney.text.length > 0 && fieldBusness.text.length != 0 && fieldTime.text != 0) {
        
        [buttonApply setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonApply setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonApply setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonApply setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        if (textField.tag == 602) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 50);
                
            } completion:^(BOOL finished) {
                
            }];
//            [fieldBankCard becomeFirstResponder];

        } else if (textField.tag == 603) {
           
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 100);
                
            } completion:^(BOOL finished) {
                
            }];
//            [fieldPhoneNum becomeFirstResponder];
            
        } else if (textField.tag == 604) {
            textField.text = @"";
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 200);
                
            } completion:^(BOOL finished) {
                
            }];
//            [fieldMoney becomeFirstResponder];
            
        } else if (textField.tag == 606) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                
                _tableView.contentOffset = CGPointMake(0, 250);
                
            } completion:^(BOOL finished) {
                
            }];

//            [fieldTime becomeFirstResponder];
        }
    }
    return YES;
}

//申请按钮
- (void)applyBigMoney:(UIButton *)button
{
    fileldName = (UITextField *)[self.view viewWithTag:600];
    fieldBank = (UITextField *)[self.view viewWithTag:601];
    fieldBankCard = (UITextField *)[self.view viewWithTag:602];
    fieldPhoneNum = (UITextField *)[self.view viewWithTag:603];
    fieldTime = (UITextField *)[self.view viewWithTag:604];
    fieldBusness = (UITextField *)[self.view viewWithTag:605];
    fieldMoney = (UITextField *)[self.view viewWithTag:606];
    fieldPos = (UITextField *)[self.view viewWithTag:607];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        _tableView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self.view endEditing:YES];
    
    if (fileldName.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入持卡人姓名"];
        
    } else if (fieldBankCard.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入银行卡号"];
        
    } else if (![NSString checkCardNo:fieldBankCard.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"银行卡号格式错误"];
        
    } else if (fieldPhoneNum.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入手机号"];
        
    } else if (![NSString validateMobile:fieldPhoneNum.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"手机号格式错误"];
        
    } else if (fieldTime.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入年月日时分秒14位时间"];
        
    } else if (fieldBusness.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请选择商户"];
        
    } else if (fieldMoney.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入充值金额"];
        
    } else {
        
        countIns ++;
        if (countIns == 1) {
            [self submitLoadingWithView:self.view loadingFlag:NO height:0];
            
        } else {
            [self submitLoadingWithHidden:NO];
        }
        
        if ([fieldPos.text isEqualToString:@"已上传POS单照片"]) {
            
            NSLog(@"已上传pos单");
            [self posData];
            
        } else {
            
            NSLog(@"未上传");
            [self getData];
            
        }
        [self.view endEditing:YES];
    }
}

//历史记录
- (void)rightBar:(UIBarButtonItem *)bar
{
    HistoryMemoryViewController *historyVC = [[HistoryMemoryViewController alloc] init];
    [self.navigationController pushViewController:historyVC animated:YES];
}

//回收键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 150) {
        
        [self.view endEditing:YES];
    }
}

#pragma mark 网络请求方法
#pragma mark --------------------------------
- (void)getData
{
    fileldName = (UITextField *)[self.view viewWithTag:600];
    fieldBank = (UITextField *)[self.view viewWithTag:601];
    fieldBankCard = (UITextField *)[self.view viewWithTag:602];
    fieldPhoneNum = (UITextField *)[self.view viewWithTag:603];
    fieldTime = (UITextField *)[self.view viewWithTag:604];
    fieldBusness = (UITextField *)[self.view viewWithTag:605];
    fieldMoney = (UITextField *)[self.view viewWithTag:606];
    fieldPos = (UITextField *)[self.view viewWithTag:607];

    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    NSDictionary *parameter = @{@"realName":fileldName.text, @"bankName":fieldBank.text, @"account":fieldBankCard.text, @"phone":fieldPhoneNum.text, @"money":fieldMoney.text, @"busName":fieldBusness.text, @"posTime":fieldTime.text, @"posImg":@"", @"token":[dic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/bigPutOn" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"zzzzzzz%@", responseObject);
        [self submitLoadingWithHidden:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSString *IDstr = [[responseObject objectForKey:@"id"] description];
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            ApplyScheduleViewController *scheduleVC = [[ApplyScheduleViewController alloc] init];
            scheduleVC.ID = IDstr;
            NSLog(@"1:%@", IDstr);
            scheduleVC.doOr = YES;
            [self.navigationController pushViewController:scheduleVC animated:YES];
            // 刷新我的账户数据
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [self submitLoadingWithHidden:YES];
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"网络超时,请再次提交"];
    }];
}

- (void)returnBankName:(NSNotification *)notice
{
    BankName *bankName = [notice object];
    fieldBank = (UITextField *)[self.view viewWithTag:601];
    fieldBank.text = bankName.bankName;
}

#pragma mark 网络请求获得我的绑定的银行卡号
#pragma mark --------------------------------

- (void)getVData
{
    NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getUserInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        [self loadingWithHidden:YES];
        
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
        } else {
            
            NSDictionary *dataDic = [NSDictionary dictionary];
            dataDic = [responseObject objectForKey:@"User"];
            
            if (![[dataDic objectForKey:@"realNameStatus"] isEqualToNumber:[NSNumber numberWithInt:2]]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"为了您的账号安全,请先实名认证" delegate:self cancelButtonTitle:@"残忍拒绝" otherButtonTitles:@"去完善",nil];
                // optional - add more buttons:
                alert.tag = 9201;
                [alert show];
                
            } else {
                [self tableViewShow];
                
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 9201) {
        if (buttonIndex == 1) {
            RealNameViewController *realNameVC = [[RealNameViewController alloc] init];
            realNameVC.realNamePan = YES;
            pushVC(realNameVC);
        } else {
            popVC;
        }
        
    }
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
