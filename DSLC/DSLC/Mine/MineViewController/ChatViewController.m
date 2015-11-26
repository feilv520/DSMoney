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

@interface ChatViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    NSArray *chatArray;
    CGRect rect;
    
    UIView *viewImport;
    UITextField *_textField;
    UIButton *buttonSend;
    CGFloat keyboardhight;
}

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"咨询理财师"];
    
    [self getDataList];
    [self importWindow];
    [self tableViewShow];
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
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到键盘的高度
    
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        viewImport.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - keyboardSize.height + 14, WIDTH_CONTROLLER_DEFAULT, 50);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 50 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorColor = [UIColor clearColor];
    
    chatArray = @[@"我是好人我是好人我是好人我是好人我是好人我是好人我是好人",
                  @"沈殿霞的女儿郑欣宜几乎是在全港影迷的关注下长大，然而这个“星二代”却不怎么让人省心。继承了母亲体型的郑欣宜减肥史长达10年，身高167厘米的她体重曾达到104公斤，后惊人甩掉46公斤。成功瘦身的郑欣宜在母亲的帮助下进入演艺圈，但并未拿出代表作。",
                  @"反而关于郑欣宜泡夜店、夜不归宿、挥霍无度等报道却不绝于耳，在肥肥去世后不久，郑欣宜更先后传出与师父闹翻、变卖房产兑现1300万港元等负面消息。",
                  @"在“星二代”中条件最好的房祖名也总是让人放不下心。由于父亲成龙的关系，房祖名以众星捧月的方式进入娱乐圈，但至今在演艺事业上还没有太大的建树，但他却是绯闻不断，香港记者还曾多次拍到了房祖名流连于夜店的照片。从目前来看，房祖名还没有做过让成龙脸上特别增光的事情，而他想要超越父亲的成就，也实在是无从说起。在“星二代”中条件最好的房祖名也总是让人放不下心。",
                  @"你最近好吗",
                  @"你是我的小呀小苹果,怎么爱你都不嫌多,红红的小脸照进我的心窝",
                  @"喔喔",
                  @"这是一个柚子, 好吃的柚子",
                  @"太阳当空照,花儿对我笑,小鸟说早早早,你为什么背上小书包,我要炸学校,天天不迟到,爱学习,爱劳动,长大要为人民立功劳"];
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
#pragma mark --------------------------------

//发送消息
- (void)sendMessage:(UIButton *)button
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"recUserId":[dic objectForKey:@"id"], @"msgContent":_textField.text};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/msg/sendMsg" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"vvvvvv%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
    }];
}

//获取消息列表
- (void)getDataList
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"recUserId":[dic objectForKey:@"id"], @"msgType":@0};

    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/msg/getMsgList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"111&&&1111%@", responseObject);
        
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (rect.size.height <= 60) {
        
        return 80;
        
    } else {
        
        return rect.size.height + 60;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return chatArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
    
        OneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
        if (cell == nil) {
            
            cell = [[OneCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
        }
            
        [cell.labelLeft setText:[chatArray objectAtIndex:indexPath.row]];
        [cell.imageLeft setImage:[UIImage imageNamed:@"left"]];

        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
        rect = [cell.labelLeft.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 100, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
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
        
        [cell.labelRight setText:[chatArray objectAtIndex:indexPath.row]];
        [cell.imageRight setImage:[UIImage imageNamed:@"right"]];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
        rect = [cell.labelRight.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 95, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        cell.labelRight.numberOfLines = 0;
        
        cell.imageContect.image = [UIImage imageNamed:@"rightWindow"];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//回收键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 0) {
        
        [_textField resignFirstResponder];//键盘回收
        
        [UIView animateWithDuration:0.001 animations:^{
            
            viewImport.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 20 - 50, WIDTH_CONTROLLER_DEFAULT, 50);
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [viewImport removeFromSuperview];
    viewImport = nil;
    
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
