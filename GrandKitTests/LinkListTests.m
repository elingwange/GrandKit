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

LinkList *creatLinkList2(int n) {
    Node *head, *tail;
    head = (Node *)malloc(sizeof(Node));
    tail = head;
    for (int i = 0; i < n; i++) {
        Node *node = (Node *)malloc(sizeof(Node));
        node->data = i + 1;
        tail->next = node;
        tail = node;
    }
    tail->next = NULL;
    return head;
}

void printLinkList(LinkList *pList) {
    while(pList->next != NULL) {
        NSLog(@"Tag %d", pList->data);
        pList = pList->next;
    }
}


- (void)testLinkList {

    LinkList *pList = creatLinkList2(5);
    printLinkList(pList);
}

@end
