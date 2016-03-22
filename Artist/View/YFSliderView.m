//
//  YFSliderView.m
//  Artist
//
//  Created by Yingwei Fan on 3/16/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//

#import "YFSliderView.h"
#import "constant.h"
#import "YFArticleModel.h"

#define kPageNumber 5

@interface YFSliderView () <UIScrollViewDelegate, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *articleModels;
@property (nonatomic,assign) int currIndex;

@end

@implementation YFSliderView

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width*3, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = kPageNumber;
        CGSize size = [_pageControl sizeForNumberOfPages:kPageNumber];
        _pageControl.frame = (CGRect){{(self.bounds.size.width - size.width)*0.5,kScrollViewHeight-30},size};
    }
    return _pageControl;
}


+ (instancetype)sliderWithTableView:(UITableView *)tableView andArticleModels:(NSArray *)articleModelArray {
    NSString *ID = @"Header";
    YFSliderView *pictureSlider = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (pictureSlider == nil) {
        pictureSlider = [[YFSliderView alloc] initWithReuseIdentifier:ID];
        pictureSlider.articleModels = [NSArray arrayWithArray:articleModelArray];
        [pictureSlider loadPictures];
    }
    return pictureSlider;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScrollViewHeight);
        //add scrollView
        [self addSubview:self.scrollView];
        
        //add pageControl
        [self addSubview:self.pageControl];
        
        self.currIndex = 0;
        
        //start NSTimer
        [self startTimer];
    }
    return self;
}

- (void)loadPictures {
    for (int i=0; i<3; i++) {
        UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScrollViewHeight)];
        //get the current article model
        YFArticleModel *currArticle = self.articleModels[(self.currIndex+i-1+kPageNumber)%kPageNumber];
        
        //set image for the button
        [imageButton setBackgroundImage:[UIImage imageNamed:currArticle.picture] forState:UIControlStateNormal];
        imageButton.adjustsImageWhenHighlighted = NO;
        [imageButton addTarget:self action:@selector(pictureClick) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:imageButton];
        
        
        CGSize size = [currArticle.name boundingRectWithSize:CGSizeMake(kScreenWidth - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0]} context:nil].size;
        CGRect frame = (CGRect){{10, self.scrollView.bounds.size.height - 20 - size.height}, size};
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:frame];
        titleLabel.numberOfLines = 0;
        titleLabel.text = currArticle.name;
        titleLabel.textColor = [UIColor whiteColor];
        [imageButton addSubview:titleLabel];
    }
    self.scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
}

- (void)pictureClick {
    //check if the delegate method is implemented by controller
    if ([self.delegate respondsToSelector:@selector(sliderView:didSelectIndex:)]) {
        [self.delegate sliderView:self didSelectIndex:self.currIndex];
    }
}

- (void)startTimer {
    if (!self.timer.valid) {
        self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(updatePicture) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)updatePicture {
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint newOffset = CGPointMake(kScreenWidth*2, 0);
        [self.scrollView setContentOffset:newOffset];
        self.pageControl.currentPage = (self.currIndex + 1)%kPageNumber;
    } completion:^(BOOL finished) {
        //delete all pictures first
        [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        self.currIndex = (self.currIndex + 1)%kPageNumber;
        [self loadPictures];
    }];
    
}


#pragma mark - delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX >= 2*kScreenWidth) {
        self.currIndex = (self.currIndex + 1)%kPageNumber;
    }
    else if (offsetX <= 0) {
        self.currIndex = (self.currIndex - 1 + kPageNumber)%kPageNumber;
    }
    self.pageControl.currentPage = self.currIndex;
    [self loadPictures];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
