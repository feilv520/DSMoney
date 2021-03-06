//
//  EmailViewController.m
//  DSLC
//
//  Created by ios on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "EmailViewController.h"
#import "LastEmailViewController.h"
#import "EmailCell.h"

@interface EmailViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

{
    UIButton *buttonNext;
    UITextField *_textField;
    
    UIButton *butRemember;
    UIView *viewBig;
    
    UITableView *_tableView;
    NSArray *contentArr;
    
    NSInteger seconds;
    NSTimer *timer;
}

@end

@implementation EmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"绑定邮箱"];
    
    seconds = 50;
    [self contentShow];
    [self rememberContent];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5)];
    [viewBottom addSubview:labelLine];
    labelLine.backgroundColor = [UIColor grayColor];
    labelLine.alpha = 0.2;
    
    UILabel *labelEmail = [CreatView creatWithLabelFrame:CGRectMake(10, 10, 60, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"邮箱地址"];
    [viewBottom addSubview:labelEmail];
    
    _textField = [CreatView creatWithfFrame:CGRectMake(90, 11, WIDTH_CONTROLLER_DEFAULT - 100, 30) setPlaceholder:@"请输入邮箱地址" setTintColor:[UIColor grayColor]];
    [viewBottom addSubview:_textField];
    _textField.delegate = self;
    _textField.textColor = [UIColor zitihui];
    _textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [_textField addTarget:self action:@selector(textEditEmail:) forControlEvents:UIControlEventEditingChanged];
    
    buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 110, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"发送验证邮箱"];
    [self.view addSubview:buttonNext];
    buttonNext.tag = 7690;
    buttonNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonNext addTarget:self action:@selector(sendEmail:) forControlEvents:UIControlEventTouchUpInside];
}

//绑定邮箱验证
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)textEditEmail:(UITextField *)textField
{
    if (textField.text.length > 0) {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (void)rememberContent
{
    butRemember = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 190, WIDTH_CONTROLLER_DEFAULT - 20, 25) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@"邮件发送成功,请您登录邮箱激活"];
    [butRemember setImage:[UIImage imageNamed:@"iconfont_complete"] forState:UIControlStateNormal];
    butRemember.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    viewBig = [CreatView creatViewWithFrame:CGRectMake(40, 225, WIDTH_CONTROLLER_DEFAULT - 80, 156) backgroundColor:[UIColor shurukuangColor]];
    viewBig.layer.cornerRadius = 5;
    viewBig.layer.masksToBounds = YES;
    viewBig.layer.borderColor = [[UIColor shurukuangBian] CGColor];
    viewBig.layer.borderWidth = 0.5;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, viewBig.frame.size.width, 156 - 12) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"EmailCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    contentArr = @[@"温馨提示", @"没有收到邮件?", @"1.验证邮件可能在垃圾邮件中,", @"请仔细查找。", @"2.如果超过10分钟仍未收到验证邮件,", @"请重新进行邮箱认证。"];
}

//发送邮件按钮
- (void)sendEmail:(UIButton *)button
{
    [_textField resignFirstResponder];
    
    
    if ([NSString validateEmail:_textField.text]) {
        
        [self updateUserEmail];
        
    } else {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"邮箱格式不正确,请更正."];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 146/6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EmailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelContent.text = [contentArr objectAtIndex:indexPath.row];
    cell.labelContent.font = [UIFont systemFontOfSize:13];
    cell.labelContent.textAlignment = NSTextAlignmentCenter;
    cell.labelContent.textColor = [UIColor zitihui];
    
    cell.backgroundColor = [UIColor shurukuangColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

// 验证码倒计时
-(void)timerFireMethod:(NSTimer *)theTimer {
    
    UIButton *button = (UIButton *)[self.view viewWithTag:7690];
    
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 50;
        [button setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        [button setTitle:@"重新发送" forState: UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setEnabled:YES];
        
        _textField.enabled = YES;
        
    }else{
        
        seconds--;
        NSString *title = [NSString stringWithFormat:@"重新发送(%lds)",(long)seconds];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button setEnabled:NO];
    }
}

- (void)releaseTImer {
    if (timer) {
        if ([timer respondsToSelector:@selector(isValid)]) {
            if ([timer isValid]) {
                [timer invalidate];
                seconds = 50;
            }
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)updateUserEmail{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"],@"email":_textField.text};
    
    NSLog(@"%@",parameter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/mail/updateUserEmail" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"updateUserEmail = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]){
        
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(barFinishReturnBack:)];
            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:14]} forState:UIControlStateNormal];
            
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
            
            _textField.enabled = NO;
            
            [self.view addSubview:butRemember];
            [self.view addSubview:viewBig];
            [viewBig addSubview:_tableView];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)barFinishReturnBack:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
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
