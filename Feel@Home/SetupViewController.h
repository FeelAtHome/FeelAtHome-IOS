//
//  SetupViewController.h
//  FeelAtHome
//
//  Created by Robin LAMBERTZ on 12/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetupViewControllerDelegate <NSObject>
- (void) createObj: (id)obj;
@end

@interface SetupViewController : UIViewController
@property id <SetupViewControllerDelegate> delegate;
@property BOOL canSave;
- (void) saveParams;
@end
