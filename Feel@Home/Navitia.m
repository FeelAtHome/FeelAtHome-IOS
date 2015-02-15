//
//  Navitia.m
//  F@H
//
//  Created by Charles HUANG on 04/02/15.
//  Copyright (c) 2015 Charles HUANG. All rights reserved.
//

#import "Navitia.h"
#import <CoreLocation/CoreLocation.h>
#import <LRResty.h>

@implementation Navitia

- (void) departureTimeToArriveAt:(NSDate*)at from:(NSString*)from to:(NSString*)to withBlock:(void (^)(NSDate*))cb
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"YYYYMMDD'T'hhmmss"];
    NSString *formattedDateString = [dateFormatter stringFromDate:at];
    
    NSLog(@"at : %@", at);
    NSLog(@"from : %@", from);
    NSLog(@"to : %@", to);
    [[LRResty client] get:[NSString stringWithFormat: @"http://api.navitia.io/v1/journeys?from=%@&to=%@&forbidden_uris[]=car&datetime_represents=arrival&datetime=%@", from, to, formattedDateString] parameters:nil headers:@{@"Authorization": @"a6d8832a-c863-4134-a17a-821f41b605a1"} withBlock:^(LRRestyResponse *response) {
        NSError *error = nil;
        NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:[response responseData] options:kNilOptions error:&error];
        NSDictionary *bestJourney = [(NSArray*)parsedData[@"journeys"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"type == %@", @"best"]][0];
        NSDate *date = [dateFormatter dateFromString:bestJourney[@"departure_date_time"]];
        cb(date);
    }];
}

@end
