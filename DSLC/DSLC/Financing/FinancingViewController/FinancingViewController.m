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

@interface FinancingViewController () <UITableViewDataSource, UITableViewDelegate>

{
    NSArray *buttonArr;
    UIButton *butThree;
    UILabel *lableRedLine;
    NSInteger buttonTag;
    UITableView *_tableView;
}

@end

@implementation FinancingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    buttonTag = 101;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    
    self.navigationItem.title = @"票据投资";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//    [self showButtonThree];
    [self showTableView];
}

//导航栏下面的三个按钮
- (void)showButtonThree
{
    buttonArr = @[@"新手专享", @"固收理财", @"票据投资"];
    
    UIScrollView *scrollView = [CreatView creatWithScrollViewFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 45) backgroundColor:[UIColor whiteColor] contentSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT/3 * buttonArr.count, 0) contentOffSet:CGPointMake(0, 0)];
    
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < 3; i++) {
        
        butThree = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/3 * i, 0, WIDTH_CONTROLLER_DEFAULT/3, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:[NSString stringWithFormat:@"%@", [buttonArr objectAtIndex:i]]];
        butThree.titleLabel.font = [UIFont systemFontOfSize:14];
        butThree.tag = 100 + i;
        [scrollView addSubview:butThree];
        
//        [butThree addTarget:self action:@selector(buttonThreePress:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 2) {
            
            [butThree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
    }
    
//    lableRedLine = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/3 * 2, 43, WIDTH_CONTROLLER_DEFAULT/3, 2) backgroundColor:[UIColor daohanglan] textColor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont systemFontOfSize:0] text:@""];
//    [self.view addSubview:lableRedLine];

}

//导航栏下面的三个按钮的点击方法
- (void)buttonThreePress:(UIButton *)button
{
//    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//        
//        if (button.tag == 100) {
//            
//            lableRedLine.frame = CGRectMake(0, 43, WIDTH_CONTROLLER_DEFAULT/3, 2);
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            
//            UIButton *beforeButton = (UIButton *)[self.view viewWithTag:buttonTag];
//            [beforeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            
//            buttonTag = button.tag;
//            
//        } else if (button.tag == 101) {
//            
//            lableRedLine.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/3, 43, WIDTH_CONTROLLER_DEFAULT/3, 2);
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            
//            UIButton *beforeButton = (UIButton *)[self.view viewWithTag:buttonTag];
//            [beforeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            
//            buttonTag = button.tag;
//            
//        } else {
//            
//            lableRedLine.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT/3 * 2, 43, WIDTH_CONTROLLER_DEFAULT/3, 2);
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            
//            UIButton *beforeButton = (UIButton *)[self.view viewWithTag:buttonTag];
//            [beforeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            
//            buttonTag = button.tag;
//        }
//        
//    } completion:^(BOOL finished) {
//        
//    }];
}

//TableView展示
- (void)showTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 53 - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 15)];
    viewHead.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.tableHeaderView = viewHead;
    
    [_tableView setSeparatorColor:[UIColor colorWithRed:246 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1.0]];
    [_tableView registerNib:[UINib nibWithNibName:@"FinancingCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FinancingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.viewGiPian.layer.cornerRadius = 4;
    cell.viewGiPian.layer.masksToBounds = YES;
    
    cell.labelMonth.text = @"3个月固定投资";
    cell.labelMonth.font = [UIFont systemFontOfSize:15];
    
    cell.viewLine.alpha = 0.7;
    cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    cell.labelPercentage.textColor = [UIColor blackColor];
    cell.labelPercentage.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:@"8.02%"];
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
    
    NSMutableAttributedString *textYear = [[NSMutableAttributedString alloc] initWithString:@"90天"];
    NSRange numText = NSMakeRange(0, [[textYear string] rangeOfString:@"天"].location);
    [textYear addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:numText];
    NSRange dayText = NSMakeRange([[textYear string] length] - 1, 1);
    [textYear addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:dayText];
    [cell.labelDayNum setAttributedText:textYear];
    
    cell.labelMoney.textAlignment = NSTextAlignmentCenter;
    cell.labelMoney.font = [UIFont systemFontOfSize:22];
    
    NSMutableAttributedString *moneyText = [[NSMutableAttributedString alloc] initWithString:@"1,000元"];
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
    
    cell.labelSurplus.text = [NSString stringWithFormat:@"%@%@", @"剩余总额:", @"24.6万"];
    cell.labelSurplus.textAlignment = NSTextAlignmentCenter;
    cell.labelSurplus.textColor = [UIColor zitihui];
    cell.labelSurplus.font = [UIFont systemFontOfSize:12];
    cell.labelSurplus.backgroundColor = [UIColor clearColor];
    
//    设置进度条的进度值 并动画展示
    [cell.progressView setProgress:0.7 animated:YES];
//    设置进度条的颜色
    cell.progressView.trackTintColor = [UIColor progressBackColor];
//    设置进度条的进度颜色
    cell.progressView.progressTintColor = [UIColor progressColor];
    
    cell.viewBottom.backgroundColor = [UIColor qianhuise];
    
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FDetailViewController *fdetailVC = [[FDetailViewController alloc] init];
    [self.navigationController pushViewController:fdetailVC animated:YES];
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
