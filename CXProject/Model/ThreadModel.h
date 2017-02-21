//
//  ThreadModel.h
//  CXProject
//
//  Created by ZhangChaoxin on 16/5/6.
//  Copyright © 2016年 ZhangChaoxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreadModel : NSObject

@property (nonatomic, assign)float forum;
@property (nonatomic, assign)int replyCount;
@property (nonatomic, strong)NSArray *recentReply;
@property (nonatomic, assign)long int updatedAt;
@property (nonatomic, assign)long int createdAt;

@property (nonatomic, strong)NSNumber *theID;

@property (nonatomic, copy)NSString *uid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *email;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *image;
@property (nonatomic, copy)NSString *thumb;
@property (nonatomic, copy)NSString *lock;
@property (nonatomic, copy)NSString *sage;


//json接口中没有的属性
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) BOOL noHTML;
@property (nonatomic, copy) NSString *dateString;

- (id)initWithDictionary:(NSDictionary *)dictionary;


@end
