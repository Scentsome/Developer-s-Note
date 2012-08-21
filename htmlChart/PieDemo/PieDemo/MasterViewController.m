//
//  MasterViewController.m
//  PieDemo
//
//  Created by chronoer on 8/21/12.
//  Copyright (c) 2012 GLuck. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "GraphViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
    NSArray * categories;
    NSMutableDictionary * sums;
}
@end

@implementation MasterViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    categories = [NSArray arrayWithObjects:@"食",@"衣",@"住",@"行",@"娛", nil];
    sums = [NSMutableDictionary dictionaryWithCapacity:[categories count]];
    [categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [sums setObject:[NSNumber numberWithInteger:0] forKey:obj];
    }];
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    NSNumber * num = [NSNumber numberWithInteger:arc4random()%2000];
    NSString * cat = [categories objectAtIndex:arc4random()%5];
    
    NSDictionary * content = [NSDictionary dictionaryWithObjectsAndKeys:num, @"amount",cat ,@"cat", nil];
    
    [_objects insertObject:content atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UILabel * amount = (UILabel *) [cell viewWithTag:10];
    UILabel * cat = (UILabel *)[cell viewWithTag:11];
    NSDictionary * object = [_objects objectAtIndex:indexPath.row];
    amount.text = [NSString stringWithFormat:@"%d", [[object objectForKey:@"amount"] integerValue]];
    cat.text = [object objectForKey:@"cat"];
//    NSDate *object = [_objects objectAtIndex:indexPath.row];
//    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = [_objects objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
    if ([[segue identifier] isEqualToString:@"showGraph"]) {
        [_objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSInteger current = [[sums objectForKey:[obj objectForKey:@"cat"]] integerValue];
            current += [[obj objectForKey:@"amount"] integerValue];
            [sums setObject:[NSNumber numberWithInteger:current] forKey:[obj objectForKey:@"cat"]];
        }];
        NSLog(@"sums %@", sums);
        GraphViewController * graph = segue.destinationViewController ;
        graph.sums = sums;
    }
}

@end
