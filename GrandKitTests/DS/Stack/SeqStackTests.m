//
//  StackTests.m
//  GrandKitTests
//
//  Created by Evan Fang on 2019/5/6.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

/* 顺序栈定义 */

#define StackSize 100
typedef char DataType;
typedef struct stack {
    DataType data[StackSize];
    int top;
} SeqStack;

/* ----- END ----- */


/** 置空栈 */
void initStack(SeqStack *stack);

/** 判栈空 */
int stackEmpty(SeqStack *stack);

/** 判栈满 */
int stackFull(SeqStack *stack);

/** 进栈 */
void push(SeqStack *stack, DataType data);

/** 出栈 */
DataType pop(SeqStack *stack);

/** 取栈顶元素 */
DataType getTop(SeqStack *stack);



void initStack(SeqStack *stack) {
    stack->top = -1;
}

int stackEmpty(SeqStack *stack) {
    return stack->top == -1;
}

int stackFull(SeqStack *stack) {
    return stack->top == (StackSize - 1);
}

void push(SeqStack *stack, DataType data) {
    stack->data[stack->top++] = data;
}

DataType pop(SeqStack *stack) {
    return stack->data[stack->top--];
}

DataType getTop(SeqStack *stack) {
    return stack->data[stack->top];
}


void printSeqStack(SeqStack *stack) {
    int index = 0;
    while (index < stack->top)
    {
        NSLog(@"Tag %c", stack->data[index++]);
    }
}

@interface SeqStackTests : XCTestCase
@end

@implementation SeqStackTests

- (void)testStack {
    SeqStack stack;
    stackEmpty(&stack);
    printSeqStack(&stack);
    
    push(&stack, 'A');
    push(&stack, 'B');
    printSeqStack(&stack);
    
}

@end
