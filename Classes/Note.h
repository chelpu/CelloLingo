//
//  Note.h
//  BassRead
//
//  Created by Chelsea Pugh on 12/19/13.
//  Copyright (c) 2013 Chelsea Pugh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (strong, nonatomic) UIImageView *noteView;
@property (nonatomic) NSInteger value;
@property (nonatomic) NSInteger xPosition;

- (id)initWithValue:(NSInteger)value xPosition:(NSInteger)xPosition;

@end
