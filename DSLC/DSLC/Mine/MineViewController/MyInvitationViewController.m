//
//  MyInvitationViewController.m
//  DSLC
//
//  Created by ios on 15/10/20.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyInvitationViewController.h"
#import "CreatView.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "MyInviteCell.h"
#import "InviteNumCell.h"
#import "InviteNameCell.h"
#import "InviteNameViewController.h"

@interface MyInvitationViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation MyInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getMyInviteInfo];
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"我的邀请"];
    [self tableViewShow];
}

//视图内容
- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 22) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];;
    
    [_tableView registerNib:[UINib nibWithNibName:@"MyInviteCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"InviteNumCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    [_tableView registerNib:[UINib nibWithNibName:@"InviteNameCell" bundle:nil] forCellReuseIdentifier:@"reuse3"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0;
        
    } else if (section == 1) {
        
        return HEIGHT_CONTROLLER_DEFAULT * (5.0 / 667.0);
        
    } else {
        
        return HEIGHT_CONTROLLER_DEFAULT * (10.0 / 667.0);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 99;
        
    } else if (indexPath.section == 1) {
        
        return 102;
        
    } else {
        
        return 49;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        
        return 6;
        
    } else {
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        MyInviteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.imageHead.image = [UIImage imageNamed:@"picture"];
        
        cell.labelName.text = @"李四";
        cell.labelName.textAlignment = NSTextAlignmentCenter;
        cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labInviteNum.text = @"我的邀请码";
        cell.labInviteNum.font = [UIFont systemFontOfSize:11];
        
        cell.labelNum.text = @"W35A";
        cell.labelNum.textColor = [UIColor daohanglan];
        cell.labelNum.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        
        cell.labelHttp.text = @"邀请链接";
        cell.labelHttp.font = [UIFont systemFontOfSize:11];
        
        cell.labelHttpNum.text = @"2eidjcom";
        cell.labelHttpNum.textColor = [UIColor daohanglan];
        cell.labelHttpNum.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        
        [cell.buttonCopy setTitle:@"复制" forState:UIControlStateNormal];
        [cell.buttonCopy setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        cell.buttonCopy.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.buttonCopy.layer.cornerRadius = 3;
        cell.buttonCopy.layer.masksToBounds = YES;
        cell.buttonCopy.layer.borderWidth = 1;
        cell.buttonCopy.layer.borderColor = [[UIColor daohanglan] CGColor];
        [cell.buttonCopy addTarget:self action:@selector(copyButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.butCopyTwo setTitle:@"复制" forState:UIControlStateNormal];
        [cell.butCopyTwo setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        cell.butCopyTwo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.butCopyTwo.layer.cornerRadius = 3;
        cell.butCopyTwo.layer.masksToBounds = YES;
        cell.butCopyTwo.layer.borderWidth = 1;
        cell.butCopyTwo.layer.borderColor = [[UIColor daohanglan] CGColor];
        [cell.butCopyTwo addTarget:self action:@selector(copyButton:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } else if (indexPath.section == 1) {
        
        InviteNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        cell.backgroundColor = [UIColor huibai];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableAttributedString *peopleNum = [[NSMutableAttributedString alloc] initWithString:@"6人\n邀请人数"];
        [peopleNum addAttribute:NSForegroundColorAttributeName value:[UIColor zitihui] range:NSMakeRange(0, [peopleNum length])];
        
        NSRange invite = NSMakeRange(0, [[peopleNum string] rangeOfString:@"人"].location);
        [peopleNum addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:18] range:invite];
        NSRange REN = NSMakeRange(1, 1);
        [peopleNum addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:REN];
        NSRange NUM = NSMakeRange(3, 4);
        [peopleNum addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:NUM];
        
        [cell.labelPeople setAttributedText:peopleNum];
        
        NSMutableAttributedString *redNumStr = [[NSMutableAttributedString alloc] initWithString:@"1,234元\n累计打开邀请红包"];
        [redNumStr addAttribute:NSForegroundColorAttributeName value:[UIColor zitihui] range:NSMakeRange(0, [redNumStr length])];
        
        NSRange totalRed = NSMakeRange(0, [[redNumStr string] rangeOfString:@"元"].location);
        [redNumStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:18] range:totalRed];
        [redNumStr addAttribute:NSForegroundColorAttributeName value:Color_Red range:totalRed];
        NSRange yuanRed = NSMakeRange([[redNumStr string] rangeOfString:@"元"].location, 1);
        [redNumStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:yuanRed];
        NSRange numRed = NSMakeRange([[redNumStr string] rangeOfString:@"元"].location + 2, 8);
        [redNumStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:numRed];
        
        [cell.redBag setAttributedText:redNumStr];
        
        NSMutableAttributedString *moneyNumStr = [[NSMutableAttributedString alloc] initWithString:@"1,234元\n累计佣金"];
        [moneyNumStr addAttribute:NSForegroundColorAttributeName value:[UIColor zitihui] range:NSMakeRange(0, [moneyNumStr length])];

        NSRange total = NSMakeRange(0, [[moneyNumStr string] rangeOfString:@"元"].location);
        [moneyNumStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:18] range:total];
        NSRange yuan = NSMakeRange([[moneyNumStr string] rangeOfString:@"元"].location, 1);
        [moneyNumStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:yuan];
        NSRange num = NSMakeRange([[moneyNumStr string] rangeOfString:@"元"].location + 2, 4);
        [moneyNumStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:num];
        
        [cell.labelMoney setAttributedText:moneyNumStr];
        
        cell.viewBottom.layer.cornerRadius = 3;
        cell.viewBottom.layer.masksToBounds = YES;
        
        [cell.butInvite setTitle:@"邀请" forState:UIControlStateNormal];
        [cell.butInvite setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.butInvite.backgroundColor = [UIColor daohanglan];
        cell.butInvite.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.butInvite.layer.cornerRadius = 3;
        cell.butInvite.layer.masksToBounds = YES;
        [cell.butInvite addTarget:self action:@selector(buttonInvite:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } else {
        
        InviteNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse3"];
        
        if (indexPath.row == 0) {
            
            cell.labelName.text = @"姓名";
            cell.labelName.textAlignment = NSTextAlignmentCenter;
            cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            
            cell.labelTime.text = @"邀请时间";
            cell.labelTime.textAlignment = NSTextAlignmentCenter;
            cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            
            cell.labelMoney.text = @"为我赚取(元)";
            cell.labelMoney.textAlignment = NSTextAlignmentCenter;
            cell.labelMoney.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            
        } else {
        
            cell.labelName.text = @"张三";
            cell.labelName.textAlignment = NSTextAlignmentCenter;
            cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        
            cell.labelTime.text = @"2015-9-2";
            cell.labelTime.textAlignment = NSTextAlignmentCenter;
            cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        
            cell.labelMoney.text = @"290元";
            cell.labelMoney.textAlignment = NSTextAlignmentCenter;
            cell.labelMoney.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            
        }
        
        cell.backgroundColor = [UIColor huibai];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

//复制按钮
- (void)copyButton:(UIButton *)button
{
    NSLog(@"复制");
}

//邀请按钮
- (void)buttonInvite:(UIButton *)button
{
    InviteNameViewController *inviteName = [[InviteNameViewController alloc] init];
    [self.navigationController pushViewController:inviteName animated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getMyInviteInfo{
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"],@"invitationMyCode":[dic objectForKey:@"invitationMyCode"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getMyInviteInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
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
