//
//  MyAfHTTPClient.m
//  DSLC
//
//  Created by 马成铭 on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyAfHTTPClient.h"
#import "TWOLoginAPPViewController.h"

@implementation MyAfHTTPClient

+ (_Nullable instancetype)sharedClient {
    static MyAfHTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    if (_sharedClient == nil) {
        _sharedClient = [[MyAfHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:MYAFHTTP_BASEURL]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        // 设置请求格式
        _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        // 设置返回格式
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    });
    return _sharedClient;
}

+ (nullable NSDictionary *)parseJSONStringToNSDictionary:(nullable NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

//- (NSURLSessionDataTask *)GET:(NSString *)URLString
//                   parameters:(id)parameters
//                      success:(void (^)(NSURLSessionDataTask * _Nullable, id _Nonnull))success
//                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
//    
//    NSURLSessionDataTask *dataTask = [MyAfHTTPClient dataTaskWithHTTPMethod:@"GET" URLString:URLString parameters:parameters success:success failure:failure];
//    
//    [dataTask resume];
//    
//    return dataTask;
//    
//    
//}

- (void)postWithURLStringP:(NSString *)URLString
               parameters:(id)parameters
                  success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSString * _Nullable responseObject))success
                  failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure{
    
//    NSString *URLPostString = [NSString stringWithFormat:@"https://yintong.com.cn/traderapi/cardandpay.htm"];
    
    [self POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nonnull responseObject) {
        
        NSData *doubi = responseObject;
        NSMutableString *responseString = [[NSMutableString alloc] initWithData:doubi encoding:NSUTF8StringEncoding];
        
//        NSLog(@"responseString = %@",responseString);
        
        NSString *character = nil;
        for (int i = 0; i < responseString.length; i ++) {
            character = [responseString substringWithRange:NSMakeRange(i, 1)];
            if ([character isEqualToString:@"\\"])
                [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
        }
        responseString = [[responseString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]] copy];
//        NSLog(@"postWithURLStringP = %@",responseString);
//        NSDictionary *responseData = [MyAfHTTPClient parseJSONStringToNSDictionary:responseString];
        success(task,responseString);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}


- (void)postWithURLString:(NSString *)URLString
                    parameters:(id)parameters
                       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure{
    
    NSString *URLPostString = [NSString stringWithFormat:@"%@%@",MYAFHTTP_BASEURL,URLString];
    
    NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [newParameters setObject:@"com.gcct.dslc" forKey:@"packageName"];
    
    [self POST:URLPostString parameters:newParameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nonnull responseObject) {
        
        NSData *doubi = responseObject;
        NSMutableString *responseString = [[NSMutableString alloc] initWithData:doubi encoding:NSUTF8StringEncoding];
        
//        NSLog(@"%@",responseString);
        
        NSString *character = nil;
        for (int i = 0; i < responseString.length; i ++) {
            character = [responseString substringWithRange:NSMakeRange(i, 1)];
            if ([character isEqualToString:@"\\"])
                [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
        }
        responseString = [[responseString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]] copy];
//        NSLog(@"%@",responseString);
        NSDictionary *responseData = [MyAfHTTPClient parseJSONStringToNSDictionary:responseString];
        
        success(task,responseData);
        if ([[responseData objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:400]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"fortyWithLogin" object:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

- (void)uploadFile:(UIImage *)img
{
    NSString *URLPostString = [NSString stringWithFormat:@"%@%@",MYAFHTTP_BASEURL,@"user/upUserHeader"];

    NSDictionary *dicMine = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSData *data = [self resetSizeOfImageData:img maxSize:1024 * 2];
    
    NSDictionary *dic = @{@"ImgData":data,@"token":[dicMine objectForKey:@"token"]};
    
    [self POST:URLPostString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        [formData appendPartWithFileData:data name:@"ImgData" fileName:fileName mimeType:@"application/octet-stream"];
    } success:^(NSURLSessionDataTask * _Nullable task, id  _Nonnull responseObject) {
        NSData *doubi = responseObject;
        NSMutableString *responseString = [[NSMutableString alloc] initWithData:doubi encoding:NSUTF8StringEncoding];
        
        NSString *character = nil;
        for (int i = 0; i < responseString.length; i ++) {
            character = [responseString substringWithRange:NSMakeRange(i, 1)];
            if ([character isEqualToString:@"\\"])
                [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
        }
        responseString = [[responseString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]] copy];
        
        NSLog(@"responseString = %@",responseString);
        
        NSDictionary *responseData = [MyAfHTTPClient parseJSONStringToNSDictionary:responseString];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
        
        [dic setValue:[responseData objectForKey:@"avatarImg"] forKey:@"avatarImg"];
        
        [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
        
        NSLog(@"上传成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败");
    }];
}

- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        return finallImageData;
    }
    
    return imageData;
}

@end
