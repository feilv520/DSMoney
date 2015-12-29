//
//  ChatViewController.m
//  Content
//
//  Created by ios on 15/11/17.
//  Copyright © 2015年 ios. All rights reserved.
//

#import "ChatViewController.h"
#import "OneCell.h"
#import "TwoCell.h"
#import "Chat.h"
#import "SendTime.h"

@interface ChatViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    NSMutableArray *chatArray;
    NSMutableArray *timeArray;
    CGRect rect;
    
    UIView *viewImport;
    UITextField *_textField;
    UIButton *buttonSend;
    CGFloat keyboardhight;
    CGSize keyboardSize;
    UILabel *labelTime;
    NSString *timeStr;
    
    Chat *chat;
    SendTime *time;
    
    CGFloat heightSum;
    
    BOOL flag;
    
    NSDictionary *dic;
}

@end

@implementation ChatViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    viewImport.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    heightSum = 0.0;
    
    flag = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.userORplanner == NO) {
        [self.navigationItem setTitle:self.chatName];
        
    }else {
        [self.navigationItem setTitle:self.chatName];
    }
    
    chatArray = [NSMutableArray array];
    timeArray = [NSMutableArray array];
    timeStr = @"";
    
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
    _tableView.hidden = YES;
    
    [self getDataList];
    [self registerForKeyboardNotifications];
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 键盘出现时
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    
//     keyboardSize为键盘尺寸 (有width, height)
    keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到键盘的高度
    
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        _tableView.contentOffset = CGPointMake(0, chatArray.count * 50);
        
        viewImport.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - keyboardSize.height + 14, WIDTH_CONTROLLER_DEFAULT, 50);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 50 - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorColor = [UIColor clearColor];
//    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 20)];
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if (!flag) {
        _tableView.contentOffset = CGPointMake(0.5, 5000);
    }
    
}

//输入窗口
- (void)importWindow
{
    viewImport = [CreatView creatViewWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 20 - 50, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC.view addSubview:viewImport];
    
    _textField = [CreatView creatWithfFrame:CGRectMake(15, 10, WIDTH_CONTROLLER_DEFAULT - 100, 30) setPlaceholder:nil setTintColor:[UIColor grayColor]];
    [viewImport addSubview:_textField];
    _textField.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    _textField.delegate = self;
    _textField.layer.cornerRadius = 5;
    _textField.layer.masksToBounds = YES;
    _textField.layer.borderWidth = 0.5;
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.layer.borderColor = [[UIColor grayColor] CGColor];
    [_textField addTarget:self action:@selector(textFieldImportContent:) forControlEvents:UIControlEventEditingChanged];
    
    buttonSend = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 15 - 60, 10, 60, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"发送"];
    [viewImport addSubview:buttonSend];
    buttonSend.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [buttonSend setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonSend setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    buttonSend.layer.cornerRadius = 5;
    buttonSend.layer.masksToBounds = YES;
    [buttonSend addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 网络请求方法
#pragma mark --------------------------

//发送消息
- (void)sendMessage:(UIButton *)button
{
    
    if (_textField.text.length == 0) {

    } else {
        
        NSString *textString = _textField.text;
        textString = [textString stringByReplacingOccurrencesOfString:@"\"" withString:@"^"];
        
        NSDictionary *parameter = @{@"recUserId":self.IId, @"msgContent":textString};
        
        [[MyAfHTTPClient sharedClient] postWithURLString:@"app/msg/sendMsg" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            NSLog(@"发送消息:vvvvvv%@", responseObject);
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                
                chat = [[Chat alloc] init];
                chat.sendUserId = [NSNumber numberWithInteger:[[dic objectForKey:@"id"] integerValue]];
                chat.msgText = _textField.text;
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *dataTime = [formatter stringFromDate:[NSDate date]];
                chat.sendTime = dataTime;
                
                [chatArray addObject:chat];
                
                [_tableView reloadData];
                _textField.text = nil;
                
                [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:chatArray.count - 1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                
            } else {
                
                [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@", error);
        }];
    }
    
}

//获取消息列表
- (void)getDataList
{
    
    NSDictionary *parameter = @{@"sendUserId":self.IId, @"msgType":@0};
    NSLog(@"%@", parameter);

    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/msg/getMsgList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"咨询详情:111&&&1111%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            [self loadingWithHidden:YES];
            _tableView.hidden = NO;
            
            NSMutableArray *dataArr = [responseObject objectForKey:@"Msg"];
            for (NSDictionary *dataDic in dataArr) {
                
                chat = [[Chat alloc] init];
                [chat setValuesForKeysWithDictionary:dataDic];
                [chatArray addObject:chat];
                
                NSDictionary *dicF = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
                
                rect = [[chat msgText] boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 70, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicF context:nil];
                
                heightSum += rect.size.height;
            }

            [self importWindow];
            [self tableViewShow];
            
        } else if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]] || responseObject == nil) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dicL = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dicL writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dicL = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dicL writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
            [self.navigationController popToRootViewControllerAnimated:NO];
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//textField绑定的点击方法
- (void)textFieldImportContent:(UITextField *)textField
{
    if (textField.text.length > 0) {
        
        [buttonSend setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonSend setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonSend setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonSend setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rect.size.height + 20 + 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return chatArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewTime = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 20)];
    labelTime = [CreatView creatWithLabelFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:10] text:[[chatArray objectAtIndex:section] sendTime]];
    [viewTime addSubview:labelTime];
    
    return viewTime;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
//    
//    if (cell == nil) {
//        
//        cell = [[TwoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
//    }
//    
//    chat = [chatArray objectAtIndex:indexPath.section];
//
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
//    cell.labelRight.numberOfLines = 0;
//    cell.labelRight.text = chat.msgText;
//
//    rect = [cell.labelRight.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 70, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
//    
//    
//    [cell.imageRight setImage:[UIImage imageNamed:@"right"]];
//    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    return cell;
//    if (chatArray.count != 0) {
//    }
    dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    chat = [chatArray objectAtIndex:indexPath.section];
    
    if (![[chat sendUserId] isEqualToNumber:[NSNumber numberWithInteger:[[dic objectForKey:@"id"] integerValue]]]) {
    
        OneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];

        if (cell == nil) {
            
            cell = [[OneCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
        }
        
        NSString *msgTextString = [chat msgText];
        
        msgTextString = [msgTextString stringByReplacingOccurrencesOfString:@"^" withString:@"\""];
        
        [cell.labelLeft setText:msgTextString];
        [cell.imageLeft setImage:[UIImage imageNamed:@"left"]];

        NSDictionary *dicF = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
        rect = [cell.labelLeft.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 70, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicF context:nil];
        cell.labelLeft.numberOfLines = 0;
        
        cell.imageContect.image = [UIImage imageNamed:@"LeftWindow"];

        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;

    } else {
        
        TwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        if (cell == nil) {
            
            cell = [[TwoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse1"];
        }
        
        chat = [chatArray objectAtIndex:indexPath.section];
        
        NSDictionary *dicF = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
        cell.labelRight.numberOfLines = 0;
        cell.labelRight.text = chat.msgText;
        
        rect = [cell.labelRight.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 70, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicF context:nil];
        
        [cell.imageRight setImage:[UIImage imageNamed:@"right"]];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

//回收键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y != 0) {
        
        [_textField resignFirstResponder];//键盘回收
        
        [UIView animateWithDuration:0.001 animations:^{
            
            viewImport.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 20 - 50, WIDTH_CONTROLLER_DEFAULT, 50);
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [viewImport removeFromSuperview];
//    viewImport = nil;
    viewImport.hidden = YES;
    
    [self.view endEditing:YES];
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
