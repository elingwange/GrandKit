//
//  LinkStackTests10.m
//  GrandKitTests
//
//  Created by Evan Fang on 2019/5/7.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface LinkStackTests10 : XCTestCase
@end


/* 顺序栈定义 */

#define StackSize 100
typedef char DataType;
typedef struct {
    DataType data[StackSize];
    int top;
} SeqStack;

/* ----- END ----- */

void initStack_10(SeqStack *stack) {
    stack->top = 0;
}

int stackEmpty_10(SeqStack *stack) {
    return stack->top == -1;
}

int stackFull_10(SeqStack *stack) {
    return stack->top == (StackSize - 1);
}

void push_10(SeqStack *stack, DataType data) {
    stack->data[stack->top] = data;
    stack->top++;
}

DataType pop_10(SeqStack *stack) {
    DataType data = stack->data[(stack->top - 1)];
    stack->top--;
    return data;
}

DataType getTop_10(SeqStack *stack) {
    return stack->data[stack->top];
}


/*
 1-判断是否是回文，如 ababbaba, abcba
 
 2-阶乘
 */


@implementation LinkStackTests10

int sysmetry(char str[]) {
    
    SeqStack stack;
    initStack_10(&stack);
    
    int j, k, i = 0;
    
    while (str[i] != '\0') i++;
    
    for (j = 0; j < i / 2; j++)
        push_10(&stack, str[j]);
    
    k = (i + 1) / 2;
    for (j = k; j < i; j++)
        if (str[j] != pop_10(&stack))
            return 0;
    
    return 1;
}

- (void)testLinkStack_10 {
    
    char str[] = "fababaababaf";
    if (sysmetry(str)) {
        NSLog(@"Tag 是回文");
    } else {
        NSLog(@"Tag 不是回文");
    }
}


/*
 n!
 */
int fact(int n) {
    int temp;
    if (n == 0)
        return 1;
    else
        temp = n * fact(n - 1);
r12: return temp;
}

- (void)testFact {
    int n = fact(3);
rl1: NSLog(@"Tag 3! = %d", n);
}


/*
         n + 1  (n<2)
 fu() =
         fu(n/2) * fu(n/4)  (n>=2)
 */
float fu(int n) {
    if (n < 2)
        return (n + 1);
    else
        return fu(n / 2) * fu(n / 4);
}

- (void)testFu {
    int n = 3;
    float result = fu(n);
    NSLog(@"Tag %f", result);
}

@end
