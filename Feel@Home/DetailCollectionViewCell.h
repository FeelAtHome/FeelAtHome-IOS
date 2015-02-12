//
//  DetailCollectionViewCell.h
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 04/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UILabel *sliderName;
@property (nonatomic, strong) IBOutlet UISlider *slider;

@end
