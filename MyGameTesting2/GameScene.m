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

@interface GameScene ()

@property (nonatomic, strong) NSArray *textureArray;
@property (nonatomic, strong) MountedHero *hero;
@property (nonatomic) CGFloat heroMoveSpeed;
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGPoint nextPosition;
@property (nonatomic, strong) SKAction *moveAction;
@property (nonatomic, strong) SKAction *moveSlowDownAction;
@property (nonatomic, strong) SKAction *moveSpeedUpAction;

@property (nonatomic, strong) UIView *leftLane;
@property (nonatomic, strong) UIView *rightLane;
@property (nonatomic, strong) UIView *centreLane;

@property (nonatomic) BOOL isLeftLane;
@property (nonatomic) BOOL isRightLane;


@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    self.isLeftLane = NO;
    self.isRightLane = NO;
    
    self.backgroundColor = [SKColor colorWithRed:212.0f/255.0f green:163.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
    
    [self setupHero];
    
    UITapGestureRecognizer *moveLeftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moveLeft:)];
    UITapGestureRecognizer *moveRightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moveRight:)];
    UITapGestureRecognizer *moveCentreTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moveCentre:)];
    
    self.leftLane = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3, self.frame.size.height)];
    self.leftLane.backgroundColor = [UIColor clearColor];
    [self.leftLane addGestureRecognizer:moveLeftTap];
    [self.view addSubview:self.leftLane];
    
    self.centreLane = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 0, 2*self.view.frame.size.width/3 - self.view.frame.size.width/3, self.frame.size.height)];
    self.centreLane.backgroundColor = [UIColor clearColor];
    [self.centreLane addGestureRecognizer:moveCentreTap];
    [self.view addSubview:self.centreLane];
    
    self.rightLane = [[UIView alloc]initWithFrame:CGRectMake(2*self.view.frame.size.width/3, 0, self.view.frame.size.width - 2*self.view.frame.size.width/3, self.frame.size.height)];
    self.rightLane.backgroundColor = [UIColor clearColor];
    [self.rightLane addGestureRecognizer:moveRightTap];
    [self.view addSubview:self.rightLane];
    
}



-(void)setupHero {
    
    NSArray *gallopTextureArray = [UnitAnimator animateUnitWithTextureAtlasName:@"Gallop"];
    
    SKTexture *temp = gallopTextureArray[0];
    SKTexture *heroTemp = [SKTexture textureWithImage:[UIImage imageNamed:@"Blank"]];
    
    self.hero = [MountedHero spriteNodeWithTexture:heroTemp];
    self.hero.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)*0.3);
    self.hero.xScale = 0.5;
    self.hero.yScale = 0.5;
    
    [UnitInitializer setupUnitAttackRadius:400 forUnit:self.hero];
    
    self.hero.horse = [Horse spriteNodeWithTexture:temp];
    self.hero.horse.textureArray = gallopTextureArray;
    self.hero.horse.position = CGPointMake(0, 0);
    self.hero.horse.zPosition = 1.0f;
    
    [self.hero addChild:self.hero.horse];
    
    
    [self.hero.horse runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.hero.horse.textureArray
                                                                              timePerFrame:0.03f
                                                                                    resize:NO
                                                                                   restore:YES]] withKey:@"horseGallopInPlace"];
    
    
    self.hero.shadow = [Shadow spriteNodeWithTexture:heroTemp];
    [UnitAnimator setupShadowForUnit:self.hero WithFrameRate:0.03f];
    [self addChild:self.hero];
    
    
}

-(void)moveLeft: (UITapGestureRecognizer *)sender {
    NSLog(@"move left");
    self.nextPosition = CGPointMake(CGRectGetMidX(self.frame)-CGRectGetMaxX(self.frame)/9, CGRectGetMaxY(self.frame)*0.3);
    [self setupMoveActionAndDuration];
    [self runHeroAction];
    
    [self.hero runAction:self.moveAction];

    [UnitAnimator heroRide:self.hero.horse withDirection:@"Left" WithFrameRate:0.03f];

        self.isLeftLane = YES;
        self.isRightLane = NO;
}

-(void)moveRight: (UITapGestureRecognizer *)sender {
    NSLog(@"move right");
    self.nextPosition = CGPointMake(CGRectGetMidX(self.frame)+CGRectGetMaxX(self.frame)/9, CGRectGetMaxY(self.frame)*0.3);
    [self setupMoveActionAndDuration];
    [self runHeroAction];

    [UnitAnimator heroRide:self.hero.horse withDirection:@"Right" WithFrameRate:0.03];
    
    self.isRightLane = YES;
    self.isLeftLane = NO;
    
}

-(void)moveCentre: (UITapGestureRecognizer *)sender {
    NSLog(@"move centre");
    self.nextPosition = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)*0.3f);
    [self setupMoveActionAndDuration];
    [self runHeroAction];

    if (self.isLeftLane) {
        [UnitAnimator heroRide:self.hero.horse withDirection:@"Right" WithFrameRate:0.03f];
    }
    
    else if (self.isRightLane) {
        [UnitAnimator heroRide:self.hero.horse withDirection:@"Left" WithFrameRate:0.03f];
    }
    
}

-(void)setupMoveActionAndDuration {
    self.heroMoveSpeed = 100;
    self.duration = ([self distanceBetweenPoint1:self.hero.position andPoint2:self.nextPosition])/self.heroMoveSpeed;
    self.moveSlowDownAction = [SKAction moveToY:self.nextPosition.y - 50.0f duration:1.0f];
    self.moveAction = [SKAction moveToX:self.nextPosition.x duration:self.duration];
    self.moveSpeedUpAction = [SKAction moveToY:CGRectGetMaxY(self.frame)*0.3 duration:self.duration];
}

-(void)runHeroAction {
    [self.hero runAction:self.moveSlowDownAction];
    [self.hero runAction:self.moveAction completion:^{
        [self.hero runAction:self.moveSpeedUpAction];
    }];
}

-(CGFloat)distanceBetweenPoint1: (CGPoint)p1 andPoint2: (CGPoint)p2 {
    return sqrt(pow((p2.x - p1.x), 2) + pow((p2.y - p1.y), 2));
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    /* Called when a touch begins */
//    UITouch *touch = [[event allTouches] anyObject];
//
//    if (self.hero.hasActions) {
//        [self.hero removeAllActions];
//    }
//
//    CGPoint location = [touch locationInNode:self];
//    [self moveHeroToNextLocation:location];
//
//    NSLog(@"%f", location.x);
//
//}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
