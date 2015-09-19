//
//  OfferingADealTableViewCell.h
//  Yelp
//
//  Created by Henry Ching on 9/17/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchCell;

@protocol SwitchCellDelegate <NSObject>

- (void)switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value;

@end

@interface SwitchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *switchLabel;
@property (assign, nonatomic) BOOL on;
@property (nonatomic, weak) id<SwitchCellDelegate> delegate;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
