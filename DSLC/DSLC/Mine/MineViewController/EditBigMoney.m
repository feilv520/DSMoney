//
//  EditBigMoney.m
//  DSLC
//
//  Created by ios on 15/11/10.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "EditBigMoney.h"
#import "MendDealCell.h"
#import "ChooseOpenAnAccountBank.h"
#import "BankName.h"
#import "ChooseBusViewController.h"

@interface EditBigMoney () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

{
    UITableView *_tabelView;
    UIButton *buttonOk;
    
    NSArray *nameArray;
    NSArray *textArray;
    
    UITextField *fileldName;
    UITextField *fieldBank;
    UITextField *fieldBankCard;
    UITextField *fieldPhoneNum;
    UITextField *fieldMoney;
    UITextField *fieldBusness;
    UITextField *fieldTime;
    UITextField *fieldPos;
    
    UIImageView *imageViewR;
    BankName *bankName;
    
    UIImageView *imageView;
    UIImageView *imagePos;
    YYAnimatedImageView *posImageView;
    NSData *finaCard;
}

@end

@implementation EditBigMoney

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"大额充值申请"];
    
    [self contentShow];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnBankName:) name:@"bank" object:nil];
}

- (void)returnBankName:(NSNotification *)notice
{
    bankName = [notice object];
    fieldBank = (UITextField *)[self.view viewWithTag:601];
    fieldBank.text = bankName.bankName;
}

- (void)contentShow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 130)];
    _tabelView.backgroundColor = [UIColor huibai];
    [_tabelView registerNib:[UINib nibWithNibName:@"MendDealCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    nameArray = @[@"真实姓名", @"开户银行", @"银行卡号", @"手机号码", @"刷卡时间", @"商户", @"充值金额", @"上传POS单照片"];
    textArray = @[[DES3Util decrypt:self.schedule.realName], self.schedule.bankName, [DES3Util decrypt:self.schedule.account], [DES3Util decrypt:self.schedule.phone], self.schedule.posTime, self.schedule.busName, [DES3Util decrypt:self.schedule.money], @"已上传POS单照片"];
    
    buttonOk = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 60, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [_tabelView.tableFooterView addSubview:buttonOk];
    buttonOk.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonOk setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [buttonOk setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [buttonOk addTarget:self action:@selector(makeSureEditReturn:) forControlEvents:UIControlEventTouchUpInside];

    imageViewR = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 22, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"jiantou"]];
    
    imageView = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 66, 5, 40, 40) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"Pos"]];
    imageView.layer.cornerRadius = 3;
    imageView.layer.masksToBounds = YES;
    imageView.yy_imageURL = [NSURL URLWithString:self.schedule.posImg];

    imagePos = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 10 - 13, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"jiantou"]];
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
    
    cell.textField.text = [textArray objectAtIndex:indexPath.row];
    cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.textField.textColor = [UIColor zitihui];
    cell.textField.tintColor = [UIColor grayColor];
    cell.textField.delegate = self;
    cell.textField.tag = indexPath.row + 600;
    
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 6) {
        
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if (indexPath.row == 1) {
        
        cell.textField.enabled = NO;
        [cell addSubview:imageViewR];
    }
    
    if (indexPath.row == 7) {
        
        [cell addSubview:imageView];
        [cell addSubview:imagePos];
        cell.textField.enabled = NO;
    }
    
    if (indexPath.row == 5) {
        
        cell.textField.enabled = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        ChooseOpenAnAccountBank *choose = [[ChooseOpenAnAccountBank alloc] init];
        choose.flagSelect = @"2";
        [self.navigationController pushViewController:choose animated:YES];
        
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nsNoticeBusness:) name:@"busness" object:nil];
        [self.navigationController pushViewController:chooseBusness animated:YES];
    }
}

- (void)nsNoticeBusness:(NSNotification *)notice
{
    NSString *busnessName = [notice object];
    fieldBusness = (UITextField *)[self.view viewWithTag:605];
    fieldBusness.text = busnessName;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{   
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
    [self saveImage:image withName:@"posUpImage.png"];
    fieldPos = (UITextField *)[self.view viewWithTag:607];
    fieldPos.text = @"已修改POS单照片";
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"posUpImage.png"];
    
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
    } else {
        
        return YES;
    }
}

//确定按钮
- (void)makeSureEditReturn:(UIButton *)button
{
    [self submitLoadingWithView:self.view loadingFlag:NO height:0];
    fieldPos = (UITextField *)[self.view viewWithTag:607];
    NSLog(@"zzzzzzzzzz%@", fieldPos.text);
    if (![fieldPos.text isEqualToString:@"已上传POS单照片"]) {
        NSLog(@"aaaaaaaaaaaaaa");
        [self upPosData];
    } else {
        [self getData];
    }
}

- (void)upPosData
{
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"posUpImage.png"];
    NSLog(@"************%@", fullPath);
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
    NSDictionary *parameter = @{@"id":self.schedule.Id, @"realName":fileldName.text, @"bankName":fieldBank.text, @"account":fieldBankCard.text, @"phone":fieldPhoneNum.text, @"money":fieldMoney.text, @"busName":fieldBusness.text, @"posTime":fieldTime.text, @"posImg":finaCard, @"token":[dic objectForKey:@"token"]};
    
    NSString *URLPostString = [NSString stringWithFormat:@"%@%@",MYAFHTTP_BASEURL,@"app/user/updateBigPutOnSerialNum"];
    
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
        
        [self submitLoadingWithHidden:YES];
        
        if ([[responseDic objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseDic objectForKey:@"resultMsg"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseDic objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
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

    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    NSDictionary *paremeter = @{@"id":self.schedule.Id, @"realName":fileldName.text, @"bankName":fieldBank.text, @"account":fieldBankCard.text, @"phone":fieldPhoneNum.text, @"money":fieldMoney.text, @"busName":fieldBusness.text, @"posTime":fieldTime.text, @"posImg":@"", @"token":[dic objectForKey:@"token"]};

    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/updateBigPutOnSerialNum" parameters:paremeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        [self submitLoadingWithHidden:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 603) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            _tabelView.contentOffset = CGPointMake(0, 100);
            
        } completion:^(BOOL finished) {
            
        }];
    } else if (textField.tag == 604) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            _tabelView.contentOffset = CGPointMake(0, 200);
            
        } completion:^(BOOL finished) {
            
        }];
    } else if (textField.tag == 606) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            _tabelView.contentOffset = CGPointMake(0, 250);
            
        } completion:^(BOOL finished) {
            
        }];
        
    } 
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 150) {
        
        [self.view endEditing:YES];
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
