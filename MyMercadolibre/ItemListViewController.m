//
//  ItemListViewController.m
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/15/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "ItemListViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ItemListViewController ()

@property(strong) NSDictionary *response;

- (void)getItemList;

@end

@implementation ItemListViewController

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
    
    [self getItemList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.response)
        return 0;
    NSInteger count = [[self.response objectForKey:@"results"] count];
    return count; //[[self.response objectForKey:@"results"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *data = [self.response objectForKey:@"results"];
    NSDictionary *item = [data objectAtIndex:indexPath.row];
    
//    UIImageView *itemImageView = (UIImageView *)[cell viewWithTag:100];
//    itemImageView.image = [UIImage imageNamed:@"shame.png"];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
    titleLabel.text = [item objectForKey:@"title"];
    
    UILabel *subtitleLabel = (UILabel *)[cell viewWithTag:102];
    NSString *subtitle = [item objectForKey:@"subtitle"];
    if (![subtitle isKindOfClass:[NSNull class]]) {
        subtitleLabel.text = subtitle;
    }
    else {
        subtitleLabel.text = @"";
    }
    
    NSString *thumbnail = [item objectForKey:@"thumbnail"];
    if (![thumbnail isKindOfClass:[NSNull class]]) {

        __weak UITableViewCell *weakCell = cell;
        
        [cell.imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:thumbnail]]
                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                           weakCell.imageView.image = image;
                                           
                                           //only required if no placeholder is set to force the imageview on the cell to be laid out to house the new image.
                                           //if(weakCell.imageView.frame.size.height==0 || weakCell.imageView.frame.size.width==0 ){
                                           [weakCell setNeedsLayout];
                                           //}
                                       }
                                       failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                           
                                       }];        
    }
    
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Delegate Implementation

- (void)meliAPIHTTPClient:(MeliAPIHTTPClient *)client didUpdateWithItems:(id)items
{
    self.response = items;
    [self.tableView reloadData];
}

- (void)meliAPIHTTPClient:(MeliAPIHTTPClient *)client didFailWithError:(NSError *)error
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Items for a Seller"
                                                 message:[NSString stringWithFormat:@"%@",error]
                                                delegate:nil
                                       cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

#pragma mark - Delegate Implementation

- (void)getItemList
{
    MeliAPIHTTPClient *client = [MeliAPIHTTPClient sharedMeliAPIHTTPClient];
    client.delegate = self;
    [client updateItemListForUserId:self.sellerId];
}

@end
