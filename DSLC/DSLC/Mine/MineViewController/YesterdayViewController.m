//
//  YesterdayViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/11/10.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "YesterdayViewController.h"
#import "ProductMoneyTableViewCell.h"
#import "productMoneyModel.h"

@interface YesterdayViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *productArray;
@property (nonatomic, strong) NSString *totalProfit;

@end

@implementation YesterdayViewController

- (void)viewDidLoad {
    
    self.productArray = [NSMutableArray array];
    
    [super viewDidLoad];
    
    [self getMyProfit];
    
}

- (void)showWithTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = [UIColor huibai];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorColor = [UIColor huibai];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ProductMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:@"productMoney"];
    
    [self.view addSubview:self.tableView];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT - 20, (160 / 687.0) * HEIGHT_CONTROLLER_DEFAULT)];
    
    NSLog(@"%f",HEIGHT_CONTROLLER_DEFAULT);
    
    UIImageView *photoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shouyi"]];
    photoImgView.frame = CGRectMake(10, 10, headerView.frame.size.width, headerView.frame.size.height - 50);
    
    photoImgView.layer.cornerRadius = 4.f;
    photoImgView.layer.masksToBounds = YES;
    
    [headerView addSubview:photoImgView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(photoImgView.frame), photoImgView.frame.size.width, 50)];
    backView.backgroundColor = Color_White;
    
    UILabel *yesterdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 50)];
    yesterdayLabel.text = @"昨日收益";
    yesterdayLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    yesterdayLabel.textAlignment = NSTextAlignmentLeft;
    
    [backView addSubview:yesterdayLabel];
    
    UILabel *yesterdayMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(photoImgView.frame.size.width - 120, 0, 100, 50)];
    
    NSMutableAttributedString *redStringM = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 元",self.totalProfit]];
    NSRange numString = NSMakeRange(0, [[redStringM string] rangeOfString:@"元"].location);
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:numString];
        NSRange oneString = NSMakeRange([[redStringM string] length] - 1, 1);
        [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:oneString];
        
    } else {
        [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:30] range:numString];
        NSRange oneString = NSMakeRange([[redStringM string] length] - 1, 1);
        [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:15] range:oneString];
    }
    [redStringM addAttribute:NSForegroundColorAttributeName value:Color_Red range:numString];
    [yesterdayMoneyLabel setAttributedText:redStringM];
    yesterdayMoneyLabel.textAlignment = NSTextAlignmentRight;
    
    [backView addSubview:yesterdayMoneyLabel];
    
    [headerView addSubview:backView];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productMoney"];
    
    cell.BackView.layer.masksToBounds = YES;
    cell.BackView.layer.cornerRadius = 4.f;
    
    cell.titleLabel.text = [[self.productArray objectAtIndex:indexPath.row] productName];
    cell.moneyLabel.text = [[self.productArray objectAtIndex:indexPath.row] productProfit];
    
    return cell;
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getMyProfit{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getMyProfit" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSArray *array = [responseObject objectForKey:@"Profit"];
        
        for (NSDictionary *dic1 in array) {
            productMoneyModel *productMM = [[productMoneyModel alloc] init];
            [productMM setValuesForKeysWithDictionary:dic1];
            [self.productArray addObject:productMM];
        }

        self.totalProfit = [responseObject objectForKey:@"totalProfit"];
        
        [self showWithTableView];
        
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
