//
//  NetworkManager.h
//  CXProject
//
//  Created by ZhangChaoxin on 16/5/5.
//  Copyright © 2016年 ZhangChaoxin. All rights reserved.
//

#import "AFN/AFNetworking/NSURLSession/AFHTTPSessionManager.h"
@interface NetworkManager : AFHTTPSessionManager

//+ (NetworkManager *)shareManager;

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure showHud:(BOOL)showHud;

@end
