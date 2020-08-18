//
//  HB_LRUCache.h
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/7/26.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef struct LinkNode {
    int data;
    struct LinkNode * _Nullable next;
    struct LinkNode * _Nonnull pre;
}LinkNode;

NS_ASSUME_NONNULL_BEGIN
@interface HB_LRUCache : NSObject
- (instancetype)initWithCapacity:(int)capacity;

- (void)putValue:(int)value ForKey:(int)key;

- (void)getValueForKey:(int)key;
@end

NS_ASSUME_NONNULL_END
