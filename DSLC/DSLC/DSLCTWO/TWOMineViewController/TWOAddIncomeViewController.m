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
}

@property (nonatomic,strong) NSMutableArray *valueArray;
@property (nonatomic,strong) NSMutableArray *colorArray;
@property (nonatomic,strong) MCMPieChartView *pieChartView;

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
    
    self.valueArray = [[NSMutableArray alloc] initWithObjects:
                       [NSNumber numberWithInt:2],
                       [NSNumber numberWithInt:3],
                       [NSNumber numberWithInt:2],
                       [NSNumber numberWithInt:3],
                       nil];
    
    self.colorArray = [NSMutableArray arrayWithObjects:
                       [UIColor colorWithRed:63.0 / 225.0 green:166.0 / 225.0 blue:252.0 / 225.0 alpha:1.0],
                       [UIColor colorWithRed:124.0 / 225.0 green:207.0 / 225.0 blue:253.0 / 225.0 alpha:1.0],
                       [UIColor colorWithRed:93.0 / 225.0 green:203.0 / 225.0 blue:224.0 / 225.0 alpha:1.0],
                       [UIColor colorWithRed:180.0 / 225.0 green:228.0 / 225.0 blue:254.0 / 225.0 alpha:1.0],
                       nil];
    
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
    [self.pieChartView setAmountText:@"0元"];
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
    NSMutableAttributedString *incomeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"230,373.41"]];
    NSRange leftRange = NSMakeRange(0, [[incomeString string] rangeOfString:@"元"].location);
    [incomeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:leftRange];
    [labelIncome setAttributedText:incomeString];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOAddIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *colorArray = @[[UIColor colorWithRed:63.0 / 225.0 green:166.0 / 225.0 blue:252.0 / 225.0 alpha:1.0], [UIColor colorWithRed:124.0 / 225.0 green:207.0 / 225.0 blue:253.0 / 225.0 alpha:1.0], [UIColor colorWithRed:93.0 / 225.0 green:203.0 / 225.0 blue:224.0 / 225.0 alpha:1.0], [UIColor colorWithRed:180.0 / 225.0 green:228.0 / 225.0 blue:254.0 / 225.0 alpha:1.0]];
    cell.viewColor.backgroundColor = [colorArray objectAtIndex:indexPath.row];
    cell.viewColor.layer.cornerRadius = 2;
    cell.viewColor.layer.masksToBounds = YES;
    
    NSArray *kindsArray = @[@"理财收益", @"红包收益", @"加息券收益", @"猴币收益"];
    cell.labelKinds.text = [kindsArray objectAtIndex:indexPath.row];
    cell.labelKinds.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    cell.labelKinds.textColor = [UIColor findZiTiColor];
    
    NSArray *moneyArray = @[@"1000.00元", @"0元", @"0元", @"1000.00元"];
    cell.labelMoney.text = [moneyArray objectAtIndex:indexPath.row];
    cell.labelMoney.textColor = [UIColor zitihui];
    cell.labelMoney.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (NSArray *)percentOfTheCircle{
    return @[@"24", @"35",@"11", @"10", @"20"];
}

- (NSArray *)textStringOfCircle{
    return @[@"IT", @"金融", @"土木工程", @"传统行业", @"其他"];
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
        
        NSLog(@"responseObject = %@",responseObject);
        
        [self loadingWithHidden:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            if ([[responseObject objectForKey:@"Profit"] count] == 0) {
                [self noDateWithHeight:100 view:self.view];
            } else {
                [self tableViewShow];
            }
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
        
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
