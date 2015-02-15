//
//  MasterViewController.m
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 29/01/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MasterCollectionViewCell.h"
#import "MyfoxAuth.h"
#import "NXOauth2Constants.h"
#import <PebbleKit/PebbleKit.h>
#import "Pebble.h"
#import "Scenario.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController
{
    MyfoxAuth   *auth;
    Pebble      *pebble;
    NSData      *pebbleAppUUID;
}
- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUUID *nsuuid = [[NSUUID alloc] initWithUUIDString:@"36f9150f-83f1-4eee-8547-864bd16bec87"];
    uuid_t uuid;
    [nsuuid getUUIDBytes:uuid];
    pebbleAppUUID = [NSData dataWithBytes:uuid length:16];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"PwettyCell"];
    [self startPebbleCommunication];
    // TODO : Should probably use keychain instead of NSUserDefault
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"myfoxUsername"] == nil)
        [self performSegueWithIdentifier:@"showSettings" sender:self];
    else
        [self startMyfoxCommunication];

    
    // TODO : Loading and setting up of the tasks should happen in AppDelegate
    // self.scenarios = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"scenarios"];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Wallpaper"]];
    [Scenario sharedInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Pebble Coms

- (void)startPebbleCommunication
{
    PBWatch *watch = [[PBPebbleCentral defaultCentral] lastConnectedWatch];
    [watch appMessagesAddReceiveUpdateHandler:^BOOL(PBWatch *watch, NSDictionary *update) {
        NSLog(@"%@", update);
        if (update[@0] == 0)
        {
            [self.sites enumerateObjectsUsingBlock:^(id obj, NSUInteger key, BOOL *stop) {
                [pebble sendData:@{
                    @0: [NSNumber numberWithUint8:1],
                    @1: [NSNumber numberWithUint32:key],
                    @2: obj
                }];
            }];
        }
        return YES;
    } withUUID:pebbleAppUUID];
}

- (void)startMyfoxCommunication
{
    if (auth == nil)
        auth = [[MyfoxAuth alloc] initAuthorize:[[NSUserDefaults standardUserDefaults] objectForKey:@"myfoxUsername"] withPassword:[[NSUserDefaults standardUserDefaults] objectForKey:@"myfoxPassword"]];
    self.sitesData = [[NSMutableDictionary alloc] init];
    [auth list_devices:@"shutter" withBlock:^(NSArray *arr, NSError *err) {
        self.sitesData[@"Blinds"] = @{@"icon" : @"Blinds", @"data": @{@"Switches": [[NSMutableArray alloc] init]}};
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.sitesData[@"Blinds"][@"data"][@"Switches"] addObject:@{@"name": obj[@"label"], @"id": obj[@"deviceId"]}];
        }];
        self.sites = [[self.sitesData keyEnumerator] allObjects];
        [auth list_devices:@"heater" withBlock:^(NSArray *arr, NSError *err) {
            if (err)
            {
                NSLog(@"You got mail 2 ! : %@", err);
                return;
            }
            self.sitesData[@"Heater"] = @{@"icon" : @"Heater", @"data": @{@"Switches": [[NSMutableArray alloc] init]}};
            [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self.sitesData[@"Heater"][@"data"][@"Switches"] addObject:@{@"name": obj[@"label"], @"id": obj[@"deviceId"]}];
            }];
            self.sites = [[self.sitesData keyEnumerator] allObjects];
            [auth list_devices:@"electric" withBlock:^(NSArray *arr, NSError *err) {
                if (err)
                {
                    NSLog(@"You got mail 2 ! : %@", err);
                    return;
                }
                self.sitesData[@"Lights"] = @{@"icon" : @"LightBulb", @"data": @{@"Switches": [[NSMutableArray alloc] init]}};
                [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [self.sitesData[@"Lights"][@"data"][@"Switches"] addObject:@{@"name": obj[@"label"], @"id": obj[@"groupId"]}];
                }];
                self.sites = [[self.sitesData keyEnumerator] allObjects];
                [self.collectionView reloadData];
                NSLog(@"%@", self.sitesData);
            }];
        }];
    }];
/*    self.sitesData = [NSMutableDictionary dictionaryWithDictionary:@{@"Lights": @{@"icon": @"LightBulb", @"data": @{@"Switches" : @[@{@"name": @"Living Room"}]}},
                       @"Alarms": @{ @"icon": @"Alarm", @"data": @{} },
                       @"Blinds": @{ @"icon": @"Blinds", @"data": @{} },
                       @"Door": @{ @"icon": @"Door", @"data": @{} },
                       @"Electric": @{ @"icon": @"Electric", @"data": @{} },
                       //@"Music": @{ @"icon": @"Music", @"data": @{} },
                       @"Heater": @{ @"icon": @"Heater", @"data": @{} }
                                                                     }];
    self.sites = [[self.sitesData keyEnumerator] allObjects];*/
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ([self.sites count] + 1);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return (1);
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MasterCollectionViewCell *cell;
    if (indexPath.row < [self.sites count])
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PwettyCell" forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:self.sitesData[self.sites[indexPath.row]][@"icon"]];
    }
    else
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DeezerCell" forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamed:@"Music"];
    }
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.layer.masksToBounds = YES;
    cell.layer.shadowOpacity = 0.25f;
    cell.layer.shadowRadius = 0.0f;
    cell.layer.shadowOffset = CGSizeZero;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    return (cell);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"%@", self.sitesData[self.sites[indexPath.row]][@"data"]);
//    [self performSegueWithIdentifier:@"ShowDetails" sender:self.sitesData[self.sites[indexPath.row]][@"data"]];
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"details"])
    {
        NSIndexPath *path = [[self.collectionView indexPathsForSelectedItems] lastObject];
        NSDictionary *data = self.sitesData[self.sites[path.row]][@"data"];
        [(DetailViewController*)segue.destinationViewController setDetailItem:@{@"key": self.sites[path.row], @"value": data}];
    }
    else if ([segue.identifier isEqualToString:@"showSettings"])
    {
        [segue.destinationViewController setDelegate:self];
    }
}

#pragma mark - UICollectionViewFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 2) / 2, ([UIScreen mainScreen].bounds.size.height - 70) / 4);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
