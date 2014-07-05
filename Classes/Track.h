//
//  Track.h
//  CelloLingo
//
//  Created by Chelsea Pugh on 3/4/14.
//  Copyright (c) 2014 Chelsea Pugh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject
- (id)initWithTrack:(NSString *)title;
@property (strong, nonatomic) NSString *title;
@end
