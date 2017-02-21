//
//  UIView+Common.m
//  BlueMobiProject
//
//  Created by 朱 亮亮 on 14-4-28.
//  Copyright (c) 2014年 朱 亮亮. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect rect = self.frame;
    rect.origin.y = top;
    self.frame = rect;
}
- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect rect = self.frame;
    rect.origin.y = bottom - rect.size.height;
    self.frame = rect;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
- (void)removeAllSubviews
{
	while (self.subviews.count)
    {
		UIView *child = self.subviews.lastObject;
		[child removeFromSuperview];
	}
}

- (void)addConstraintWithItem:(UIView *)item ToTopMultiplier:(CGFloat)topMut constant:(CGFloat)topCon byTopView:(UIView *)topView;
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:topView
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:topMut
                                                      constant:topCon]];
}
- (void)addConstraintWithItem:(UIView *)item ToLeftMultiplier:(CGFloat)leftMut constant:(CGFloat)leftCon byLeftView:(UIView *)leftView
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:leftView
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:leftMut
                                                      constant:leftCon]];

}
- (void)addConstraintWithItem:(UIView *)item ToBottomMultiplier:(CGFloat)bottomMut constant:(CGFloat)bottomCon byBottomView:(UIView *)bottomView
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:bottomView
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:bottomMut
                                                      constant:bottomCon]];

}
- (void)addConstraintWithItem:(UIView *)item ToRightMultiplier:(CGFloat)rightMut constant:(CGFloat)rightCon byRightView:(UIView *)rightView
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:rightView
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:rightMut
                                                      constant:rightCon]];

}
// 计算时间间隔


- (NSString *)getDateIntervalFromData:(NSDate *)paramStartDate endDate:(NSDate *)paramEndDate
{
    if (paramStartDate != nil)
    {
        NSString *strResult = nil;
        NSCalendar *chineseClendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit|NSSecondCalendarUnit | NSDayCalendarUnit| NSMonthCalendarUnit | NSYearCalendarUnit;
       
        NSDateComponents *DateComponent = [chineseClendar components:unitFlags fromDate:paramStartDate toDate:paramEndDate options:0];
    
        NSInteger diffHour = [DateComponent hour];
        NSInteger diffMin = [DateComponent minute];
        NSInteger diffSec = [DateComponent second];
        NSInteger diffDay = [DateComponent day];
        NSInteger diffMon = [DateComponent month];
        NSInteger diffYear = [DateComponent year];
        NSInteger diffNoSec = [DateComponent nanosecond];
        if (diffYear>0)
        {
            strResult=[NSString stringWithFormat:@"%ld years ago",(long)diffYear];
        }else if(diffMon>0)
        {
            strResult=[NSString stringWithFormat:@"%ld months ago",(long)diffMon];
        }else if(diffDay>0)
        {
            strResult=[NSString stringWithFormat:@"%ld days ago",(long)diffDay];
        }else if(diffHour>0)
        {
            strResult=[NSString stringWithFormat:@"%ld hours ago",(long)diffHour];
        }else if(diffMin>0)
        {
            strResult=[NSString stringWithFormat:@"%ld minutes ago",(long)diffMin];
        }else if(diffSec>0)
        {
            strResult=[NSString stringWithFormat:@"%ld seconds ago",(long)diffSec];
        }
        else if (diffNoSec > 0)
        {
            strResult=[NSString stringWithFormat:@"Just now"];
        }
        else
        {
            strResult=[NSString stringWithFormat:@"The unknown time"];
        }
        return strResult;
    }
    else
    {
        return @"The unknown time";
    }
}
@end
