//
//  IfThenViewController.m
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 11/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "IfThenViewController.h"

@interface IfThenViewController ()

@end

@implementation IfThenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.conditionsController.delegate = self;
    self.actionsController.delegate = self;
    if (self.cond != nil)
        [self.conditionsController setSelectedClass: [self.cond class]];
    if (self.action != nil)
        [self.actionsController setSelectedClass: [self.action class]];
    if (self.action != nil && self.cond != nil)
        [self activateSaveButton];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedActions"])
        self.actionsController = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"embedConditions"])
        self.conditionsController = [segue destinationViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)choseCondition: (NSObject <Condition>*)cond {
    self.cond = cond;
    NSLog(@"Condition : %@", cond);
    if (self.action != nil)
        [self activateSaveButton];
}

- (void)choseAction: (NSObject <Action>*)action {
    self.action = action;
    NSLog(@"Action : %@", action);
    if (self.cond != nil)
        [self activateSaveButton];
}

- (void)activateSaveButton {
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
}

- (void)save {
    NSLog(@"Saving to %@", self.delegate);
    [self.delegate newStepWhen:self.cond then:self.action];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
