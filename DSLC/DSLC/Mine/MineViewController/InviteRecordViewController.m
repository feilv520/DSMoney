//
//  InviteRecordViewController.m
//  DSLC
//
//  Created by ios on 16/4/14.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "InviteRecordViewController.h"
#import "InviteRecordCell.h"

@interface InviteRecordViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tabelView;
    NSMutableArray *contentArr;
}

@end

@implementation InviteRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"邀请记录"];
    contentArr = [NSMutableArray array];
    
    [self getRecordData];
}

- (void)noHaveInviteRecord
{
    UIImageView *imageViewNo = [CreatView creatImageViewWithFrame:CGRectMake(75, (HEIGHT_CONTROLLER_DEFAULT- 20 - 64)/2 - 100 - 50, WIDTH_CONTROLLER_DEFAULT - 150, 200) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"NoRecord"]];
    [self.view addSubview:imageViewNo];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        imageViewNo.frame = CGRectMake(75, (HEIGHT_CONTROLLER_DEFAULT- 20 - 64)/2 - 100 - 50, WIDTH_CONTROLLER_DEFAULT - 150, 200);
        
    } else if (WIDTH_CONTROLLER_DEFAULT == 375) {
        
        imageViewNo.frame = CGRectMake(85, (HEIGHT_CONTROLLER_DEFAULT- 20 - 64)/2 - 120 - 50, WIDTH_CONTROLLER_DEFAULT - 170, 240);
        
    } else {
        
        imageViewNo.frame = CGRectMake(95, (HEIGHT_CONTROLLER_DEFAULT- 20 - 64)/2 - 140 - 50, WIDTH_CONTROLLER_DEFAULT - 190, 280);
    }
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, (HEIGHT_CONTROLLER_DEFAULT- 20 - 64)/2 - 120 - 50 + imageViewNo.frame.size.height + 30, WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"您还没有邀请过好友,快去邀请拿好礼吧!"];
    [self.view addSubview:labelAlert];
}

- (void)tabelViewShow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.backgroundColor = [UIColor qianhuise];
    _tabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.1)];
    [_tabelView registerNib:[UINib nibWithNibName:@"InviteRecordCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InviteRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (indexPath.row == 0) {
        
        cell.labelPhoneNum.text = @"手机号";
        cell.labelRealName.text = @"实名认证";
        cell.labelMoney.text = @"投资";
        cell.labelTime.text = @"注册时间";
        
    } else {
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)getRecordData
{
    if (contentArr.count == 0) {
        [self noHaveInviteRecord];
    } else {
        [self tabelViewShow];
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
