//
//  Business.h
//  Yelp
//
//  Created by Henry Ching on 9/16/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Business : NSObject

@property(strong, atomic) NSString *imageURL;
@property(strong, atomic) NSString *name;
@property(strong, atomic) NSString *ratingImageURl;
@property(assign, atomic) NSInteger numReviews;
@property(strong, atomic) NSString *address;
@property(strong, atomic) NSString *categories;
@property(assign, atomic) CGFloat distance;

+ (NSArray *)businessesWithDictionaries:(NSArray *)dictionaries;

@end
