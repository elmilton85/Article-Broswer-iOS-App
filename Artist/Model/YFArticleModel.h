//
//  YFArticleModel.h
//  Artist
//
//  Created by Yingwei Fan on 3/16/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFArticleModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *picture;
@property (nonatomic,copy) NSString *date;

- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype) articleWithDict:(NSDictionary *)dict;

@end
