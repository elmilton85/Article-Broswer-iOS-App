//
//  YFToolBar.m
//  Artist
//
//  Created by Yingwei Fan on 3/22/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//

#import "YFToolBar.h"
#import "constant.h"

@interface YFToolBar ()
@property (nonatomic,assign) int index;
@end

@implementation YFToolBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIButton *)backButton {
    if (_backButton == nil) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 1, 34, 34)];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIButton *)likeButton {
    if (_likeButton == nil) {
        _likeButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-34-5, 1, 34, 34)];
        [_likeButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [_likeButton setBackgroundImage:[UIImage imageNamed:@"like_highlighted"] forState:UIControlStateSelected];
        [_likeButton addTarget:self action:@selector(likeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeButton;
}

- (instancetype)initWithFrame:(CGRect)frame andIndex:(int)index {
    if (self = [super initWithFrame:frame]) {
        UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, kScreenWidth, 34)];
        emptyView.backgroundColor = [UIColor whiteColor];
        [self addSubview:emptyView];
        [self addSubview:self.backButton];
        [self addSubview:self.likeButton];
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
        
        _index = index;
    }
    return self;
}

- (void)likeButtonClick {
    if (self.likeButton.isSelected) {
        [self.likeButton setSelected:NO];
    }
    else {
        [self.likeButton setSelected:YES];
    }
    
    //post a notification to notify the YFArticleListViewController to change like value
    NSNotification *notification = [NSNotification notificationWithName:@"LikeButtonClicked" object:self.likeButton userInfo:@{@"index":[NSNumber numberWithInt:self.index]}];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
