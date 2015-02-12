//
//  MyfoxLightsAction.m
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 11/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "MyfoxLightsAction.h"
#import "F@H_auth.h"

@implementation MyfoxLightsAction
{
 //   F_H_auth *auth;
    NSString *elecGroup;
    NSString *username;
    NSString *password;
}

#pragma mark - NSCoding

- (id) initWithCoder: (NSCoder*)decoder
{
    username = [decoder decodeObjectForKey:@"username"];
    password = [decoder decodeObjectForKey:@"password"];
  //  auth = [[F_H_auth alloc] init:username withPassword:password];
    elecGroup = [decoder decodeObjectForKey:@"elecGroup"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:username forKey:@"username"];
    [encoder encodeObject:password forKey:@"password"];
    [encoder encodeObject:elecGroup forKey:@"elecGroup"];
}

#pragma mark - end NSCoding

- (BOOL) isEqual: (NSObject*)obj
{
    if ([obj isKindOfClass:[MyfoxLightsAction class]])
        return [((MyfoxLightsAction*)obj)->elecGroup isEqualToString:elecGroup];
    else
        return NO;
}

+ (NSString*)name {
    return @"Turn on Lights";
}

- (void) run {
 //   [auth set_request_electric_group_new_state:elecGroup withState:1 withErrorHandler:nil];
}

@end
