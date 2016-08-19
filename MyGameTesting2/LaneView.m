//
//  LaneView.m
//  MyGameTesting2
//
//  Created by Li Pan on 2016-08-18.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import "LaneView.h"

@implementation LaneView

- (instancetype)initWithLaneNumber: (NSUInteger)lanenumber {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        [self addGestureRecognizer:_tapGestureRecognizer];
        
        switch (lanenumber) {
            case 1:
                self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/3, [UIScreen mainScreen].bounds.size.height);
                break;
                
            case 2:
                self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/3, 0, 2*[UIScreen mainScreen].bounds.size.width/3 - [UIScreen mainScreen].bounds.size.width/3, [UIScreen mainScreen].bounds.size.height);
                break;
                
            case 3:
                self.frame = CGRectMake(2*[UIScreen mainScreen].bounds.size.width/3, 0, [UIScreen mainScreen].bounds.size.width - 2*[UIScreen mainScreen].bounds.size.width/3, [UIScreen mainScreen].bounds.size.height);
                break;
                
            default:
                self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/3, [UIScreen mainScreen].bounds.size.height);
                break;
                break;
        }
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
