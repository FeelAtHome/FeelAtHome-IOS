//
//  deezer.h
//  deezer
//
//  Created by Charles HUANG on 05/02/15.
//  Copyright (c) 2015 Charles HUANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeezerConnect.h"
#import "DZRPlayer.h"

@interface Deezer : NSObject<DeezerSessionDelegate>
@property DZRPlayer *player;
-(void) deezerAuth;
-(void) deezerPlayArtist: (NSString*) Artist;
-(void) deezerPlayRadio: (id) Radio;
-(void) deezerNext;
-(void) deezerPlay;
-(void) deezerPause;
-(void) deezerStop;
-(void) deezerTogglePlay;

@end
