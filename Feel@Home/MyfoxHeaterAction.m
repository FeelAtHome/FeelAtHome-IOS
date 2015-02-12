//
//  MyfoxHeaterAction.m
//  FeelAtHome
//
//  Created by Michael BARBARIN on 11/02/15.
//  Copyright (c) 2015 Michael BARBARIN. All rights reserved.
//

#import "MyfoxHeaterAction.h"
#import "MyfoxAuth.h"

@interface MyfoxHeaterActionViewController : SetupViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation MyfoxHeaterAction
{
    MyfoxAuth *auth;
    NSString *heater;
    NSString *username;
    NSString *password;
}

+ (NSString*)name
{
    return @"Turn on Heater";
}

- (id) initWithDictionary:(NSDictionary *)dict
{
    heater = dict[@"heater"];
    username = dict[@"username"];
    password = dict[@"password"];
    return self;
}

#pragma mark - NSCoding

- (id) initWithCoder: (NSCoder*)decoder
{
    username = [decoder decodeObjectForKey:@"username"];
    password = [decoder decodeObjectForKey:@"password"];
    auth = [[MyfoxAuth alloc] initAuthorize:username withPassword:password];
    heater = [decoder decodeObjectForKey:@"Heater"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:username forKey:@"username"];
    [encoder encodeObject:password forKey:@"password"];
    [encoder encodeObject:heater forKey:@"Heater"];
}

#pragma mark - end NSCoding

- (void) run {
    NSLog(@"Running Heater");
    //[auth set_request_shutter_new_state:heater withState:TRUE withErrorHandler:nil];
}

+ (MyfoxHeaterActionViewController*)setupView {
    return [[MyfoxHeaterActionViewController alloc] init];
}

@end

@implementation MyfoxHeaterActionViewController
- (id)init {
    self = [super initWithNibName:@"MyfoxHeaterActionView" bundle:nil];
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.canSave = YES;
    self.title = @"Myfox Heater Configuration";
	// Do any additional setup after loading the view.
}

- (void) saveParams {
    [self.delegate createObj:[[MyfoxHeaterAction alloc] initWithDictionary:@{@"heater": self.textField.text}]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

