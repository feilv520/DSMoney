//
//  TWOAddressManageViewController.m
//  DSLC
//
//  Created by ios on 16/6/2.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOAddressManageViewController.h"
#import "UIPlaceHolderTextView.h"
#import "TWOAddressAlreadySetViewController.h"

@interface TWOAddressManageViewController () <UITextViewDelegate>

{
    UIPlaceHolderTextView *_textView;
    UIButton *buttonSave;
}

@end

@implementation TWOAddressManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"地址设置"];
    
    [self contentSHOW];
}

- (void)contentSHOW
{
    _textView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(9, 9, WIDTH_CONTROLLER_DEFAULT - 18, 152.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    [self.view addSubview:_textView];
    if (self.addressState) {
        _textView.text = self.address;
    } else {
        _textView.placeholder = @"请输入你的准确地址...";
    }
    _textView.placeholderColor = [UIColor findZiTiColor];
    _textView.delegate = self;
    _textView.textColor = [UIColor findZiTiColor];
    _textView.tintColor = [UIColor grayColor];
    _textView.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    _textView.layer.cornerRadius = 5;
    _textView.layer.masksToBounds = YES;
    _textView.layer.borderColor = [[UIColor profitColor] CGColor];
    _textView.layer.borderWidth = 0.5;
    
    buttonSave = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(9, _textView.frame.size.height + 9 + 30, WIDTH_CONTROLLER_DEFAULT - 18, 40) backgroundColor:nil textColor:[UIColor whiteColor] titleText:@"保存"];
    [self.view addSubview:buttonSave];
    if (self.addressState) {
        buttonSave.backgroundColor = [UIColor profitColor];
    } else {
        buttonSave.backgroundColor = [UIColor findZiTiColor];
    }
    buttonSave.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonSave.layer.cornerRadius = 5;
    buttonSave.layer.masksToBounds = YES;
    [buttonSave addTarget:self action:@selector(buttonSaveAddress:) forControlEvents:UIControlEventTouchUpInside];
}

//保存按钮置灰
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (_textView.text.length == 0) {
        buttonSave.backgroundColor = [UIColor findZiTiColor];
    } else {
        buttonSave.backgroundColor = [UIColor profitColor];
    }
}

//字数限制
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location < 60) {
        return YES;
    } else {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"输入字数不能超过60"];
        return NO;
    }
}

//保存地址的按钮方法
- (void)buttonSaveAddress:(UIButton *)button
{
    if (_textView.text.length == 0) {

    } else {
        [self setAddressData];
        [self.view endEditing:YES];
    }
}

- (void)setAddressData
{
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"], @"address":_textView.text};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/saveAddress" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"设置地址=========%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            TWOAddressAlreadySetViewController *addressSetVC = [[TWOAddressAlreadySetViewController alloc] init];
            addressSetVC.numberNo = 0;
            addressSetVC.addressString = _textView.text;
            pushVC(addressSetVC);
            
            // 刷新任务中心列表
            [[NSNotificationCenter defaultCenter] postNotificationName:@"taskListFuction" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getMyAccountInfo" object:nil];
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
