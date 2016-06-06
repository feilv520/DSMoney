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
    _textView.placeholder = @"请输入你的准确地址...";
    _textView.placeholderColor = [UIColor findZiTiColor];
    _textView.delegate = self;
    _textView.textColor = [UIColor findZiTiColor];
    _textView.tintColor = [UIColor grayColor];
    _textView.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    _textView.layer.cornerRadius = 5;
    _textView.layer.masksToBounds = YES;
    _textView.layer.borderColor = [[UIColor profitColor] CGColor];
    _textView.layer.borderWidth = 0.5;
    
    buttonSave = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(9, _textView.frame.size.height + 9 + 30, WIDTH_CONTROLLER_DEFAULT - 18, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"保存"];
    [self.view addSubview:buttonSave];
    buttonSave.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonSave.layer.cornerRadius = 5;
    buttonSave.layer.masksToBounds = YES;
    [buttonSave addTarget:self action:@selector(buttonSaveAddress:) forControlEvents:UIControlEventTouchUpInside];
}

//保存地址的按钮方法
- (void)buttonSaveAddress:(UIButton *)button
{
    if (_textView.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入地址"];
    } else {
        TWOAddressAlreadySetViewController *addressSetVC = [[TWOAddressAlreadySetViewController alloc] init];
        addressSetVC.numberNo = 0;
        addressSetVC.addressString = _textView.text;
        pushVC(addressSetVC);
        [self.view endEditing:YES];
    }
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
