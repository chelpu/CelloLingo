//
//  Note.m
//  BassRead
//
//  Created by Chelsea Pugh on 12/19/13.
//  Copyright (c) 2013 Chelsea Pugh. All rights reserved.
//

#import "Note.h"

@implementation Note

- (id)initWithValue:(NSInteger)value xPosition:(NSInteger)xPosition {
    self = [super init];
    if(self) {
        self.value = value;
        self.xPosition = xPosition;
        self.noteView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,30,30)];
        self.noteView.image = [UIImage imageNamed:@"wholeNote.png"];
    }
    return self;
}

@end
