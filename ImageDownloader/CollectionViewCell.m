//
//  CollectionViewCell.m
//  ImageDownloader
//
//  Created by Sean Donato on 4/6/18.
//  Copyright © 2018 Sean Donato. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)prepareForReuse{
    
    _cellImage.image = nil;
}
@end
