//
//  NSStringTests.m
//  GrandKitTests
//
//  Created by Evan Fang on 2019/4/15.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSStringTests : XCTestCase

@end

@implementation NSStringTests

- (void)testRange {
    NSString *str = @"+86|18062658756";
    NSRange range = [str rangeOfString:@"|"];
    str = [str substringFromIndex:(range.location + 1)];
    str = [NSString stringWithFormat:@"%@****%@", [str substringWithRange:NSMakeRange(0, 3)], [str substringFromIndex:7]];
    
}


@end
