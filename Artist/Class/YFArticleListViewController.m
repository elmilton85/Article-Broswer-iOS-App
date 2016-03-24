//
//  YFArticleListTableViewController.m
//  Artist
//
//  Created by Yingwei Fan on 3/20/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//


#import "YFArticleListViewController.h"
#import "YFArticleModel.h"
#import "YFArticleCell.h"
#import "YFSliderView.h"
#import "YFToolBar.h"
#import "YFDetailArticleModel.h"
#import "YFArticleViewController.h"
#import "constant.h"

@interface YFArticleListViewController () <YFSliderViewDelegate>

@property (nonatomic, strong) NSArray *articleArray;
@property (nonatomic, strong) NSArray *detailArticleArray;//contains dictionaries
@property (nonatomic, strong) NSArray *pictureSliderRowIndexArray;
@property (nonatomic, strong) NSMutableArray *likeStatus;
@property (nonatomic, strong) YFSliderView *pictureSlider;

@end

@implementation YFArticleListViewController
#pragma mark - properties lazy loading
- (NSArray *)articleArray {
    if (_articleArray == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"articles" ofType:@"plist"]];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            [arrayM addObject:[YFArticleModel articleWithDict:dict]];
        }
        _articleArray = arrayM;
    }
    return _articleArray;
}

- (NSArray *)detailArticleArray {
    if (_detailArticleArray == nil) {
        _detailArticleArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"detailArticles" ofType:@"plist"]];
    }
    return _detailArticleArray;
}

- (NSArray *)pictureSliderRowIndexArray {
    if (_pictureSliderRowIndexArray == nil) {
        _pictureSliderRowIndexArray = [NSArray arrayWithObjects:@0, @1, @2, @3, @4, nil];
    }
    return _pictureSliderRowIndexArray;
}

- (NSMutableArray *)liked {
    if (_likeStatus == nil) {
        _likeStatus = [NSMutableArray array];
        for (int i=0; i<self.articleArray.count; i++) {
            [_likeStatus addObject:@0];
        }
    }
    return _likeStatus;
}

- (YFSliderView *)pictureSlider {
    if (_pictureSlider == nil) {
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i=0; i<self.pictureSliderRowIndexArray.count; i++) {
            int modelIndex = [self.pictureSliderRowIndexArray[i] intValue];
            [arrayM addObject:self.articleArray[modelIndex]];
        }
        _pictureSlider = [YFSliderView sliderWithTableView:self.tableView andArticleModels:arrayM];
        _pictureSlider.delegate = self;
    }
    return  _pictureSlider;
}

#pragma mark - view methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configUI];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(changeLikedArray:) name:@"LikeButtonClicked" object:nil];
}

- (void)configUI {
    self.tableView.rowHeight = kCellHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(-80, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    //let the header view follow the cells to scroll
    self.tableView.tableHeaderView = self.pictureSlider;
}

- (void)changeLikedArray:(NSNotification *)noti {
    int currIndex = [noti.userInfo[@"index"] intValue];
    BOOL currLikeStatus = [self.likeStatus[currIndex] boolValue];
    currLikeStatus ^= 1;
    self.likeStatus[currIndex] = [NSNumber numberWithBool:currLikeStatus];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.pictureSlider.timer invalidate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.pictureSlider startTimer];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - tableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YFArticleCell *cell = [YFArticleCell cellWithTableView:tableView];
    cell.article = self.articleArray[indexPath.row];
    return cell;
}


#pragma mark - scrollView delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.pictureSlider.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.pictureSlider startTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = self.tableView.contentOffset.y;
    if (offsetY<0) {
        self.tableView.contentOffset = CGPointMake(0, 0);
    }
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select row %lu",indexPath.row);
    
    YFDetailArticleModel *detailArticle = [[YFDetailArticleModel alloc] initWithDict:self.detailArticleArray[indexPath.row]];
    detailArticle.index = (int)indexPath.row;
    YFArticleViewController *detailArticleController = [[YFArticleViewController alloc] initWithDetailArticleModel:detailArticle andIsLiked:[self.likeStatus[indexPath.row] boolValue]];

//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self presentViewController:detailArticleController animated:YES completion:nil];
//    });
    [self.navigationController pushViewController:detailArticleController animated:YES];
}

#pragma mark - sliderView delegate

- (void)sliderView:(YFSliderView *)sliderView didSelectIndex:(int)index {
    int row = [self.pictureSliderRowIndexArray[index] intValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
