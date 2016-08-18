//
//  UnitInitializer.h
//  MyGameTesting2
//
//  Created by Li Pan on 2016-08-18.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Unit;

@interface UnitInitializer : NSObject

+(void)setupUnitAttackRadius: (float)radius forUnit: (Unit *)unit;

@end
