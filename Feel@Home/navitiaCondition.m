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

@interface navitiaConditionViewController : SetupViewController<UITextFieldDelegate>
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

+ (NSString*)name
{
    return @"Time to go work";
}

-(id)initWithDictionary: (NSDictionary*) dict
{
    from = dict[@"from"];
    to = dict[@"to"];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString: from completionHandler:^(NSArray* placemarks, NSError* error){
        for (CLPlacemark* aPlacemark in placemarks)
        {
            // Process the placemark.
            NSString *latDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude];
            NSString *lngDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude];
            from = [NSString stringWithFormat: @"%@;%@", lngDest1, latDest1];
        }
    }];
    [geocoder geocodeAddressString: to completionHandler:^(NSArray* placemarks, NSError* error){
        for (CLPlacemark* aPlacemark in placemarks)
        {
            // Process the placemark.
            NSString *latDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.latitude];
            NSString *lngDest1 = [NSString stringWithFormat:@"%.4f",aPlacemark.location.coordinate.longitude];
            to = [NSString stringWithFormat: @"%@;%@", lngDest1, latDest1];
        }
    }];
    at = dict[@"at"];
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
}

#pragma mark -NSCoding

- (void) getNextDepartureTime: (void(^)())cb {
    [navitia departureTimeToArriveAt:at from:from to:to withBlock:^(NSDate *stuff) {
       nextNotif = [NSTimer timerWithTimeInterval:[stuff timeIntervalSinceNow] invocation:[NSInvocation jr_invocationWithTarget:Nil block:^(id target) {
           cb();
           [self getNextDepartureTime:cb];
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

+ (SetupViewController*)setupView {
    return [[navitiaConditionViewController alloc] init];
}

@end

@implementation navitiaConditionViewController

-(id)init{
    self = [super initWithNibName:@"NavitiaConditionView" bundle:nil];
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.canSave = YES;
    self.title = @"Journey configuration";
}

-(void) saveParams{
    [self.delegate createObj:[[navitiaCondition alloc] initWithDictionary:@{
        @"from": self.departureField.text,
        @"to": self.arrivalField.text,
        @"at": self.atField.date
    }]];
}

@end
