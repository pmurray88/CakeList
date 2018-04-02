//
//  CakeCell.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeCell.h"

@interface CakeCell()
- (void)loadImage:(NSURL *)url;
@end

@implementation CakeCell

-(void)prepareForReuse {
    [super prepareForReuse];
    [self.cakeImageView setImage:nil];
}

- (void)setupCell:(Cake *)cake {
    self.titleLabel.text = [cake.title capitalizedString];
    self.descriptionLabel.text = cake.desc;
    [self loadImage:cake.image];
}

- (void)loadImage:(NSURL *)url {
    
    /*
    // Would use a third party image library here such as SDWebImage or Haneke to make use of their
    // built in image caching to prevent the images having to be fetched on each redraw of the cell
     */
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.cakeImageView setImage:[UIImage imageWithData:data]];
            });
        }
    }];
    [task resume];
}

@end
