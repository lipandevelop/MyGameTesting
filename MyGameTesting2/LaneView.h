//
//  LaneView.h
//  MyGameTesting2
//
//  Created by Li Pan on 2016-08-18.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaneView : UIView
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

- (instancetype)initWithLaneNumber: (NSUInteger)lanenumber;

@end
