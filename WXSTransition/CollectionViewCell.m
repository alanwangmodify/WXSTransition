//
//  CollectionViewCell.m
//  WXSTransition
//
//  Created by 王小树 on 16/5/31.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imgView];
    }
    return self;
    
}

-(UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgView.image = [UIImage imageNamed:@"img"];
        
    }
    return _imgView;
}
@end
