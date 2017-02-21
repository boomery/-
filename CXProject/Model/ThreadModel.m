//
//  ThreadModel.m
//  CXProject
//
//  Created by ZhangChaoxin on 16/5/6.
//  Copyright © 2016年 ZhangChaoxin. All rights reserved.
//

#import "ThreadModel.h"

@implementation ThreadModel
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
        if ([key isEqualToString:@"createdAt"])
        {
            //换算成时间
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:_createdAt/1000];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"yyyy/MM/dd HH:MM"];
            _dateString = [formatter stringFromDate:confromTimesp];
        }
        else if ([key isEqualToString:@"content"])
        {
            if (!_noHTML)
            {
                NSString *regEx = @"<([^>]*)>";
                NSString * stringWithoutHTML = [_content stringByReplacingOccurrencesOfRegex:regEx withString:@""];
                _content = stringWithoutHTML;
                
                NSString *newString = [stringWithoutHTML stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@"  "];
                _content = newString;
                _noHTML = YES;
            }
            _contentHeight = [HZUtil getHeightWithString:_content fontSize:13.5 width:DEF_SCREEN_WIDTH-10];
        }
        else if ([key isEqualToString:@"uid"])
        {
            NSString *regEx = @"<([^>]*)>";
            NSString * stringWithoutHTML = [_uid stringByReplacingOccurrencesOfRegex:regEx withString:@""];
            _uid = stringWithoutHTML;
        }
    }
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    return;
}
@end
