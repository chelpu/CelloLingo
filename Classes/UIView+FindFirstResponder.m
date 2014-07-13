//
//  UIView+FindFirstResponder.m
//  BassRead
//
//  Created by Chelsea Pugh on 2/27/14.
//  Copyright (c) 2014 Chelsea Pugh. All rights reserved.
//

#import "UIView+FindFirstResponder.h"

@implementation UIView (FindFirstResponder)
-(UIView *)findViewThatIsFirstResponder {
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findViewThatIsFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}
@end
