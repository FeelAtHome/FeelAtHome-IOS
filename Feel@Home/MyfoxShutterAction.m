//
//  MyfoxShutterAction.m
//  FeelAtHome
//
//  Created by Michael BARBARIN on 11/02/15.
//  Copyright (c) 2015 Michael BARBARIN. All rights reserved.
//

#import "MyfoxShutterAction.h"
#import "MyfoxAuth.h"

@interface MyfoxShutterActionViewController : SetupViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation MyfoxShutterAction
{
    MyfoxAuth *auth;
    NSString *shutter;
    NSString *username;
    NSString *password;
}

+ (NSString*) name
{
    return @"Open the Shutters";
}


- (id) initWithDictionary: (NSDictionary*)dict
{
    username = dict[@"username"];
    password = dict[@"password"];
    auth = [[MyfoxAuth alloc] initAuthorize:username withPassword:password];
    shutter = dict[@"shutter"];
    return self;
}

#pragma mark - NSCoding

- (id) initWithCoder: (NSCoder*)decoder
{
    username = [decoder decodeObjectForKey:@"username"];
    password = [decoder decodeObjectForKey:@"password"];
    auth = [[MyfoxAuth alloc] initAuthorize:username withPassword:password];
    shutter = [decoder decodeObjectForKey:@"shutter"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:username forKey:@"username"];
    [encoder encodeObject:password forKey:@"password"];
    [encoder encodeObject:shutter forKey:@"shutter"];
}

#pragma mark - end NSCoding

- (void) run {
    NSLog(@"Running shutter");
//    [auth set_request_shutter_new_state:shutter withState:TRUE withErrorHandler:nil];
}

+ (SetupViewController*) setupView
{
    return [[MyfoxShutterActionViewController alloc] init];
}

@end


@implementation MyfoxShutterActionViewController
- (id)init {
    self = [super initWithNibName:@"MyfoxShutterActionView" bundle:nil];
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
    self.title = @"Myfox Shutter Configuration";
	// Do any additional setup after loading the view.
}

- (void) saveParams {
    [self.delegate createObj:[[MyfoxShutterAction alloc] initWithDictionary:@{@"shutter": self.textField.text}]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

