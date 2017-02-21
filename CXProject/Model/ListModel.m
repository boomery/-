//
//  ListModel.m
//  CXProject
//
//  Created by ZhangChaoxin on 16/5/6.
//  Copyright © 2016年 ZhangChaoxin. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        _theID = value;
    }
    else
    {
        [super setValue:value forKey:key];
    }
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    return;
}

@end
