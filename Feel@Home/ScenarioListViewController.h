//
//  ScenariosViewController.h
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 09/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScenarioViewController.h"

@interface ScenarioListViewController : UITableViewController<ScenarioViewControllerDelegate>
@property UIBarButtonItem       *addButton;
@property NSMutableArray        *scenarios;
@end
