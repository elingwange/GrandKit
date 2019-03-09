//
//  CalendarUtil.m
//  GrandKit
//
//  Created by Evan Fang on 2019/3/9.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import "CalendarUtil.h"

@implementation CalendarUtil

+ (NSInteger)getCurrentMonthForDays {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSRange range = [currentCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    NSLog(@"nsrange = %@----- %ld",NSStringFromRange(range),range.location);
    return numberOfDaysInMonth;
}


@end
