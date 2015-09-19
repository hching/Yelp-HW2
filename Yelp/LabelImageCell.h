//
//  LabelImageCell.h
//  Yelp
//
//  Created by Henry Ching on 9/17/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageURLView;
@end
