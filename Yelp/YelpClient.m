//
//  YelpClient.m
//  Yelp
//
//  Created by Henry Ching on 9/16/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "YelpClient.h"

@implementation YelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSDictionary *parameters = @{@"term": term, @"ll" : @"37.774866,-122.394556"};
    
    return [self GET:@"search" parameters:parameters success:success failure:failure];
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term filters:(NSDictionary *)filters success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSLog(@"Searching: %@", filters);
    
    NSString *val = ([filters objectForKey:@"deals_filter"] == nil ? @"0" : [filters objectForKey:@"deals_filter"]);
    NSString *radius = ([filters objectForKey:@"radius_filter"] == nil ? @"10690" : [filters objectForKey:@"radius_filter"]);
    NSString *sort = ([filters objectForKey:@"sort"] == nil ? @"0" : [filters objectForKey:@"sort"]);
    NSString *category = [self getCategories:filters];
    
    NSDictionary *parameters = @{@"term": term, @"ll" : @"37.774866,-122.394556", @"deals_filter": val, @"radius_filter": radius, @"sort": sort, @"category_filter": category};
    
    return [self GET:@"search" parameters:parameters success:success failure:failure];
}

- (NSString *)getCategories:(NSDictionary *)filters {
    NSString *filterString = @"";
    NSArray *categories = [filters objectForKey:@"category_filter"];
    for(NSString *c in categories) {
        switch ([c intValue]) {
            case 0:
                filterString = (filterString.length == 0 ? @"afghani" : [NSString stringWithFormat:@"%@, %@", filterString, @"afghani"]);
                break;
            case 1:
                filterString = (filterString.length == 0 ? @"african" : [NSString stringWithFormat:@"%@, %@", filterString, @"african"]);
                break;
            case 2:
                filterString = (filterString.length == 0 ? @"newamerican" : [NSString stringWithFormat:@"%@, %@", filterString, @"newamerican"]);
                break;
            case 3:
                filterString = (filterString.length == 0 ? @"chinese" : [NSString stringWithFormat:@"%@, %@", filterString, @"chinese"]);
                break;
            case 4:
                filterString = (filterString.length == 0 ? @"japanese" : [NSString stringWithFormat:@"%@, %@", filterString, @"japanese"]);
                break;
            default:
                filterString = @"All";
                break;
        }
    }
    NSLog([NSString stringWithFormat:@"category: %@",filterString]);
    return filterString;
}

@end
