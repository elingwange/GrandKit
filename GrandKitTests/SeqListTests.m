//
//  SeqListTests.m
//  GrandKitTests
//
//  Created by Evan on 2019/4/16.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SeqListTests : XCTestCase
@end

#define ListSize 100
typedef int DataType;

typedef struct {
    DataType data[ListSize];
    int length; // 当前表长
} SeqList;

/*
 InitList(L) 构造一个空的线性表L
 
 
 */


@implementation SeqListTests

void InitList(SeqList *L) {
    
}



- (void)testExample {
    SeqList *L;
    InitList(L);
}

@end
