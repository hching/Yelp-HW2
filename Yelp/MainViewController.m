//
//  MainViewController.m
//  Yelp
//
//  Created by Henry Ching on 9/16/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "Business.h"
#import "BusinessTableViewCell.h"
#import "FilterViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainViewController () <FilterViewControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *businesses;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filterButton;
@property (strong, nonatomic) NSMutableDictionary *filterSettings;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Yelp";
    //self.mainTableView.rowHeight = UITableViewAutomaticDimension;
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    self.navigationItem.titleView = searchBar;
    [searchBar setDelegate:self];
    
    [self yelpIt:@"Thai"];
}

- (void) yelpIt:(NSString*)searchfor {
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:searchfor success:^(AFHTTPRequestOperation *operation, id response) {
        //NSLog(@"response: %@", response);
        NSArray *businessDictionaries = response[@"businesses"];
        
        self.businesses = [Business businessesWithDictionaries:businessDictionaries];
        [self.mainTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (void) yelpItWithFilters:(NSString*)searchfor:(NSDictionary*)filters {
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:searchfor filters:(NSDictionary *)filters success:^(AFHTTPRequestOperation *operation, id response) {
        //NSLog(@"response: %@", response);
        NSArray *businessDictionaries = response[@"businesses"];
        
        self.businesses = [Business businessesWithDictionaries:businessDictionaries];
        [self.mainTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)filterViewController:(FilterViewController *)filterViewController didChangeFilters:(NSDictionary *)filters {
    NSLog(@"Fire");
    //self.filterSettings = [NSMutableDictionary dictionaryWithDictionary:filters];
    //NSString *d = [filters valueForKey:@"distince"];
    //NSLog(@"%@", self.filterSettings);
    [self yelpItWithFilters:@"Thai":filters];
}

- (IBAction)onFilterButton:(UIBarButtonItem *)sender {
    NSLog(@"Pushed");
    [self performSegueWithIdentifier:@"filterSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"filterSegue"]) {
        FilterViewController *vc = (FilterViewController *) segue.destinationViewController;
        [vc setDelegate:self];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (BusinessTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.businesscell"];
    cell.business = self.businesses[indexPath.row];
    return cell;
}

- (void)searchBarSearchButtonClicked:(UISearchBar * _Nonnull)searchBar {
    NSLog(@"Searching...");
    [self yelpIt:searchBar.text];
}

@end
