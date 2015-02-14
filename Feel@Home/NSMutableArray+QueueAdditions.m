//
//  NSMutableArray+QueueAdditions.m
//  FeelAtHome
//
//  Created by Robin LAMBERTZ on 14/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "NSMutableArray+QueueAdditions.h"

@implementation NSMutableArray (QueueAdditions)
// Queues are first-in-first-out, so we remove objects from the head
- (id) dequeue {
    // if ([self count] == 0) return nil; // to avoid raising exception (Quinn)
    id headObject = [self objectAtIndex:0];
    if (headObject != nil) {
#if !__has_feature(objc_arc)
        [[headObject retain] autorelease]; // so it isn't dealloc'ed on remove
#endif
        [self removeObjectAtIndex:0];
    }
    return headObject;
}

// Add to the tail of the queue (no one likes it when people cut in line!)
- (void) enqueue:(id)anObject {
    [self addObject:anObject];
    //this method automatically adds to the end of the array
}

@end
