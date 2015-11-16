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

@interface TransactionViewController () <UITableViewDataSource, UITableViewDelegate>{
    UIView *selectionView;
    UIView *bView;
}

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray;
    
    [self getMyTradeList];
    
    [self showTableView];
    [self naviagationContentShow];
    [self showSelectionView];
    
}

//导航内容
- (void)naviagationContentShow
{
    [self.navigationItem setTitle:@"交易记录"];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(itemAction:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)itemAction:(UIBarButtonItem *)barButtonItem{
    
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
            bView.alpha = 0.7;
        } completion:^(BOOL finished) {
            
        }];
        barButtonItem.title = @"收起";
    }
    
}

- (void)buttonAction:(UIButton *)btn{
    
}

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
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
        
        [buttonView.selectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [selectionView addSubview:buttonView];
    }
    
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
    if (section == 0) {
        [labelButton setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
    } else {
        [labelButton setImage:[UIImage imageNamed:@"8"] forState:UIControlStateNormal];
    }
    
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
    
    cell.contentView.layer.masksToBounds = YES;
    cell.contentView.layer.cornerRadius = 8.0;
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    } else {
        return 2;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getMyTradeList{
    
    NSLog(@"token = %@",[self.flagDic objectForKey:@"token"]);
    
    NSDictionary *parameter = @{@"curPage":@1,@"token":[self.flagDic objectForKey:@"token"],@"tranBeginDate":@"2015-10-01",@"tranEndDate":@"2015-10-31",@"tranType":@""};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getMyTradeList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
