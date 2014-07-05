//
//  Track.m
//  CelloLingo
//
//  Created by Chelsea Pugh on 3/4/14.
//  Copyright (c) 2014 Chelsea Pugh. All rights reserved.
//

#import "Track.h"

@implementation Track

- (id)initWithTrack:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

@end
