//
//  LinkListTests.m
//  GrandKitTests
//
//  Created by Evan Fang on 2019/4/22.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

/* 单链表定义 */

typedef struct note{
    int data;
    struct note *next;
} Node;

typedef Node LinkList;

/* ----- END ----- */


@interface LinkListTests : XCTestCase
@end


@implementation LinkListTests

LinkList *creatLinkList(int n) {
    Node *head, *tail;
    head = (Node *)malloc(sizeof(Node));
//    NSLog(@"Tag %d", head->data);
    
    tail = head;
    for (int i = 1; i < n; i++) {
        Node *node = (Node *)malloc(sizeof(Node));
        node->data = i;
//        NSLog(@"Tag %d", node->data);
        
        tail->next = node;
        tail = node;
    }
    tail->next = NULL;
    return head;
}

void printLinkList(LinkList *pList) {
    Node *p = pList;
    while(p->next != NULL) {
        NSLog(@"Tag %d", p->data);
        p = p->next;
    }
    NSLog(@"Tag %d", p->data);
    NSLog(@"Tag ------------");
}

LinkList * insertToHead(LinkList *pList, Node *pNode) {
    pNode->next = pList;
    return pNode;
}

LinkList * insertToRear(LinkList *pList, Node *pNode) {
    // 定义初始指向头部的尾指针
    Node *pear = pList;
    // 将尾指针移到尾部
    while (pear->next != NULL) {
        pear = pear->next;
    }
    pear->next = pNode;
    pNode->next = NULL;
    return pList;
}

LinkList * insertList(LinkList *list, Node *node, int position) {
    
    Node *pMoving = list;
    // 将指针移动到指定位置的前一位
    for (int i = 1; i < (position - 1); i++) {
        pMoving = pMoving->next;
    }
    node->next = pMoving->next;
    pMoving->next = node;
    
    return list;
}

LinkList * deleteList(LinkList *list, int position) {
    Node *near = list;
    for (int i = 1; i < (position - 1); i++) {
        near = near->next;
    }
    // 此处对节点指针的释放的用法有问题
//    Node *node = near->next;
//    free(node);
    near->next = near->next->next;
    return list;
}

- (void)testLinkList {

    LinkList *pList = creatLinkList(5);
//    printLinkList(pList);
    
    Node *node = (Node *)malloc(sizeof(Node));
//    node->data = 11;
//    pList = insertToHead(pList, node);
//    printLinkList(pList);
//
//    // 头节点 表头节点
//
//    node = (Node *)malloc(sizeof(Node));
//    node->data = 22;
//    pList = insertToRear(pList, node);
    printLinkList(pList);
    
    node->data = 99;
    pList = insertList(pList, node, 2);
    printLinkList(pList);
    
    
    pList = deleteList(pList, 2);
    printLinkList(pList);
    
}

@end
