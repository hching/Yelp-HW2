//
//  FilterViewController.m
//  Yelp
//
//  Created by Henry Ching on 9/17/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "FilterViewController.h"
#import "SwitchCell.h"
#import "LabelCell.h"
#import "LabelImageCell.h"

@interface FilterViewController () <SwitchCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *filterTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (strong, nonatomic) NSDictionary *filters;
@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) NSMutableArray *category_selected;
@property (nonatomic, strong) NSArray *opt_distance;
@property (nonatomic, strong) NSArray *opt_sortBy;
@property (nonatomic, strong) NSArray *opt_category;
@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Filter";
    
    self.opt_distance = [[NSArray alloc] initWithObjects: @"Auto", @"0.3 miles", @"1 mile", @"5 miles", @"20 miles", nil];
    self.opt_sortBy = [[NSArray alloc] initWithObjects: @"Best Match", @"Distinace", @"Highest Rating", nil];
    self.opt_category = [[NSArray alloc] initWithObjects: @"Afghan", @"African", @"American (New)", @"Chinese", @"Japanese", nil];
    self.dict = [[NSMutableDictionary alloc] init];
    self.category_selected = [[NSMutableArray alloc] init];
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

- (IBAction)onSearchButton:(UIBarButtonItem *)sender {
    //NSLog(@"%@", self.filters);
    
    [self.dict setObject:[NSArray arrayWithArray:self.category_selected] forKey:@"category_filter"];
    self.filters = self.dict;
    [self.delegate filterViewController:self didChangeFilters:self.filters];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 2:
            return self.opt_distance.count;
            break;
        case 4:
            return self.opt_sortBy.count;
            break;
        case 6:
            return self.opt_category.count;
        default:
            return 1;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        switch (indexPath.section) {
            case 1:
            case 3:
            case 5:
                return 30;
                break;
            
            default:
                return 44;
                break;
        }
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 2:
            NSLog(@"%ld", (long)indexPath.row);
            float radius = 16090;;
            switch (indexPath.row) {
                case 0:
                    radius = 0.3 * 1609.344;
                    break;
                case 1:
                    radius = 1 * 1609.344;
                    break;
                case 2:
                    radius = 5 * 1609.344;
                    break;
                case 3:
                    radius = 20 * 1609.344;
                    break;
                default:
                    break;
            }
            //[self.dict setObject:[NSNumber numberWithInt:indexPath.row] forKey:@"radius_filter"];
            [self.dict setObject:[NSString stringWithFormat:@"%f", radius] forKey:@"radius_filter"];
            break;
        case 4:
            NSLog(@"%ld", (long)indexPath.row);
            [self.dict setObject:[NSNumber numberWithInt:indexPath.row] forKey:@"sort"];
            break;
        default:
            break;
    }
    self.filters = self.dict;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0: {
            SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
            cell.switchLabel.text = @"Offering a Deal";
            NSString *val = ([self.filters objectForKey:@"deals_filter"] == nil ? @"0" : [self.filters objectForKey:@"deals_filter"]);
            if(val)
                cell.on = YES;
            else
                cell.on = NO;
            cell.delegate = self;
            return cell;
            break;
        }
        case 1: {
            LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"labelCell"];
            cell.titleLabel.text = @"Distance";
            cell.backgroundColor = [UIColor lightGrayColor];
            return cell;
            break;
        }
        case 2: {
            LabelImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"labelImageCell"];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            NSString *obj = self.opt_distance[indexPath.row];
            cell.titleLabel.text = obj;
            //UIImageView *image = [UIImage imageNamed:@"down_arrow"];
            return cell;
            break;
        }
        case 3: {
            LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"labelCell"];
            cell.titleLabel.text = @"Sort By";
            cell.backgroundColor = [UIColor lightGrayColor];
            return cell;
            break;
        }
        case 4: {
            LabelImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"labelImageCell"];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            NSString *obj = self.opt_sortBy[indexPath.row];
            cell.titleLabel.text = obj;
            //NSString *sort = ([self.filters objectForKey:@"sort"] == nil ? @"0" : [self.filters objectForKey:@"sort"]);
            cell.selected = YES;
            return cell;
            break;
        }
        case 5: {
            LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"labelCell"];
            cell.titleLabel.text = @"Category";
            cell.backgroundColor = [UIColor lightGrayColor];
            return cell;
            break;
        }
        case 6: {
            SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
            NSString *obj = self.opt_category[indexPath.row];
            cell.switchLabel.text = obj;
            cell.delegate = self;
            return cell;
            break;
        }
        default: {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            return cell;
        }
            break;
    }
}

- (void)switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value {
    NSIndexPath *indexPath = [self.filterTableView indexPathForCell:cell];
    switch (indexPath.section) {
        case 0:
            [self.dict setObject:[NSNumber numberWithBool:value] forKey:@"deals_filter"];
            break;
        case 6: {
            if(value)
                //self.category_selected = [NSString stringWithFormat:@"%@, %@", self.category_selected, cell.]
                [self.category_selected addObject:[NSNumber numberWithInt:indexPath.row]];
                //[self.dict setObject:[NSNumber numberWithInt:indexPath.row] forKey:@"category"];
            break;
        }
        default:
            break;
    }
}

@end
