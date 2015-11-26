//
//  ChooseRedBagController.m
//  DSLC
//
//  Created by ios on 15/11/23.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ChooseRedBagController.h"
#import "NotSeparateCell.h"
#import "TheThirdRedBagCell.h"
#import "RedBagModel.h"

@interface ChooseRedBagController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *imageBagArr;
    NSArray *styleArr;
}

@property (nonatomic, strong) NSMutableArray *redBagArray;

@end

@implementation ChooseRedBagController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getMyRedPacketList];
    
    self.redBagArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"选择红包"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 5)];
    _tableView.tableHeaderView.backgroundColor = [UIColor huibai];
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"NotSeparateCell" bundle:nil] forCellReuseIdentifier:@"Reuse1"];
    
    imageBagArr = @[@"银元宝", @"铜元宝", @"钻石", @"金元宝", @"阶梯", @"邀请"];
    styleArr = @[@"银元宝红包", @"铜元宝红包", @"钻石红包", @"金元宝红包", @"阶梯红包", @"邀请红包"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.redBagArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RedBagModel *redbagModel = [self.redBagArray objectAtIndex:indexPath.row];
        
    NotSeparateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse1"];
    
    cell.labelSend.text = @"送";
    cell.labelSend.textColor = [UIColor whiteColor];
    cell.labelSend.textAlignment = NSTextAlignmentCenter;
    cell.labelSend.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    cell.labelSend.backgroundColor = [UIColor daohanglan];
    cell.labelSend.layer.cornerRadius = 5;
    cell.labelSend.layer.masksToBounds = YES;
    
    NSString *string = [NSString stringWithFormat:@"%@~%@元",[redbagModel rpFloor],[redbagModel rpTop]];
    NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange leftStr = NSMakeRange(0, [[redStr string] rangeOfString:@"元"].location);
    [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:leftStr];
    [redStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:leftStr];
    [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[string rangeOfString:@"元"]];
    [cell.labelMoney setAttributedText:redStr];
    cell.labelMoney.textColor = [UIColor daohanglan];
    cell.labelMoney.backgroundColor = [UIColor clearColor];
    
    cell.labelBagStyle.text = [redbagModel rpTypeName];
    cell.labelBagStyle.backgroundColor = [UIColor clearColor];
    cell.labelBagStyle.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    cell.laeblRequest.text = [NSString stringWithFormat:@"单笔投资金额满%@",[redbagModel rpLimit]];
    cell.laeblRequest.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.laeblRequest.textColor = [UIColor zitihui];
    cell.laeblRequest.backgroundColor = [UIColor clearColor];
    
    cell.labelDays.text = [NSString stringWithFormat:@"理财期限大于%@天",[redbagModel daysLimit]];
    cell.labelDays.textColor = [UIColor zitihui];
    cell.labelDays.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    cell.labelDays.backgroundColor = [UIColor clearColor];
    
    cell.labelTime.text = [NSString stringWithFormat:@"%@%@", @"有效期:截止", [redbagModel rpTime]];
    cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    cell.labelTime.textColor = [UIColor zitihui];
    cell.labelTime.backgroundColor = [UIColor clearColor];
    
    cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imageBagArr objectAtIndex:indexPath.row]]];
    
    cell.backgroundColor = [UIColor huibai];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendValue" object:[self.redBagArray objectAtIndex:indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getMyRedPacketList{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"],@"buyMoney":self.buyMoney,@"days":self.days};
    
    NSLog(@"%@",parameter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/redpacket/getUserRedPacketRandList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getMyRedPacketList = %@",responseObject);
        
        for (NSDictionary *dic in [responseObject objectForKey:@"RedPacket"]) {
            if ([[dic objectForKey:@"rpType"] isEqualToString:@"2"] || [[dic objectForKey:@"rpType"] isEqualToString:@"1"]) {
                RedBagModel *redbagModel = [[RedBagModel alloc] init];
                [redbagModel setValuesForKeysWithDictionary:dic];
                [self.redBagArray addObject:redbagModel];
            }
        }
        
        [_tableView reloadData];
        
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
