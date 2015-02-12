//
//  Condition.h
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 09/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetupViewController.h"

@protocol Condition <NSCoding>
- (void)startWithCb: (void(^)())cb;
- (void)stop;

+ (NSString*)name;
+ (SetupViewController*)setupView;

@end
