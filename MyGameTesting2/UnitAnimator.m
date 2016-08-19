//
//  UnitAnimator.m
//  MyGameTesting2
//
//  Created by Li Pan on 2016-08-17.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import "UnitAnimator.h"
#import <SpriteKit/SpriteKit.h>
#import "Unit.h"

@interface UnitAnimator ()

@end


@implementation UnitAnimator

+ (NSArray *)animateUnitWithTextureAtlasName: (NSString *)atlasName {
    
    NSMutableArray *gallopFrames = [NSMutableArray array];
    
    SKTextureAtlas *gallopFramesAtlas = [SKTextureAtlas atlasNamed:atlasName];
    
    NSArray *imageNamesArray = [NSArray array];
    NSArray *textureArray = [NSMutableArray array];
    
    imageNamesArray = (NSMutableArray *)[gallopFramesAtlas textureNames];
    
    //    NSLog(@"Unsorted %@", imageNamesArray);
    
    imageNamesArray = [imageNamesArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
    //    NSLog(@"Sorted %@", imageNamesArray);
    
    for (NSString *fileName in imageNamesArray) {
        SKTexture *texture = [gallopFramesAtlas textureNamed:fileName];
        [gallopFrames addObject:texture];
    }
    
    textureArray = gallopFrames;
    
    return textureArray;
        
}

+ (void)heroWeaponRide: (SKSpriteNode *)weapon toDirection: (NSString *)direction withFrameRate: (float) frameRate andWeapon: (NSString *)weaponName{
    NSArray *heroRideTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"WeaponKnifeRide"];
    NSArray *heroRideLeftTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"WeaponKnifeRideLeft"];
    NSArray *heroRideRightTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"WeaponKnifeRideRight"];
    
    if ([direction isEqualToString:@"Left"]) {
        [weapon runAction:[SKAction animateWithTextures:heroRideLeftTextureArray timePerFrame:frameRate]
             completion:^{
                 [weapon runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:heroRideTextureArray
                                                                                timePerFrame:frameRate
                                                                                      resize:NO
                                                                                     restore:YES]] withKey:[NSString stringWithFormat:@"kWeaponRide%@", direction]];
             }];
    }
    
    if ([direction isEqualToString:@"Right"]) {
        [weapon runAction:[SKAction animateWithTextures:heroRideRightTextureArray timePerFrame:frameRate]
             completion:^{
                 [weapon runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:heroRideTextureArray
                                                                                timePerFrame:frameRate
                                                                                      resize:NO
                                                                                     restore:YES]] withKey:[NSString stringWithFormat:@"kWeaponRide%@", direction]];
             }];
        
    }
    
    if ([direction isEqualToString:@"Centre"]) {
        [weapon runAction:[SKAction animateWithTextures:heroRideTextureArray timePerFrame:frameRate = 0.01]];
    }
}


+ (void)heroRide: (SKSpriteNode *)hero toDirection: (NSString *)direction withFrameRate: (float) frameRate {
    
    NSArray *heroRideTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"HeroRide"];
    NSArray *heroRideLeftTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"HeroRideLeft"];
    NSArray *heroRideRightTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"HeroRideRight"];
    
    if ([direction isEqualToString:@"Left"]) {
        [hero runAction:[SKAction animateWithTextures:heroRideLeftTextureArray timePerFrame:frameRate]
              completion:^{
                  [hero runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:heroRideTextureArray
                                                                                  timePerFrame:frameRate
                                                                                        resize:NO
                                                                                       restore:YES]] withKey:[NSString stringWithFormat:@"kHeroRide%@", direction]];
              }];
    }
    
    if ([direction isEqualToString:@"Right"]) {
        [hero runAction:[SKAction animateWithTextures:heroRideRightTextureArray timePerFrame:frameRate]
              completion:^{
                  [hero runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:heroRideTextureArray
                                                                                  timePerFrame:frameRate
                                                                                        resize:NO
                                                                                       restore:YES]] withKey:[NSString stringWithFormat:@"kHeroRide%@", direction]];
              }];
        
    }
    
    if ([direction isEqualToString:@"Centre"]) {
        [hero runAction:[SKAction animateWithTextures:heroRideTextureArray timePerFrame:frameRate = 0.01]];
    }
    
}

+ (void)heroHorseRide: (SKSpriteNode *)horse toDirection: (NSString *)direction withFrameRate: (float) frameRate {
    
    NSArray *gallopTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"Gallop"];
    NSArray *gallopLeftTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"GallopLeft"];
    NSArray *gallopRightTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"GallopRight"];
    
    if ([direction isEqualToString:@"Left"]) {
        [horse runAction:[SKAction animateWithTextures:gallopLeftTextureArray timePerFrame:frameRate]
              completion:^{
            [horse runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:gallopTextureArray
                                                                            timePerFrame:frameRate
                                                                                  resize:NO
                                                                                 restore:YES]] withKey:[NSString stringWithFormat:@"kHeroHorseRide%@", direction]];
        }];
    }
    
    if ([direction isEqualToString:@"Right"]) {
        [horse runAction:[SKAction animateWithTextures:gallopRightTextureArray timePerFrame:frameRate]
              completion:^{
            [horse runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:gallopTextureArray
                                                                            timePerFrame:frameRate
                                                                                  resize:NO
                                                                                 restore:YES]] withKey:[NSString stringWithFormat:@"kHeroHorseRide%@", direction]];
        }];

    }
    
    if ([direction isEqualToString:@"Centre"]) {
        [horse runAction:[SKAction animateWithTextures:gallopTextureArray timePerFrame:frameRate = 0.01]];
    }

}

+ (void)setupShadowForUnit: (Unit *)unit WithFrameRate: (float)frameRate {
    NSArray *shadowTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"GallopShadow"];
    
    unit.shadow.textureArray = shadowTextureArray;
    unit.shadow.position = CGPointMake(110, 0);
    unit.shadow.xScale = 0.8f;
    unit.shadow.yScale = 0.75f;
    unit.shadow.zPosition = 0.90f;
    unit.shadow.alpha = 0.5f;
    
    [unit addChild:unit.shadow];
    
    [unit.shadow runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:unit.shadow.textureArray
                                                                               timePerFrame:frameRate
                                                                                     resize:NO
                                                                                    restore:YES]] withKey:@"shadowGallopInPlace"];

    
}


@end
