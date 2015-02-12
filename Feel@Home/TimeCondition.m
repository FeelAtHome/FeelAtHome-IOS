//
//  TimeCondition.m
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 09/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "TimeCondition.h"
#import "NSInvocation+blocks.h"

@interface TimeConditionViewController : SetupViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *timeField;
@end

@implementation TimeCondition
{
    NSDate *next;
    NSTimer *nextNotif;
    NSDateFormatter *formatter;
}

- (id)init
{
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    next = [NSDate date];
    return self;
}

- (id) initWithDictionary: (NSDictionary*)dict
{
    self = [self init];
    next = dict[@"timer"];
    return self;
}

#pragma mark - NSCoding

- (id) initWithCoder: (NSCoder*)decoder
{
    self = [self init];
    next = [formatter dateFromString:[decoder decodeObjectForKey:@"time"]];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:[formatter stringFromDate:next] forKey:@"time"];
}

#pragma mark - end NSCoding

+ (NSString*)name {
    return @"At Given Time";
}

- (void)startWithCb:(void (^)())cb
{
    if ([next timeIntervalSinceNow] < 0)
        [self nextDate];
    nextNotif = [NSTimer timerWithTimeInterval:[next timeIntervalSinceNow] invocation:[NSInvocation jr_invocationWithTarget:nil block:^(id stuff) {
        cb();
        [self nextDate];
        [self startWithCb: cb];
    }] repeats:NO];
}

- (void)stop {
    [nextNotif invalidate];
}

- (void) nextDate {
    NSDateComponents* deltaComps = [[NSDateComponents alloc] init];
    [deltaComps setDay:1];

    while ([next timeIntervalSinceNow] < 0)
        next = [[NSCalendar currentCalendar] dateByAddingComponents:deltaComps toDate:next options:0];
}

+ (SetupViewController*)setupView {
    return [[TimeConditionViewController alloc] init];
}

@end

@implementation TimeConditionViewController
- (id)init {
    self = [super initWithNibName:@"TimeConditionViewController" bundle:nil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.canSave = YES;
    self.title = @"Myfox Shutter Configuration";
	// Do any additional setup after loading the view.
}

- (void) saveParams {
    [self.delegate createObj:[[TimeCondition alloc] initWithDictionary:@{@"timer": self.timeField.date}]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end


