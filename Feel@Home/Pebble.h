//
//  Pebble.h
//  FeelAtHome
//
//  Created by Robin LAMBERTZ on 14/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pebble : NSObject
- (void)sendData:(NSDictionary*) dict;
- (void)sendData:(NSDictionary*) dict withUUID:(NSData*) uuid;
@end
