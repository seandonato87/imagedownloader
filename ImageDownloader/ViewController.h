//
//  ViewController.h
//  ImageDownloader
//
//  Created by Sean Donato on 4/6/18.
//  Copyright © 2018 Sean Donato. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheManager.h"
#import "ImageViewController.h"
@interface ViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (strong,nonatomic) NSMutableArray *imageURLSArray;
@property (strong,nonatomic) CacheManager *imageCache;
@property (weak, nonatomic) IBOutlet UIView *activityIndicatorParentView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

