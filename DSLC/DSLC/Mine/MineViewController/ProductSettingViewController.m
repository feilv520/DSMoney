//
//  ProductSettingViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ProductSettingViewController.h"
#import "define.h"
#import "SettingTitleTableViewCell.h"
#import "SettingGetDetailTableViewCell.h"
#import "SettingGetMoneyTableViewCell.h"
#import "SettingPieTableViewCell.h"
#import "XYPieChart.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "CastProduceViewController.h"
#import "MyAccountProductView.h"

@interface ProductSettingViewController () <UITableViewDataSource, UITableViewDelegate, XYPieChartDataSource, XYPieChartDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) XYPieChart *pieChartLeft;
@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;

@property (nonatomic, strong) NSDictionary *moneyDic;

@property (nonatomic, strong) NSMutableArray *nameMArr;

@end

@implementation ProductSettingViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pieChartLeft reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getMyAssetInfo];
    
    self.view.backgroundColor = TabelVie_Color_Gray;
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 84) style:UITableViewStylePlain];
    
    self.mainTableView.backgroundColor = TabelVie_Color_Gray;
    
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SettingTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"title"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SettingPieTableViewCell" bundle:nil] forCellReuseIdentifier:@"pie"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SettingGetDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"getDetail"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"SettingGetMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:@"getMoney"];
    
    self.mainTableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.mainTableView];
    
    self.slices = [NSMutableArray arrayWithCapacity:4];
    
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:0/255.0 green:1 blue:1 alpha:1],nil];
    
    self.pieChartLeft = [[XYPieChart alloc] initWithFrame:CGRectMake((150 / 375.0) * WIDTH_CONTROLLER_DEFAULT , 0, (200 / 375.0) * WIDTH_CONTROLLER_DEFAULT, (200 / 375.0) * WIDTH_CONTROLLER_DEFAULT)];
    
    [self.pieChartLeft setDelegate:self];
    [self.pieChartLeft setDataSource:self];
    [self.pieChartLeft setStartPieAngle:M_PI_2];
    [self.pieChartLeft setAnimationSpeed:1.0];
    [self.pieChartLeft setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:15]];
    [self.pieChartLeft setLabelRadius:50];
    [self.pieChartLeft setShowPercentage:YES];
    [self.pieChartLeft setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.pieChartLeft setPieCenter:CGPointMake(100, 100)];
    [self.pieChartLeft setUserInteractionEnabled:NO];
    [self.pieChartLeft setLabelShadowColor:[UIColor blackColor]];
    
    [self.navigationItem setTitle:@"账户资产"];
    
}

#pragma mark tableView delegate and dataSource
#pragma mark --------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 0.5;
    }
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SettingTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
            
            cell.AllMoney.text = [NSString stringWithFormat:@"%@万元",[self.moneyDic objectForKey:@"totalMoney"]];
            
            return cell;
        } else {
            SettingGetMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"getMoney"];
            
            NSMutableAttributedString *redString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",[self.moneyDic objectForKey:@"yeProfit"]]];
            NSRange redShuZi = NSMakeRange(0, [[redString string] rangeOfString:@"元"].location);
            [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:redShuZi];
            
            NSRange YUANString = NSMakeRange([[redString string] length] - 1, 1);
            [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:YUANString];
            [redString addAttribute:NSForegroundColorAttributeName value:Color_Black range:YUANString];
            [cell.yesterdayLabel setAttributedText:redString];
            cell.yesterdayLabel.textColor = [UIColor daohanglan];
            cell.yesterdayLabel.textAlignment = NSTextAlignmentCenter;
            
            NSMutableAttributedString *wanYuanStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@万元",[self.moneyDic objectForKey:@"totalProfit"]]];
            NSRange shuziStr = NSMakeRange(0, [[wanYuanStr string] rangeOfString:@"万"].location);
            [wanYuanStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:shuziStr];
            NSRange wanZiStr = NSMakeRange([[wanYuanStr string] length] - 2, 2);
            [wanYuanStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:wanZiStr];
            [cell.allDay setAttributedText:wanYuanStr];
            cell.allDay.textAlignment = NSTextAlignmentCenter;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            SettingTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
            cell.AllMoney.hidden = YES;
            
            return cell;
        } else {
            SettingPieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pie"];
            
            NSBundle *rootBundle = [NSBundle mainBundle];
            
            MyAccountProductView *myAccountPView = [[rootBundle loadNibNamed:@"MyAccountProductView" owner:nil options:nil] lastObject];
            
            myAccountPView.frame = CGRectMake(17, 20, 120, 160);
            
            [cell addSubview:myAccountPView];
            
            if ([[self.moneyDic objectForKey:@"Asset"] count] == 1) {
                
                myAccountPView.GSView.hidden = NO;
                myAccountPView.GSLabel.hidden = NO;
                
            } else if ([[self.moneyDic objectForKey:@"Asset"] count] == 2) {
                
                myAccountPView.GSView.hidden = NO;
                myAccountPView.GSLabel.hidden = NO;
                
                myAccountPView.PJView.hidden = NO;
                myAccountPView.PJLabel.hidden = NO;
                
            } else if ([[self.moneyDic objectForKey:@"Asset"] count] == 3) {
                
                myAccountPView.GSView.hidden = NO;
                myAccountPView.GSLabel.hidden = NO;
                
                myAccountPView.PJView.hidden = NO;
                myAccountPView.PJLabel.hidden = NO;
                
                myAccountPView.NewView.hidden = NO;
                myAccountPView.NewLabel.hidden = NO;
                
            } else if ([[self.moneyDic objectForKey:@"Asset"] count] == 4) {
                
                myAccountPView.GSView.hidden = NO;
                myAccountPView.GSLabel.hidden = NO;
                
                myAccountPView.PJView.hidden = NO;
                myAccountPView.PJLabel.hidden = NO;
                
                myAccountPView.NewView.hidden = NO;
                myAccountPView.NewLabel.hidden = NO;
                
                myAccountPView.BDView.hidden = NO;
                myAccountPView.BDLabel.hidden = NO;
                
            }
            
            [cell addSubview:self.pieChartLeft];
            
            return cell;
        }
    } else {
        if (indexPath.row == 0) {
            SettingTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
            cell.AllMoney.hidden = YES;
            return cell;
        } else {
            SettingGetDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"getDetail"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 2;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 45;
        } else {
            return 88;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 45;
        } else {
            return 200;
        }
    } else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 1) {
            
            CastProduceViewController *castPVC = [[CastProduceViewController alloc] init];
            [self.navigationController pushViewController:castPVC animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - XYPieChart Data Source
#pragma mark --------------------------------

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return [[self.moneyDic objectForKey:@"Asset"] count];
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    NSLog(@"%ld",[[self.slices objectAtIndex:index] intValue]);
    return [[self.slices objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
#pragma mark --------------------------------
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %ld",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %ld",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did deselect slice at index %ld",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %ld",(unsigned long)index);
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getMyAssetInfo{
    NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getMyAssetInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        self.moneyDic = [NSDictionary dictionary];
        self.moneyDic = responseObject;
        
//        totalMoney
        
        CGFloat GSNumber = 0.0f;
        CGFloat PJNumber = 0.0f;
        CGFloat NewNumber = 0.0f;
        CGFloat BDNumber = 0.0f;
        
        for(int i = 0; i < [[self.moneyDic objectForKey:@"Asset"] count]; i ++)
        {
            if ([[[[self.moneyDic objectForKey:@"Asset"] objectAtIndex:i] objectForKey:@"productTypeName"] isEqualToString:@"固收理财"]) {
                
                GSNumber += [[[[self.moneyDic objectForKey:@"Asset"] objectAtIndex:i] objectForKey:@"productMoney"] floatValue];

//                NSString *nameString = [NSString stringWithFormat:@"固收理财%f%%",GSNumber / [[self.moneyDic objectForKey:@"totalMoney"] floatValue]];
                
                NSString *nameString = [NSString stringWithFormat:@"固收理财%f%%",GSNumber / 110000.0];
                
                [self.nameMArr addObject:nameString];
                

                
            } else if ([[[[self.moneyDic objectForKey:@"Asset"] objectAtIndex:i] objectForKey:@"productTypeName"] isEqualToString:@"票据投资"]) {
                
                PJNumber += [[[[self.moneyDic objectForKey:@"Asset"] objectAtIndex:i] objectForKey:@"productMoney"] floatValue];
                
                NSString *nameString = [NSString stringWithFormat:@"票据投资%f%%",PJNumber / 110000.0];
                
                [self.nameMArr addObject:nameString];
                
            } else if ([[[[self.moneyDic objectForKey:@"Asset"] objectAtIndex:i] objectForKey:@"productTypeName"] isEqualToString:@"新手专享"]) {
                
                NewNumber += [[[[self.moneyDic objectForKey:@"Asset"] objectAtIndex:i] objectForKey:@"productMoney"] floatValue];
                
                NSString *nameString = [NSString stringWithFormat:@"新手专享%f%%",NewNumber / 110000.0];
                
                [self.nameMArr addObject:nameString];
                
            } else if ([[[[self.moneyDic objectForKey:@"Asset"] objectAtIndex:i] objectForKey:@"productTypeName"] isEqualToString:@"标的"]) {
                
                BDNumber += [[[[self.moneyDic objectForKey:@"Asset"] objectAtIndex:i] objectForKey:@"productMoney"] floatValue];
                
                NSString *nameString = [NSString stringWithFormat:@"标的%f%%",BDNumber / 110000.0];
                
                [self.nameMArr addObject:nameString];
                
            }
            
            
//            NSNumber *one = [NSNumber numberWithInt:rand()%100];
//            [_slices addObject:one];
        }
        
        [self.mainTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

@end
