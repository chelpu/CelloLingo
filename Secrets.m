//
//  Secrets.m
//  CelloLingo
//
//  Created by Chelsea Pugh on 7/12/14.
//  Copyright (c) 2014 Chelsea Pugh. All rights reserved.
//

#import "Secrets.h"

@implementation Secrets

- (id)init {
    if(self = [super init]) {
        self.SCClientID = @"c76d3fe9bb6cfee88bb0d1598219eee4";
        self.SCSecret = @"66360dbcf98d672fb4af2fbb5a0351c8";
        self.ParseAppID = @"bhDyk8YsZefvMzRFA8l1JmxW9H1ylWG5mp0QqBoa";
        self.ParseClientKey = @"kt2DXoyX3jLJkWzhE00OUDBEdEzp2twifLy2JOOJ";
    }
    return self;
}

@end
