//
//  SetupViewController.m
//  FeelAtHome
//
//  Created by Robin LAMBERTZ on 12/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "SetupViewController.h"

@interface SetupViewController ()

@end

@implementation SetupViewController
{
    UIBarButtonItem *saveBtn;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveClicked)];
    self.canSave = NO;
    self.navigationItem.leftBarButtonItem = saveBtn;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveClicked
{
    [self saveParams];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)canSave
{
    return saveBtn.enabled;
}

- (void)setCanSave: (BOOL)save
{
    saveBtn.enabled = save;
}

@end
