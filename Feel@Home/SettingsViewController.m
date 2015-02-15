//
//  SettingsViewController.m
//  FeelAtHome
//
//  Created by Robin LAMBERTZ on 15/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *myfoxUsernameField;
@property (weak, nonatomic) IBOutlet UITextField *myfoxPasswordField;

@end

@implementation SettingsViewController

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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.myfoxUsernameField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"myfoxUsername"];
    self.myfoxPasswordField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"myfoxPassword"];
	// Do any additional setup after loading the view.
}

- (void)save
{
    [[NSUserDefaults standardUserDefaults] setObject:self.myfoxUsernameField.text forKey:@"myfoxUsername"];
    [[NSUserDefaults standardUserDefaults] setObject:self.myfoxPasswordField.text forKey:@"myfoxPassword"];
    [self.delegate startMyfoxCommunication];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
