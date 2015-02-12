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

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

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
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"PwettyCell"];

    // TODO : Request those from myfox
    self.sitesData = @{@"Lights": @{@"icon": @"LightBulb", @"data": @{@"Switches" : @[@{@"name": @"Living Room"}]}},
                       @"Alarms": @{ @"icon": @"Alarm", @"data": @{} },
                       @"Blinds": @{ @"icon": @"Blinds", @"data": @{} },
                       @"Door": @{ @"icon": @"Door", @"data": @{} },
                       @"Electric": @{ @"icon": @"Electric", @"data": @{} },
                       @"Music": @{ @"icon": @"Music", @"data": @{} },
                       @"Heater": @{ @"icon": @"Heater", @"data": @{} }
    };
    self.sites = [[self.sitesData keyEnumerator] allObjects];

    // TODO : Loading and setting up of the tasks should happen in AppDelegate
    // self.scenarios = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"scenarios"];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Wallpaper"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ([self.sites count]);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return (1);
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MasterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PwettyCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.sitesData[self.sites[indexPath.row]][@"icon"]];
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
    NSLog(@"%@", self.sitesData[self.sites[indexPath.row]][@"data"]);
//    [self performSegueWithIdentifier:@"ShowDetails" sender:self.sitesData[self.sites[indexPath.row]][@"data"]];
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"details"])
    {
        NSIndexPath *path = [[self.collectionView indexPathsForSelectedItems] lastObject];
        NSLog(@"%@", self.sitesData[self.sites[path.row]]);
        NSDictionary *data = self.sitesData[self.sites[path.row]][@"data"];
        NSLog(@"%@", data);
        [(DetailViewController*)segue.destinationViewController setDetailItem:@{@"key": self.sites[path.row], @"value": data}];
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
