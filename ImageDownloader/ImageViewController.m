//
//  ImageViewController.m
//  ImageDownloader
//
//  Created by Sean Donato on 4/6/18.
//  Copyright © 2018 Sean Donato. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil set:(NSString *)imgid :(NSString*)imgURL {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _imageidForImgVC = imgid;
        _imageURLForImgVC= [NSURL URLWithString: imgURL];
    }
    return self;

    
}
-(void)viewWillAppear:(BOOL)animated{
    
    _imageCacheForImgVC = [CacheManager sharedManager];
    if([_imageCacheForImgVC.imageCache objectForKey:_imageidForImgVC]){
        _imageFromURL.image = [_imageCacheForImgVC.imageCache objectForKey:_imageidForImgVC];
    }else{
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_imageURLForImgVC];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          dispatch_async(dispatch_get_main_queue(), ^{ // Correct
                                              
                                              
                                              _imageFromURL.image= [UIImage imageWithData:data];
                                              UIImage *x = [UIImage imageWithData:data];
                                              [_imageCacheForImgVC.imageCache setObject:x forKey:_imageidForImgVC];
                                          });
                                          
                                      }];
        
        [task resume];
        
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
