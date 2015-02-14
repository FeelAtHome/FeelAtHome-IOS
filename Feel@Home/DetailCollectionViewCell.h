//
//  DetailCollectionViewCell.h
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 04/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCollectionViewCell : UICollectionViewCell
@end


@protocol DetailCollectionViewCellDelegate <NSObject>
- (void)light: (DetailCollectionViewCell*)cell toggle: (BOOL)on;
@end

@interface DetailCollectionViewCell ()

@property (nonatomic, strong) IBOutlet UILabel *sliderName;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property id <DetailCollectionViewCellDelegate> delegate;

@end