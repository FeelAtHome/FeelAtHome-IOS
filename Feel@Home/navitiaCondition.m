//
//  navitiaAction.m
//  F@H
//
//  Created by Charles HUANG on 11/02/15.
//  Copyright (c) 2015 Charles HUANG. All rights reserved.
//

#import "navitiacondition.h"
#import "Navitia.h"
#import "NSInvocation+blocks.h"
#import "SetupViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface navitiaConditionViewController : SetupViewController<UITextFieldDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *departureField;
@property (weak, nonatomic) IBOutlet UITextField *arrivalField;
@property (weak, nonatomic) IBOutlet UIDatePicker *atField;
@end

@implementation navitiaCondition
{
    NSString*   from;
    NSString*   to;
    NSDate*     at;
    NSTimer*    nextNotif;
    Navitia*    navitia;
}

+(NSString*)name
{
    return @"When it's Time to Work";
}

-(id)initWithDictionary: (NSDictionary*) dict
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    from = dict[@"from"];
    if([from isEqualToString: @"OK"])
        from = dict[@"fromLocation"];
    else
    {
        [geocoder geocodeAddressString: from completionHandler:^(NSArray* placemarks, NSError* error){
            for (CLPlacemark* aPlacemark in placemarks)
            {
                // Process the placemark.
                NSString *latDest1 = [NSString stringWithFormat:@"%.5f",aPlacemark.location.coordinate.latitude];
                NSString *lngDest1 = [NSString stringWithFormat:@"%.5f",aPlacemark.location.coordinate.longitude];
                from = [NSString stringWithFormat: @"%@;%@", lngDest1, latDest1];
            }
        }];
    }
    
    to = dict[@"to"];
    if([to isEqualToString:@"OK"])
        to = dict[@"toLocation"];
    else
    {
        [geocoder geocodeAddressString: to completionHandler:^(NSArray* placemarks, NSError* error){
            for (CLPlacemark* aPlacemark in placemarks)
            {
                // Process the placemark.
                NSString *latDest1 = [NSString stringWithFormat:@"%.5f",aPlacemark.location.coordinate.latitude];
                NSString *lngDest1 = [NSString stringWithFormat:@"%.5f",aPlacemark.location.coordinate.longitude];
                to = [NSString stringWithFormat: @"%@;%@", lngDest1, latDest1];
            }
        }];
    }
    at = dict[@"at"];
    NSLog(@"%@",from);
    NSLog(@"%@",to);
    return self;
}
#pragma mark -NSCoding

-(id) initWithCoder:decoder
{
    from = [decoder decodeObjectForKey:@"from"];
    to = [decoder decodeObjectForKey:@"to"];
    at = [decoder decodeObjectForKey:@"at"];
    navitia = [Navitia alloc];
    return self;
}

- (void) encodeWithCoder: (NSCoder*)encoder
{
    [encoder encodeObject:from forKey:@"from"];
    [encoder encodeObject:to forKey:@"to"];
    [encoder encodeObject:to forKey:@"at"];
}

#pragma mark -NSCoding

+ (SetupViewController*)setupView {
    return [[navitiaConditionViewController alloc] init];
}

- (void) startWithCb:(void (^)())cb {
    [navitia departureTimeToArriveAt:at from:from to:to withBlock:^(NSDate *stuff) {
       nextNotif = [NSTimer timerWithTimeInterval:[stuff timeIntervalSinceNow] invocation:[NSInvocation jr_invocationWithTarget:Nil block:^(id target) {
           cb();
           [self startWithCb: cb];
       }] repeats:NO];
    }];
}

-(void) stop{
    [nextNotif invalidate];
}

- (void) nextDate {
    NSDateComponents* deltaComps = [[NSDateComponents alloc] init];
    [deltaComps setDay:1];
    
    while([at timeIntervalSinceNow] < 0)
        at =  [[NSCalendar currentCalendar] dateByAddingComponents:deltaComps toDate:at options:0];
}

@end

@implementation navitiaConditionViewController
{
    CLLocationManager   *locationManager;
    NSString            *fromLocate;
    NSString            *toLocate;
    NSString            *locate;
}
-(id)init{
    self = [super initWithNibName:@"NavitiaConditionView" bundle:nil];
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    self.canSave = YES;
    self.title = @"Journey configuration";
}

-(void) saveParams{
    [self.delegate createObj:[[navitiaCondition alloc] initWithDictionary:@{
        @"from": self.departureField.text,
        @"to": self.arrivalField.text,
        @"fromLocation": fromLocate,
        @"toLocation": toLocate,
        @"at": self.atField.date
    }]];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.departureField)
        [self.arrivalField becomeFirstResponder];
    else
        [textField resignFirstResponder];
    return YES;
}

- (IBAction)getDepartureLocation:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    if(locate != nil)
    {
        self.departureField.text = @"OK";
        fromLocate = locate;
    }
}

- (IBAction)getArrivalLocation:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    if(locate != nil)
    {
        self.arrivalField.text = @"OK";
        toLocate = locate;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        locate = [NSString stringWithFormat:@"%.5f;%.5f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude];
    }
    [locationManager stopUpdatingLocation];
}

@end
