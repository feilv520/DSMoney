//
//  CastProduceViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "CastProduceViewController.h"
#import "define.h"
#import "CastUpTableViewCell.h"
#import "CastDownTableViewCell.h"
#import "CastDetailTableViewCell.h"
#import "CreatView.h"
#import "UIColor+AddColor.h"
#import "CheckViewController.h"
#import "MoneyDetailViewController.h"

@interface CastProduceViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTV;

@property (nonatomic, strong) NSDictionary *castDic;

@end

@implementation CastProduceViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getCastProduct];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = buttonBorderColor;
    
    self.mainTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 84) style:UITableViewStylePlain];
    
    self.mainTV.backgroundColor = buttonBorderColor;
    
    self.mainTV.dataSource = self;
    self.mainTV.delegate = self;
    
    [self.mainTV registerNib:[UINib nibWithNibName:@"CastUpTableViewCell" bundle:nil] forCellReuseIdentifier:@"castUp"];
    [self.mainTV registerNib:[UINib nibWithNibName:@"CastDownTableViewCell" bundle:nil] forCellReuseIdentifier:@"castDown"];
    [self.mainTV registerNib:[UINib nibWithNibName:@"CastDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"castDetail"];
    
    [self.view addSubview:self.mainTV];
    
    [self setXYButton];
    
    [self.navigationItem setTitle:@"在投产品"];
}

//查看协议
- (void)setXYButton{
    
    UIView *tableBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 84 + 43)];
    
    tableBottom.backgroundColor = Color_Clear;
    
    UIButton *xyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [xyButton setFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (51 / 375.0), 42, WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), 43)];
    
    [xyButton setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    
    [xyButton setTitle:@"查看协议" forState:UIControlStateNormal];
    
    [xyButton setTitleColor:Color_White forState:UIControlStateNormal];
    
    [xyButton addTarget:self action:@selector(xyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [tableBottom addSubview:xyButton];
    
    self.mainTV.tableFooterView = tableBottom;
    
}

- (void)xyButtonAction:(UIButton *)btn{
    
    CheckViewController *checkVC = [[CheckViewController alloc] init];
    [self.navigationController pushViewController:checkVC animated:YES];
}

#pragma mark tableview delegate and dataSource
#pragma mark ---------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 20;
    } else {
        return 0.5;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else {
        return [[[self.castDic objectForKey:@"Product"] objectForKey:@"Asset"] count] + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CastUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"castUp"];
            cell.productName.text = [[self.castDic objectForKey:@"Product"] objectForKey:@"productName"];
            cell.productType.text = [[self.castDic objectForKey:@"Product"] objectForKey:@"productType"];
            cell.productNumber.text = [NSString stringWithFormat:@"%@%%",[[self.castDic objectForKey:@"Product"] objectForKey:@"productAnnualYield"]];
            
            cell.productMoney.text = [NSString stringWithFormat:@"%@元",[DES3Util decrypt:[[self.castDic objectForKey:@"Product"] objectForKey:@"money"]]];

            NSString *moneyString = [DES3Util decrypt:[[self.castDic objectForKey:@"Product"] objectForKey:@"money"]];
            moneyString = [moneyString stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            cell.productProfit.text = [NSString stringWithFormat:@"%.2lf元",[moneyString floatValue] * [[[self.castDic objectForKey:@"Product"] objectForKey:@"productAnnualYield"] floatValue] * [[[self.castDic objectForKey:@"Product"] objectForKey:@"productPeriod"] floatValue] / 36500.0];
            
            cell.productDate.text = [[self.castDic objectForKey:@"Product"] objectForKey:@"productToaccountTypeName"];
            
            return cell;
        } else {
            return nil;
        }
    } else {
        if (indexPath.row == 0) {
            CastDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"castDown"];
            return cell;
        } else {
            CastDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"castDetail"];
            
            cell.assetName.text = [[[[self.castDic objectForKey:@"Product"] objectForKey:@"Asset"] objectAtIndex:indexPath.row - 1] objectForKey:@"assetName"];
            cell.assetMoney.text = [NSString stringWithFormat:@"%@元",[DES3Util decrypt:[[[[self.castDic objectForKey:@"Product"] objectForKey:@"Asset"] objectAtIndex:indexPath.row - 1] objectForKey:@"investMoney"]]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
    
//    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 222;
    } else {
        if (indexPath.row == 0) {
            return 50;
        } else {
            return 89;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        
        MoneyDetailViewController *moneyDetail = [[MoneyDetailViewController alloc] init];
        moneyDetail.idString = [[[[self.castDic objectForKey:@"Product"] objectForKey:@"Asset"] objectAtIndex:indexPath.row - 1] objectForKey:@"assetId"];
        [self.navigationController pushViewController:moneyDetail animated:YES];
        
    }
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getCastProduct{

    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"productId":self.idString,@"token":[dic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getCastProduct" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        self.castDic = [NSDictionary dictionary];
        self.castDic = responseObject;
        
        [self.mainTV reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
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
