//
//  DeezerViewController.m
//  FeelAtHome
//
//  Created by Robin LAMBERTZ on 15/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "DeezerViewController.h"
#import "Deezer.h"

@interface DeezerViewController ()

@end

@implementation DeezerViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Wallpaper"]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Play:(id)sender {
    [[Deezer sharedInstance] deezerTogglePlay];
}
- (IBAction)next:(id)sender {
    [[Deezer sharedInstance] deezerNext];
}

@end
