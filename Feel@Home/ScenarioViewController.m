//
//  ScenarioViewController.m
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 11/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "ScenarioViewController.h"

@interface ScenarioViewController ()

@end

@implementation ScenarioViewController
{
    UIBarButtonItem *saveButton;
}
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
    saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    NSLog(@"Loaded view");
    self.titleField.text = self.scenario.title;
    saveButton.enabled = ![self.titleField.text isEqualToString:@""];
	// Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"shouldReturn");
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)text
{
    if ([text isEqualToString:@""] && range.location == 0 && range.length >= [textField.text length])
        saveButton.enabled = NO;
    else
        saveButton.enabled = YES;
    return YES;
}

- (void)save: (id)sender {
    NSLog(@"Saved");
    self.scenario.title = self.titleField.text;
    if (self.delegate != nil)
        [self.delegate scenarioChanged: self.scenario];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Segue Ident : %@", [segue identifier]);
    if ([segue.identifier isEqualToString:@"embedTable"])
    {
        NSLog(@"Scenario = %@", self.scenario);
        [segue.destinationViewController setScenario:self.scenario];
    }
}

@end
