//
//  TWOUsableAllMoneyViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/5/20.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOUsableAllMoneyViewController.h"
#import "MSelectionView.h"
#import "MyMonkeyNumCell.h"

@interface TWOUsableAllMoneyViewController () <UITableViewDataSource, UITableViewDelegate> {
    UIButton *bView;
    UIView *selectionView;
}

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation TWOUsableAllMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:@"全部"];
    
    self.view.backgroundColor = Color_White;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(selectDataBarPress:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:13], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self showTableView];
    
}

// 创建TableView
- (void)showTableView{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 84) style:UITableViewStylePlain];
    
    self.mainTableView.backgroundColor = Color_Gray;
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"MyMonkeyNumCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self.view addSubview:self.mainTableView];
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
        selectionView.frame = CGRectMake(0, 0, WIDTH_CVIEW_DEFAULT, 150);
        bView.alpha = 0.3;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)showSelectionView{
    
    selectionView = [[UIView alloc] initWithFrame:CGRectMake(0, -150, WIDTH_CONTROLLER_DEFAULT, 150)];
    
    selectionView.backgroundColor = Color_White;
    [self.view addSubview:selectionView];
    
    NSArray *nameArray = @[@"充值",@"提现",@"投资",@"回款",@"收益",@"红包"];
    
    CGFloat marginX = WIDTH_CVIEW_DEFAULT * (23 / 375.0);
    CGFloat marginY = HEIGHT_CVIEW_DEFAULT * (25 / 667.0);
    
    if (WIDTH_CONTROLLER_DEFAULT == 414.0){
        marginX = WIDTH_CVIEW_DEFAULT * (35 / 375.0);
        marginY = HEIGHT_CVIEW_DEFAULT * (25 / 667.0);
    }
    CGFloat buttonX = WIDTH_CVIEW_DEFAULT * (90 / 375.0);
    CGFloat buttonY = HEIGHT_CVIEW_DEFAULT * (37 / 667.0);
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        NSBundle *rootBundle = [NSBundle mainBundle];
        MSelectionView *buttonView = [[rootBundle loadNibNamed:@"MSelectionView" owner:nil options:nil] lastObject];
        
        CGFloat bVX = marginX + (i % 3) * (marginX + buttonX);
        CGFloat bVY = marginY + (i / 3) * (marginY + buttonY);
        
        buttonView.frame = CGRectMake(bVX, bVY, buttonX, buttonY);
        
        [buttonView.selectionButton setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
        
        [buttonView.selectionButton setBackgroundImage:[UIImage imageNamed:@"矩形-10"] forState:UIControlStateNormal];
        [buttonView.selectionButton setBackgroundImage:[UIImage imageNamed:@"anniuS"] forState:UIControlStateSelected];
        
        buttonView.selectionButton.tag = i;
        
        [buttonView.selectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [selectionView addSubview:buttonView];
    }
    
}

- (void)buttonAction:(id)sender{
    UIButton *button = (UIButton *)sender;
    NSLog(@"button = %ld",button.tag);
    
    [UIView animateWithDuration:0.5 animations:^{
        selectionView.frame = CGRectMake(0, -150, WIDTH_CVIEW_DEFAULT, 150);
        
    } completion:^(BOOL finished) {
        [bView setHidden:YES];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyMonkeyNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelName.text = @"充值";
    cell.labelTime.text = @"2016-01-01";
    cell.labelMoney.text = @"+10000";
    
    if (indexPath.row % 2 == 0) {
        cell.labelMoney.textColor = [UIColor redColor];
    } else {
        cell.labelMoney.textColor = [UIColor greenColor];
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
