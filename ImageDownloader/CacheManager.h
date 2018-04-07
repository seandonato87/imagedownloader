//
//  CacheManager.h
//  ImageDownloader
//
//  Created by Sean Donato on 4/6/18.
//  Copyright © 2018 Sean Donato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CacheManager : NSObject


@property (nonatomic, retain) NSCache *imageCache;
@property (nonatomic, retain) NSCache *thumbnailCache;

+ (id)sharedManager;
-(void)setImageInCache :(UIImage*)image :(NSString*)stringID;
-(void)setThumbnailInCache :(UIImage*)image :(NSString*)stringID;

@end
