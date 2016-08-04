//
//  TWONoticeDetailViewController.m
//  DSLC
//
//  Created by ios on 16/7/18.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWONoticeDetailViewController.h"

@interface TWONoticeDetailViewController ()

{
    NSDictionary *dataDic;
}

@end

@implementation TWONoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"公告详情"];
    
    [self loadingWithView:self.view loadingFlag:NO height:(HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53)/2.0 - 50];
    
    [self noticeDetailData];
}

- (void)contentShow
{
    UILabel *labelTitle = [CreatView creatWithLabelFrame:CGRectMake(25, 21, WIDTH_CONTROLLER_DEFAULT - 50, 17) backgroundColor:[UIColor clearColor] textColor:[UIColor blackZiTi] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:[dataDic objectForKey:@"title"]];
    [self.view addSubview:labelTitle];
    NSDictionary *diction = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:16], NSFontAttributeName, nil];
    CGRect rectT = [labelTitle.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 50, 100899) options:NSStringDrawingUsesLineFragmentOrigin attributes:diction context:nil];
    labelTitle.frame = CGRectMake(25, 21, WIDTH_CONTROLLER_DEFAULT - 50, rectT.size.height);
    labelTitle.numberOfLines = 0;
    
    UILabel *labelTime = [CreatView creatWithLabelFrame:CGRectMake(25, 21 + 18 + labelTitle.frame.size.height, WIDTH_CONTROLLER_DEFAULT - 50, 13) backgroundColor:[UIColor clearColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:[dataDic objectForKey:@"sendTime"]];
    [self.view addSubview:labelTime];
    
    UILabel *labelContent = [CreatView creatWithLabelFrame:CGRectMake(25, 21 + 18 + labelTitle.frame.size.height + 37, WIDTH_CONTROLLER_DEFAULT - 50, 10) backgroundColor:[UIColor clearColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:[dataDic objectForKey:@"content"]];
    [self.view addSubview:labelContent];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:14], NSFontAttributeName, nil];
    CGRect rect = [labelContent.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 50, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    labelContent.numberOfLines = 0;
    labelContent.frame = CGRectMake(25, 21 + 18 + labelTitle.frame.size.height + 37, WIDTH_CONTROLLER_DEFAULT - 50, rect.size.height);
}

#pragma mark DataDetail~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)noticeDetailData
{
    NSDictionary *parmeter = @{@"id":self.messageID};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"notice/getNoticeOne" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        
        NSLog(@"公告详情~~~~~~~~~~~~~~~~~~~~~~%@", responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            dataDic = [responseObject objectForKey:@"notice"];
            [self contentShow];
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
