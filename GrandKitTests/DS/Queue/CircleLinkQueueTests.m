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
QueueNode * enqueueCLQueue(QueueNode *rear, DataType x) {
    QueueNode *s = (QueueNode *)malloc(sizeof(QueueNode));
    s->data = x;
    s->next = rear->next;
    rear->next = s;
    rear = s;
    return rear;
}

/** 出队列 */
void dequeueCLQueue(QueueNode *rear, DataType *x) {
    
    QueueNode *p = rear->next; // 指向头节点
    if (p->next == p) {
        // 如果头节点的next指针指向自己，则表明空队列
    }
    QueueNode *temp = p->next;
    p->next = p->next->next;
    *x = temp->data;
    free(temp);
}


void printCLQueue(QueueNode *rear) {
    QueueNode *p = rear->next->next;
    while (p->data != 0) {
        NSLog(@"Tag %c", p->data);
        p = p->next;
    }
//    NSLog(@"Tag %c", p->data);
    NSLog(@"Tag ------------");
}

@implementation CircleLinkQueueTests

- (void)testCircleLinkQueue {
    
    QueueNode rear;
    QueueNode *p = initCLQueue(&rear);
    
    p = enqueueCLQueue(p, 'A');
    p = enqueueCLQueue(p, 'B');
    p = enqueueCLQueue(p, 'C');
    p = enqueueCLQueue(p, 'D');
    printCLQueue(p);
    
    DataType x;
    dequeueCLQueue(p, &x);
    printCLQueue(p);
}

@end
