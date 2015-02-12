//
//  ScenariosViewController.m
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 09/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "ScenarioListViewController.h"
#import "Scenario.h"

@interface ScenarioListViewController ()

@end

@implementation ScenarioListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)scenarioChanged:(Scenario *)scenario
{
    NSLog(@"indexPath : %@", [self.tableView indexPathForSelectedRow]);
    if (![self.tableView indexPathForSelectedRow])
        [self.scenarios addObject:scenario];
    NSLog(@"Saving to %@", self.scenariosFileName);
    [NSKeyedArchiver archiveRootObject:self.scenarios toFile:self.scenariosFileName];
    [self.tableView reloadData];
    // TODO : save the damn thing
}

- (void)writeScenarios
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.scenarios = [NSKeyedUnarchiver unarchiveObjectWithFile:self.scenariosFileName];
    if (self.scenarios == nil)
        self.scenarios = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject: (id)sender {
    [self performSegueWithIdentifier:@"createNew" sender:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.scenarios count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[self.scenarios objectAtIndex:indexPath.row] title];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (NSString*)scenariosFileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"scenarios.dat"];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing)
        [self.navigationItem setLeftBarButtonItem:self.addButton animated:YES];
    else
    {
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
        /*[self.scenarios enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj enable];
        }];*/
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        @try {
            [self.scenarios removeObjectAtIndex:indexPath.row];
            NSLog(@"Saving to %@", self.scenariosFileName);
            [NSKeyedArchiver archiveRootObject:self.scenarios toFile:self.scenariosFileName];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } @catch (NSException *e) {
            
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"createNew"])
    {
        Scenario *scenario;
        if (sender)
            scenario = self.scenarios[[self.tableView indexPathForCell:sender].row];
        else
            scenario = [[Scenario alloc] init];
        [segue.destinationViewController setScenario:scenario];
        [segue.destinationViewController setDelegate:self];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
