//
//  deezer.m
//  deezer
//
//  Created by Charles HUANG on 05/02/15.
//  Copyright (c) 2015 Charles HUANG. All rights reserved.
//

#import "deezer.h"
#import "DeezerConnect.h"
#import "DZRRequestManager.h"
#import "DZRObject.h"
#import "DZRRadio.h"
#import "DZRPlayer.h"

@implementation Deezer
{
    id nextToPlay;
}

-(void) deezerAuth
{
    DeezerConnect *dzrconnect = [[DeezerConnect alloc] initWithAppId:@"150241" andDelegate:self];

    [[DZRRequestManager defaultManager] setDzrConnect:dzrconnect];
    [dzrconnect authorize:@[DeezerConnectPermissionBasicAccess]];
    NSLog(@"#YOLO");
}

-(void) deezerDidLogin
{
    NSLog(@"#DIDLOGIN");
    //NSString* Artist = @"Caravan Palace";
    //NSString* Radio = @"36361";
    
    self.player = [[DZRPlayer alloc] initWithConnection:[[DZRRequestManager defaultManager] dzrConnect]];
    if (nextToPlay)
        [self.player play: nextToPlay];
}

-(void) deezerPlayArtist: (NSString*) Artist
{
    [DZRObject searchFor:DZRSearchTypeAlbum withQuery: Artist requestManager:[DZRRequestManager defaultManager] callback:^(DZRObjectList *obj, NSError *err) {
        [obj objectAtIndex:0 withManager:[DZRRequestManager defaultManager] callback:^(id obj, NSError *error) {
            if (self.player == nil)
                nextToPlay = obj;
            else
                [self.player play:obj];
        }];
    }];
}

-(void) deezerPlayRadio: (id) sender
{
    [DZRRadio objectWithIdentifier: sender requestManager: [DZRRequestManager defaultManager] callback:^(id obj, NSError *error)
    {
        if (error) NSLog(@"%@", error);
        [[obj iterator] nextWithRequestManager:[DZRRequestManager defaultManager] callback:^(DZRTrack *nextTrack, NSError *error)
        {
            if (error) NSLog(@"%@", error);
            NSLog(@"nextTrack : %@", nextTrack);
        }];
        if (self.player == nil)
            nextToPlay = obj;
        else
            [self.player play: obj];
    }];
}

-(void) deezerNext
{
    [self.player next];
}

-(void) deezerPlay
{
    [self.player play];
}

-(void) deezerPause
{
    [self.player pause];
}

-(void) deezerStop
{
    [self.player stop];
}

-(void) deezerTogglePlay
{
    if([self.player isPlaying])
    {
        [self.player pause];
    }
    else
        [self.player play];
}

@end
