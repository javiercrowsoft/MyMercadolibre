//
//  MasterViewController.m
//  MyMercadolibre
//
//  Created by Javier Alvarez on 6/13/13.
//  Copyright (c) 2013 Javier Alvarez. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MasterViewController ()

@property(strong) NSDictionary *response;

- (void)getSellers;

@end

@implementation MasterViewController

#pragma mark - Managing the detail item

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [self getSellers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.response)
        return 0;
    NSInteger count = [[self.response objectForKey:@"data"] count];
    return count; //[[self.response objectForKey:@"data"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    NSArray *data = [self.response objectForKey:@"data"];
    
    NSUInteger row = indexPath.row;
    NSDictionary *seller = [data objectAtIndex:row];
    
    UILabel *sellerNameLabel = (UILabel *)[cell viewWithTag:101];
    sellerNameLabel.text = [seller objectForKey:@"seller_name"];
    
    UILabel *itemBoughtLabel = (UILabel *)[cell viewWithTag:102];
    itemBoughtLabel.text = [seller objectForKey:@"item_name"];

    UIImageView *itemImageView = (UIImageView *)[cell viewWithTag:100];
    
    NSString *itemId = [seller objectForKey:@"item_id"];
    
    itemImageView.image = nil;
    
    __weak UITableViewCell *weakCell = cell;
    
    NSString *link = [@"http://www.crowsoft.com.ar/cscvxi/get_meli_item_image.php?item_id=" stringByAppendingString:itemId];
    
    [cell.imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:link]]
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
    
    return cell;
}

/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}
*/

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *data = [self.response objectForKey:@"data"];
        NSDictionary *seller = [data objectAtIndex:indexPath.row];
        NSString *seller_name = [seller objectForKey:@"seller_name"];
        NSString *seller_id = [seller objectForKey:@"seller_id"];
        id destination = [segue destinationViewController];
        [destination setDetailItem:seller_name];
        [destination setSellerId:seller_id];
    }
}

#pragma mark - Delegate Implementation

- (void)meliHTTPClient:(MeliHTTPClient *)client didUpdateWithSellers:(id)someSellers
{
    self.response = someSellers;
    [self.tableView reloadData];
}

- (void)meliHTTPClient:(MeliHTTPClient *)client didFailWithError:(NSError *)error
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Sellers"
                                                 message:[NSString stringWithFormat:@"%@",error]
                                                delegate:nil
                                       cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

#pragma mark - Delegate Implementation

- (void)getSellers
{
    MeliHTTPClient *client = [MeliHTTPClient sharedMeliHTTPClient];
    client.delegate = self;
    [client updateSellerListForNick:self.nick];
}

@end
