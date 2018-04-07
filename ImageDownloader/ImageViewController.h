//
//  ImageViewController.h
//  ImageDownloader
//
//  Created by Sean Donato on 4/6/18.
//  Copyright © 2018 Sean Donato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheManager.h"

@interface ImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageFromURL;
@property (strong,nonatomic) CacheManager *imageCacheForImgVC;
@property (strong,nonatomic) NSURL *imageURLForImgVC;
@property (strong,nonatomic) NSString *imageidForImgVC;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil set:(NSString *)imgid :(NSString*)imgURL;
@end
