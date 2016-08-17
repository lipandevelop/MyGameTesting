//
//  GameScene.m
//  MyGameTesting2
//
//  Created by Li Pan on 2016-08-15.
//  Copyright (c) 2016 Li Pan. All rights reserved.
//

#import "GameScene.h"
#import "Hero.h"

@interface GameScene ()

@property (nonatomic, strong) NSArray *textureArray;
@property (nonatomic, strong) SKSpriteNode *horse;
@property (nonatomic, strong) SKSpriteNode *horse;
@property (nonatomic) CGFloat heroMoveSpeed;
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGPoint nextPosition;
@property (nonatomic, strong) SKAction *moveAction;

@property (nonatomic, strong) UIView *leftLane;
@property (nonatomic, strong) UIView *rightLane;
@property (nonatomic, strong) UIView *centreLane;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    
    self.backgroundColor = [SKColor colorWithRed:212.0f/255.0f green:163.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
    
    [self setupHorse];
    
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

-(void)moveLeft: (UITapGestureRecognizer *)sender {
    NSLog(@"move left");
    self.nextPosition = CGPointMake(CGRectGetMidX(self.frame)-CGRectGetMaxX(self.frame)/9, CGRectGetMaxY(self.frame)*0.3);
    [self setupMoveActionAndDuration];
    [self.horse runAction:self.moveAction];
    
}

-(void)moveRight: (UITapGestureRecognizer *)sender {
    NSLog(@"move right");
    self.nextPosition = CGPointMake(CGRectGetMidX(self.frame)+CGRectGetMaxX(self.frame)/9, CGRectGetMaxY(self.frame)*0.3);
    [self setupMoveActionAndDuration];
    [self.horse runAction:self.moveAction];
    
}

-(void)moveCentre: (UITapGestureRecognizer *)sender {
    NSLog(@"move centre");
    self.nextPosition = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)*0.3);
    [self setupMoveActionAndDuration];
    [self.horse runAction:self.moveAction];
    
}

-(void)setupMoveActionAndDuration {
    self.heroMoveSpeed = 360;
    self.duration = ([self distanceBetweenPoint1:self.horse.position andPoint2:self.nextPosition])/self.heroMoveSpeed;
    self.moveAction = [SKAction moveToX:self.nextPosition.x duration:self.duration];
}

-(void)setupHorse {
    
    NSMutableArray *gallopFrames = [NSMutableArray array];
    
    SKTextureAtlas *gallopFramesAtlas = [SKTextureAtlas atlasNamed:@"Gallop"];
    
    NSArray *imageNamesArray = [NSArray array];
    self.textureArray = [NSMutableArray array];
    
    imageNamesArray = (NSMutableArray *)[gallopFramesAtlas textureNames];
    
//    NSLog(@"Unsorted %@", imageNamesArray);
    
    imageNamesArray = [imageNamesArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
//    NSLog(@"Sorted %@", imageNamesArray);
    
    for (NSString *fileName in imageNamesArray) {
        SKTexture *texture = [gallopFramesAtlas textureNamed:fileName];
        [gallopFrames addObject:texture];
    }
    
    self.textureArray = gallopFrames;
    
    
//    NSLog(@"%@", gallopFrames);
    
    //Create bear sprite, setup position in middle of the screen, and add to Scene
    SKTexture *temp = self.textureArray[0];
    self.horse = [SKSpriteNode spriteNodeWithTexture:temp];
    self.horse.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame)*0.3);
    self.horse.xScale = 0.5;
    self.horse.yScale = 0.5;
    [self addChild:self.horse];
    
    
    [self.horse runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.textureArray
                                                                        timePerFrame:0.03f
                                                                              resize:NO
                                                                             restore:YES]] withKey:@"heroGallopInPlace"];
}

-(void)setupHeroShadow {
    
    NSMutableArray *gallopFrames = [NSMutableArray array];
    
    SKTextureAtlas *gallopFramesAtlas = [SKTextureAtlas atlasNamed:@"GallopShadow"];
    
    NSArray *imageNamesArray = [NSArray array];
    self.textureArray = [NSMutableArray array];
    
    imageNamesArray = (NSMutableArray *)[gallopFramesAtlas textureNames];
    
    //    NSLog(@"Unsorted %@", imageNamesArray);
    
    imageNamesArray = [imageNamesArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
    //    NSLog(@"Sorted %@", imageNamesArray);
    
    for (NSString *fileName in imageNamesArray) {
        SKTexture *texture = [gallopFramesAtlas textureNamed:fileName];
        [gallopFrames addObject:texture];
    }
    
    self.textureArray = gallopFrames;
    
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
