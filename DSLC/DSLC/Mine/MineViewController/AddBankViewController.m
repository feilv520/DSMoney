//
//  AddBankViewController.m
//  DSLC
//
//  Created by ios on 15/10/16.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "AddBankViewController.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "define.h"
#import "AddBankCell.h"

@interface AddBankViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
    NSArray *textFieldArr;
    UIImageView *imageViewRight;
    UILabel *labelChoose;
}

@end

@implementation AddBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self navigationContent];
    [self showViewControllerContent];
}

//navigation
- (void)navigationContent
{
    self.navigationItem.title = @"添加银行卡";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:nil setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonReturn:)];
    [imageReturn addGestureRecognizer:tap];
}

//视图内容
- (void)showViewControllerContent
{
    titleArr = @[@"持卡人", @"身份证号码", @"银行", @"卡号", @"开户省市", @"预留手机号"];
    textFieldArr = @[@"黄冬明", @"身份证号", @"选择发卡银行", @"银行卡号", @"选择省市", @"预留银行开户手机号"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIView *view = [UIView new];
    _tableView.tableFooterView = view;
    _tableView.backgroundColor = [UIColor huibai];
    
    [_tableView registerNib:[UINib nibWithNibName:@"AddBankCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    imageViewRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"arrow"]];
    
    labelChoose = [CreatView creatWithLabelFrame:CGRectMake(120, 10, 224, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor colorWithRed:193.0 / 255.0 green:194.0 / 255.0 blue:195.0 / 255.0 alpha:1.0] textAlignment:NSTextAlignmentLeft textFont:[UIFont systemFontOfSize:14] text:@"选择发卡银行"];
    
    UIButton *buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0))/2, HEIGHT_CONTROLLER_DEFAULT * (47.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (43.0 / 667.0)) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [view addSubview:buttonNext];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_CONTROLLER_DEFAULT * (50.0 / 667.0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[AddBankCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
    cell.labelTitle.font = [UIFont systemFontOfSize:15];
    
    cell.textField.placeholder = [textFieldArr objectAtIndex:indexPath.row];
    cell.textField.font = [UIFont systemFontOfSize:14];
    cell.textField.tintColor = [UIColor yuanColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 2) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        cell.textField.hidden = YES;
        
        [cell addSubview:imageViewRight];
        [cell addSubview:labelChoose];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
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
