//
//  StepsTableViewController.h
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 11/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scenario.h"
#import "Action.h"
#import "Condition.h"
#import "IfThenViewController.h"

@interface StepsTableViewController : UITableViewController<IfThenViewControllerDelegate>
@property Scenario*     scenario;
@end
