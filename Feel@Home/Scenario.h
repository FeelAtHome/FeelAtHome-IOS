//
//  Scenario.h
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 09/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Condition.h"
#import "Action.h"

@interface Scenario : NSObject<NSCoding>
@property NSString          *title;
@property NSMutableArray    *steps;
@property BOOL              enabled;

- (Scenario*) initWithConditions: (NSArray*)conds forActions: (NSArray*) actions;
- (void) when: (NSObject<Condition>*)cond then: (NSObject<Action>*)action;
- (void) enable;
- (void) disable;
@end
