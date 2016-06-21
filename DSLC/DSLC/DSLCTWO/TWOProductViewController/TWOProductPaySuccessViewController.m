//
//  TWOProductPaySuccessViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/5/12.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOProductPaySuccessViewController.h"
#import "TWOProductDetailTableViewCell.h"

@interface TWOProductPaySuccessViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *titleArray;
    NSMutableArray *valueArray;
    
    UIView *sureView;
}

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation TWOProductPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    
    [self.navigationItem setTitle:@"投资成功"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(buttonNothing:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishLastBarPress:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:13], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    titleArray = @[@"本次投资",@"预期收益",@"计息起始日",@"到期日",@"收获猴币"];
    
    valueArray = [NSMutableArray arrayWithCapacity:5];
    [valueArray addObject:[NSString stringWithFormat:@"%@",self.allMoneyString]];
    [valueArray addObject:[NSString stringWithFormat:@"%@",self.syString]];
    [valueArray addObject:[NSString stringWithFormat:@"%@",self.qDayString]];
    [valueArray addObject:[NSString stringWithFormat:@"%@",self.dDayString]];
    [valueArray addObject:[NSString stringWithFormat:@"%@",self.monkeyString]];
    
    [self showTableView];
    [self setSureView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [sureView removeFromSuperview];
    sureView = nil;
}

// 创建TableView
- (void)showTableView{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 84) style:UITableViewStyleGrouped];
    
    self.mainTableView.backgroundColor = Color_Gray;
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"TWOProductDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self tableViewHeadShow];
    
    [self.view addSubview:self.mainTableView];
}

- (void)tableViewHeadShow{
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 196)];
    headImageView.image = [UIImage imageNamed:@"productDetailBackground"];
    self.mainTableView.tableHeaderView = headImageView;
    
    UIImageView *monkeyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headImageView.center.x - 60.0, 30, 127, 120)];
    [headImageView addSubview:monkeyImageView];
    monkeyImageView.image = [UIImage imageNamed:@"paysuccess"];
}

- (void)setSureView{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    sureView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 78, WIDTH_CONTROLLER_DEFAULT, 58)];
    
    sureView.backgroundColor = Color_White;
    
    [app.window addSubview:sureView];
    
    UIButton *lookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    lookButton.frame = CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 40);
    
    [lookButton addTarget:self action:@selector(lookAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [lookButton setBackgroundImage:[UIImage imageNamed:@"productSureButton"] forState:UIControlStateNormal];
    
    [lookButton setTitle:@"查看投资详情" forState:UIControlStateNormal];
    
    [sureView addSubview:lookButton];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TWOProductDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.titleLabel.text = [titleArray objectAtIndex:indexPath.row];
    
    cell.valueLabel.text = [valueArray objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 无操作
- (void)buttonNothing:(UIBarButtonItem *)button{
    
}

// 返回产品列表页
- (void)finishLastBarPress:(UIBarButtonItem *)button{
    NSLog(@"返回");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// 查看投资详情
- (void)lookAction:(id)sender{
    NSLog(@"查看投资详情");
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
