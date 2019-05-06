//
//  LinkStackTests.m
//  GrandKitTests
//
//  Created by Evan Fang on 2019/5/6.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

/* 链栈定义 */

typedef char DataType;
typedef struct linkStack {
    DataType data;
    struct linkStack *next;
} StackNode, *LinkStack;

/* ----- END ----- */


/** 判栈空 */
int linkStackEmpty(LinkStack s) {
    return s == NULL;
}

/** 进栈 */
LinkStack pushLinkStack(LinkStack top, DataType x) {
    StackNode *node = (StackNode *)malloc(sizeof(StackNode));
    node->data = x;
    node->next = top;
    top = node;
    return top;
}

/** 出栈 */
LinkStack popLinkStack(LinkStack top, DataType *x) {
    
    LinkStack s = top;
    *x = s->data; // 保存删除节点值，并带回
    top = top->next;
    free(s);
    return top;
}

/** 打印链栈 */
void printLinkStack(LinkStack s) {
    StackNode *p = s;
    while(p->next != NULL)
    {
        NSLog(@"Tag %d", p->data);
        p = p->next;
    }
    NSLog(@"Tag %d", p->data);
    NSLog(@"Tag ------------");
}

@interface LinkStackTests : XCTestCase
@end

@implementation LinkStackTests


- (void)testLinkStack {
    
    StackNode *firstNode = (StackNode *)malloc(sizeof(StackNode));
    firstNode->data = 1;
    firstNode->next = NULL;
    printLinkStack(firstNode);
    
    LinkStack s = pushLinkStack(firstNode, 2);
    s = pushLinkStack(s, 3);
    printLinkStack(s);
    
    DataType *x;
    s = popLinkStack(s, x);
    printLinkStack(s);
    NSLog(@"Tag %d", &x);
    
}

@end
