//
//  ChooseOpenAnAccountBank.m
//  DSLC
//
//  Created by ios on 15/11/30.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ChooseOpenAnAccountBank.h"
#import "BankListCell.h"
#import "BankName.h"

@interface ChooseOpenAnAccountBank () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *bankNameArr;
}

@end

@implementation ChooseOpenAnAccountBank

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"开户银行"];
    bankNameArr = [NSMutableArray array];
    
    [self tableViewContentShow];
    [self getData];
}

- (void)tableViewContentShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor huibai];
    [_tableView registerNib:[UINib nibWithNibName:@"BankListCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return bankNameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    BankName *bank = [bankNameArr objectAtIndex:indexPath.row];
    cell.labelBank.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    cell.labelBank.text = bank.bankName;
    
    return cell;
}

#pragma mark 网络请求方法
#pragma mark --------------------------------
- (void)getData
{
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getBankList" parameters:NULL success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"mmmmmmmm%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            BankName *bankName = [[BankName alloc] init];
            NSMutableArray *bankArray = [responseObject objectForKey:@"Bank"];
            for (NSDictionary *dataDic in bankArray) {
                [bankName setValuesForKeysWithDictionary:dataDic];
                [bankNameArr addObject:bankName];
            }
            
            [_tableView reloadData];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"mmmmmmmmmmm%@", error);
        
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
