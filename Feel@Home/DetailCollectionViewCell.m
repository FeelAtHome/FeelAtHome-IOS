//
//  DetailCollectionViewCell.m
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 04/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "DetailCollectionViewCell.h"

@implementation DetailCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)lightsSwitched {
    [self.delegate light:self toggle:self.switchButton.on];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
