//
//  BusinessTableViewCell.h
//  Yelp
//
//  Created by Henry Ching on 9/16/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Business.h"

@interface BusinessTableViewCell : UITableViewCell

@property(nonatomic, strong) Business *business;

@end
