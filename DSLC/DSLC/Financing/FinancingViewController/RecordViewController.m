//
//  RecordViewController.m
//  DSLC
//
//  Created by ios on 15/11/4.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordCell.h"
#import "ProductBuyRecords.h"

@interface RecordViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
}

@property (nonatomic, strong) NSMutableArray *productListArray;

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.productListArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"投资记录"];
    
    [self getProductBuyRecords];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"RecordCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    ProductBuyRecords *buyRecords = [self.productListArray objectAtIndex:indexPath.row];
    
    NSString *whoString = [NSString stringWithFormat:@"%@**购买了%@",[buyRecords tranName],[buyRecords tranAmount]];
    cell.labelWho.text = whoString;
    cell.labelWho.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelTime.text = [buyRecords tranTime];
    cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    cell.labelTime.textColor = [UIColor zitihui];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getProductBuyRecords{
    
    NSDictionary *parameter = @{@"productId":self.idString,@"curPage":@1};
    
    NSLog(@"%@",parameter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getProductBuyRecords" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        
        NSLog(@"%@",responseObject);
        
        NSArray *array = [responseObject objectForKey:@"Transaction"];
        for (NSDictionary *dic in array) {
            ProductBuyRecords *productBR = [[ProductBuyRecords alloc] init];
            [productBR setValuesForKeysWithDictionary:dic];
            [self.productListArray addObject:productBR];
        }
        
        [self tableViewShow];
        
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
