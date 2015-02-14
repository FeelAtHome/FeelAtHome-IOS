//
//  Navitia.h
//  F@H
//
//  Created by Charles HUANG on 04/02/15.
//  Copyright (c) 2015 Charles HUANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Navitia : NSObject
- (void) departureTimeToArriveAt:(NSDate*)at from:(NSString*)from to:(NSString*)to withBlock:(void (^)(NSDate*))cb;
@end
