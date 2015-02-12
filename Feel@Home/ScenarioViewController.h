//
//  ScenarioViewController.h
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 11/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scenario.h"

@protocol ScenarioViewControllerDelegate <NSObject>
- (void)scenarioChanged: (Scenario*)scenario;
@end

@interface ScenarioViewController : UIViewController<UITextFieldDelegate>
@property Scenario *scenario;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property id <ScenarioViewControllerDelegate> delegate;
@end
