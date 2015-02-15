//
//  DebugCondition.m
//  FeelAtHome
//
//  Created by Robin LAMBERTZ on 15/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "DebugCondition.h"
#import "SetupViewController.h"

@implementation DebugCondition

#pragma mark - NSCoding

- (id) initWithCoder: (NSCoder*)decoder
{
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
}

#pragma mark - end NSCoding

+ (NSString*)name {
    return @"When Saving Scenario";
}

- (void)startWithCb:(void (^)())cb
{
    cb();
}

- (void)stop {
    NSLog(@"Nothing to stop");
}

+ (SetupViewController*)setupView {
    return nil;
}

@end
