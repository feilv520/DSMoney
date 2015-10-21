//
//  ChooseStyleViewController.m
//  DSLC
//
//  Created by ios on 15/10/21.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ChooseStyleViewController.h"
#import "define.h"
#import "ChooseStyleCell.h"
#import "UIColor+AddColor.h"
#import "ChooseCell.h"
#import "CreatView.h"

@interface ChooseStyleViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
    NSArray *pashArr;
    UITextField *_textField;
    UIButton *buttonNext;
    UIButton *button1;
    UIButton *button2;
    BOOL decide;
}

@end

@implementation ChooseStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setTitle:@"选择充值方式"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    titleArr = @[@"支付金额(元)", @"充值金额(元)"];
    pashArr = @[@"快捷支付", @"网银支付"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100)];
    [_tableView registerNib:[UINib nibWithNibName:@"ChooseCell" bundle:nil] forCellReuseIdentifier:@"reuses1"];
    [_tableView registerNib:[UINib nibWithNibName:@"ChooseStyleCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    _textField = [CreatView creatWithfFrame:CGRectMake(120, 10, WIDTH_CONTROLLER_DEFAULT - 130, 30) setPlaceholder:@"充值金额最小为1元" setTintColor:[UIColor grayColor]];
    _textField.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [_textField addTarget:self action:@selector(textFiledEdit:) forControlEvents:UIControlEventEditingChanged];
    
    buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 60, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [_tableView.tableFooterView addSubview:buttonNext];
    buttonNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonNext addTarget:self action:@selector(buttonNext:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textFiledEdit:(UITextField *)textField
{
    if ([textField.text length] > 0) {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    }
}

//下一步按钮
- (void)buttonNext:(UIButton *)button
{
    NSLog(@"下一步");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_CONTROLLER_DEFAULT * (50.0 / 667.0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0;
        
    } else {
        
        return HEIGHT_CONTROLLER_DEFAULT * (10.0 / 667.0);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuses1"];
        
        if (cell == nil) {
            
            cell = [[ChooseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse1"];
        }
        
        cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
        cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        if (indexPath.row == 0) {
            
            cell.labelYuan.text = @"9,000";
            cell.labelYuan.textColor = [UIColor daohanglan];
            cell.labelYuan.font = [UIFont fontWithName:@"CenturyGothic" size:16];
            
        } else {
            
            cell.labelYuan.hidden = YES;
            [cell addSubview:_textField];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        ChooseStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        if (cell == nil) {
            
            cell = [[ChooseStyleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
        }
        
        [cell.butChoose setBackgroundImage:[UIImage imageNamed:@"emptyyuan"] forState:UIControlStateNormal];
        cell.butChoose.tag = 100 + indexPath.row;
        [cell.butChoose addTarget:self action:@selector(buttonChoose:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.labelStyle.text = [pashArr objectAtIndex:indexPath.row];
        cell.labelStyle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        if (indexPath.row == 0) {
            
            [cell.butChoose setBackgroundImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
            button2 = cell.butChoose;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

//选择支付方式
- (void)buttonChoose:(UIButton *)button
{
    if (button.tag == 101) {
        
        button1 = button;
        [button2 setBackgroundImage:[UIImage imageNamed:@"emptyyuan"] forState:UIControlStateNormal];
        [button1 setBackgroundImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
        
    } else {
        
        [button1 setBackgroundImage:[UIImage imageNamed:@"emptyyuan"] forState:UIControlStateNormal];
        [button2 setBackgroundImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
        
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
