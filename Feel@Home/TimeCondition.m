//
//  TimeCondition.m
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 09/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "TimeCondition.h"
#import "NSTimer+Blocks.h"

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
    nextNotif = [NSTimer scheduledTimerWithTimeInterval:[next timeIntervalSinceNow] block:^{
        cb();
        // [self nextDate]; // Theorically unneeded
        [self startWithCb:cb];
    } repeats:NO];
}

- (void)stop {
    NSLog(@"Stopping timer");
    [nextNotif invalidate];
}

-(void)dealloc {
    NSLog(@"TimeCondition deallocating");
}

- (void) nextDate {
    NSDateComponents* deltaComps = [[NSDateComponents alloc] init];
    [deltaComps setDay:1];

    NSDate *now = [NSDate date];
    while ([next compare:now] == NSOrderedAscending)
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
    self.title = @"Timer Configuration";
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


