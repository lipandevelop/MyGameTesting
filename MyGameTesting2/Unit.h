//
//  Unit.h
//  MyGameTesting2
//
//  Created by Li Pan on 2016-08-17.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import "BasicAnimatedNode.h"
#import "Horse.h"
#import "Human.h"
#import "Shadow.h"
#import "Weapon.h"

@interface Unit : BasicAnimatedNode

@property (nonatomic, strong) Horse *horse;
@property (nonatomic, strong) Human *human;
@property (nonatomic, strong) Shadow *shadow;
@property (nonatomic, strong) Weapon *weapon;


@end
