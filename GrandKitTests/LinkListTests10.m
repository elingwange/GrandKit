//
//  LinkListTests10.m
//  GrandKitTests
//
//  Created by Evan Fang on 2019/4/28.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface LinkListTests10 : XCTestCase
@end


typedef int DataType;
typedef struct node {
    DataType data;
    struct node *next;
} ListNode, *LinkList;



/*
 已知两单链表A和B分别表示两个集合，其元素值递增有序。
 试写一算法，求A和B的交集C，要求C同样以元素值递增的单链表形式存储。
 
 用例1: A {1, 2, 3, 4}, B {2, 4, 6} -> C {2, 4}
 ...
 */

@implementation LinkListTests10


LinkList creatLinkListA_10(int n) {
    ListNode *head, *tail;
    head = (ListNode *)malloc(sizeof(ListNode));
    tail = head;
    for (int i = 1; i < n; i++) {
        ListNode *node = (ListNode *)malloc(sizeof(ListNode));
        node->data = i;
        tail->next = node;
        tail = node;
    }
    tail->next = NULL;
    return head;
}

LinkList creatLinkListB_10(int n) {
    ListNode *head, *tail;
    head = (ListNode *)malloc(sizeof(ListNode));
    tail = head;
    for (int i = 2; i < n; i += 2) {
        ListNode *node = (ListNode *)malloc(sizeof(ListNode));
        node->data = i;
        tail->next = node;
        tail = node;
    }
    tail->next = NULL;
    return head;
}

void printLinkList_10(LinkList list) {
    ListNode *p = list;
    while(p->next != NULL) {
        NSLog(@"Tag %d", p->data);
        p = p->next;
    }
    NSLog(@"Tag %d", p->data);
    NSLog(@"Tag ------------");
}


LinkList mixLinkList(LinkList A, LinkList B)
{
    ListNode *pa;
    // 创建链表C
    LinkList C = (ListNode *)malloc(sizeof(ListNode));
    ListNode *pc = C;
    
    pa = A->next;
    while (!(pa->data == 0 && pa->next == NULL))
    {
        ListNode *pb = B->next;
        
        while (pb->next != NULL)
        {
            if (pa->data == pb->data)
            {
                ListNode *node = (ListNode *)malloc(sizeof(ListNode));
                node->data = pb->data;
                pc->next = node;
                pc = pc->next;
            }
            pb = pb->next;
        }
        pa = pa->next;
    }
    
    
    return C;
}



- (void)testLinkList_10 {
    
    LinkList A = creatLinkListA_10(5);
    printLinkList_10(A);
    
    LinkList B = creatLinkListB_10(8);
    printLinkList_10(B);
    
//    LinkList C = mixLinkList(A, B);
//    printLinkList_10(C);
    
}


@end
