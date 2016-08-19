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
+ (void)heroHorseRide: (SKSpriteNode *)horse toDirection: (NSString *)direction withFrameRate: (float) frameRate;
+ (void)heroRide: (SKSpriteNode *)horse toDirection: (NSString *)direction withFrameRate: (float) frameRate;
+ (void)heroWeaponRide: (SKSpriteNode *)weapon toDirection: (NSString *)direction withFrameRate: (float) frameRate andWeapon: (NSString *)weaponName;

+ (void)setupShadowForUnit: (Unit *)unit WithFrameRate: (float)frameRate;

@end
