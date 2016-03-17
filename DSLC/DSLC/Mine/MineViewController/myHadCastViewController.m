//
//  myHadCastViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/3/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "myHadCastViewController.h"
#import "myHadCastTableViewCell.h"
#import "myHadCastDetailViewController.h"
#import "myCastModel.h"

@interface myHadCastViewController () <UITableViewDelegate, UITableViewDataSource>

{
    UITableView *mainTableView;
    
    NSMutableArray *mainArray;
    
}

@end

@implementation myHadCastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mainArray = [NSMutableArray array];
    
    [self showTableView];
    [self getUserAssetsList];
    
}

- (void)showTableView
{
    if (mainTableView == nil) {
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 45) style:UITableViewStylePlain];
    }
    
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.separatorColor = [UIColor clearColor];
    mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [mainTableView registerNib:[UINib nibWithNibName:@"myHadCastTableViewCell" bundle:nil] forCellReuseIdentifier:@"myHadCTVC"];
    
    [mainTableView setSeparatorColor:[UIColor colorWithRed:246 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1.0]];
    
    [self.view addSubview:mainTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return mainArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    myHadCastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myHadCTVC"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    myCastModel *model = [mainArray objectAtIndex:indexPath.section];
    
    cell.titleLabel.text = model.productName;
    
    cell.moneyLabel.text = [DES3Util decrypt:model.totalProfit];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    myHadCastDetailViewController *myHadCDVC = [[myHadCastDetailViewController alloc] init];
    myHadCDVC.model = [mainArray objectAtIndex:indexPath.section];
    pushVC(myHadCDVC);
}

- (void)getUserAssetsList{
    NSDictionary *parameters = @{@"curPage":@1,@"status":@"3",@"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getUserAssetsList" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSArray *productArray = [responseObject objectForKey:@"Product"];
            
            for (NSDictionary *dic in productArray) {
                myCastModel *model = [[myCastModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [mainArray addObject:model];
            }
            
            [mainTableView reloadData];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"无数据"];
            
        }
        
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