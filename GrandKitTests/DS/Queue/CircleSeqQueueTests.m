//
//  CircleSeqQueueTests.m
//  GrandKitTests
//
//  Created by Evan Fang on 2019/5/15.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CircleSeqQueueTests : XCTestCase

@end


/*
 
 在循环队列的顺序存储结构下，分别写入队（插入元素）、出队（删除元素）时修改队尾、队头指针的操作语句以及求队列长度的公式。
 
 1-循环队列的顺序存储结构
 2-入队
 3-出队
 4-队列长度
 
 */


/* 循环队列的顺序存储结构定义 */

#define MAX_SIZE 100
typedef char DataType;

typedef struct queue {
    DataType data[MAX_SIZE];
    
} CircleSeqQueue;


/* ----- END ----- */




@implementation CircleSeqQueueTests


- (void)testCircleSeqQueue {
    
    
    
}

@end
