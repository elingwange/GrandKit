//
//  SeqListTests.m
//  GrandKitTests
//
//  Created by Evan on 2019/4/16.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

enum State {
    FAIL, OK
};



/* 线性表定义 */

#define ListSize 100
typedef int DataType;

typedef struct {
    DataType data[ListSize];
    int length; // 当前表长
} SeqList;

/* ----- END ----- */


@interface SeqListTests : XCTestCase

int init(SeqList *L);                                   /** 初始化操作，建立一个空的线性表 **/

void create(SeqList *L, int length);                    /** 创建一个链表长度为length的线性表 **/

void print(SeqList L);                                  /** 打印线性表中的每一个元素 **/

int getlength(SeqList L);                               /** 返回线性表元素的个数 **/

void insert(SeqList *L, int pos, DataType elem);        /** 在线性表的第pos个位置插入 一个新元素elem **/

int getElem(SeqList L, int pos, DataType *e);           /** 将线性表中第pos个位置的元素返回，保存在*e中 **/

int locate(SeqList L, DataType e);                      /** 在线性表中查找与给定元素e相等的元素，如果有相同的返回状态值1，如果没有，返回状态值0 **/

int delete(SeqList *L, int pos, DataType *elem);        /** 从线性表中删除pos位置处的元素，并将其存放在elem中； **/

int clear(SeqList L, SeqList *pL);                      /** 清空顺序表 **/

@end


/*
 InitList(L) 构造一个空的线性表L
 
 
 */


@implementation SeqListTests

int init(SeqList *L) {
    L->length = 0;
    return OK;
}

void create(SeqList *L, int length) {
    int index = 0;
    while (index < length) {
        L->data[index] = index;
        index++;
    }
    L->length = index;
}

void print(SeqList L) {
    int index = 0;
    while (index < L.length) {
        NSLog(@"%d", L.data[index]);
        index++;
    }
}

void insert(SeqList *L, int pos, DataType e) {
    
    int index = (L->length - 1);
    while (index >= (pos-1)) {
        L->data[index+1] = L->data[index];
        index--;
    }
    L->data[pos-1] = e;
    L->length++;
}


- (void)testInit {
    SeqList L;
    init(&L);
    
    create(&L, 10);
    
    print(L);
    NSLog(@"-----------");
    
    insert(&L, 1, 666);
    
    print(L);
    
}

@end
