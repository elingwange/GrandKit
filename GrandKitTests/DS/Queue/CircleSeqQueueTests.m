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
    int top, rear;
} CircleSeqQueue;

/* ----- END ----- */

CircleSeqQueue createCSQ() {
    CircleSeqQueue queue;
    queue.top = queue.rear = 0;
    return queue;
}

/*
 * 入队
 */
CircleSeqQueue * enqueueCSQ(CircleSeqQueue *queue, DataType x) {
    // 判断CircleSeqQueue是否已满
    if ((queue->rear + 1) % MAX_SIZE != queue->top) {
        queue->data[queue->rear] = x;
        queue->rear = (queue->rear + 1) % MAX_SIZE;
    }
    return queue;
}

/*
 * 队列长度
 */
int lengthCSQ(CircleSeqQueue *queue) {
    
    // （rear - front + QueueSize）% QueueSize
    
    
    
    
    return 0;
}

/*
 * 出队
 */
CircleSeqQueue * dequeueCSQ(CircleSeqQueue *q, DataType *x) {
    *x = q->data[q->top];
    q->top = (q->top + 1) % MAX_SIZE;
    return q;
}


@implementation CircleSeqQueueTests


- (void)testCircleSeqQueue {
    
    CircleSeqQueue queue = createCSQ();
    CircleSeqQueue *q = enqueueCSQ(&queue, 'A');
    q = enqueueCSQ(&queue, 'A');
    
    DataType x;
    q = dequeueCSQ(q, &x);
    
    
}

@end
