//
//  UnitAnimator.h
//  MyGameTesting2
//
//  Created by Li Pan on 2016-08-17.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SKSpriteNode;
@class Unit;

@interface UnitAnimator : NSObject

+ (NSArray *)animateUnitWithTextureAtlasName: (NSString *)atlasName;
+ (void)heroRide: (SKSpriteNode *)horse withDirection: (NSString *)direction WithFrameRate: (float) frameRate;
+ (void)setupShadowForUnit: (Unit *)unit WithFrameRate: (float)frameRate;

@end
