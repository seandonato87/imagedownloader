//
//  CacheManager.m
//  ImageDownloader
//
//  Created by Sean Donato on 4/6/18.
//  Copyright © 2018 Sean Donato. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager
- (id)init {
    if (self = [super init]) {
        
        _imageCache = [[NSCache alloc]init];
        
        }
    return self;
}

+ (id)sharedManager {
    
    static CacheManager *myCacheManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myCacheManager = [[self alloc] init];
        
    });
    return myCacheManager;
}
-(void)setImageInCache :(UIImage*)image :(NSString*)stringID{
    [_imageCache setObject:image forKey:stringID];
}

-(void)setThumbnailInCache :(UIImage*)image :(NSString*)stringID{
    [_thumbnailCache setObject:image forKey:stringID];
}
@end
