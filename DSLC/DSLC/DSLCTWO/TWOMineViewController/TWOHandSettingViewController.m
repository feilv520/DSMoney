//
//  TWOHandSettingViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/5/18.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOHandSettingViewController.h"
#import "TWOHandSetTableViewCell.h"
#import "TWOPersonalSetCell.h"
#import "MyHandViewController.h"
#import "TWOFixHandViewController.h"

@interface TWOHandSettingViewController () <UITableViewDataSource, UITableViewDelegate>{
    BOOL flag;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TWOHandSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:@"手势密码"];
    
    // 判断是否存在isLogin.plist文件
    if (![FileOfManage ExistOfFile:@"handOpen.plist"]) {
        [FileOfManage createWithFile:@"handOpen.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"handFlag",@"YES",@"ifSetHandFlag",@"",@"handString",nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"handOpen.plist"]];
    
    flag = [[dic objectForKey:@"handFlag"] boolValue];
    
    [self tableViewShow];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchButtonAction:) name:@"switchButton" object:nil];
    
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 1)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOHandSetTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuseHand"];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOPersonalSetCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!flag) {
        return 1;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        TWOHandSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseHand"];
        
        [cell.switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        [cell.switchButton setOn:flag];
        
        cell.switchButton.tag = 5020;
        
        cell.titleLabel.text = @"手势密码";
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else {
    
        TWOPersonalSetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        cell.labelStates.hidden = YES;
        cell.imageRight.image = [UIImage imageNamed:@"arrow"];
        cell.labelTitle.text = @"修改手势密码";
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        
        TWOFixHandViewController *fixHandVC = [[TWOFixHandViewController alloc] init];
        pushVC(fixHandVC);
    }
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch *)sender;
    BOOL isButtonOn = [switchButton isOn];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"handOpen.plist"]];
    
    if (isButtonOn) {
        flag = YES;
        [dic setValue:@"YES" forKey:@"handFlag"];
        [dic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
        
        MyHandViewController *myHandVC = [[MyHandViewController alloc] init];
        pushVC(myHandVC);
        
    }else {
        flag = NO;
        [dic setValue:@"NO" forKey:@"handFlag"];
        [dic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
        
        MyHandViewController *myHandVC = [[MyHandViewController alloc] init];
        myHandVC.flagString = @"YES";
        pushVC(myHandVC);
        
    }
    [self.tableView reloadData];
}

- (void)switchButtonAction:(NSNotification *)not{
    UISwitch *switchButton = (UISwitch *)[self.view viewWithTag:5020];
    flag = NO;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"handOpen.plist"]];
    [dic setValue:@"NO" forKey:@"handFlag"];
    [dic writeToFile:[FileOfManage PathOfFile:@"handOpen.plist"] atomically:YES];
    [switchButton setOn:flag];
    [self.tableView reloadData];
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
