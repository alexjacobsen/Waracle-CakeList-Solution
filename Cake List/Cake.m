//
//  Cake.m
//  Cake List
//
//  Created by Alex Jacobsen on 22/04/2019.
//  Copyright © 2019 Stewart Hart. All rights reserved.
//

#import "Cake.h"

NSString * _Nonnull const CakeDescriptionKey = @"desc";
NSString * _Nonnull const CakeImageKey = @"image";
NSString * _Nonnull const CakeTitleKey = @"title";

@implementation Cake

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self != nil) {
        if (dictionary != nil) {
            self.desc = (NSString*) dictionary[CakeDescriptionKey];
            self.image = (NSString*) dictionary[CakeImageKey];
            self.title = (NSString*) dictionary[CakeTitleKey];
        }
    }
    return self;
}

@end
