//
//  DebugAction.m
//  FeelAtHome
//
//  Created by Robin LAMBERTZ on 13/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "SetupViewController.h"
#import "DebugAction.h"

@implementation DebugAction

+ (NSString*)name
{
    return @"Debug";
}


#pragma mark - NSCoding

- (id) initWithCoder: (NSCoder*)decoder
{
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
}

#pragma mark - end NSCoding

- (void) run {
    NSLog(@"Running Debug");
    //[auth set_request_shutter_new_state:heater withState:TRUE withErrorHandler:nil];
}

+ (SetupViewController*)setupView {
    return nil;
}

@end
