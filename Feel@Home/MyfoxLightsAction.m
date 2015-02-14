//
//  MyfoxLightsAction.m
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 11/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "MyfoxLightsAction.h"
#import "MyfoxAuth.h"


@interface MyfoxLightsActionViewController : SetupViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *lightsField;
@end

@implementation MyfoxLightsAction
{
    MyfoxAuth *auth;
    NSInteger elecGroup;
    NSString *username;
    NSString *password;
}

- (id) initWithDictionary: (NSDictionary*)dict
{
    username = dict[@"username"];
    password = dict[@"password"];
    auth = [[MyfoxAuth alloc] initAuthorize:username withPassword:password];
    elecGroup = dict[@"lights"];
    return self;
}

#pragma mark - NSCoding

- (id) initWithCoder: (NSCoder*)decoder
{
    username = [decoder decodeObjectForKey:@"username"];
    password = [decoder decodeObjectForKey:@"password"];
    auth = [[MyfoxAuth alloc] initAuthorize:username withPassword:password];
    elecGroup = [decoder decodeIntegerForKey:@"elecGroup"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:username forKey:@"username"];
    [encoder encodeObject:password forKey:@"password"];
    [encoder encodeInteger:elecGroup forKey:@"elecGroup"];
}

#pragma mark - end NSCoding

+ (NSString*)name {
    return @"Turn on Lights";
}

- (void) run {
    [auth set_request_electric_group_new_state:elecGroup withState:1 withErrorHandler:nil];
}

+ (SetupViewController*) setupView
{
    return [[MyfoxLightsActionViewController alloc] init];
}

@end

@implementation MyfoxLightsActionViewController
- (id)init
{
    self = [super initWithNibName:@"MyfoxLightsActionView" bundle:nil];
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameField)
        [self.passwordField becomeFirstResponder];
    else if (textField == self.passwordField)
        [self.lightsField becomeFirstResponder];
    else
        [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.canSave = YES;
    self.title = @"Myfox Shutter Configuration";
	// Do any additional setup after loading the view.
}

- (void) saveParams {
    [self.delegate createObj:[[MyfoxLightsAction alloc] initWithDictionary:@{
        @"username": self.usernameField.text,
        @"password": self.passwordField.text,
        @"lights": self.lightsField.text
    }]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

