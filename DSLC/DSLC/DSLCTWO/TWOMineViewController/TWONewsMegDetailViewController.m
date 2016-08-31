//
//  TWONewsMegDetailViewController.m
//  DSLC
//
//  Created by ios on 16/7/21.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWONewsMegDetailViewController.h"

@interface TWONewsMegDetailViewController ()

{
    NSDictionary *dataDictionary;
}

@end

@implementation TWONewsMegDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"消息详情"];
    
    [self megDetailData];
}

- (void)contentShow
{
    UILabel *labelTitle = [CreatView creatWithLabelFrame:CGRectMake(25, 21, WIDTH_CONTROLLER_DEFAULT - 50, 17) backgroundColor:[UIColor clearColor] textColor:[UIColor blackZiTi] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:[dataDictionary objectForKey:@"msgTitle"]];
    [self.view addSubview:labelTitle];
    
    UILabel *labelTime = [CreatView creatWithLabelFrame:CGRectMake(25, 56, WIDTH_CONTROLLER_DEFAULT - 50, 13) backgroundColor:[UIColor clearColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:[dataDictionary objectForKey:@"sendTime"]];
    [self.view addSubview:labelTime];
    
    UILabel *labelContent = [CreatView creatWithLabelFrame:CGRectMake(25, 100, WIDTH_CONTROLLER_DEFAULT - 50, 10) backgroundColor:[UIColor clearColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:[dataDictionary objectForKey:@"msgText"]];
    [self.view addSubview:labelContent];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:14], NSFontAttributeName, nil];
    CGRect rect = [labelContent.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 50, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    labelContent.numberOfLines = 0;
    labelContent.frame = CGRectMake(25, 100, WIDTH_CONTROLLER_DEFAULT - 50, rect.size.height);
}

#pragma mark megDetailData~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)megDetailData
{
    NSDictionary *parmeter = @{@"msgTextId":self.msgID, @"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"msg/getMessageInfo" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"消息详情>>>>>>>>>>>>>>%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            dataDictionary = responseObject;
            [self contentShow];
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"getMessageDataRefrush" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getMyAccountInfo" object:nil];
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
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
