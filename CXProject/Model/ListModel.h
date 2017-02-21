//
//  ListModel.h
//  CXProject
//
//  Created by ZhangChaoxin on 16/5/6.
//  Copyright © 2016年 ZhangChaoxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

@property (nonatomic, assign)float tag;
@property (nonatomic, assign)int cooldown;
@property (nonatomic, assign)int theID;
@property (nonatomic, assign)int lock;
@property (nonatomic, copy)NSString *name;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
