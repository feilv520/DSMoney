//
//  SocialPlatformViewController.m
//  DSLC
//
//  Created by ios on 15/11/13.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "SocialPlatformViewController.h"
#import "InviteSocilPlatFormCell.h"
#import "AddressBookViewController.h"

@interface SocialPlatformViewController () <UITableViewDataSource, UITableViewDelegate, UMSocialUIDelegate>

{
    UITableView *_tableView;
    NSArray *picArr;
    NSArray *nameArr;
}

@end

@implementation SocialPlatformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"邀请"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT ,HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    [_tableView registerNib:[UINib nibWithNibName:@"InviteSocilPlatFormCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    picArr = @[@[@"微信"], @[@"朋友圈"], @[@"新浪微博"], @[@"人人网"], @[@"QQ空间"], @[@"PhoneNum"]];
    nameArr = @[@[@"微信好友"], @[@"微信朋友圈"], @[@"新浪微博"], @[@"人人网"], @[@"QQ空间"], @[@"手机通讯录"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InviteSocilPlatFormCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *pictureArr = [picArr objectAtIndex:indexPath.section];
    cell.imagePIc.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [pictureArr objectAtIndex:indexPath.row]]];
    cell.labelNAME.text = [[nameArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelNAME.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"大圣理财,金融街的新宠.大圣理财链接:https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            NSLog(@"%u",response.responseCode);
            if (response.responseCode == UMSResponseCodeSuccess) {
//                [self getShareRedPacket];
                NSLog(@"邀请成功！");
            }
        }];
        
    } else if (indexPath.section == 1) {
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"大圣理财,金融街的新宠.大圣理财链接:https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            NSLog(@"%u",response.responseCode);
            if (response.responseCode == UMSResponseCodeSuccess) {
//                [self getShareRedPacket];
                NSLog(@"邀请成功！");
            }
        }];
        
    } else if (indexPath.section == 2) {
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"大圣理财,金融街的新宠.大圣理财链接:https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
            NSLog(@"shareResponse = %u",shareResponse.responseCode);
            if (shareResponse.responseCode == UMSResponseCodeSuccess) {
//                [self getShareRedPacket];
                NSLog(@"邀请成功！");
            }
        }];
        
    } else if (indexPath.section == 3) {
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToRenren] content:@"大圣理财,金融街的新宠.大圣理财链接:https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            NSLog(@"%u",response.responseCode);
            if (response.responseCode == UMSResponseCodeSuccess) {
//                [self getShareRedPacket];
                NSLog(@"邀请成功！");
            }
        }];
        
    } else if (indexPath.section == 4) {
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"大圣理财,金融街的新宠.大圣理财链接:https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            NSLog(@"%u",response.responseCode);
            if (response.responseCode == UMSResponseCodeSuccess) {
//                [self getShareRedPacket];
                NSLog(@"邀请成功！");
            }
        }];
        
    } else if (indexPath.section == 5) {
        
        AddressBookViewController *addressVC = [[AddressBookViewController alloc] init];
        [self.navigationController pushViewController:addressVC animated:YES];
        
    }
}

#pragma mark 分享成功回调方法
#pragma mark --------------------------------

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    //根据`responseCode`得到发送结果,如果分享成功
    NSLog(@"%u",response.responseCode);
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark 分享成功拿红包
#pragma mark --------------------------------

- (void)getShareRedPacket{
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/redpacket/getShareRedPacket" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"分享成功,一天只能获得一个红包."];
        }
        
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
