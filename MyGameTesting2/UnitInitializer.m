//
//  UnitInitializer.m
//  MyGameTesting2
//
//  Created by Li Pan on 2016-08-18.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import "UnitInitializer.h"
#import <SpriteKit/SpriteKit.h>
#import "Unit.h"

@implementation UnitInitializer

+(void)setupUnitAttackRadius: (float)radius forUnit: (Unit *)unit {
    
    SKSpriteNode *tile = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(radius, radius)];
    SKCropNode* cropNode = [SKCropNode node];
    SKShapeNode* mask = [SKShapeNode node];
    [mask setPath:CGPathCreateWithRoundedRect(CGRectMake(-radius/2, radius/2, radius, radius), radius/2, radius/2, nil)];
    [mask setFillColor:[SKColor clearColor]];
    [cropNode setMaskNode:mask];
    [cropNode addChild:tile];
    [unit addChild:cropNode];
    
}

@end
