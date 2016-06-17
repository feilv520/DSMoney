//
//  TWOAlreadyBankCardViewController.m
//  DSLC
//
//  Created by ios on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOAlreadyBankCardViewController.h"
#import "TWOBankCardCell.h"
#import "TWOBankCardModel.h"

@interface TWOAlreadyBankCardViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation TWOAlreadyBankCardViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"银行卡"];
    
    [self getDataBankCardList];
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 35)];
    _tableView.tableFooterView.backgroundColor = [UIColor qianhuise];
    _tableView.backgroundColor = [UIColor qianhuise];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOBankCardCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UIButton *butCall = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 35) backgroundColor:[UIColor qianhuise] textColor:[UIColor profitColor] titleText:nil];
    [_tableView.tableFooterView addSubview:butCall];
    butCall.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    NSMutableAttributedString *callString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"更换绑定银行卡请致电客服:%@", @"400-000-000"]];
    NSRange callRange = NSMakeRange(0, 13);
    [callString addAttribute:NSForegroundColorAttributeName value:[UIColor findZiTiColor] range:callRange];
    NSRange phoneRange = NSMakeRange([[callString string] length] - 11, 11);
    [callString addAttribute:NSForegroundColorAttributeName value:[UIColor profitColor] range:phoneRange];
    [butCall setAttributedTitle:callString forState:UIControlStateNormal];
    [butCall addTarget:self action:@selector(buttonCallPhone:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.imagePincture.image = [UIImage imageNamed:@"yinhangkabg"];
    cell.imageBankLogo.image = [UIImage imageNamed:@"gongshang"];
    
    cell.labelBankName.text = @"工商银行";
    cell.labelStyle.text = @"储蓄卡";
    cell.labelCardNum.text = @"6225**** ****8823";
    
    cell.imageBankLogo.backgroundColor = [UIColor clearColor];
    cell.labelBankName.backgroundColor = [UIColor clearColor];
    cell.labelStyle.backgroundColor = [UIColor clearColor];
    cell.labelCardNum.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//拨打电话
- (void)buttonCallPhone:(UIButton *)button
{
    NSLog(@"call");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        _tableView.scrollEnabled = NO;
    } else {
        _tableView.scrollEnabled = YES;
    }
}

#pragma data
- (void)getDataBankCardList
{
    NSDictionary *parermeter = @{@"curPage":@1, @"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"bankCard/getUserBankCardList" parameters:parermeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"银行卡列表;;;;;;;;%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSMutableArray *bankCardArray = [responseObject objectForKey:@"BankCard"];
            for (NSDictionary *dataDic in bankCardArray) {
                TWOBankCardModel *bankModel = [[TWOBankCardModel alloc] init];
                [bankModel setValuesForKeysWithDictionary:dataDic];
            }
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
