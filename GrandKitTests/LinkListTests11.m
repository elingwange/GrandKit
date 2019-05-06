//
//  LinkListTests11.m
//  GrandKitTests
//
//  Created by Evan Fang on 2019/4/30.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface LinkListTests11 : XCTestCase
@end


typedef int DataType;
typedef struct node {
    DataType data;
    struct node *next;
    struct node *prior;
} ListNode, *LinkList;


/*
 设有一个带头节点的双向循环链表，head为头指针。
 试写一算法，实现在值为x的节点之前插入一个值为y的节点。
 
 ...
 */


@implementation LinkListTests11

LinkList creatLinkListA_11(int n) {
    ListNode *head, *tail;
    head = (ListNode *)malloc(sizeof(ListNode));
    tail = head;
    for (int i = 1; i < n; i++) {
        ListNode *node = (ListNode *)malloc(sizeof(ListNode));
        node->data = i;
        tail->next = node;
        node->prior = tail;
        tail = node;
    }
    tail->next = head;
    head->prior = tail;
    return head;
}

void printLinkList_11(LinkList list) {
    ListNode *p = list;
    while(p->next != list) {
        NSLog(@"Tag %d", p->data);
        p = p->next;
    }
    NSLog(@"Tag %d", p->data);
    NSLog(@"Tag ------------");
}


void insertDLLinkList(LinkList list, DataType x, DataType y)
{
    ListNode *p = list->next;
    
    while (p != list)
    {
        if (p->data == x)
        {
            ListNode *node = (ListNode *)malloc(sizeof(ListNode));
            node->data = y;
            p->prior->next = node;
            node->prior = p->prior;
            p->prior = node;
            node->next = p;
            break;
        }
        p = p->next;
    }
}



- (void)testLinkList_11 {
    
    LinkList A = creatLinkListA_11(13);
    printLinkList_11(A);
    
    insertDLLinkList(A, 9, 99);
    printLinkList_11(A);
}

@end
