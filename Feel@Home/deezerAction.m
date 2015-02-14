//
//  deezerAction.m
//  deezer
//
//  Created by Charles HUANG on 11/02/15.
//  Copyright (c) 2015 Charles HUANG. All rights reserved.
//

#import "deezerAction.h"
#import "Deezer.h"
#import "SetupViewController.h"

Deezer *deezer;

@interface deezerActionViewController : SetupViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *radioField;

@end

@implementation deezerAction
{
    NSString*   radio;
    Deezer*     deezer;
}

+ (NSString*)name
{
    return @"Play Radio";
}

- (id)initWithRadio :(NSString*)Radio
{
    radio = Radio;
    return (self);
}


#pragma mark -NSCoding

-(id) initWithCoder:decoder
{
    radio = [decoder decodeObjectForKey:@"radio"];
    deezer = [Deezer alloc];
    return self;
}

-(void) encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:radio forKey:@"radio"];
}

#pragma mark -end NSCoding

-(void) run{
    [deezer deezerPlayRadio: radio];
}

+ (deezerActionViewController*)setupView {
    return [[deezerActionViewController alloc] init];
}

@end

@implementation deezerActionViewController

-(id)init{
    self = [super initWithNibName:@"deezerActionView" bundle:nil];
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"TOP LEL");
    
    self.canSave = YES;
    self.title = @"Radio configuration";
    //deezer = [Deezer alloc];
    NSLog(@"%@", deezer);
    //[deezer deezerAuth];
    //do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    deezer = [Deezer alloc];
    [deezer deezerAuth];
}

-(void) saveParams{
    [self.delegate createObj:[[deezerAction alloc] initWithRadio: self.radioField.text]];
}

-(void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
    }

@end