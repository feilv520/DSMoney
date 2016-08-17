//
//  TWOAddIncomeViewController.m
//  DSLC
//
//  Created by ios on 16/5/9.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOAddIncomeViewController.h"
#import "TWOAddIncomeCell.h"
#import "MCMPieChartView.h"
#import "LYCircleView.h"

@interface TWOAddIncomeViewController () <UITableViewDataSource, UITableViewDelegate, PieChartDelegate, LYCircleViewDataSource>

{
    UITableView *_tableView;
    LYCircleView *circle;
    
    NSMutableArray *kindsArray;
}

@property (nonatomic, strong) NSMutableArray *profitArray;

@property (nonatomic, strong) NSMutableArray *valueArray;
@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, strong) MCMPieChartView *pieChartView;

@property (nonatomic, strong) NSString *totalMoneyString;

@end

@implementation TWOAddIncomeViewController

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
    [self.navigationItem setTitle:@"累计收益"];
    
    self.valueArray = [NSMutableArray arrayWithObjects:@"0.00",@"0.00",@"0.00",@"0.00",@"0.00",nil];
    
    self.profitArray = [NSMutableArray array];
    
    kindsArray = [NSMutableArray arrayWithArray:@[@"可用余额", @"在投资金", @"未结算预期收益", @"提现中",@"体现中",@"其他"]];
    
    self.colorArray = [NSMutableArray array];
    
    [self loadingWithView:self.view loadingFlag:NO height:(HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53)/2.0 - 50];
    
    [self getMyProfitFuction];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.pieChartView reloadChart];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 358.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 30)];
    _tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
    UIView *viewline = [CreatView creatViewWithFrame:CGRectMake(0, _tableView.tableFooterView.frame.size.height - 0.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    viewline.alpha = 0.3;
    [_tableView.tableFooterView addSubview:viewline];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOAddIncomeCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self tableViewHeadShow];
}

- (void)noAddMoneyDataShow
{
    UIImageView *imageMonkey = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, 78, 260/2, 284/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"累计收益无数据"]];
    [self.view addSubview:imageMonkey];
}

- (void)tableViewHeadShow
{
    UIView *viewUp = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 286.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor whiteColor]];
    [_tableView.tableHeaderView addSubview:viewUp];
    
    //add shadow img
    CGRect pieFrame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - 258.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) * 0.5, 10, 258.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 258.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    
    //    UIImage *shadowImg = [UIImage imageNamed:@"shadow.png"];
    //    UIImageView *shadowImgView = [[UIImageView alloc]initWithImage:shadowImg];
    //    shadowImgView.frame = CGRectMake(0, pieFrame.origin.y + PIE_HEIGHT*0.92, shadowImg.size.width/2, shadowImg.size.height/2);
    //    [viewUp addSubview:shadowImgView];
    
    self.pieChartView = [[MCMPieChartView alloc]initWithFrame:pieFrame withValue:self.valueArray withColor:self.colorArray];
    self.pieChartView.delegate = self;
    [viewUp addSubview:self.pieChartView];
    [self.pieChartView setTitleText:@"在投资金"];
    [self.pieChartView setAmountText:@"----"];
    self.pieChartView.centerView.hidden = YES;
    
    UIView *viewUpLine = [CreatView creatViewWithFrame:CGRectMake(0, viewUp.frame.size.height - 0.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [viewUp addSubview:viewUpLine];
    viewUpLine.alpha = 0.3;
    
    UIView *viewGray = [CreatView creatViewWithFrame:CGRectMake(0, viewUp.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 12.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor qianhuise]];
    [_tableView.tableHeaderView addSubview:viewGray];
    
    UIView *viewDown = [CreatView creatViewWithFrame:CGRectMake(0, viewUp.frame.size.height + viewGray.frame.size.height, WIDTH_CONTROLLER_DEFAULT, _tableView.tableHeaderView.frame.size.height - viewUp.frame.size.height - 12.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor whiteColor]];
    [_tableView.tableHeaderView addSubview:viewDown];
    
    UIView *viewDown1 = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [viewDown addSubview:viewDown1];
    viewDown1.alpha = 0.3;
    
    UILabel *labelAdd = [CreatView creatWithLabelFrame:CGRectMake(20, viewDown.frame.size.height/2 - 10, 70, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:@"累计收益"];
    [viewDown addSubview:labelAdd];
    
    UILabel *labelIncome = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 18 - (WIDTH_CONTROLLER_DEFAULT - 20 - 70 - 16 - 10), viewDown.frame.size.height/2 - 12, WIDTH_CONTROLLER_DEFAULT - 20 - 70 - 16 - 10, 24) backgroundColor:[UIColor whiteColor] textColor:[UIColor colorWithRed:253.0 / 225.0 green:135.0 / 225.0 blue:74.0 / 225.0 alpha:1.0] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:nil];
    [viewDown addSubview:labelIncome];
    NSMutableAttributedString *incomeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", self.totalMoneyString]];
    NSRange leftRange = NSMakeRange(0, [[incomeString string] rangeOfString:@"元"].location);
    [incomeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:leftRange];
    [labelIncome setAttributedText:incomeString];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.valueArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOAddIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.viewColor.backgroundColor = [self.colorArray objectAtIndex:indexPath.row];
    cell.viewColor.layer.cornerRadius = 2;
    cell.viewColor.layer.masksToBounds = YES;
    
    cell.labelKinds.text = [kindsArray objectAtIndex:indexPath.row];
    cell.labelKinds.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    cell.labelKinds.textColor = [UIColor findZiTiColor];
    
    cell.labelMoney.text = [NSString stringWithFormat:@"%@元",[self.valueArray objectAtIndex:indexPath.row]];
    cell.labelMoney.textColor = [UIColor zitihui];
    cell.labelMoney.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (void)selectedFinish:(MCMPieChartView *)pieChartView index:(NSInteger)index percent:(float)per
{
    NSLog(@"123");
}

#pragma mark 累计收益
#pragma mark --------------------------------

- (void)getMyProfitFuction{
    
    NSDictionary *parmeter = @{@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/getMyProfit" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        
        NSLog(@"responseObject = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            NSArray *colorArray = @[[UIColor colorFromHexCode:@"046bc4"], [UIColor colorFromHexCode:@"0283de"], [UIColor colorFromHexCode:@"0ca5f0"],[UIColor colorFromHexCode:@"35a3ff"],[UIColor colorFromHexCode:@"30cdf6"],[UIColor colorFromHexCode:@"16b6cc"],[UIColor colorFromHexCode:@"3399cc"],[UIColor colorFromHexCode:@"79c6fc"],[UIColor colorFromHexCode:@"b4e4ff"],[UIColor colorFromHexCode:@"dbe5eb"]];
            
            self.profitArray = [responseObject objectForKey:@"Profit"];
            
            for (NSInteger i = 0; i < self.profitArray.count ; i++) {
                [self.valueArray replaceObjectAtIndex:i withObject:[[DES3Util decrypt:[[self.profitArray objectAtIndex:i] objectForKey:@"profitMoney"]] stringByReplacingOccurrencesOfString:@"," withString:@""]];
                [kindsArray replaceObjectAtIndex:i withObject:[[self.profitArray objectAtIndex:i] objectForKey:@"profitName"]];
                [self.colorArray addObject:[colorArray objectAtIndex:i]];
            }
            
            self.totalMoneyString = [DES3Util decrypt:[responseObject objectForKey:@"totalProfit"]];
            
            if ([[responseObject objectForKey:@"Profit"] count] == 0 || [[DES3Util decrypt:[responseObject objectForKey:@"totalProfit"]] isEqualToString:@"0.00"]) {
                [self noAddMoneyDataShow];
            } else {
                [self tableViewShow];
            }
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self.pieChartView reloadChart];
        });
        
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
