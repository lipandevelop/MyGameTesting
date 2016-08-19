//
//  GameScene.m
//  MyGameTesting2
//
//  Created by Li Pan on 2016-08-15.
//  Copyright (c) 2016 Li Pan. All rights reserved.
//

#import "GameScene.h"
#import "MountedHero.h"
#import "UnitAnimator.h"
#import "UnitInitializer.h"
#import "LaneView.h"

typedef enum {
    laneLeft = 1,
    laneCentre,
    laneRight,

} HeroLane;

@interface GameScene ()

@property (nonatomic, strong) NSArray *textureArray;
@property (nonatomic, strong) MountedHero *hero;
@property (nonatomic, assign) CGFloat heroMoveSpeed;
@property (nonatomic, assign) CGPoint nextPosition;
@property (nonatomic, assign) HeroLane isLane;

@property (nonatomic, strong) UIView *circle;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    self.isLane = laneCentre;
    self.heroMoveSpeed = 100;
    
    self.circle = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)*0.3, 100, 100)];
    
    NSLog(@"%f, %f", CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)*0.3);
    self.circle.backgroundColor = [UIColor clearColor];
    self.circle.layer.cornerRadius = self.circle.bounds.size.width/2;
    self.circle.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
    self.circle.layer.borderWidth = 2.0f;
    [self.view addSubview:self.circle];

    
    self.backgroundColor = [SKColor colorWithRed:212.0f/255.0f green:163.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
    
    [self setupHero];
    [self setupLanes];
    
}

-(void)setupHero {
    
    NSArray *gallopTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"Gallop"];
    NSArray *heroRideTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"HeroRide"];
    NSArray *heroWeaponRideTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"WeaponKnifeRide"];

    
    SKTexture *temp = gallopTextureArray[0];
    SKTexture *heroTemp = [SKTexture textureWithImage:[UIImage imageNamed:@"Blank"]];
    
    self.hero = [MountedHero spriteNodeWithTexture:heroTemp];
    self.hero.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)*0.3);
    self.hero.xScale = 0.5;
    self.hero.yScale = 0.5;
    
    self.hero.human = [Human spriteNodeWithTexture:heroRideTextureArray[0]];
    self.hero.human.textureArray = heroRideTextureArray;
    self.hero.human.position = CGPointMake(-5, 15);
    self.hero.human.zPosition = 1.1f;
    
    self.hero.weapon = [Weapon spriteNodeWithTexture:heroWeaponRideTextureArray[0]];
    self.hero.weapon.textureArray = heroWeaponRideTextureArray;
    self.hero.weapon.position = CGPointMake(55, 10);
    self.hero.weapon.zPosition = 1.01f;
    
    
    [UnitInitializer setupUnitAttackRadius:400 forUnit:self.hero];
    
    self.hero.horse = [Horse spriteNodeWithTexture:temp];
    self.hero.horse.textureArray = gallopTextureArray;
    self.hero.horse.position = CGPointMake(0, 0);
    self.hero.horse.zPosition = 1.0f;
    
    [self.hero addChild:self.hero.horse];
    [self.hero addChild:self.hero.weapon];
    [self.hero addChild:self.hero.human];
    
    [self.hero.human runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.hero.human.textureArray
                                                                              timePerFrame:0.03f
                                                                                    resize:NO
                                                                                   restore:YES]] withKey:@"heroRideInPlace"];
    
    [self.hero.horse runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.hero.horse.textureArray
                                                                              timePerFrame:0.03f
                                                                                    resize:NO
                                                                                   restore:YES]] withKey:@"horseGallopInPlace"];
    
    [self.hero.weapon runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.hero.weapon.textureArray
                                                                              timePerFrame:0.03f
                                                                                    resize:NO
                                                                                   restore:YES]] withKey:@"heroWeaponRidePlace"];
    
    self.hero.shadow = [Shadow spriteNodeWithTexture:heroTemp];
    [UnitAnimator setupShadowForUnit:self.hero WithFrameRate:0.03f];
    [self addChild:self.hero];
    
    
}

-(void)setupLanes {
    
    LaneView *leftLane = [[LaneView alloc] initWithLaneNumber:1];
    [leftLane.tapGestureRecognizer addTarget:self action:@selector(moveLeft:)];
    LaneView *centreLane = [[LaneView alloc] initWithLaneNumber:2];
    [centreLane.tapGestureRecognizer addTarget:self action:@selector(moveCentre:)];
    LaneView *rightLane = [[LaneView alloc] initWithLaneNumber:3];
    [rightLane.tapGestureRecognizer addTarget:self action:@selector(moveRight:)];
    
    [self.view addSubview:leftLane];
    [self.view addSubview:centreLane];
    [self.view addSubview:rightLane];
    
}

-(void)moveLeft: (UITapGestureRecognizer *)sender {
    NSLog(@"move left");
    
    [self.hero removeAllActions];
    self.nextPosition = CGPointMake(CGRectGetMidX(self.frame)-CGRectGetMaxX(self.frame)/9, self.hero.position.y);
    
    if (self.isLane != laneLeft) {
        [UnitAnimator heroRide:self.hero.human toDirection:@"Left" withFrameRate:0.03];
        [UnitAnimator heroHorseRide:self.hero.horse toDirection:@"Left" withFrameRate:0.03];
        [UnitAnimator heroWeaponRide:self.hero.weapon toDirection:@"Left" withFrameRate:0.03 andWeapon:@"Knife"];
        [self setupAndRunMoveActionWithDuration];
    }
    
    else {
        [self setupAndRunChargeActionWithDuration];
    }
    
    self.isLane = laneLeft;
    
}

-(void)moveRight: (UITapGestureRecognizer *)sender {
    NSLog(@"move right");
    
    [self.hero removeAllActions];
    self.nextPosition = CGPointMake(CGRectGetMidX(self.frame)+CGRectGetMaxX(self.frame)/9, self.hero.position.y);
    
    if (self.isLane != laneRight) {
        [UnitAnimator heroRide:self.hero.human toDirection:@"Right" withFrameRate:0.03];
        [UnitAnimator heroHorseRide:self.hero.horse toDirection:@"Right" withFrameRate:0.03];
        [UnitAnimator heroWeaponRide:self.hero.weapon toDirection:@"Right" withFrameRate:0.03 andWeapon:@"Knife"];
        [self setupAndRunMoveActionWithDuration];
    }
    
    else {
        [self setupAndRunChargeActionWithDuration];
    }
    
    self.isLane = laneRight;
    
}

-(void)moveCentre: (UITapGestureRecognizer *)sender {
    NSLog(@"move centre");
    
    [self.hero removeAllActions];
    
    self.nextPosition = CGPointMake(CGRectGetMidX(self.frame), self.hero.position.y);
    
    if (self.isLane != laneCentre) {
        if ((self.isLane = laneLeft)) {
            [UnitAnimator heroRide:self.hero.human toDirection:@"Right" withFrameRate:0.03];
            [UnitAnimator heroHorseRide:self.hero.horse toDirection:@"Right" withFrameRate:0.03];
            [UnitAnimator heroWeaponRide:self.hero.weapon toDirection:@"Right" withFrameRate:0.03 andWeapon:@"Knife"];
            [self setupAndRunMoveActionWithDuration];
            
        }
        
        if ((self.isLane = laneRight)) {
            [UnitAnimator heroRide:self.hero.human toDirection:@"Left" withFrameRate:0.03];
            [UnitAnimator heroHorseRide:self.hero.horse toDirection:@"Left" withFrameRate:0.03];
            [UnitAnimator heroWeaponRide:self.hero.weapon toDirection:@"Left" withFrameRate:0.03 andWeapon:@"Knife"];
            [self setupAndRunMoveActionWithDuration];
            
        }
    }
    else {
        [self setupAndRunChargeActionWithDuration];
    }
    self.isLane = laneCentre;
}

-(void)setupAndRunMoveActionWithDuration {
    CGFloat duration = ([self distanceBetweenPoint1:self.hero.position andPoint2:self.nextPosition])/self.heroMoveSpeed;
    [self.hero removeAllActions];
    SKAction *moveSlowDownAction = [SKAction moveToY:self.nextPosition.y - 50.0f duration:1.0f];
    SKAction *moveAction = [SKAction moveToX:self.nextPosition.x duration:duration];
    SKAction *moveCatchUpAction = [SKAction moveToY:CGRectGetMaxY(self.frame)*0.3 duration:duration];
    SKAction *firstStep = [SKAction group:@[moveSlowDownAction, moveAction]];
    SKAction *sequence = [SKAction sequence:@[firstStep, moveCatchUpAction]];
    
    [self.hero runAction:sequence];
}

-(void)setupAndRunChargeActionWithDuration {
    [self.hero removeAllActions];
//    CGFloat duration = ([self distanceBetweenPoint1:self.hero.position andPoint2:self.nextPosition])/self.heroMoveSpeed;
    SKAction *moveSpeedUpAction = [SKAction moveToY:self.hero.position.y + 20.0f duration:0.5];
    SKAction *moveSpeedSlowDownAction = [SKAction moveToY:CGRectGetMaxY(self.frame)*0.3 duration:3];
    SKAction *sequence = [SKAction sequence:@[moveSpeedUpAction, moveSpeedSlowDownAction]];

    [self.hero runAction:sequence];
}

-(void)setupAndRunRecoverPositionActionWithDuration {
    if (self.hero.position.x > CGRectGetMaxY(self.frame)*0.3) {
        CGFloat duration = ([self distanceBetweenPoint1:self.hero.position andPoint2:CGPointMake(self.hero.position.x, CGRectGetMaxY(self.frame)*0.3)])/self.heroMoveSpeed;
        SKAction *moveSpeedSlowDownAction = [SKAction moveToY:CGRectGetMaxY(self.frame)*0.3 duration:duration/4];
        [self.hero runAction:moveSpeedSlowDownAction];
    }
}

-(CGFloat)distanceBetweenPoint1: (CGPoint)p1 andPoint2: (CGPoint)p2 {
    return sqrt(pow((p2.x - p1.x), 2) + pow((p2.y - p1.y), 2));
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

-(void)update:(CFTimeInterval)currentTime {
    self.circle.center = self.hero.position;
}

@end
