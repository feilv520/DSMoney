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
    NSDictionary *parameter = @{@"msgTextId":self.idString, @"msgType":@1};
    
    NSLog(@"%@",parameter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/msg/getMsgList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        MessageModel *messageModel = [[MessageModel alloc] init];
        
        for (NSDictionary *dic in [responseObject objectForKey:@"Msg"]) {
            [messageModel setValuesForKeysWithDictionary:dic];
        }
        
//        self.textLabel.text = [messageModel msgText];
        
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
