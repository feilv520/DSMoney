//
//  RecordViewController.m
//  DSLC
//
//  Created by ios on 15/11/4.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "TWORecordViewController.h"
#import "RecordCell.h"
#import "ProductBuyRecords.h"
#import "TWOProductRecordTableViewCell.h"

@interface TWORecordViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSInteger page;
    BOOL moreFlag;
    MJRefreshBackGifFooter *gifFooter;
    
    UIView *moreView;
    UIButton *moreButton;
}

@property (nonatomic, strong) NSMutableArray *productListArray;

@end

@implementation TWORecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    
    self.productListArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"投资记录"];
    
    page = 1;
    moreFlag = NO;
    [self getProductBuyRecords];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor colorFromHexCode:@"#F5F6F7"];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOProductRecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
//    [self addTableViewWithFooter:_tableView];
    moreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 60)];
    _tableView.tableFooterView = moreView;

    moreView.backgroundColor = Color_White;
    
    moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 60);
    [moreButton setTitle:@"点击查看更多" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor colorFromHexCode:@"#2493e7"] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [moreView addSubview:moreButton];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TWOProductRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    ProductBuyRecords *buyRecords = [self.productListArray objectAtIndex:indexPath.row];
    
    cell.phoneNumber.text = [buyRecords tranName];
    cell.moneyNumber.text = [NSString stringWithFormat:@"%@元",[buyRecords tranAmount]];
    cell.dateNumber.text = [buyRecords tranTime];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getProductBuyRecords{
    
    NSDictionary *parameter = @{@"productId":self.idString,@"curPage":[NSNumber numberWithInteger:page]};
    
    NSLog(@"%@",parameter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getProductBuyRecords" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        
        NSLog(@"%@",responseObject);
        
        NSArray *array = [responseObject objectForKey:@"Transaction"];
        
        if (array.count == 0) {
            [self noDateWithHeight:100 view:self.view];
            _tableView.hidden = YES;
            return ;
        }
        
        for (NSDictionary *dic in array) {
            ProductBuyRecords *productBR = [[ProductBuyRecords alloc] init];
            [productBR setValuesForKeysWithDictionary:dic];
            [self.productListArray addObject:productBR];
        }
        
        if ([[responseObject objectForKey:@"currPage"] isEqual:[responseObject objectForKey:@"totalPage"]]) {
            moreFlag = YES;
            [moreButton setTitle:@"已显示全部" forState:UIControlStateNormal];
            moreButton.enabled = NO;
        }
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
    
}

- (void)moreAction:(id)sender{
    if (!moreFlag) {
        page ++;
        [self getProductBuyRecords];
    }
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
