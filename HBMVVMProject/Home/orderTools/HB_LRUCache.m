//
//  HB_LRUCache.m
//  HBMVVMProject
//
//  Created by hongbao.cui on 2020/7/26.
//  Copyright © 2020 hongbao.cui. All rights reserved.
//

#import "HB_LRUCache.h"
@interface HB_LRUCache() {
    NSMutableDictionary *cacheDict;
    LinkNode *linkNode;
    int capacity;
    LinkNode *head;
    LinkNode *tail;
}
@end

@implementation HB_LRUCache
- (void)dealloc {
    free(linkNode);
    linkNode = NULL;
}
- (instancetype)initWithCapacity:(int)_capacity {
    self = [super init];
    if (self) {
        capacity = _capacity;
        cacheDict = [[NSMutableDictionary alloc] initWithCapacity:_capacity];
//        linkNode  = (LinkNode *)malloc(sizeof(LinkNode));
//        head = linkNode;
//        tail = linkNode;
//        LinkNode *currentLinkNode = NULL;
//        LinkNode *current = linkNode;
//        while (current&&_capacity>0) {
//            linkNode->data = 0;
//            LinkNode *node1 = (LinkNode *)malloc(sizeof(LinkNode));
//            linkNode->next =node1;
//            linkNode->pre = currentLinkNode;
//            currentLinkNode = linkNode->next;
//            current = current->next;
//            _capacity--;
//        }
    }
    return self;
}
- (void)moveToHead:(LinkNode *)node {
    if (node == NULL) {
        return;
    }
    LinkNode *tempTail = NULL;
    if (node->data == head->data) {
        return;
    } else if (node->data == tail->data) {
        tempTail = tail;
        tail->pre->next = NULL;
        tail = tail->pre;
    } else {
        tempTail = node;
        node->pre->next = node->next;
        node->next->pre = node->pre;
    }
    tempTail->next = head;
    head->pre = tempTail;
    head = tempTail;
}
- (void)addToHead:(LinkNode *)node {
    if ([cacheDict objectForKey:@(node->data)]) {
        [self moveToHead:node];
    } else {
        [cacheDict setObject:@(node->data) forKey:@(node->data)];
        node->next = head;
        head->pre = node;
        head = node;
    }
}
- (void)removeLastTail{
    tail->pre->next = NULL;
    tail = tail->pre;
    [cacheDict removeObjectForKey:@(tail->data)];
}
- (void)putValue:(int)value ForKey:(int)key  {
    if (cacheDict.count < capacity) {
        LinkNode *node = (LinkNode *)malloc(sizeof(linkNode));
        node->data = value;
        [self addToHead:node];
        [cacheDict setObject:@(node->data) forKey:@(node->data)];
    } else if(cacheDict.count == capacity) {
        LinkNode *node = (LinkNode *)malloc(sizeof(linkNode));
        node->data = value;
        [self moveToHead:node];
        [self removeLastTail];
    } else {
        LinkNode *node = (LinkNode *)malloc(sizeof(linkNode));
        node->data = value;
        [self addToHead:node];
        [self removeLastTail];
    }
}

- (void)getValueForKey:(int )key {
    
}
@end
