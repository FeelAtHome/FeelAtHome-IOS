//
//  MasterViewController.h
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 29/01/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//@property (strong, nonatomic) DetailViewController      *detailViewController;
@property NSArray                   *sites;
@property NSDictionary              *sitesData;
@end
