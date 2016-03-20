//
//  YFArticleCell.m
//  Artist
//
//  Created by Yingwei Fan on 3/16/16.
//  Copyright © 2016 Yingwei Fan. All rights reserved.
//

#import "YFArticleCell.h"
#import "YFArticleModel.h"
#import "constant.h"

@implementation YFArticleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat labelX = 10;
        CGFloat labelY = 10;
        CGFloat labelW = [UIScreen mainScreen].bounds.size.width - 100 - 30;
        CGFloat labelH = 64;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        label.numberOfLines = 0;
        label.contentMode = UIViewContentModeTop;
        label.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:label];
        self.nameLabel = label;
        
        CGFloat imageX = [UIScreen mainScreen].bounds.size.width - 100 - 10;
        CGFloat imageY = 10;
        CGFloat imageW = 100;
        CGFloat imageH = 80;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
//        imageView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:imageView];
        self.pictureView = imageView;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, kCellHeight-25, 100, 20)];
        label.font = [UIFont systemFontOfSize:10.0];
        [self.contentView addSubview:label];
        self.dateLabel = label;
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"articleCell";
    YFArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YFArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setArticle:(YFArticleModel *)article {
    _article = article;
    
    self.nameLabel.text = _article.name;
    self.pictureView.image = [UIImage imageNamed:_article.picture];
    self.dateLabel.text = _article.date;
    
    //set content to align top
    //must be used after the text is set
    [self.nameLabel sizeToFit];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
