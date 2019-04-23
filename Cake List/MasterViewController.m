//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"
#import "CakeCell.h"
#import "Cake.h"

NSString * _Nonnull const CakeDataUrl = @"https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json";
NSString * _Nonnull const CakeCellIdentifier = @"CakeCell";
NSInteger const TableViewNumberOfRowsInSection = 1;

@implementation MasterViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.refreshControl addTarget:self action:@selector(refreshTableData) forControlEvents:UIControlEventValueChanged];
    [self getDataWithCompletion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Refresh Control

/**
 When the refesh control is used this method will fetch new Cake data.
 Once the data is sucessfully downloaded the table view will be reloaded to show the new data.
 */
- (void)refreshTableData {
    [self getDataWithCompletion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Network Calls

/**
 This method downloads json data for a list of cakes and maps that data
 to corresponding "Cake" models.
 */
- (void)getDataWithCompletion:(void (^)(void))completion {
    
    // Attempt to get data
    NSURL *url = [NSURL URLWithString:CakeDataUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // Check if we actually got any data back
    if (data != nil) {
        NSError *jsonError;
        NSArray *responseData = [NSJSONSerialization
                                 JSONObjectWithData:data
                                 options:kNilOptions
                                 error:&jsonError];
        
        if (!jsonError) {
            // If there isn't a JSON error then map the data to the Cake models
            NSMutableArray *cakes = [NSMutableArray new];
            for (NSDictionary *dictionary in responseData) {
                [cakes addObject: [Cake.alloc initWithDictionary: dictionary]];
            }
            self.cakes = cakes;
        }
        if (completion != nil) {
            completion();
        }
    }
}

#pragma mark - Table View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return TableViewNumberOfRowsInSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cakes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CakeCell *cell = (CakeCell*)[tableView dequeueReusableCellWithIdentifier:CakeCellIdentifier];
    Cake *cake = self.cakes[indexPath.row];
    [cell setCake: cake];
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
