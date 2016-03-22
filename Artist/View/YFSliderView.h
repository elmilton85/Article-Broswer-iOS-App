//
//  YFSliderView.h
//  Artist
//
//  Created by Yingwei Fan on 3/16/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFSliderView;
@protocol YFSliderViewDelegate <NSObject>
@optional
- (void)sliderView:(YFSliderView *)sliderView didSelectIndex:(int)index;

@end

@interface YFSliderView : UITableViewHeaderFooterView

@property (nonatomic,weak) id<YFSliderViewDelegate>delegate;
@property (nonatomic,strong) NSTimer *timer;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
+ (instancetype)sliderWithTableView:(UITableView *)tableView andArticleModels:(NSArray *)articleModelArray;
- (void)startTimer;

@end
