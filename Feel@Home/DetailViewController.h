//
//  DetailViewController.h
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 29/01/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
