//
//  IfThenViewController.h
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 11/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConditionsTableViewController.h"
#import "ActionsTableViewController.h"
#import "Condition.h"
#import "Action.h"

@protocol IfThenViewControllerDelegate <NSObject>

- (void)newStepWhen: (NSObject <Condition>*)cond then: (NSObject <Action>*)action;

@end

@interface IfThenViewController : UIViewController<ConditionsTableViewControllerDelegate, ActionsTableViewControllerDelegate>
@property NSObject <Condition> *cond;
@property NSObject <Action>    *action;
@property(weak) ConditionsTableViewController* conditionsController;
@property(weak) ActionsTableViewController* actionsController;
@property(weak) id <IfThenViewControllerDelegate> delegate;
@end
