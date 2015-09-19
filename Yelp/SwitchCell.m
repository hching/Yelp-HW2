//
//  OfferingADealTableViewCell.m
//  Yelp
//
//  Created by Henry Ching on 9/17/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "SwitchCell.h"

@interface SwitchCell ()
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;
@property (weak, nonatomic) IBOutlet UISwitch *onSwitchChangedValue;

@end

@implementation SwitchCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    _on = on;
    [self.switchControl setOn:on animated:animated];
}

- (IBAction)onSwitchChangedValue:(UISwitch *)sender {
    [self.delegate switchCell:self didUpdateValue:self.switchControl.on];
}

@end
