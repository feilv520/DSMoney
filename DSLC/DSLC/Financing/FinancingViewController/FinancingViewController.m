//
//  FinancingViewController.m
//  DSLC
//
//  Created by ios on 15/10/8.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "FinancingViewController.h"
#import "CreatView.h"
#import "FinancingCell.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "FDetailViewController.h"
#import "ProductListModel.h"

@interface FinancingViewController () <UITableViewDataSource, UITableViewDelegate>

{
    NSArray *buttonArr;
    UIButton *butThree;
    UILabel *lableRedLine;
    NSInteger buttonTag;
    UITableView *_tableView;
    
    NSArray *nameArray;
    UIButton *butLastTime;
}

@property (nonatomic, strong) NSMutableArray *productListArray;

@end

@implementation FinancingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getProductList];
    
    [self loadingWithView:self.view loadingFlag:NO height:120.0];
    
    self.productListArray = [NSMutableArray array];
    
    buttonTag = 101;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    
    self.navigationItem.title = @"票据投资";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

//TableView展示
- (void)showTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 53 - 64 - 20 - 45) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    viewHead.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.tableHeaderView = viewHead;
    
    [_tableView setSeparatorColor:[UIColor colorWithRed:246 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1.0]];
    [_tableView registerNib:[UINib nibWithNibName:@"FinancingCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    nameArray = @[@"小银票001", @"小银票002", @"小银票003", @"小银票004", @"小银票005", @"小银票006", @"小银票007", @"小银票008", @"小银票009", @"小银票010"];
    
    [self addTableViewWithHeader:_tableView];
    [self addTableViewWithFooter:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FinancingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.viewGiPian.layer.cornerRadius = 4;
    cell.viewGiPian.layer.masksToBounds = YES;
    
    cell.labelMonth.text = [[self.productListArray objectAtIndex:indexPath.row] productName];
    cell.labelMonth.font = [UIFont systemFontOfSize:15];
    
    cell.viewLine.alpha = 0.7;
    cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    cell.labelPercentage.textColor = [UIColor blackColor];
    cell.labelPercentage.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%",[[self.productListArray objectAtIndex:indexPath.row] productAnnualYield]]];
//    ,号前面是指起始位置 ,号后面是指到%这个位置截止的总长度
    NSRange redRange = NSMakeRange(0, [[textString string] rangeOfString:@"%"].location);
    [textString addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:redRange];
    [textString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:redRange];
//    此句意思是指起始位置 是8.02%这个字符串的总长度减掉1 就是指起始位置是% 长度只有1
    NSRange symbol = NSMakeRange([[textString string] length] - 1, 1);
    [textString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:symbol];
    [cell.labelPercentage setAttributedText:textString];
    
    cell.labelYear.text = @"年化收益率";
    cell.labelYear.textColor = [UIColor zitihui];
    cell.labelYear.textAlignment = NSTextAlignmentCenter;
    cell.labelYear.font = [UIFont systemFontOfSize:12];
    
    cell.labelDayNum.textAlignment = NSTextAlignmentCenter;
    cell.labelDayNum.font = [UIFont systemFontOfSize:22];
    
    NSMutableAttributedString *textYear = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天",[[self.productListArray objectAtIndex:indexPath.row] productPeriod]]];
    NSRange numText = NSMakeRange(0, [[textYear string] rangeOfString:@"天"].location);
    [textYear addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:numText];
    NSRange dayText = NSMakeRange([[textYear string] length] - 1, 1);
    [textYear addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:dayText];
    [cell.labelDayNum setAttributedText:textYear];
    
    cell.labelMoney.textAlignment = NSTextAlignmentCenter;
    cell.labelMoney.font = [UIFont systemFontOfSize:22];
    
    NSMutableAttributedString *moneyText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",[[self.productListArray objectAtIndex:indexPath.row] productAmountMin]]];
    NSRange moneyNum = NSMakeRange(0, [[moneyText string] rangeOfString:@"元"].location);
    [moneyText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:moneyNum];
    NSRange yuanStr = NSMakeRange([[moneyText string] length] - 1, 1);
    [moneyText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:yuanStr];
    [cell.labelMoney setAttributedText:moneyText];
    
    cell.labelData.text = @"理财期限";
    cell.labelData.textAlignment = NSTextAlignmentCenter;
    cell.labelData.textColor = [UIColor zitihui];
    cell.labelData.font = [UIFont systemFontOfSize:12];
    
    cell.labelQiTou.text = @"起投资金";
    cell.labelQiTou.textAlignment = NSTextAlignmentCenter;
    cell.labelQiTou.textColor = [UIColor zitihui];
    cell.labelQiTou.font = [UIFont systemFontOfSize:12];
    
    cell.labelSurplus.text = [NSString stringWithFormat:@"%@%@", @"剩余总额:", [NSString stringWithFormat:@"%@万元",[[self.productListArray objectAtIndex:indexPath.row] residueMoney]]];
    cell.labelSurplus.textAlignment = NSTextAlignmentCenter;
    cell.labelSurplus.textColor = [UIColor zitihui];
    cell.labelSurplus.font = [UIFont systemFontOfSize:12];
    cell.labelSurplus.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row == 0) {
        
        cell.progressView.hidden = YES;
        
        butLastTime = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(131, 9, 210, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@" 倒计时 12:12:65"];
        [cell.viewBottom addSubview:butLastTime];
        butLastTime.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        butLastTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [butLastTime setImage:[UIImage imageNamed:@"61-拷贝"] forState:UIControlStateNormal];
        
    } else {
        
        //    设置进度条的进度值 并动画展示
        [cell.progressView setProgress:0.7 animated:YES];
        //    设置进度条的颜色
        cell.progressView.trackTintColor = [UIColor progressBackColor];
        //    设置进度条的进度颜色
        cell.progressView.progressTintColor = [UIColor progressColor];
        
    }
    
    cell.viewBottom.backgroundColor = [UIColor qianhuise];
    
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FDetailViewController *fdetailVC = [[FDetailViewController alloc] init];
    fdetailVC.estimate = YES;
    fdetailVC.idString = [[self.productListArray objectAtIndex:indexPath.row] productId];
    [self.navigationController pushViewController:fdetailVC animated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getProductList{
    
    NSDictionary *parameter = @{@"productType":@2,@"curPage":@1};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getProductList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        
        NSLog(@"%@",responseObject);
        
        NSArray *array = [responseObject objectForKey:@"Product"];
        for (NSDictionary *dic in array) {
            ProductListModel *productM = [[ProductListModel alloc] init];
            [productM setValuesForKeysWithDictionary:dic];
            [self.productListArray addObject:productM];
        }
        
        [self showTableView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
    
}

//- (void)loadNewData:(MJRefreshGifHeader *)header{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{        // 刷新表格
//        [_tableView reloadData];                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//        [header setState:MJRefreshStateIdle];
//    });
//}
//
//- (void)loadMoreData:(MJRefreshBackGifFooter *)footer{
//    //    / 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [_tableView reloadData];
//        
//        // 拿到当前的上拉刷新控件，结束刷新状态
//        [_tableView.mj_footer endRefreshing];
//    });
//}

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
