//
//  YFDetailArticleModel.h
//  Artist
//
//  Created by Yingwei Fan on 3/18/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFDetailArticleModel : NSObject
@property (nonatomic,copy) NSString *topImage;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *body;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailArticleWithDict:(NSDictionary *)dict;

@end
