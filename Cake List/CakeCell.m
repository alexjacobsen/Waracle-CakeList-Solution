//
//  CakeCell.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeCell.h"

@interface CakeCell()

@property (nonatomic) Cake *cake;

@end

@implementation CakeCell

#pragma mark - Setters

- (void)setCake: (Cake *) cake {
    _cake = cake;
    [self updateUI];
}

#pragma mark - UI

/**
 Ensures that a cell has all it's UI elements cleared before being reused by the table view
 */
- (void)prepareForReuse {
    [super prepareForReuse];
    self.titleLabel.text = nil;
    self.descriptionLabel.text = nil;
    self.cakeImageView.image = nil;
}

- (void)updateUI {
    [self setImage];
    [self setLabels];
}

/**
 Set the text for the labels.
 */
- (void)setLabels {
    __weak __typeof__(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.titleLabel.text = weakSelf.cake.title;
        weakSelf.descriptionLabel.text = weakSelf.cake.desc;
    });
}

/**
 Asynchronously download the image from URL and display in the image view.
 */
- (void)setImage {
    __weak __typeof__(self) weakSelf = self;
    
    // Start activity spinner
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicator startAnimating];
    });
    
    // Download the image
    [self downloadImageWithURL:[NSURL URLWithString: self.cake.image] completionBlock:^(BOOL succeeded, UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image != nil) {
                [weakSelf.cakeImageView setImage: image];
            } else {
                // Set to not found image since no image could be retrieved from the URL.
                [weakSelf.cakeImageView setImage: [UIImage imageNamed:@"ImageNotFound"]];
            }
        });
        
        // Stop activity spinner
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.activityIndicator stopAnimating];
        });
    }];
}

#pragma mark - Download

/**
 This method performs an asynchronous image download from a provided URL.

 @param url The url to download the image from.
 @param completionBlock The completion block called once the download has completed. This returns the image and a success boolean.
 */
- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [[UIImage alloc] initWithData:data];
            completionBlock(YES,image);
        } else {
            completionBlock(NO,nil);
        }
    }];
}
@end
