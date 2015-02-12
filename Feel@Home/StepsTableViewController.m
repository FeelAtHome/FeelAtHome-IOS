//
//  StepsTableViewController.m
//  Feel@Home
//
//  Created by Robin LAMBERTZ on 11/02/15.
//  Copyright (c) 2015 Robin LAMBERTZ. All rights reserved.
//

#import "StepsTableViewController.h"

@interface StepsTableViewController ()

@end

@implementation StepsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newStepWhen: (NSObject <Condition>*)cond then: (NSObject <Action>*)action
{
    NSLog(@"New step when %@ then %@", [[cond class] name], [[action class] name]);
    NSUInteger row = [self.tableView indexPathForSelectedRow].row;
    if (row == 0)
        [self.scenario when:cond then:action];
    else
    {
        [self.scenario.steps[row - 1][@"condition"] stop];
        self.scenario.steps[row - 1] = @{ @"condition": cond, @"action": action };
    }
    NSLog(@"%@", self.scenario);
    [self.tableView reloadData];
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
    return [self.scenario.steps count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"addStep"];
        cell.textLabel.text = @"Add Step";
    }
    else
    {
        NSLog(@"Adding edit step cell");
        cell = [tableView dequeueReusableCellWithIdentifier:@"editStep"];
        NSString *condName = [[self.scenario.steps[indexPath.row - 1][@"condition"] class] name];
        NSLog(@"%@", condName);
        NSString *actionName = [[self.scenario.steps[indexPath.row - 1][@"action"] class] name];
        cell.textLabel.text = [@[condName, @"->", actionName] componentsJoinedByString:@" "];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Steps";
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return indexPath.row != 0;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.scenario.steps[indexPath.row - 1][@"condition"] stop];
        [self.scenario.steps removeObjectAtIndex:indexPath.row - 1];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    if ([segue.identifier isEqualToString:@"addCell"])
        [segue.destinationViewController setDelegate:self];
    else if ([segue.identifier isEqualToString:@"editCell"])
    {
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        [segue.destinationViewController setCond:self.scenario.steps[path.row - 1][@"condition"]];
        [segue.destinationViewController setAction:self.scenario.steps[path.row - 1][@"action"]];
        [segue.destinationViewController setDelegate:self];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
