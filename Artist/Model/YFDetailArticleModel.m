//
//  YFDetailArticleModel.m
//  Artist
//
//  Created by Yingwei Fan on 3/18/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//

#import "YFDetailArticleModel.h"

@implementation YFDetailArticleModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)detailArticleWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
