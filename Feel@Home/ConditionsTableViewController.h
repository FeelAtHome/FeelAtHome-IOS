//
//  ConditionsTableViewController.h
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 11/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Condition.h"

@protocol ConditionsTableViewControllerDelegate <NSObject>

- (void)choseCondition: (NSObject <Condition>*)cond;

@end

@interface ConditionsTableViewController : UITableViewController
@property NSArray *conditionsClasses;
@property id <ConditionsTableViewControllerDelegate> delegate;
@property Class selectedClass;

@end
