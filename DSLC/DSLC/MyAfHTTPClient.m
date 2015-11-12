//
//  MyAfHTTPClient.m
//  DSLC
//
//  Created by 马成铭 on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyAfHTTPClient.h"

@implementation MyAfHTTPClient

//static NSString * MYAFHTTP_BASEURL = @"http://192.168.0.178:8080/tongjiang/admin/p2p/";
static NSString * MYAFHTTP_BASEURL = @"http://192.168.0.161:8080/zhongxin/interface/p2p/";


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

- (void)postWithURLString:(NSString *)URLString
                    parameters:(id)parameters
                       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure{
    
    NSString *URLPostString = [NSString stringWithFormat:@"%@%@",MYAFHTTP_BASEURL,URLString];
    
    NSLog(@"%@",URLPostString);
    
    NSLog(@"parameters = %@",parameters);
    
    [self POST:URLPostString parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nonnull responseObject) {
        
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
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

@end
