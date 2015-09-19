//
//  FilterViewController.h
//  Yelp
//
//  Created by Henry Ching on 9/17/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterViewController;

@protocol FilterViewControllerDelegate <NSObject>

- (void)filterViewController:(FilterViewController *) filterViewController didChangeFilters:(NSDictionary *)filters;

@end

@interface FilterViewController : UIViewController

@property (nonatomic, weak) id<FilterViewControllerDelegate> delegate;

@end
