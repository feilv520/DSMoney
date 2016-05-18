//
//  MessageDetailViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageModel.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationItem setTitle:@"消息详情"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getDataList];
}

// 获取消息详情
- (void)getDataList
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"msgTextId":self.idString, @"msgType":@1, @"token":[dic objectForKey:@"token"]};
    
    NSLog(@"%@",parameter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/msg/getMsgInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
            NSLog(@"%@",responseObject);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
            
            MessageModel *messageModel = [[MessageModel alloc] init];
            
            [messageModel setValuesForKeysWithDictionary:[responseObject objectForKey:@"Msg"]];
            
            self.textLabel.text = [messageModel msgText];
            
            self.titleLabel.text = [messageModel msgTitle];
            
            self.dataLabel.text = [messageModel sendTime];
            
            [self noDataViewWithRemoveToView];
        } else {
            [self noDateWithHeight:330 view:self.view];
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
