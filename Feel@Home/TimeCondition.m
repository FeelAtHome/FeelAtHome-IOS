//
//  TimeCondition.m
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 09/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "TimeCondition.h"
#import "NSInvocation+blocks.h"
@implementation TimeCondition
{
    NSDate *next;
    NSTimer *nextNotif;
    NSDateFormatter *formatter;
}

#pragma mark - NSCoding

- (id) initWithCoder: (NSCoder*)decoder
{
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    next = [formatter dateFromString:[decoder decodeObjectForKey:@"time"]];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:[formatter stringFromDate:next] forKey:@"time"];
}

#pragma mark - end NSCoding

- (id) init {
    next = [NSDate date];
    return self;
}

+ (NSString*)name {
    return @"At Given Time";
}

- (void)startWithCb:(void (^)())cb
{
    if ([next timeIntervalSinceNow] < 0)
        [self nextDate];
    nextNotif = [NSTimer timerWithTimeInterval:[next timeIntervalSinceNow] invocation:[NSInvocation jr_invocationWithTarget:nil block:^(id stuff) {
        cb();
        [self nextDate];
        [self startWithCb: cb];
    }] repeats:NO];
}

- (void)stop {
    [nextNotif invalidate];
}

- (void) nextDate {
    NSDateComponents* deltaComps = [[NSDateComponents alloc] init];
    [deltaComps setDay:1];

    while ([next timeIntervalSinceNow] < 0)
        next = [[NSCalendar currentCalendar] dateByAddingComponents:deltaComps toDate:next options:0];
}

@end
