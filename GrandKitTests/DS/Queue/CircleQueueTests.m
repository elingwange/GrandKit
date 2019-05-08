//
//  CircleQueueTests.m
//  GrandKitTests
//
//  Created by Evan Fang on 2019/5/8.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CircleQueueTests : XCTestCase
@end


/* 顺序循环队列定义 */

#define QueueSize 5
typedef char DataType;

typedef struct {
    DataType data[QueueSize];
    int front, pear;
} CirQueue;

/* ----- END ----- */


/** 置空队列 */
void initQueue(CirQueue *Q) {
    Q->front = Q->pear = 0;
}

/** 判队空 */
int queueEmpty(CirQueue *Q) {
    return Q->front == Q->pear;
}

/** 判队满 */
int queueFull(CirQueue *Q) {
    return (Q->pear + 1) % QueueSize == Q->front;
}

/** 入队列 */
void enQueue(CirQueue *Q, DataType x) {
    if (queueFull(Q)) {
        // "Queue overflow"
        return;
    }
    Q->data[Q->pear] = x;
    Q->pear = (Q->pear + 1) % QueueSize;
}

/** 取对头元素 */


/** 出队列 */
DataType deQueue(CirQueue *Q) {
    
    if (queueEmpty(Q)) {
        // empty
        return 0;
    }
    DataType x = Q->data[Q->front];
    Q->front = (Q->front + 1) % QueueSize;
    return x;
}


@implementation CircleQueueTests

- (void)testCircleQueue {
    
    CirQueue queue;
    initQueue(&queue);
    
    enQueue(&queue, 'A');
    enQueue(&queue, 'B');
    enQueue(&queue, 'C');
    deQueue(&queue);
    deQueue(&queue);
    enQueue(&queue, 'D');
    enQueue(&queue, 'E');
    enQueue(&queue, 'F');
    enQueue(&queue, 'G');
    
    
}

@end
