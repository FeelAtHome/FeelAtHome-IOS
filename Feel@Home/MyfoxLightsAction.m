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
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation MyfoxLightsAction
{
    MyfoxAuth *auth;
    NSString *elecGroup;
    NSString *username;
    NSString *password;
}

- (id) initWithDictionary: (NSDictionary*)dict
{
    elecGroup = dict[@"elecGroup"];
    return self;
}

#pragma mark - NSCoding

- (id) initWithCoder: (NSCoder*)decoder
{
    username = [decoder decodeObjectForKey:@"username"];
    password = [decoder decodeObjectForKey:@"password"];
    auth = [[MyfoxAuth alloc] initAuthorize:username withPassword:password];
    elecGroup = [decoder decodeObjectForKey:@"elecGroup"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:username forKey:@"username"];
    [encoder encodeObject:password forKey:@"password"];
    [encoder encodeObject:elecGroup forKey:@"elecGroup"];
}

#pragma mark - end NSCoding

- (BOOL) isEqual: (NSObject*)obj
{
    if ([obj isKindOfClass:[MyfoxLightsAction class]])
        return [((MyfoxLightsAction*)obj)->elecGroup isEqualToString:elecGroup];
    else
        return NO;
}

+ (NSString*)name {
    return @"Turn on Lights";
}

- (void) run {
    NSLog(@"Running Lights");
    //[auth set_request_electric_group_new_state:elecGroup withState:1 withErrorHandler:nil];
}

+ (SetupViewController*) setupView
{
    return [[MyfoxLightsActionViewController alloc] init];
}

@end

@implementation MyfoxLightsActionViewController
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
    [self.delegate createObj:[[MyfoxLightsAction alloc] initWithDictionary:@{@"shutter": self.textField.text}]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

