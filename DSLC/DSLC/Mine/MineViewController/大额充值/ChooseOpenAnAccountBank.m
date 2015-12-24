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
#import "City.h"

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
    if ([self.flagSelect isEqualToString:@"2"]) {
        [self getData];
    } else if ([self.flagSelect isEqualToString:@"3"]) {
        [self getAreaListOfP];
    } else if ([self.flagSelect isEqualToString:@"4"]) {
        [self getAreaListOfS];
    }
    
    if ([self.flagSelect isEqualToString:@"22"]) {
        [self getData];
    } else if ([self.flagSelect isEqualToString:@"33"]) {
        [self getAreaListOfP];
    } else if ([self.flagSelect isEqualToString:@"44"]) {
        [self getAreaListOfS];
    }
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
    _tableView.hidden = YES;
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
    
    cell.labelBank.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    if ([self.flagSelect isEqualToString:@"3"] || [self.flagSelect isEqualToString:@"4"] || [self.flagSelect isEqualToString:@"33"] || [self.flagSelect isEqualToString:@"44"]) {
        City *city = [bankNameArr objectAtIndex:indexPath.row];
        cell.labelBank.text = city.cityName;
    } else {
        BankName *bank = [bankNameArr objectAtIndex:indexPath.row];
        cell.labelBank.text = bank.bankName;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.flagSelect isEqualToString:@"3"] || [self.flagSelect isEqualToString:@"4"]) {
        City *city = [bankNameArr objectAtIndex:indexPath.row];
        if ([self.flagSelect isEqualToString:@"3"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cityP" object:city];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cityS" object:city];
        }
    } else {
        BankName *bank = [bankNameArr objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bank" object:bank];
    }
    
    if ([self.flagSelect isEqualToString:@"33"] || [self.flagSelect isEqualToString:@"44"]) {
        City *city = [bankNameArr objectAtIndex:indexPath.row];
        if ([self.flagSelect isEqualToString:@"33"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cityPR" object:city];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"citySR" object:city];
        }
    } else {
        BankName *bank = [bankNameArr objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bankR" object:bank];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------
- (void)getData
{
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/getBankList" parameters:NULL success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"mmmmmmmm%@", responseObject);
        [self loadingWithHidden:YES];
        _tableView.hidden = NO;
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSMutableArray *bankArray = [responseObject objectForKey:@"Bank"];
            for (NSDictionary *dataDic in bankArray) {
                BankName *bankName = [[BankName alloc] init];
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

- (void)getAreaListOfP {
    
    NSDictionary *parameters = @{@"type":@"1",@"proviceCode":@""};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/index/getAreaList" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getAreaListOfP = %@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSMutableArray *bankArray = [responseObject objectForKey:@"Area"];
            for (NSDictionary *dataDic in bankArray) {
                City *bankName = [[City alloc] init];
                [bankName setValuesForKeysWithDictionary:dataDic];
                [bankNameArr addObject:bankName];
            }
            [_tableView reloadData];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        
    }];
}

- (void)getAreaListOfS {
    
    NSDictionary *parameters = @{@"type":@2,@"proviceCode":self.cityCode};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/index/getAreaList" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getAreaListOfP = %@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSMutableArray *bankArray = [responseObject objectForKey:@"Area"];
            for (NSDictionary *dataDic in bankArray) {
                City *bankName = [[City alloc] init];
                [bankName setValuesForKeysWithDictionary:dataDic];
                [bankNameArr addObject:bankName];
            }
            [_tableView reloadData];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@", error);
        
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
