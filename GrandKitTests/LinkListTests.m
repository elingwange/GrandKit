//
//  LinkListTests.m
//  GrandKitTests
//
//  Created by Evan Fang on 2019/4/22.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

/* 单链表定义 */

typedef char DataType;

typedef struct note {
    DataType data;
    struct note *next;
} Node;

typedef Node * LinkList;

/* ----- END ----- */


@interface LinkListTests : XCTestCase

//void init(LinkList p);                                   /** 初始化操作，建立一个空链表 **/



@end

@implementation LinkListTests


//void init(LinkList p) {
//    p->data = 0;
//    p->next = NULL;
//}


- (void)testLinkList {


}

@end
