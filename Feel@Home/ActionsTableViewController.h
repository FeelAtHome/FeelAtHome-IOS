//
//  ActionsTableViewController.h
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 11/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Action.h"

@protocol ActionsTableViewControllerDelegate <NSObject>

- (void)choseAction: (NSObject <Action>*)cond;

@end

@interface ActionsTableViewController : UITableViewController<SetupViewControllerDelegate>
@property NSArray *actionsClasses;
@property id <ActionsTableViewControllerDelegate> delegate;
@property Class selectedClass;
@end
