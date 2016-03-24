//
//  YFToolBar.h
//  Artist
//
//  Created by Yingwei Fan on 3/22/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFDetailArticleModel;

@interface YFToolBar : UIView

@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UIButton *likeButton;
- (instancetype)initWithFrame:(CGRect)frame andIndex:(int)index;

@end
