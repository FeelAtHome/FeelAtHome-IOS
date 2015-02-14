//
//  NSMutableArray+QueueAdditions.h
//  FeelAtHome
//
//  Created by Robin LAMBERTZ on 14/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (QueueAdditions)
- (id) dequeue;
- (void) enqueue:(id)obj;

@end
