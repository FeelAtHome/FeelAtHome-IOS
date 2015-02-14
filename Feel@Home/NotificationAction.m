//
//  PebbleNotifAction.m
//  FeelAtHome
//
//  Created by Robin LAMBERTZ on 14/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "NotificationAction.h"
#import <PebbleKit/PebbleKit.h>

@implementation NotificationAction
#pragma mark - NSCoding

- (id) initWithCoder: (NSCoder*)decoder
{
    //username = [decoder decodeObjectForKey:@"username"];
    //password = [decoder decodeObjectForKey:@"password"];
    //auth = [[MyfoxAuth alloc] initAuthorize:username withPassword:password];
    //elecGroup = [decoder decodeObjectForKey:@"elecGroup"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
    //[encoder encodeObject:username forKey:@"username"];
    //[encoder encodeObject:password forKey:@"password"];
    //[encoder encodeObject:elecGroup forKey:@"elecGroup"];
}

#pragma mark - end NSCoding

+ (NSString*)name {
    return @"Send a Notification";
}

- (void) run {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"This is local notification";
    notification.alertAction = @"View Details";
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    //[auth set_request_electric_group_new_state:elecGroup withState:1 withErrorHandler:nil];
}

+ (SetupViewController*) setupView
{
    return nil;
}

@end
