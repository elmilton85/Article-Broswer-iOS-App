//
//  YFArticleCell.h
//  Artist
//
//  Created by Yingwei Fan on 3/16/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFArticleModel;

@interface YFArticleCell : UITableViewCell

@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UIImageView *pictureView;
@property (nonatomic,weak) UILabel *dateLabel;
@property (nonatomic,strong) YFArticleModel *article;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
