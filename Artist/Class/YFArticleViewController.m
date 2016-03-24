//
//  YFArticleViewController.m
//  Artist
//
//  Created by Yingwei Fan on 3/17/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//

#import "YFArticleViewController.h"
#import "YFDetailArticleModel.h"
#import "YFToolBar.h"
#import "constant.h"


@interface YFArticleViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIImageView *topImageView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *bodyLabel;
@property (nonatomic, strong) YFToolBar *toolBar;

@property (nonatomic, assign) BOOL isLiked;

@property (nonatomic, strong)YFDetailArticleModel *articleModel;
@end

@implementation YFArticleViewController

- (instancetype)initWithDetailArticleModel:(YFDetailArticleModel *)articleModel andIsLiked:(BOOL)isLiked {
    if (self = [super init]) {
        _articleModel = articleModel;
        _isLiked = isLiked;
    }
    return self;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        CGFloat contentH = CGRectGetMaxY(self.topImageView.frame) + 20 + self.titleLabel.bounds.size.height + 20 + self.bodyLabel.bounds.size.height;
        _scrollView.contentSize = CGSizeMake(0, contentH);
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIImageView *)topImageView {
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -80, kScreenWidth, kScreenWidth-80)];
        _topImageView.image = [UIImage imageNamed:self.articleModel.topImage];
    }
    return _topImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        CGSize size = [self.articleModel.title boundingRectWithSize:CGSizeMake(kScreenWidth-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} context:nil].size;
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = (CGRect){{20, CGRectGetMaxY(self.topImageView.frame) + 20}, size};
        _titleLabel.text = self.articleModel.title;
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)bodyLabel {
    if (_bodyLabel == nil) {
        _bodyLabel = [[UILabel alloc] init];
        CGSize size = [self.articleModel.body boundingRectWithSize:CGSizeMake(kScreenWidth-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        _bodyLabel.frame = (CGRect){{20,CGRectGetMaxY(self.titleLabel.frame)+20},size};
        _bodyLabel.text = self.articleModel.body;
        _bodyLabel.font = [UIFont systemFontOfSize:14];
        _bodyLabel.numberOfLines = 0;
    }
    return _bodyLabel;
}


- (YFToolBar *)toolBar {
    if (_toolBar == nil) {
        _toolBar = [[YFToolBar alloc] initWithFrame:CGRectMake(0, kScreenHeight-35, kScreenWidth, 35) andIndex:self.articleModel.index];
        if (self.isLiked) {
            [_toolBar.likeButton setSelected:YES];
        }
        [_toolBar.backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _toolBar;
}

- (void)backButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollView addSubview:self.topImageView];
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.bodyLabel];
    [self.view addSubview:self.toolBar];
    [self.view bringSubviewToFront:self.topImageView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 30, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    //gesture
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - srollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = self.scrollView.contentOffset.y;
    if (offsetY<-80) {
        self.scrollView.contentOffset = CGPointMake(0, -80);
    }
}


@end
