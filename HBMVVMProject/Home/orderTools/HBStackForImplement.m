//
//  HBStackForImplement.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/3/7.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HBStackForImplement.h"

@interface HBStackForImplement ()
// 存储栈数据
@property (nonatomic, strong) NSMutableArray *stackArray;
@end

@implementation HBStackForImplement
//入栈
- (void)push:(id)obj {
    [self.stackArray addObject:obj];
}
//出栈 先进后出，后进先出
- (id)popObj {
    if ([self isEmpty]) {
        return nil;
    } else {
        return self.stackArray.lastObject;
    }
}
- (BOOL)isEmpty {
    return !self.stackArray.count;
}
//栈的长度
- (NSInteger)stackLength {
    return self.stackArray.count;
}
//从栈底遍历 顺序遍历数组
-(void)enumerateObjectsFromBottom:(StackBlock)block {
    [self.stackArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block ? block(obj) : nil;
    }];
}
//从栈顶遍历 逆序遍历数组
-(void)enumerateObjectsFromtop:(StackBlock)block {
    [self.stackArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block ? block(obj) : nil;
    }];
}
//出栈 逆序遍历数组
-(void)enumerateObjectsPopStack:(StackBlock)block {
    __weak typeof(self) weakSelf = self;
    NSUInteger count = self.stackArray.count;
    for (NSUInteger i = count; i > 0; i --) {
        if (block) {
            block(weakSelf.stackArray.lastObject);
            [self.stackArray removeLastObject];
        }
    }
}
//移除栈
-(void)removeAllObjects {
    [self.stackArray removeAllObjects];
}
//栈顶
-(id)topObj {
    if ([self isEmpty]) {
        return nil;
    } else {
        return self.stackArray.lastObject;
    }
}
 
- (NSMutableArray *)stackArray {
    if (!_stackArray) {
        _stackArray = [NSMutableArray array];
    }
    return _stackArray;
}
@end
