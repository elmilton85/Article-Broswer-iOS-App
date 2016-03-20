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
#import "YFDetailArticleModel.h"
#import "YFArticleViewController.h"
#import "constant.h"

@interface YFArticleListViewController ()

@property (nonatomic, strong) NSArray *articleArray;
@property (nonatomic, strong) NSArray *detailArticleArray;
@property (nonatomic,strong) YFSliderView *pictureSlider;

@end

@implementation YFArticleListViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configUI];
}

- (void)configUI {
    self.tableView.rowHeight = kCellHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(-80, 0, 0, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    //let the header view follow the cells to scroll
    self.pictureSlider = [YFSliderView sliderWithTableView:self.tableView];
    self.tableView.tableHeaderView = self.pictureSlider;
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

#pragma mark - data source

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

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return kScrollViewHeight;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    self.pictureSlider = [YFSliderView sliderWithTableView:tableView];
//    return self.pictureSlider;
//}

#pragma mark - delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.pictureSlider.timer invalidate];
    NSLog(@"begin dragging");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.pictureSlider startTimer];
    NSLog(@"end dragging");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = self.tableView.contentOffset.y;
    if (offsetY<0) {
        self.tableView.contentOffset = CGPointMake(0, 0);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select row %lu",indexPath.row);
    
    YFDetailArticleModel *detailArticle = [[YFDetailArticleModel alloc] initWithDict:self.detailArticleArray[indexPath.row]];
    YFArticleViewController *detailArticleController = [[YFArticleViewController alloc] initWithDetailArticleModel:detailArticle];

//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self presentViewController:detailArticleController animated:YES completion:nil];
//    });
    [self.navigationController pushViewController:detailArticleController animated:YES];
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
