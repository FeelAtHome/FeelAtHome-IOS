//
//  Scenario.m
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 09/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "Scenario.h"

@implementation Scenario

#pragma mark - NSCoding
- (id) initWithCoder:(NSCoder *)decoder {
    self.title = [decoder decodeObjectForKey:@"title"];
    self.steps = [decoder decodeObjectForKey:@"steps"];
    self.enabled = [decoder decodeBoolForKey:@"enabled"];
    if (self.enabled)
        [self enable];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.steps forKey:@"steps"];
    [encoder encodeBool:self.enabled forKey:@"enabled"];
}

#pragma mark - end NSCoding

- (Scenario*) init
{
    self.title = @"";
    self.steps = [[NSMutableArray alloc] init];
    self.enabled = NO;
    return self;
}

- (Scenario*) initWithConditions: (NSArray*)conds forActions: (NSArray*) actions
{
    self = [self init];
    for (int i = 0; i < [conds count] && i < [actions count]; i++) {
        [self when:conds[i] then:actions[i]];
    }
    return self;
}

- (BOOL) containsCond: (NSObject<Condition>*)cond forAction:(NSObject<Action>*)action
{
    __block BOOL ret = NO;
    [self.steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj[@"condition"] == cond && obj[@"action"] == action)
            ret = *stop = YES;
    }];
    return ret;
}

- (void) when: (NSObject<Condition>*)cond then: (NSObject<Action>*)action
{
    [self.steps addObject:@{@"condition": cond, @"action": action}];
}

- (void) enable {
    self.enabled = YES;
    [self.steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj[@"condition"] startWithCb:^{
            [obj[@"action"] run];
        }];
    }];
}

- (void) disable {
    self.enabled = NO;
    [self.steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj[@"condition"] stop];
    }];
}

@end
