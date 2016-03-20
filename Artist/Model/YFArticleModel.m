//
//  YFArticleModel.m
//  Artist
//
//  Created by Yingwei Fan on 3/16/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//

#import "YFArticleModel.h"

@implementation YFArticleModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)articleWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
