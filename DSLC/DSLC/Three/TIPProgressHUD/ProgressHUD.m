//
// Copyright (c) 2013 Related Code - http://relatedcode.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//判定系统版本
#define IOSVersion [[UIDevice currentDevice].systemVersion doubleValue]
#define IS_IOS6 [[[UIDevice currentDevice] systemVersion] floatValue]<7.0
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue]>=7.0
#define IS_IOS8 [[[UIDevice currentDevice] systemVersion] floatValue]>=8.0


#import "ProgressHUD.h"

@implementation ProgressHUD

@synthesize window, hud, spinner, image, label;

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (ProgressHUD *)shared
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	static dispatch_once_t once = 0;
	static ProgressHUD *progressHUD;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	dispatch_once(&once, ^{ progressHUD = [[ProgressHUD alloc] init]; });
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return progressHUD;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)dismiss
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[self shared] hudHide];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)show:(NSString *)status
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[self shared] hudMake:status imgage:nil spin:YES hide:NO];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showSuccess:(NSString *)status
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[self shared] hudMake:status imgage:HUD_IMAGE_SUCCESS spin:NO hide:YES];
}

+ (void)showMessage:(NSString *)status Width:(float)width High:(float)high
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[self shared] hudMake2:status imgage:nil spin:NO hide:YES Width:width High:high];
}


//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showError:(NSString *)status
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[self shared] hudMake:status imgage:HUD_IMAGE_ERROR spin:NO hide:YES];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)init
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([delegate respondsToSelector:@selector(window)])
		window = [delegate performSelector:@selector(window)];
	else window = [[UIApplication sharedApplication] keyWindow];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	hud = nil; spinner = nil; image = nil; label = nil;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.alpha = 0;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudMake:(NSString *)status imgage:(UIImage *)img spin:(BOOL)spin hide:(BOOL)hide
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self hudCreate];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	label.text = status;
	label.hidden = (status == nil) ? YES : NO;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	image.image = img;
	image.hidden = (img == nil) ? YES : NO;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (spin) [spinner startAnimating]; else [spinner stopAnimating];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[self hudOrient];
	[self hudSize];
    
    
	[self hudShow];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (hide) [NSThread detachNewThreadSelector:@selector(timedHide) toTarget:self withObject:nil];
}





//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudCreate
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (hud == nil)
	{
		hud = [[UIToolbar alloc] initWithFrame:CGRectZero];
        if (IOSVersion >= 7.0) {
            hud.barTintColor = HUD_BACKGROUND_COLOR;
        }else{

            hud.backgroundColor = [UIColor clearColor];
            hud.tintColor = HUD_BACKGROUND_COLOR;

        }
       
		hud.translucent = YES;
		hud.layer.cornerRadius = 10;
		hud.layer.masksToBounds = YES;
		//-----------------------------------------------------------------------------------------------------------------------------------------
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
	}
	if (hud.superview == nil) [window addSubview:hud];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (spinner == nil)
	{
		spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		spinner.color = HUD_SPINNER_COLOR;
		spinner.hidesWhenStopped = YES;
	}
	if (spinner.superview == nil) [hud addSubview:spinner];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (image == nil)
	{
		image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
	}
	if (image.superview == nil) [hud addSubview:image];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (label == nil)
	{
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.font = HUD_STATUS_FONT;
        if (IOSVersion >= 7.0) {
            label.textColor = HUD_STATUS_COLOR;
        }else{
            label.textColor = HUD_STATUS_COLOR;
        }
		
        
        
		label.backgroundColor = [UIColor clearColor];
//		label.textAlignment = NSTextAlignmentCenter;
		label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		label.numberOfLines = 0;
	}
	if (label.superview == nil){
        UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:label];
        NSArray * arr = [[NSArray alloc]initWithObjects:item, nil];
        
        [hud setItems:arr];
        [hud addSubview:label];
    }
//    NSLog(@"%@",hud.subviews);
	//---------------------------------------------------------------------------------------------------------------------------------------------
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudDestroy
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[label removeFromSuperview];	label = nil;
	[image removeFromSuperview];	image = nil;
	[spinner removeFromSuperview];	spinner = nil;
	[hud removeFromSuperview];		hud = nil;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)rotate:(NSNotification *)notification
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self hudOrient];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudOrient
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	CGFloat rotate = 0.0;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	UIInterfaceOrientation orient = [[UIApplication sharedApplication] statusBarOrientation];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (orient == UIInterfaceOrientationPortrait)			rotate = 0.0;
	if (orient == UIInterfaceOrientationPortraitUpsideDown)	rotate = M_PI;
	if (orient == UIInterfaceOrientationLandscapeLeft)		rotate = - M_PI_2;
	if (orient == UIInterfaceOrientationLandscapeRight)		rotate = + M_PI_2;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	hud.transform = CGAffineTransformMakeRotation(rotate);
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudSize
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	CGRect labelRect = CGRectZero;
	CGFloat hudWidth = 100, hudHeight = 100;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (label.text != nil)
	{
		NSDictionary *attributes = @{NSFontAttributeName:label.font};
		NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
        CGSize size;
        if (IS_IOS7) {
            labelRect = [label.text boundingRectWithSize:CGSizeMake(200, 300) options:options attributes:attributes context:NULL];
            size = labelRect.size;
        }
		else{
            size = [label.text  sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200,300) lineBreakMode:NSLineBreakByWordWrapping];
        }
		labelRect.origin.x = 12;
		labelRect.origin.y = 66;

		hudWidth = size.width + 24;
		hudHeight = size.height + 80;

		if (hudWidth < 100)
		{
			hudWidth = 100;
			labelRect.origin.x = 0;
			labelRect.size.width = 100;
		}
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	CGSize screen = [UIScreen mainScreen].bounds.size;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	hud.center = CGPointMake(screen.width/2, screen.height/2-150);
	hud.bounds = CGRectMake(0, 0, hudWidth, hudHeight);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	CGFloat imagex = hudWidth/2;
	CGFloat imagey = (label.text == nil) ? hudHeight/2 : 36;
	image.center = spinner.center = CGPointMake(imagex, imagey);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	label.frame = labelRect;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudShow
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (self.alpha == 0)
	{
		self.alpha = 1;

		hud.alpha = 0;
		hud.transform = CGAffineTransformScale(hud.transform, 1.2, 1.2);

		NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;

		[UIView animateWithDuration:0.15 delay:0 options:options animations:^{
			hud.transform = CGAffineTransformScale(hud.transform, 1/1.4, 1/1.4);
			hud.alpha = 1;
		}
		completion:^(BOOL finished){ }];
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hudHide
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	if (self.alpha == 1)
	{
		NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn;

		[UIView animateWithDuration:0.15 delay:0 options:options animations:^{
			hud.transform = CGAffineTransformScale(hud.transform, 0.7, 0.7);
			hud.alpha = 0;
		}
		completion:^(BOOL finished)
		{
			[self hudDestroy];
			self.alpha = 0;
		}];
	}
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)timedHide
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	@autoreleasepool
	{
		double length = label.text.length;
		NSTimeInterval sleep = length * 0.04 + 0.5;
		
		[NSThread sleepForTimeInterval:sleep];
		[self hudHide];
	}
}


//-------------------===============自定义=============--------------------------------

- (void)hudMake2:(NSString *)status imgage:(UIImage *)img spin:(BOOL)spin hide:(BOOL)hide Width:(float)width High:(float)high
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
	[self hudCreate];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	label.text = status;
//    label.textAlignment = NSTextAlignmentCenter;
	label.hidden = (status == nil) ? YES : NO;
//    NSLog(@"%@",label.superview);
	//---------------------------------------------------------------------------------------------------------------------------------------------
	image.image = img;
	image.hidden = (img == nil) ? YES : NO;
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (spin) [spinner startAnimating]; else [spinner stopAnimating];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[self hudOrient];
	[self hudWidth:width High:high withText:status];
    
	[self hudShow];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if (hide) [NSThread detachNewThreadSelector:@selector(timedHide) toTarget:self withObject:nil];
}

// 设置弹出框宽高
- (void)hudWidth:(float)width High:(float)high withText:(NSString *)text
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    CGRect labelRect = CGRectZero;
    CGSize labelSize = CGSizeZero;
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    if (label.text != nil)
    {
        NSDictionary *attributes = @{NSFontAttributeName:label.font};
        NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
        
        if (IOSVersion >= 7.0) {
            labelRect = [label.text boundingRectWithSize:CGSizeMake(260, 300) options:options attributes:attributes context:NULL];
            
        }else{
            labelSize = [label.text  sizeWithFont:label.font constrainedToSize:CGSizeMake(260,300) lineBreakMode:NSLineBreakByClipping];
        }
        
        labelRect.origin.x = 12;
        labelRect.origin.y = 10;
        
        if (IOSVersion >= 7.0) {
            width = labelRect.size.width + 24;
        }else{
            width = labelSize.width + 24;
            labelRect.size.width  = labelSize.width;
            labelRect.size.height = labelSize.height;
        }
        width = labelRect.size.width + 24;
        //		high = 48;
        high =  labelRect.size.height + 20;
        
        //        if (width < 100)
        //        {
        //            width = 100;
        //            labelRect.origin.x = 0;
        //            labelRect.size.width = 80;
        //        }
    }
    //---------------------------------------------------------------------------------------------------------------------------------------------
    CGSize screen = [UIScreen mainScreen].bounds.size;
    //---------------------------------------------------------------------------------------------------------------------------------------------
    hud.center = CGPointMake(screen.width/2, screen.height/2 + 160);
    hud.bounds = CGRectMake(0, 0, width, high);
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    //CGFloat imagex = hudWidth/2;
    //CGFloat imagey = (label.text == nil) ? hudHeight/2 : 36;
    //image.center = spinner.center = CGPointMake(imagex, imagey);
    //---------------------------------------------------------------------------------------------------------------------------------------------
    
    label.frame = labelRect;
    
    UILabel *lab1 = (UILabel *)[self viewWithTag:2001];
    if(lab1)
        [lab1 removeFromSuperview];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.tag = 2001;
    lab.numberOfLines = 0;
    lab.textColor = label.textColor;
    lab.font = label.font;
    lab.frame = labelRect;
    lab.text = text;
    [self.hud addSubview:lab];
    [label removeFromSuperview];
}

@end
