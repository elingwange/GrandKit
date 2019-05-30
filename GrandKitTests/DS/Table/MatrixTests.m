//
//  MatrixTests.m
//  GrandKitTests
//
//  Created by Evan on 2019/5/30.
//  Copyright © 2019 Evan Fang. All rights reserved.
//

#import <XCTest/XCTest.h>

#define n 3

void MM(int a[n][n])
{
    int i,j,temp;
    for(i = 0; i < n; i++)
        for(j = 0; j < i; j++)
        {
            temp = a[i][j];
            a[i][j] = a[j][i];
            a[j][i] = temp;
        }
    
    int zero = a[0][0];
    
//    for(i = 0; i < n; i++)
//    {
//        for(j = 0; j < n; j++)
//            NSLog(@"%d", a[i][j]);
//        NSLog(@"\n");
//    }
}

@interface MatrixTests : XCTestCase
@end

@implementation MatrixTests


- (void)testMatrix {
    
    int A[n][n] = {
        {1,2,3},
        {4,5,6},
        {7,8,9}
    };
    
    MM(A);
}

@end
