//
//  CircleLinkQueueTests.m
//  GrandKitTests
//
//  Created by Evan Fang on 2019/5/9.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CircleLinkQueueTests : XCTestCase
@end


/* 循环链表队列定义 */
typedef char DataType;

typedef struct node {
    DataType data;
    struct node *next;
} QueueNode, *rear;

/* ----- END ----- */


/** 初始化空队列 */
QueueNode * initCLQueue(QueueNode *rear) {
    rear = (QueueNode *)malloc(sizeof(QueueNode));
    rear->next = rear;
    return rear;
}

/** 入队列 */
void enqueueCLQueue(QueueNode *rear, DataType x) {
    QueueNode *s = (QueueNode *)malloc(sizeof(QueueNode));
    s->data = x;
    s->next = rear->next;
    rear->next = s;
    rear = s;
}

/** 出队列 */
void dequeueCLQueue(QueueNode *rear, DataType x) {
    
    
    
}


void printCLQueue(QueueNode *rear) {
    QueueNode *p = rear->next;
    while (p->data != 0) {
        NSLog(@"Tag %c", p->data);
        p = p->next;
    }
//    NSLog(@"Tag %c", p->data);
    NSLog(@"Tag ------------");
}

@implementation CircleLinkQueueTests

- (void)testCircleLinkQueue {
    
    QueueNode *rear;
    QueueNode *p = initCLQueue(rear);
    
    enqueueCLQueue(p, 'A');
    enqueueCLQueue(p, 'B');
//    enqueueCLQueue(p, 'C');
//    enqueueCLQueue(p, 'D');
    printCLQueue(p);
}

@end
