//
//  TWOImputNewPhoneNumViewController.m
//  DSLC
//
//  Created by ios on 16/5/17.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOImputNewPhoneNumViewController.h"
#import "TWOPhoneNumCell.h"
#import "TWOGetCodeCell.h"
#import "TWOImputPhoneNumCell.h"

@interface TWOImputNewPhoneNumViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    UIButton *butMakeSure;
    UITextField *_textField;
}

@end

@implementation TWOImputNewPhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"更换绑定手机号"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 55)];
    _tableView.tableFooterView.backgroundColor = [UIColor qianhuise];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOImputPhoneNumCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOGetCodeCell" bundle:nil] forCellReuseIdentifier:@"reuseCode"];
    
//    确定按钮
    butMakeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 15, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [_tableView.tableFooterView addSubview:butMakeSure];
    butMakeSure.layer.cornerRadius = 5;
    butMakeSure.layer.masksToBounds = YES;
    butMakeSure.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butMakeSure addTarget:self action:@selector(makeSureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        TWOImputPhoneNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        cell.imagePic.image = [UIImage imageNamed:@"手机"];
        cell.textFieldPhone.delegate = self;
        cell.textFieldPhone.textColor = [UIColor ZiTiColor];
        cell.textFieldPhone.placeholder = @"请输入需要更换绑定的手机号";
        cell.textFieldPhone.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textFieldPhone.tintColor = [UIColor grayColor];
        cell.buttonEye.hidden = YES;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        TWOGetCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCode"];
        
        cell.imageLeft.image = [UIImage imageNamed:@"yanzhenma"];
        cell.textFieldCode.placeholder = @"请输入短信验证码";
        cell.textFieldCode.tintColor = [UIColor grayColor];
        cell.textFieldCode.textColor = [UIColor ZiTiColor];
        cell.textFieldCode.delegate = self;
        cell.textFieldCode.tag = 333;
        cell.textFieldCode.keyboardType = UIKeyboardTypeNumberPad;
        
        cell.butGetCode.layer.cornerRadius = 6;
        cell.butGetCode.layer.masksToBounds = YES;
        cell.butGetCode.layer.borderColor = [[UIColor profitColor] CGColor];
        cell.butGetCode.layer.borderWidth = 1;
        [cell.butGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [cell.butGetCode addTarget:self action:@selector(getCodeButton:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

//获取验证码
- (void)getCodeButton:(UIButton *)button
{
    NSLog(@"code");
}

//确定按钮方法
- (void)makeSureButtonClicked:(UIButton *)button
{
    [self.view endEditing:YES];
    NSArray *viewControllers = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewControllers objectAtIndex:2] animated:YES];
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
