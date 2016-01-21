//
//  NewbieViewController.m
//  DSLC
//
//  Created by ios on 15/10/28.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "NewbieViewController.h"
#import "define.h"
#import "FinancingCell.h"
#import "NewBieCell.h"
#import "FDetailViewController.h"
#import "ProductListModel.h"

@interface NewbieViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    UIImageView *imageView;
    UIButton *butLastTime;
    
    NSInteger page;
    
    BOOL moreFlag;
    BOOL newFlag;
    
    MJRefreshGifHeader *headerT;
    MJRefreshBackGifFooter *footerT;
}

@property (nonatomic, strong) NSMutableArray *productListArray;

@end


@implementation NewbieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    page = 1;
    
    moreFlag = NO;
    
    newFlag = NO;
    
    self.productListArray = [NSMutableArray array];
    
    [self getProductList];
    
    [self tableViewShow];
    
    [self loadingWithView:self.view loadingFlag:NO height:120.0];
    
    self.view.backgroundColor = [UIColor huibai];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refrush) name:@"refrushToProductList" object:nil];
    
}

- (void)refrush {
    
    [self getProductList];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53 - 45) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.tableHeaderView.backgroundColor = [UIColor huibai];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"FinancingCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"NewBieCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    
    [self addTableViewWithHeader:_tableView];
    [self addTableViewWithFooter:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self.productListArray objectAtIndex:0] productType] isEqualToString:@"3"]) {
        if (indexPath.row == 0) {
        
            return 209;
        
        } else {
            return 145;
        }
    } else {
        
        return 145;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self.productListArray objectAtIndex:0] productType] isEqualToString:@"3"]) {
        if (indexPath.row == 0) {
            
            NewBieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
            
            cell.viewBottom.backgroundColor = [UIColor whiteColor];
            cell.viewBottom.layer.cornerRadius = 3;
            cell.viewBottom.layer.masksToBounds = YES;
            
            cell.imageLeftUp.image = [UIImage imageNamed:@"iconfont-zhuanxiangeps"];
            
            cell.labelShouYiLv.text = @"预期年化收益率";
            cell.labelShouYiLv.font = [UIFont fontWithName:@"CenturyGothic" size:13];
            
            NSMutableAttributedString *redString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%",[[self.productListArray objectAtIndex:indexPath.row] productAnnualYield]]];
            NSRange leftRange = NSMakeRange(0, [[redString string] rangeOfString:@"%"].location);
            [redString addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:leftRange];
            [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:40] range:leftRange];
            
            NSRange rightRange = NSMakeRange([[redString string] length] - 1, 1);
            [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:rightRange];
            [cell.labelPercent setAttributedText:redString];
            cell.labelPercent.textAlignment = NSTextAlignmentCenter;
            
            cell.viewLine.backgroundColor = [UIColor grayColor];
            cell.viewLine.alpha = 0.2;
            
            [cell.buttonImage setImage:[UIImage imageNamed:@"iconfont-liwu"] forState:UIControlStateNormal];
            [cell.buttonImage setTitle:@" 新手专享" forState:UIControlStateNormal];
            [cell.buttonImage setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
            cell.buttonImage.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            
            NSString *residueString = [[self.productListArray objectAtIndex:indexPath.row] residueMoney];
            
            NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天",[[self.productListArray objectAtIndex:indexPath.row] productPeriod]]];
            NSRange redRange = NSMakeRange(0, [[textString string] rangeOfString:@"天"].location);
            [textString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:[self sizeOfLength:residueString]] range:redRange];
            NSRange symbol = NSMakeRange([[textString string] length] - 1, 1);
            [textString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:symbol];
            [cell.labelLeftUp setAttributedText:textString];
            
            NSMutableAttributedString *midString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",[[self.productListArray objectAtIndex:indexPath.row] residueMoney]]];
            NSRange midRange = NSMakeRange(0, [[midString string] rangeOfString:@"元"].location);
            [midString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:[self sizeOfLength:residueString]] range:midRange];
            NSRange rightStr = NSMakeRange([[midString string] length] - 1, 1);
            [midString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:rightStr];
            [cell.labelMidUp setAttributedText:midString];
            
            NSMutableAttributedString *rightString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",[[self.productListArray objectAtIndex:indexPath.row] productAmountMin]]];
            NSRange threeRange = NSMakeRange(0, [[rightString string] rangeOfString:@"元"].location);
            [rightString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:[self sizeOfLength:residueString]] range:threeRange];
            NSRange three = NSMakeRange([[rightString string] length] - 1, 1);
            [rightString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:three];
            [cell.labelRightUp setAttributedText:rightString];
            
            cell.labelLeftRight.text = @"理财期限";
            cell.labelLeftRight.textColor = [UIColor zitihui];
            cell.labelLeftRight.font = [UIFont systemFontOfSize:12];
            
            cell.labelMidDOwn.text = @"剩余总额";
            cell.labelMidDOwn.textColor = [UIColor zitihui];
            cell.labelMidDOwn.font = [UIFont systemFontOfSize:12];
            
            cell.labelDownRight.text = @"起投资金";
            cell.labelDownRight.textColor = [UIColor zitihui];
            cell.labelDownRight.font = [UIFont systemFontOfSize:12];
            
            cell.backgroundColor = [UIColor huibai];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            
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
            
            CGFloat money = [[[self.productListArray objectAtIndex:indexPath.row] residueMoney] floatValue];
            
            cell.labelSurplus.text = [NSString stringWithFormat:@"%@%@", @"剩余总额:", [NSString stringWithFormat:@"%.2lf万",money / 10000.0]];
            cell.labelSurplus.textAlignment = NSTextAlignmentCenter;
            cell.labelSurplus.textColor = [UIColor zitihui];
            cell.labelSurplus.font = [UIFont systemFontOfSize:10];
            cell.labelSurplus.backgroundColor = [UIColor clearColor];
            
            //        imageView = [CreatView creatImageViewWithFrame:CGRectMake(131, 15, 210, 8) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"bar-full"]];
            //        cell.progressView.hidden = YES;
            //        [cell.viewBottom addSubview:imageView];
            cell.viewBottom.backgroundColor = [UIColor qianhuise];
            
            if ([[[self.productListArray objectAtIndex:indexPath.row] residueMoney] isEqualToString:@"0.00"]) {
                
                cell.outPay.hidden = NO;
                cell.labelQiTou.hidden = YES;
                cell.labelMoney.hidden = YES;
                
            } else {
            
                cell.outPay.hidden = YES;
                cell.labelQiTou.hidden = NO;
                cell.labelMoney.hidden = NO;
                
            }
            //    设置进度条的进度值 并动画展示
            CGFloat bL = [[[self.productListArray objectAtIndex:indexPath.row] residueMoney] floatValue] / [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue];
            
            CGFloat bLL = 1.0 - bL;
            
            [cell.progressView setProgress:bLL animated:YES];
            //    设置进度条的颜色
            cell.progressView.trackTintColor = [UIColor progressBackColor];
            //    设置进度条的进度颜色
            cell.progressView.progressTintColor = [UIColor progressColor];
        
            cell.backgroundColor = [UIColor huibai];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else {
        
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
        
        CGFloat money = [[[self.productListArray objectAtIndex:indexPath.row] residueMoney] floatValue];
        
        cell.labelSurplus.text = [NSString stringWithFormat:@"%@%@", @"剩余总额:", [NSString stringWithFormat:@"%.2lf万",money / 10000.0]];
        cell.labelSurplus.textAlignment = NSTextAlignmentCenter;
        cell.labelSurplus.textColor = [UIColor zitihui];
        cell.labelSurplus.font = [UIFont systemFontOfSize:12];
        cell.labelSurplus.backgroundColor = [UIColor clearColor];
        
        //        imageView = [CreatView creatImageViewWithFrame:CGRectMake(131, 15, 210, 8) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"bar-full"]];
        //        cell.progressView.hidden = YES;
        //        [cell.viewBottom addSubview:imageView];
        cell.viewBottom.backgroundColor = [UIColor qianhuise];
        
        if ([[[self.productListArray objectAtIndex:indexPath.row] residueMoney] isEqualToString:@"0.00"]) {
            
            cell.outPay.hidden = NO;
            cell.labelQiTou.hidden = YES;
            cell.labelMoney.hidden = YES;
            
        } else {
            
            cell.outPay.hidden = YES;
            cell.labelQiTou.hidden = NO;
            cell.labelMoney.hidden = NO;
            
        }
        //    设置进度条的进度值 并动画展示
        CGFloat bL = [[[self.productListArray objectAtIndex:indexPath.row] residueMoney] floatValue] / [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue];
        
        CGFloat bLL = 1.0 - bL;
        
        [cell.progressView setProgress:bLL animated:YES];
        //    设置进度条的颜色
        cell.progressView.trackTintColor = [UIColor progressBackColor];
        //    设置进度条的进度颜色
        cell.progressView.progressTintColor = [UIColor progressColor];
    
        cell.backgroundColor = [UIColor huibai];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FDetailViewController *detailVC = [[FDetailViewController alloc] init];
    if ([[[self.productListArray objectAtIndex:0] productType] isEqualToString:@"3"]) {
        if (indexPath.row == 0) {
            detailVC.estimate = NO;
        } else {
            detailVC.estimate = YES;
        }
    } else {
        detailVC.estimate = YES;
    }
    detailVC.idString = [[self.productListArray objectAtIndex:indexPath.row] productId];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getProductList{
    
    NSDictionary *parameter = @{@"productType":@3,@"curPage":[NSNumber numberWithInteger:page]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getProductList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
            [self loadingWithHidden:YES];
            
            NSLog(@"%@",responseObject);
            
            if (page == 1) {
                NSLog(@"123");
                [self.productListArray removeAllObjects];
                self.productListArray = nil;
                self.productListArray = [NSMutableArray array];
            }
            
            NSArray *array = [responseObject objectForKey:@"Product"];
            
            for (NSDictionary *dic in array) {
                ProductListModel *productM = [[ProductListModel alloc] init];
                [productM setValuesForKeysWithDictionary:dic];
                [self.productListArray addObject:productM];
            }
            
            if ([[[self.productListArray objectAtIndex:0] productType] isEqualToString:@"3"]) {
                if (![FileOfManage ExistOfFile:@"NewProduct.plist"]) {
                    [FileOfManage createWithFile:@"NewProduct.plist"];
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[array objectAtIndex:0] objectForKey:@"productId"],@"NewProduct",@"0",@"dealSecret",nil];
                    //设置属性值,没有的数据就新建，已有的数据就修改。
                    [dic writeToFile:[FileOfManage PathOfFile:@"NewProduct.plist"] atomically:YES];
                } else {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:[FileOfManage PathOfFile:@"NewProduct.plist"]];
                    //设置属性值,没有的数据就新建，已有的数据就修改。
#warning asdasdasdasdasdasdasdasdasdasd
                    [dic setObject:[[array objectAtIndex:0] objectForKey:@"productId"] forKey:@"NewProduct"];
                    [dic writeToFile:[FileOfManage PathOfFile:@"NewProduct.plist"] atomically:YES];
                }
            }
            
            if ([[responseObject objectForKey:@"currPage"] isEqual:[responseObject objectForKey:@"totalPage"]]) {
                moreFlag = YES;
            }
            
            [footerT endRefreshing];
            
            [headerT endRefreshing];
            
            [_tableView reloadData];
        } else {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

#pragma mark 判断是否还要加载更多
#pragma mark --------------------------------

- (void)loadMoreData:(MJRefreshBackGifFooter *)footer{
    
    footerT = footer;
    
    if (moreFlag) {
        // 拿到当前的上拉刷新控件，结束刷新状态
        [footer endRefreshing];
    } else {
        page ++;
        [self getProductList];
    }
    
}

- (void)loadNewData:(MJRefreshGifHeader *)header{
    
    headerT = header;
    
    [self.productListArray removeAllObjects];
    self.productListArray = nil;
    self.productListArray = [NSMutableArray array];
    if (newFlag) {
        [header endRefreshing];
    } else {
        page = 1;
        [self getProductList];

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
