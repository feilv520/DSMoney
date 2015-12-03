//
//  BillViewController.m
//  DSLC
//
//  Created by ios on 15/10/28.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BillViewController.h"
#import "define.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "FinancingViewController.h"
#import "NewbieViewController.h"
#import "BillCell.h"
#import "FDetailViewController.h"
#import "ProductListModel.h"

@interface BillViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UIScrollView *scrollView;
    UIButton *butThree;
    NSArray *butThrArr;
    UILabel *labelLine;
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    
    FinancingViewController *financingVC;
    NewbieViewController *newbieVC;
    
    UITableView *_tableView;
    NSArray *butRedArray;
    
    UIImageView *imageView;
    
    NSInteger flag;
    
    NSMutableArray *flagArray;
}

@property (nonatomic, strong) NSMutableArray *productListArray;

@end

@implementation BillViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getProductList];
    
    [self loadingWithView:self.view loadingFlag:NO height:120.0];
    
    self.view.backgroundColor = [UIColor huibai];
    
    self.productListArray = [NSMutableArray array];
    
    flagArray = [NSMutableArray array];
    
    imageView = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 49, 65, 49, 49) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"已售罄"]];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 45 - 53) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.tableFooterView.backgroundColor = [UIColor huibai];
    [_tableView setSeparatorColor:[UIColor colorWithRed:246 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1.0]];
    [_tableView registerNib:[UINib nibWithNibName:@"BillCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self addTableViewWithHeader:_tableView];
    [self addTableViewWithFooter:_tableView];
    
    butRedArray = @[@"3", @"6", @"9", @"12", @"7", @"9", @"1", @"5", @"6", @"8"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.backgroundColor = [UIColor huibai];
    
    [cell.buttonRed setBackgroundImage:[UIImage imageNamed:@"圆角矩形-2"] forState:UIControlStateNormal];
    [cell.buttonRed setTitle:[NSString stringWithFormat:@"%@", [butRedArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    cell.buttonRed.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelMonth.text = [[self.productListArray objectAtIndex:indexPath.row] productName];
    cell.labelMonth.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    
    cell.labelQiTou.text = [NSString stringWithFormat:@"%@起投",[[self.productListArray objectAtIndex:indexPath.row] productAmountMin]];
    cell.labelQiTou.textColor = [UIColor zitihui];
    cell.labelQiTou.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    cell.labelQiTou.textAlignment = NSTextAlignmentRight;
    
    cell.viewLine1.backgroundColor = [UIColor grayColor];
    cell.viewLine1.alpha = 0.2;
    
    NSMutableAttributedString *leftString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%",[[self.productListArray objectAtIndex:indexPath.row] productAnnualYield]]];
    NSRange left = NSMakeRange(0, [[leftString string] rangeOfString:@"%"].location);
    [leftString addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:left];
    [leftString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:left];
    NSRange right = NSMakeRange([[leftString string] length] - 1, 1);
    [leftString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:right];
    [leftString addAttribute:NSForegroundColorAttributeName value:[UIColor zitihui] range:right];
    [cell.labelLeftUp setAttributedText:leftString];
    
    NSMutableAttributedString *midString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天",[[self.productListArray objectAtIndex:indexPath.row] productPeriod]]];
    NSRange leftMid = NSMakeRange(0, [[midString string] rangeOfString:@"天"].location);
    [midString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:leftMid];
    NSRange rightMid = NSMakeRange([[midString string] length] - 1, 1);
    [midString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:rightMid];
    [midString addAttribute:NSForegroundColorAttributeName value:[UIColor zitihui] range:rightMid];
    [cell.labelMidUp setAttributedText:midString];
    
    [cell.butRightUp setImage:[UIImage imageNamed:@"组-14"] forState:UIControlStateNormal];
    NSMutableAttributedString *rightString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@元",[[self.productListArray objectAtIndex:indexPath.row] residueMoney]]];
    NSRange rightLeft = NSMakeRange(0, [[rightString string] rangeOfString:@"元"].location);
    [rightString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:[self sizeOfLength:[[self.productListArray objectAtIndex:indexPath.row] residueMoney]]] range:rightLeft];
    NSRange rightR = NSMakeRange([[rightString string] length] - 1, 1);
    [rightString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:rightR];
    [rightString addAttribute:NSForegroundColorAttributeName value:[UIColor zitihui] range:rightR];
    [cell.butRightUp setAttributedTitle:rightString forState:UIControlStateNormal];
    
    cell.labelLeftDown.text = @"年化收益率";
    cell.labelLeftDown.textColor = [UIColor zitihui];
    cell.labelLeftDown.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    cell.labelMidDown.text = @"理财期限";
    cell.labelMidDown.textColor = [UIColor zitihui];
    cell.labelMidDown.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    cell.labelRightDown.text = @"剩余总额";
    cell.labelRightDown.textColor = [UIColor zitihui];
    cell.labelRightDown.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    if ([[[self.productListArray objectAtIndex:indexPath.row] productStatus] isEqualToString:@"4"]) {
        cell.saleOut.hidden = NO;
        cell.labelRightDown.hidden = YES;
        cell.butRightUp.hidden = YES;
    } else {
        cell.saleOut.hidden = YES;
        cell.labelRightDown.hidden = NO;
        cell.butRightUp.hidden = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FDetailViewController *detailVC = [[FDetailViewController alloc] init];
    detailVC.estimate = YES;
    detailVC.idString = [[self.productListArray objectAtIndex:indexPath.row] productId];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getProductList{
    
    NSDictionary *parameter = @{@"productType":@1,@"curPage":@1};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getProductList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        
        NSLog(@"%@",responseObject);
        
        NSArray *array = [responseObject objectForKey:@"Product"];
        for (NSDictionary *dic in array) {
            [flagArray addObject:[dic objectForKey:@"productStatus"]];
            ProductListModel *productM = [[ProductListModel alloc] init];
            [productM setValuesForKeysWithDictionary:dic];
            [self.productListArray addObject:productM];
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
