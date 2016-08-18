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

+ (void)heroRide: (SKSpriteNode *)horse withDirection: (NSString *)direction WithFrameRate: (float) frameRate {
    
    NSArray *gallopTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"Gallop"];
    NSArray *gallopLeftTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"GallopLeft"];
    NSArray *gallopRightTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"GallopRight"];

    
    if ([direction isEqualToString:@"Left"]) {
        [horse runAction:[SKAction animateWithTextures:gallopLeftTextureArray timePerFrame:0.03f]
              completion:^{
            [horse runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:gallopTextureArray
                                                                            timePerFrame:0.03f
                                                                                  resize:NO
                                                                                 restore:YES]] withKey:@"horseGallopLeft"];
        }];
    }
    
    else if ([direction isEqualToString:@"Right"]) {
        [horse runAction:[SKAction animateWithTextures:gallopRightTextureArray timePerFrame:0.03f]
              completion:^{
            [horse runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:gallopTextureArray
                                                                            timePerFrame:0.03f
                                                                                  resize:NO
                                                                                 restore:YES]] withKey:@"horseGallopRight"];
        }];

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
