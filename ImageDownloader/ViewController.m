//
//  ViewController.m
//  ImageDownloader
//
//  Created by Sean Donato on 4/6/18.
//  Copyright © 2018 Sean Donato. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    
    if(!_imageURLSArray){
        
        _imageURLSArray = [[NSMutableArray alloc]init];
        _imageCache = [CacheManager sharedManager];
        _imageCollectionView.delegate = self;
        _imageCollectionView.dataSource = self;
        [self.view bringSubviewToFront:_imageCollectionView];
        [_imageCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
        [self imageJSONDownloader];

    }

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(150.0,150.0);
    return size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    
    if([_imageURLSArray count]){
        return [_imageURLSArray count];
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    __block CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    cell.cellImage.image = nil;
    if([[_imageURLSArray objectAtIndex:indexPath.row] isKindOfClass:[NSDictionary class]]){
        
        NSMutableDictionary *imgDict = [_imageURLSArray objectAtIndex:indexPath.row];

        if([imgDict objectForKey:@"id"]){
            
            NSString  *imgID = [imgDict objectForKey:@"id"];
        
            if([_imageCache.thumbnailCache objectForKey:[imgDict objectForKey:@"id"]]){
                
                cell.cellImage.image = [_imageCache.thumbnailCache objectForKey:imgID];
                
            }else{

                NSString *urlString =[imgDict objectForKey:@"thumbnailUrl"];
                NSString *stringWithHttps = [urlString stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];

                NSURL *thumbnailUrl = [NSURL URLWithString:stringWithHttps];

                NSURLRequest *request = [NSURLRequest requestWithURL:thumbnailUrl];
                
                NSURLSession *session = [NSURLSession sharedSession];
                NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                        completionHandler:
                                              ^(NSData *data, NSURLResponse *response, NSError *error) {
                                                 dispatch_async(dispatch_get_main_queue(), ^{ // Correct
                                                     
                                                   
                                                     cell.cellImage.image= [UIImage imageWithData:data];
                                                     UIImage *x = [UIImage imageWithData:data];
                                                         [_imageCache.thumbnailCache setObject:x forKey:imgID];
                                                                                                });

                                              }];
                
                [task resume];

                
            }
        }
    }
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;

    return cell;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *imgDict = [_imageURLSArray objectAtIndex:indexPath.row];
    NSString *urlString =[imgDict objectForKey:@"url"];
    NSString *stringWithHttps = [urlString stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
    

    ImageViewController *imgVC = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil set:[imgDict objectForKey:@"id"] :stringWithHttps];
    [self.navigationController pushViewController:imgVC animated:YES];
    
}

-(void)imageJSONDownloader{
    
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: @"https://jsonplaceholder.typicode.com/photos"];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    _imageURLSArray = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error:nil];
    [_imageCollectionView reloadData];



}

@end
