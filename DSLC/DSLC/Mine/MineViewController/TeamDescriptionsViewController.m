//
//  TeamDescriptionsViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "TeamDescriptionsViewController.h"

@interface TeamDescriptionsViewController ()

@end

@implementation TeamDescriptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"管理团队简介";
    
    [self contentShow];
}

- (void)contentShow
{
    UILabel *labelTitle = [CreatView creatWithLabelFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"国丞财富 产品管理人"];
    [self.view addSubview:labelTitle];
    
    UILabel *labelContent = [CreatView creatWithLabelFrame:CGRectMake(10, 50, WIDTH_CONTROLLER_DEFAULT - 20, 10) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"第一个问题是连接App Store，受影响的用户不能存取App Store、不能更新apps、不能找回下载记录。就算注销再登入Apple ID，依然未能修复。部分不幸的用户，问题更超越App Store，而是所有用Apple ID 登入的功能都受影响例如Game Center 和Apple Music。\n\n第二个不少用户都遇到的重大问题是Touch ID。有些装置的Touch ID 辨识速度变得很慢，或者变得不稳定，最严重的是完全没反应。部分用户强制重启后能暂时修复，但再过一阵子问题又再发生。\n\n之前只要由iOS 9.1 降回iOS 9.0.2 就能修正以上两个问题，可是现在Apple 已经暂停认证iOS 9.0.2。由于颇多人都受影响，外国大型传媒Forbes 甚至直接联络Apple，不过Apple 暂时不回应。"];
    [self.view addSubview:labelContent];
    labelContent.numberOfLines = 0;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:14], NSFontAttributeName,nil];
    CGRect rect = [labelContent.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    labelContent.frame = CGRectMake(10, 50, WIDTH_CONTROLLER_DEFAULT - 20, rect.size.height);
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
