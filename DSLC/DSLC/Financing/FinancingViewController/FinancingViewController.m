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
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    self.navigationItem.title = @"理财产品";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self showButtonThree];
    [self showTableView];
}

//导航栏下面的三个按钮
- (void)showButtonThree
{
    buttonArr = @[@"新手专享", @"固收理财", @"票据投资"];
    
    UIScrollView *scrollView = [CreatView creatWithScrollViewFrame:CGRectMake(0, 0, self.view.frame.size.width, 45) backgroundColor:[UIColor whiteColor] contentSize:CGSizeMake(self.view.frame.size.width/3 * buttonArr.count, 0) contentOffSet:CGPointMake(0, 0)];
    
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < 3; i++) {
        
        butThree = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(self.view.frame.size.width/3 * i, 0, self.view.frame.size.width/3, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor grayColor] titleText:[NSString stringWithFormat:@"%@", [buttonArr objectAtIndex:i]]];
        butThree.titleLabel.font = [UIFont systemFontOfSize:14];
        butThree.tag = 100 + i;
        [scrollView addSubview:butThree];
        
        [butThree addTarget:self action:@selector(buttonThreePress:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 1) {
            
            [butThree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
    }
    
    lableRedLine = [CreatView creatWithLabelFrame:CGRectMake(self.view.frame.size.width/3, 43, self.view.frame.size.width/3, 2) backgroundColor:[UIColor redColor] textColor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont systemFontOfSize:0] text:@""];
    [self.view addSubview:lableRedLine];

}

//导航栏下面的三个按钮的点击方法
- (void)buttonThreePress:(UIButton *)button
{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        if (button.tag == 100) {
            
            lableRedLine.frame = CGRectMake(0, 43, self.view.frame.size.width/3, 2);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UIButton *beforeButton = (UIButton *)[self.view viewWithTag:buttonTag];
            [beforeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            buttonTag = button.tag;
            
        } else if (button.tag == 101) {
            
            lableRedLine.frame = CGRectMake(self.view.frame.size.width/3, 43, self.view.frame.size.width/3, 2);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UIButton *beforeButton = (UIButton *)[self.view viewWithTag:buttonTag];
            [beforeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            buttonTag = button.tag;
            
        } else {
            
            lableRedLine.frame = CGRectMake(self.view.frame.size.width/3 * 2, 43, self.view.frame.size.width/3, 2);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            UIButton *beforeButton = (UIButton *)[self.view viewWithTag:buttonTag];
            [beforeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            buttonTag = button.tag;
        }
        
    } completion:^(BOOL finished) {
        
    }];
}

//TableView展示
- (void)showTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 45 - 53 - 64 - 15) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    cell.viewGiPian.layer.cornerRadius = 5;
    cell.viewGiPian.layer.masksToBounds = YES;
    
    cell.labelMonth.text = @"3个月固定投资";
    cell.labelMonth.font = [UIFont systemFontOfSize:15];
    
    cell.viewLine.alpha = 0.7;
    cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    cell.labelPercentage.textColor = [UIColor redColor];
    cell.labelPercentage.font = [UIFont systemFontOfSize:22];
    cell.labelPercentage.text = @"8.02%";
    cell.labelPercentage.textAlignment = NSTextAlignmentCenter;
    
    cell.labelYear.text = @"年化收益率";
    cell.labelYear.textColor = [UIColor grayColor];
    cell.labelYear.textAlignment = NSTextAlignmentCenter;
    cell.labelYear.font = [UIFont systemFontOfSize:12];
    
    cell.labelDayNum.textAlignment = NSTextAlignmentCenter;
    cell.labelDayNum.font = [UIFont systemFontOfSize:22];
    cell.labelDayNum.text = @"90天";
    
    cell.labelMoney.textAlignment = NSTextAlignmentCenter;
    cell.labelMoney.font = [UIFont systemFontOfSize:22];
    cell.labelMoney.text = @"1,000元";
    
    cell.labelData.text = @"理财期限";
    cell.labelData.textAlignment = NSTextAlignmentCenter;
    cell.labelData.textColor = [UIColor grayColor];
    cell.labelData.font = [UIFont systemFontOfSize:12];
    
    cell.labelQiTou.text = @"起投资金";
    cell.labelQiTou.textAlignment = NSTextAlignmentCenter;
    cell.labelQiTou.textColor = [UIColor grayColor];
    cell.labelQiTou.font = [UIFont systemFontOfSize:12];
    
    cell.labelSurplus.text = [NSString stringWithFormat:@"%@%@", @"剩余总额:", @"24.6万"];
    cell.labelSurplus.textAlignment = NSTextAlignmentCenter;
    cell.labelSurplus.textColor = [UIColor grayColor];
    cell.labelSurplus.font = [UIFont systemFontOfSize:12];
    cell.labelSurplus.backgroundColor = [UIColor clearColor];
    
    cell.viewBottom.backgroundColor = [UIColor qianhuise];
    
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
