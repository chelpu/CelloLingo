//
//  Secrets.h
//  CelloLingo
//
//  Created by Chelsea Pugh on 7/12/14.
//  Copyright (c) 2014 Chelsea Pugh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Secrets : NSObject

@property (strong, nonatomic) NSString *SCClientID;
@property (strong, nonatomic) NSString *SCSecret;
@property (strong, nonatomic) NSString *ParseAppID;
@property (strong, nonatomic) NSString *ParseClientKey;

- (id)init;

@end
