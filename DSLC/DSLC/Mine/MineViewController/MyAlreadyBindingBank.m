//
//  MyAlreadyBindingBank.m
//  DSLC
//
//  Created by ios on 15/11/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyAlreadyBindingBank.h"
#import "MyAlreadyCell.h"

@interface MyAlreadyBindingBank () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tabelView;
}

@end

@implementation MyAlreadyBindingBank

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"我的银行卡"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.backgroundColor = [UIColor huibai];
    _tabelView.tableFooterView = [UIView new];
    [_tabelView registerNib:[UINib nibWithNibName:@"MyAlreadyCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAlreadyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.imageSign.image = [UIImage imageNamed:@"2013123115540975"];
    
    cell.laeblBankName.text = @"中国工商银行";
    cell.laeblBankName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelName.text = @"张学伟";
    cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelCard.text = @"储蓄卡";
    cell.labelCard.textColor = [UIColor zitihui];
    cell.labelCard.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    
    cell.laeblCardNum.text = @"6225**** ****8823";
    cell.laeblCardNum.textColor = [UIColor zitihui];
    cell.laeblCardNum.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    return cell;
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
