//
//  TWOUsableAllMoneyViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/5/20.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOUsableAllMoneyViewController.h"
#import "MSelectionView.h"
#import "TWOMonkeyRecordCell.h"
#import "TWOMyAccountListModel.h"

@interface TWOUsableAllMoneyViewController () <UITableViewDataSource, UITableViewDelegate> {
    UIButton *bView;
    UIView *selectionView;
    
    NSInteger page;
    
    NSMutableArray *listArray;
    
    UIButton *butMore;
    BOOL moreFlag;
    
    NSString *typeString;
    NSString *tempTypeString;
}

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation TWOUsableAllMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:@"账单"];
    
    self.view.backgroundColor = Color_White;
    
    page = 1;
    
    moreFlag = NO;
    
    listArray = [NSMutableArray array];
    
    typeString = @"";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(selectDataBarPress:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:13], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self getMyTradeRecordsFuction];
    
    [self showTableView];
    
}

// 创建TableView
- (void)showTableView{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 84) style:UITableViewStylePlain];
    
    self.mainTableView.backgroundColor = Color_Gray;
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"TWOMonkeyRecordCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 45)];
    [self tableViewFootView];
    
    [self.view addSubview:self.mainTableView];
}

- (void)tableViewFootView
{
    UIView *viewLineDown = [CreatView creatViewWithFrame:CGRectMake(0, 45.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [self.mainTableView.tableFooterView addSubview:viewLineDown];
    viewLineDown.alpha = 0.3;
    
    butMore = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.mainTableView.tableFooterView.frame.size.height - 0.5) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"点击查看更多"];
    [self.mainTableView.tableFooterView addSubview:butMore];
    butMore.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butMore addTarget:self action:@selector(buttonCheckMore:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectDataBarPress:(UIBarButtonItem *)bar
{
    
    if (bView == nil) {
        
        bView = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 84) backgroundColor:Color_Black textColor:nil titleText:nil];
        
        bView.alpha = 0.3;
        
        [bView addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:bView];
    } else {
        [bView setHidden:NO];
    }
    
    [self showSelectionView];
    
    [UIView animateWithDuration:0.5 animations:^{
        selectionView.hidden = NO;
        selectionView.frame = CGRectMake(0, 0, WIDTH_CVIEW_DEFAULT, (125 / 667.0) * HEIGHT_CONTROLLER_DEFAULT);
        bView.alpha = 0.3;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)showSelectionView{
    
    if (selectionView == nil) {
        selectionView = [[UIView alloc] initWithFrame:CGRectMake(0, -125, WIDTH_CONTROLLER_DEFAULT, (125 / 667.0) * HEIGHT_CONTROLLER_DEFAULT)];
        
        selectionView.backgroundColor = Color_White;
        [self.view addSubview:selectionView];
        
        NSArray *nameArray = @[@"全部",@"充值",@"提现",@"投资",@"兑付",@"加息"];
        
        CGFloat marginX = WIDTH_CVIEW_DEFAULT * (23 / 375.0);
        CGFloat marginY = HEIGHT_CVIEW_DEFAULT * (25 / 667.0);
        
        if (WIDTH_CONTROLLER_DEFAULT == 414.0){
            marginX = WIDTH_CVIEW_DEFAULT * (36 / 375.0);
            marginY = HEIGHT_CVIEW_DEFAULT * (25 / 667.0);
        }
        CGFloat buttonX = WIDTH_CVIEW_DEFAULT * (90 / 375.0);
        CGFloat buttonY = HEIGHT_CVIEW_DEFAULT * (34 / 667.0);
        
        for (NSInteger i = 0; i < nameArray.count; i++) {
            NSBundle *rootBundle = [NSBundle mainBundle];
            MSelectionView *buttonView = [[rootBundle loadNibNamed:@"MSelectionView" owner:nil options:nil] lastObject];
            
            CGFloat bVX = marginX + (i % 3) * (marginX + buttonX);
            CGFloat bVY = marginY + (i / 3) * (marginY + buttonY);
            
            buttonView.frame = CGRectMake(bVX, bVY, buttonX, buttonY);
            
            [buttonView.selectionButton setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
            
            buttonView.selectionButton.layer.masksToBounds = YES;
            buttonView.selectionButton.layer.cornerRadius = 4.0f;
            buttonView.selectionButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            buttonView.selectionButton.layer.borderWidth = 1.0;
            
            [buttonView.selectionButton setBackgroundImage:[UIImage imageNamed:@"productSureButton"] forState:UIControlStateHighlighted];
            
            buttonView.selectionButton.tag = i;
            
            [buttonView.selectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [selectionView addSubview:buttonView];
        }
    }
    
}

- (void)buttonAction:(id)sender{
    UIButton *button = (UIButton *)sender;
    NSLog(@"button = %ld",(long)button.tag);
    
    page = 1;
    
    [UIView animateWithDuration:0.5 animations:^{
        selectionView.frame = CGRectMake(0, -150, WIDTH_CVIEW_DEFAULT, 150);
        
        if (button.tag == 0) {
            typeString = @"";
        } else {
            typeString = [NSString stringWithFormat:@"%ld",(long)button.tag + 1];
            if (button.tag == 3) {
                typeString = @"1";
            } else if (button.tag == 4) {
                typeString = @"5";
            } else if (button.tag == 5) {
                typeString = @"7";
            }
        }
    } completion:^(BOOL finished) {
        [bView setHidden:YES];
        [self getMyTradeRecordsFuction];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWOMonkeyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    TWOMyAccountListModel *myAccountListModel = [listArray objectAtIndex:indexPath.row];
    
    cell.labelTitle.text = [myAccountListModel tradeTypeName];
    cell.labelTime.text = [myAccountListModel tradeTime];
    cell.labelNumber.text = [NSString stringWithFormat:@"%@%@",[myAccountListModel mark], [DES3Util decrypt:[myAccountListModel tradeMoney]]];
    
    cell.labelMiddle.hidden = YES;
    
    if ([[myAccountListModel mark] isEqualToString:@"+"]) {
        cell.labelNumber.textColor = [UIColor profitColor];
    } else {
        cell.labelNumber.textColor = [UIColor orangecolor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//关闭按钮
- (void)closeButton:(UIButton *)but{
    
    [UIView animateWithDuration:0.5 animations:^{
        selectionView.frame = CGRectMake(0, -150, WIDTH_CVIEW_DEFAULT, 150);
        
    } completion:^(BOOL finished) {
        [bView setHidden:YES];
    }];
}

//点击查看更多
- (void)buttonCheckMore:(UIButton *)button
{
    if (!moreFlag) {
        page ++;
        [self getMyTradeRecordsFuction];
    }
}

- (void)noDataShowMyList
{
    UIImageView *imageMonkey = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 260/2/2, 78, 260/2, 260/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [self.view addSubview:imageMonkey];
}

#pragma mark 我的账单
#pragma mark --------------------------------

- (void)getMyTradeRecordsFuction{
    
    NSDictionary *parameters = @{@"curPage":[NSNumber numberWithInteger:page],@"pageSize":@"10",@"tranType":typeString,@"tranBeginDate":@"",@"tranEndDate":@"",@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/getMyTradeRecords" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
       
        [self noDataViewWithRemoveToView];
        
        NSLog(@"getMyTradeRecords = %@",responseObject);
        
        NSMutableArray *dataArr = [responseObject objectForKey:@"Trade"];
        
        if (dataArr.count == 0) {
            [self noDataShowMyList];
            [self.mainTableView setHidden:YES];
        } else {
            [self.mainTableView setHidden:NO];
        }
        
        if (![tempTypeString isEqualToString:typeString]) {
            
            [listArray removeAllObjects];
            listArray = nil;
            listArray = [NSMutableArray array];
        }
            
        for (NSDictionary *dataDic in dataArr) {
            TWOMyAccountListModel *myAccountListModel = [[TWOMyAccountListModel alloc] init];
            [myAccountListModel setValuesForKeysWithDictionary:dataDic];
            [listArray addObject:myAccountListModel];
        }
        
        if ([[responseObject objectForKey:@"currPage"] isEqual:[responseObject objectForKey:@"totalPage"]]) {
            moreFlag = YES;
            [butMore setTitle:@"已显示全部" forState:UIControlStateNormal];
            [butMore setTitleColor:[UIColor findZiTiColor] forState:UIControlStateNormal];
            butMore.enabled = NO;
        }
        
        [self.mainTableView reloadData];
        
        tempTypeString = typeString;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
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
