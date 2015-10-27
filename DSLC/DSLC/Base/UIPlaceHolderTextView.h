//
//  UIPlaceHolderTextView.h
//  textview
//
//  Created by seegroup on 15/3/19.
//  Copyright (c) 2015年 seegroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end