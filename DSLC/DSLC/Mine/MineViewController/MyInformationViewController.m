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

@interface MyInformationViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
    UISwitch *switchLeft;
}

@end

@implementation MyInformationViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    self.navigationController.navigationBar.translucent = NO;
    
    [self navigationContent];
    [self tableViewShow];
}

//navigation
- (void)navigationContent
{
    self.navigationItem.title = @"我的资料";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:nil setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonReturn:)];
    [imageReturn addGestureRecognizer:tap];
}

//tableView展示
- (void)tableViewShow
{
    titleArr = @[@[@"我的银行卡"],
                 @[@"绑定手机", @"绑定邮箱", @"实名认证"],
                 @[@"登录密码", @"交易密码", @"手势密码", @"修改手势密码"]];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.tableFooterView = view;
    view.backgroundColor = [UIColor huibai];
    [_tableView registerNib:[UINib nibWithNibName:@"MyInformationCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    switchLeft = [[UISwitch alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT * (64.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (10.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (50.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (30.0 / 667.0))];
    [switchLeft addTarget:self action:@selector(showSwitchGetOnOrOff:) forControlEvents:UIControlEventEditingChanged];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0;
        
    } else {
        
        return HEIGHT_CONTROLLER_DEFAULT * (11.0 / 667.0);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_CONTROLLER_DEFAULT * (50.0 / 667.0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    } else if (section == 1) {
        
        return 3;
        
    } else {
        
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[MyInformationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    NSArray *rowArr = [titleArr objectAtIndex:indexPath.section];
    cell.labelTitle.text = [rowArr objectAtIndex:indexPath.row];
    cell.labelTitle.font = [UIFont systemFontOfSize:15];
    
    cell.imageRight.image = [UIImage imageNamed:@"arrow"];
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 2) {
            
            cell.imageRight.hidden = YES;
            
            [cell addSubview:switchLeft];
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        MyBankViewController *myBankVC = [[MyBankViewController alloc] init];
        [self.navigationController pushViewController:myBankVC animated:YES];
    }
}

//手势密码开关
- (void)showSwitchGetOnOrOff:(UISwitch *)switchOn
{
    NSLog(@"手势密码");
}

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
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