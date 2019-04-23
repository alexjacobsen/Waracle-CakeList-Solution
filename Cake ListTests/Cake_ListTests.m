//
//  Cake_ListTests.m
//  Cake ListTests
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CakeCell.h"

@interface Cake_ListTests : XCTestCase

@end

@implementation Cake_ListTests

- (void)setUp {
    [super setUp];
}

#pragma CakeCell Network Tests

/**
 Test that image downloads succeed when a valid URL pointing to an image is provided.
 */
- (void)testDownloadImageWithURLSuceeded {
    // An example of an image URL provided with the project that does link to an image.
    NSURL *validImageUrl = [NSURL URLWithString: @"http://www.bbcgoodfood.com/sites/bbcgoodfood.com/files/recipe_images/recipe-image-legacy-id--1001468_10.jpg"];
    CakeCell *cell = [[CakeCell alloc] init];
    [cell downloadImageWithURL:validImageUrl completionBlock:^(BOOL succeeded, UIImage *image) {
        XCTAssertTrue(succeeded);
    }];
}

/**
 Test that image downloads fail when an invalid URL(which doesn't point to an image) is provided.
 */
- (void)testDownloadImageWithURLFailed {
    // An example of an image URL provided with the project that doesn't link to an image.
    NSURL *invalidImageUrl = [NSURL URLWithString: @"http://www.villageinn.com/i/pies/profile/carrotcake_main1.jpg"];
    CakeCell *cell = [[CakeCell alloc] init];
    [cell downloadImageWithURL:invalidImageUrl completionBlock:^(BOOL succeeded, UIImage *image) {
        XCTAssertFalse(succeeded);
    }];
}

@end
