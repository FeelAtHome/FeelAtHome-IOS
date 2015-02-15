//
//  SettingsViewController.h
//  FeelAtHome
//
//  Created by Robin LAMBERTZ on 15/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SettingsViewControllerDelegate
- (void)startMyfoxCommunication;
@end

@interface SettingsViewController : UIViewController
@property id <SettingsViewControllerDelegate> delegate;
@end
