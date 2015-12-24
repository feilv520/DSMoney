//
//  TransactionViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/20.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "TransactionViewController.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "CreatView.h"
#import "AppDelegate.h"
#import "TranctionTableViewCell.h"
#import "MSelectionView.h"
#import "MTransactionModel.h"

@interface TransactionViewController () <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
    UIView *selectionView;
    UIView *bView;
    
    NSMutableArray *transactionArr;
    NSDictionary *transactionDic;
    
    NSDictionary *parameter;
    
    NSString *tranBeginDate;
    NSString *tranEndDate;
    
    NSArray *yearArr;
    NSArray *monthArr;
    
    UIPickerView *myPickerView;
    
}
@property (nonatomic, strong) NSMutableArray *transactionArray;
@property (nonatomic, strong) NSMutableArray *transactionName;
@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
    
    self.view.backgroundColor = Color_Gray;
    
    self.transactionArray = [NSMutableArray array];
    self.transactionName = [NSMutableArray array];
    
    yearArr = @[@"2010",@"2011",@"2012",@"2013",@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027",@"2028",@"2029",@"2030",@"2031",@"2032",@"2033",@"2034",@"2035",@"2036",@"2037",@"2038",@"2039",@"2040",@"2041",@"2042",@"2043",@"2044",@"2045"];
    monthArr = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    
    tranBeginDate = @"";
    tranEndDate = @"";
    
    [self getMyTradeList:0];
    
    [self showTableView];
    [self naviagationContentShow];
    [self showSelectionView];
    bView.hidden = YES;
    self.mainTableView.hidden = YES;
}

//导航内容
- (void)naviagationContentShow
{
    [self.navigationItem setTitle:@"交易记录"];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(itemAction:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)itemAction:(UIBarButtonItem *)barButtonItem{
    [self noDataViewWithRemoveToView];
    [myPickerView removeFromSuperview];
    if ([barButtonItem.title isEqualToString:@"收起"]) {
        [UIView animateWithDuration:0.5 animations:^{
            selectionView.frame = CGRectMake(0, -200, WIDTH_CONTROLLER_DEFAULT, 200);
            bView.alpha = 0.0;
        } completion:^(BOOL finished) {
            
        }];
        barButtonItem.title = @"筛选";
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            selectionView.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 200);
            bView.alpha = 0.3;
            
        } completion:^(BOOL finished) {
            
        }];
        barButtonItem.title = @"收起";
    }
    
}

- (void)buttonAction:(UIButton *)btn{
    
    NSInteger number = btn.tag;
    
    if (number == 0 || number == 2 || number == 3 || number == 4 || number == 5 || number == 6) {
        [UIView animateWithDuration:0.5 animations:^{
            selectionView.frame = CGRectMake(0, -200, WIDTH_CONTROLLER_DEFAULT, 200);
            bView.alpha = 0.0;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            selectionView.frame = CGRectMake(0, -200, WIDTH_CONTROLLER_DEFAULT, 200);
        } completion:^(BOOL finished) {
            
        }];
    }
    self.navigationItem.rightBarButtonItem.title = @"筛选";
    NSLog(@"%ld",(long)number);
    switch (number) {
        case 0:
            tranBeginDate = @"";
            tranEndDate = @"";
            [self getMyTradeList:0];
            break;
        case 1:
            [self setPickerView];
            tranBeginDate = @"2015-11-01";
            tranEndDate = @"2015-11-31";
            [myPickerView selectRow:5  inComponent:0 animated:NO];
            [myPickerView selectRow:10  inComponent:1 animated:NO];
            break;
        case 2:
            [self getMyTradeList:1];
            break;
        case 3:
            [self getMyTradeList:5];
            break;
        case 4:
            [self getMyTradeList:3];
            break;
        case 5:
            [self getMyTradeList:2];
            break;
        case 6:
            [self getMyTradeList:4];
            break;
            
        default:
            break;
    }
    
    
}

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [myPickerView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showSelectionView{
    bView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    
    bView.backgroundColor = Color_Black;
    
    bView.alpha = 0.0;
    
    [self.view addSubview:bView];
    
    selectionView = [[UIView alloc] initWithFrame:CGRectMake(0, -200, WIDTH_CONTROLLER_DEFAULT, 200)];
    
    selectionView.backgroundColor = Color_White;
    [self.view addSubview:selectionView];
    
    NSArray *nameArray = @[@"全部",@"时间",@"买入",@"兑付",@"提现",@"充值",@"大额充值"];
    
    CGFloat marginX = WIDTH_CONTROLLER_DEFAULT * (23 / 375.0);
    CGFloat marginY = HEIGHT_CONTROLLER_DEFAULT * (25 / 667.0);
    CGFloat buttonX = WIDTH_CONTROLLER_DEFAULT * (90 / 375.0);
    CGFloat buttonY = HEIGHT_CONTROLLER_DEFAULT * (37 / 667.0);
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        NSBundle *rootBundle = [NSBundle mainBundle];
        MSelectionView *buttonView = [[rootBundle loadNibNamed:@"MSelectionView" owner:nil options:nil] lastObject];
        
        CGFloat bVX = marginX + (i % 3) * (marginX + buttonX);
        CGFloat bVY = marginY + (i / 3) * (marginY + buttonY);
        
        buttonView.frame = CGRectMake(bVX, bVY, buttonX, buttonY);
        
        [buttonView.selectionButton setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
        
        [buttonView.selectionButton setBackgroundImage:[UIImage imageNamed:@"矩形-10"] forState:UIControlStateNormal];
        [buttonView.selectionButton setBackgroundImage:[UIImage imageNamed:@"anniuS"] forState:UIControlStateSelected];
        
        buttonView.selectionButton.tag = i;
        
        [buttonView.selectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [selectionView addSubview:buttonView];
    }
    
}

// 创建PickerView
- (void)setPickerView{
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 217, WIDTH_CONTROLLER_DEFAULT, 200)];
    
//    [self.view addSubview:pickerView];

    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.window addSubview:myPickerView];
    
    myPickerView.backgroundColor = [UIColor whiteColor];
    
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
}

#pragma mark pickerView 的代理方法
#pragma mark --------------------------------

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    // 返回2表明该控件只包含2列
    return 2;
}
// UIPickerViewDataSource中定义的方法，该方法返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    // 如果是第一列，返回yesrArr中元素的个数
    // 即yesrArr包含多少个元素，第一列就包含多少个列表项
    if (component == 0) {
        return yearArr.count;
    }
    // 如果是其他列，返回monthArr中元素的个数。
    // 即monthArr包含多少个元素，其他列（只有第二列）包含多少个列表项
    return monthArr.count;
}
// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为
// UIPickerView中指定列、指定列表项上显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component
{
    // 如果是第一列，返回yesrArr中row索引处的元素
    // 即第一列的列表项标题由yesrArr集合元素决定。
    if (component == 0) {
        return [yearArr objectAtIndex:row];
    }
    // 如果是其他列（只有第二列），返回monthArr中row索引处的元素
    // 即第二列的列表项标题由monthArr集合元素决定。
    return [monthArr objectAtIndex:row];
}
// 当用户选中UIPickerViewDataSource中指定列、指定列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    NSArray* tmp  = component == 0 ? yearArr: monthArr;
//    NSString* tip = component == 0 ? @"年": @"月";
//    // 使用一个UIAlertView来显示用户选中的列表项
//    UIAlertView* alert = [[UIAlertView alloc]
//                          initWithTitle:@"提示"
//                          message:[NSString stringWithFormat:@"你选中的%@是：%@，"
//                                   , tip , [tmp objectAtIndex:row]]
//                          delegate:nil
//                          cancelButtonTitle:@"确定"
//                          otherButtonTitles:nil];
    if (component == 0) {
        tranBeginDate = [tranBeginDate stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:[tmp objectAtIndex:row]];
        tranEndDate = [tranEndDate stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:[tmp objectAtIndex:row]];
    } else {
        tranBeginDate = [tranBeginDate stringByReplacingCharactersInRange:NSMakeRange(5, 2) withString:[tmp objectAtIndex:row]];
        tranEndDate = [tranEndDate stringByReplacingCharactersInRange:NSMakeRange(5, 2) withString:[tmp objectAtIndex:row]];
    }
    
    if (component == 1) {
        [UIView animateWithDuration:0.5 animations:^{
            [myPickerView removeFromSuperview];
            bView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self getMyTradeList:0];
        }];
    }
    
    NSLog(@"%@--%@",tranBeginDate,tranEndDate);
    
//    [alert show];
}
// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为
// UIPickerView中指定列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component
{
    // 如果是第二列，宽度为90
//    if (component == 1) {
        return WIDTH_CONTROLLER_DEFAULT / 2.0;
//    }
    // 如果是其他列（只有第一列），宽度为210
//    return 210;
}

// 创建TableView
- (void)showTableView{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 74) style:UITableViewStylePlain];
    
    self.mainTableView.backgroundColor = Color_Gray;
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"TranctionTableViewCell" bundle:nil] forCellReuseIdentifier:@"tranction"];
    
    [self.view addSubview:self.mainTableView];

}
    
#pragma mark tableview delegate and dataSource
#pragma mark --------------------------------

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *monthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 55)];
    
    monthView.backgroundColor = Color_Gray;
    
    UIView *monthViewOfWhite = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 45)];
    
    UIButton *labelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [labelButton setFrame:CGRectMake(10, -7, 60, 60)];
    
    NSString *monthString = [self.transactionName objectAtIndex:section];
    
    monthString = [monthString substringWithRange:NSMakeRange(5, 2)];
    
    [labelButton setImage:[UIImage imageNamed:monthString] forState:UIControlStateNormal];
    
    NSLog(@"monthString = %@",monthString);
    
    [labelButton setTitle:@" 月" forState:UIControlStateNormal];
    [labelButton.titleLabel setFont:[UIFont fontWithName:@"CenturyGothic" size:14]];
    [labelButton setTitleColor:Color_Red forState:UIControlStateNormal];
    
    labelButton.userInteractionEnabled = NO;
    
    [monthViewOfWhite addSubview:labelButton];
    
    monthViewOfWhite.backgroundColor = Color_White;
    
    [monthView addSubview:monthViewOfWhite];
    
    return monthView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *monthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 55)];
    
    monthView.backgroundColor = Color_Gray;
    
    return monthView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath: (NSIndexPath*)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TranctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tranction"];
    
    cell.userInteractionEnabled = NO;
    
    cell.contentView.layer.masksToBounds = YES;
    cell.contentView.layer.cornerRadius = 8.0;
    
    MTransactionModel *tModel = [[[self.transactionArray objectAtIndex:indexPath.section] objectForKey:[self.transactionName objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];

    cell.dateLabel.text = [tModel tradeTime];
    if ([[tModel tradeStatus] isEqualToString:@"0"]) {
        cell.stateLabel.text = @"失败";
        cell.stateLabel.textColor = [UIColor zitihui];
    } else {
        cell.stateLabel.text = @"成功";
        cell.stateLabel.textColor = [UIColor blueColor];
    }
    cell.typeLabel.text = [tModel tradeTypeName];
    cell.moneyLabel.text = [DES3Util decrypt:[tModel tradeMoney]];
    cell.productName.text = [tModel tradeProductName];
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.transactionName.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[self.transactionArray objectAtIndex:section] objectForKey:[self.transactionName objectAtIndex:section]] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getMyTradeList:(NSInteger)number{
    
    NSLog(@"token = %@",[self.flagDic objectForKey:@"token"]);
    
    if (number == 0 || number == 1) {
        parameter = @{@"curPage":@1,@"token":[self.flagDic objectForKey:@"token"],@"tranBeginDate":tranBeginDate,@"tranEndDate":tranEndDate,@"tranType":@""};
    } else {
        parameter = @{@"curPage":@1,@"token":[self.flagDic objectForKey:@"token"],@"tranBeginDate":@"",@"tranEndDate":@"",@"tranType":[NSNumber numberWithInteger:number]};
    }
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/trade/getMyTradeRecords" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]] || responseObject == nil) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
            [self.navigationController popToRootViewControllerAnimated:NO];
            return ;
        }
        
        NSLog(@"%@",[responseObject objectForKey:@"Trade"]);
        
        if ([[[responseObject objectForKey:@"Trade"] objectAtIndex:0] count] == 0) {
            [self noDateWithView:nil height:120 view:self.view];
            [_mainTableView setHidden:YES];
        } else {
            [self loadingWithHidden:YES];
            [self loadingWithHidden:YES];
            [_mainTableView setHidden:NO];
            for (NSDictionary *dic in [responseObject objectForKey:@"Trade"]) {
                self.transactionName = [[dic allKeys] copy];
            }
            
            for (NSDictionary *dic in [responseObject objectForKey:@"Trade"]) {
                for (NSInteger i = 0; i < self.transactionName.count; i++) {
                    transactionArr = [NSMutableArray array];
                    for (NSDictionary *ddic in [dic objectForKey:[self.transactionName objectAtIndex:i]]) {
                        MTransactionModel *tModel = [[MTransactionModel alloc] init];
                        [tModel setValuesForKeysWithDictionary:ddic];
                        [transactionArr addObject:tModel];
                    }
                    transactionDic = [NSDictionary dictionaryWithObject:transactionArr forKey:[self.transactionName objectAtIndex:i]];
                    [self.transactionArray addObject:transactionDic];
                }
            }
            
            [_mainTableView reloadData];
//        NSLog(@"transactionName = %@",self.transactionName);
//        NSLog(@"transactionArray = %@",self.transactionArray);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
