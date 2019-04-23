//
//  Cake.h
//  Cake List
//
//  Created by Alex Jacobsen on 22/04/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cake : NSObject

@property (strong, nonatomic, nullable) NSString *desc;
@property (strong, nonatomic, nullable) NSString *image;
@property (strong, nonatomic, nullable) NSString *title;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary<NSString *, id> *)dictionary;

@end
