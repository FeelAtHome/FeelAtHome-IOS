//
//  Pebble.m
//  FeelAtHome
//
//  Created by Robin LAMBERTZ on 14/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "Pebble.h"
#import "NSMutableArray+QueueAdditions.h"
#import <PebbleKit/PebbleKit.h>

@implementation Pebble
{
    NSMutableArray *queue;
    BOOL            isReady;
}

- (id)init
{
    queue = [[NSMutableArray alloc] init];
    isReady = YES;
    return self;
}

- (void)sendData:(NSDictionary*) dict
{
    [self sendData:dict withUUID:nil];
}

- (void)sendData:(NSDictionary*) dict withUUID:(NSData*) uuid
{
    [queue enqueue:@{@"dict": dict, @"uuid": uuid}];
    if (isReady)
    {
        [self finallySendData:[queue objectAtIndex:0] withUUID:uuid];
        isReady = NO;
    }
}

- (void)finallySendData:(NSDictionary*)dict withUUID: (NSData*)uuid
{
    void (^myBlock)(PBWatch*,NSDictionary*,NSError*) = ^(PBWatch *watch, NSDictionary *update, NSError *error) {
        if (error)
        {
            // TODO : Restart sending to the queue after some time elapsed.
            NSLog(@"ERROR : %@", error);
        }
        else
        {
            [queue dequeue];
            if ([queue count] == 0)
                isReady = YES;
            else
            {
                id obj = [queue objectAtIndex:0];
                [self finallySendData:obj[@"dict"] withUUID:obj[@"uuid"]];
            }
        }
    };
    
    if (uuid != nil)
        [[[PBPebbleCentral defaultCentral] lastConnectedWatch] appMessagesPushUpdate:dict withUUID:uuid onSent:myBlock];
    else
        [[[PBPebbleCentral defaultCentral] lastConnectedWatch] appMessagesPushUpdate:dict onSent:myBlock];
}

@end
