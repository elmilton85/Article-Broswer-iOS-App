//
//  YFSliderView.h
//  Artist
//
//  Created by Yingwei Fan on 3/16/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFSliderView : UITableViewHeaderFooterView

@property (nonatomic,strong) NSTimer *timer;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
+ (instancetype)sliderWithTableView:(UITableView *)tableView;
- (void)startTimer;

@end
