//
//  LinkListTests2.m
//  GrandKitTests
//
//  Created by Evan Fang on 2019/4/24.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface LinkListTests : XCTestCase
@end

typedef int DataType;
typedef struct node {
    DataType data;
    struct node *next;
} ListNode;

typedef ListNode *LinkList;
LinkList *p;
LinkList head;


@implementation LinkListTests

LinkList creatLinkList(int n) {
    ListNode *head, *tail;
    head = (ListNode *)malloc(sizeof(ListNode));
//    NSLog(@"Tag %d", head->data);

    tail = head;
    for (int i = n; i > 0; i -= 2) {
        ListNode *node = (ListNode *)malloc(sizeof(ListNode));
        node->data = i;
//        NSLog(@"Tag %d", node->data);

        tail->next = node;
        tail = node;
    }
    tail->next = NULL;
    return head;
}

void printLinkList(LinkList list) {
    ListNode *p = list;
    while(p->next != NULL) {
        NSLog(@"Tag %d", p->data);
        p = p->next;
    }
    NSLog(@"Tag %d", p->data);
    NSLog(@"Tag ------------");
}

ListNode *GetNodei(LinkList head, int i) {
    
    ListNode *p; int j;
    p=head->next; j=1;
    while (p != NULL && j<i) {
        p=p->next; ++j;
    }
    if (j==i)
        return p;
    else
        return NULL;
}

void split(LinkList a, LinkList b) {
    ListNode *p, *r, *s;    // 使用局部的指针变量，便于临时操作
    p = a->next;    // p指向表头节点，游标指针
    r = a;          // r指向A表的当前节点
    s = b;          // s指向B表的当前节点
    while (p != NULL) {
        r->next = p;        // 序号为奇数的节点链接到A表上
        r = p;              // r总是指向A链表到最后一个节点
        p = p->next;        // 游标指针指向下一节点
        if (p != NULL) {
            s->next = p;
            s = p;
            p = p->next;
        }
    }
    r->next = s->next = NULL;
}

LinkList mergeList(LinkList La, LinkList Lb) {
    ListNode *pa, *pb, *pc;
    pa = La->next;
    pb = Lb->next;
    LinkList Lc;
    Lc = pc = La;
    
    while (pa != NULL && pb != NULL) {
        if (pa->data <= pb->data) {
            pc->next = pa;
            pc = pa;
            pa = pa->next;
        }
        else {
            pc->next = pb;
            pc = pb;
            pb = pb->next;
        }
    }
    pc->next = pa != NULL ? pa : pb;
    free(Lb);
    return Lc;
}

void insertList(LinkList head, ListNode *node) {
    
    ListNode *p;
    p = head;
    
    while (p->next != head) {
        
        
    }
    
    
}

- (void)testLinkList {
    
    head = creatLinkList(10);
    printLinkList(head);
    
//    ListNode *node = GetNodei(head, 5);
//    NSLog(@"Tag %d", node->data);
    
//    LinkList b = (ListNode *)malloc(sizeof(ListNode));
//    split(head, b);
//    printLinkList(head);
    
//    LinkList Lc = mergeList(head, b);
//    printLinkList(Lc);
    
    ListNode *node = (ListNode *)malloc(sizeof(ListNode));
    node->data = 5;
    insertList(head, node);
    
}

@end
