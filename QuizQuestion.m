//
//  QuizQuestion.m
//  
//
//  Created by Chelsea Pugh on 3/4/14.
//
//

#import "QuizQuestion.h"

@implementation QuizQuestion

- (id)initWithQuestion:(NSString *)question answers:(NSArray *)answers answerIndex:(NSInteger)answerIndex
{
    self = [super init];
    if (self) {
        self.question = question;
        self.answers = [[NSArray alloc] initWithArray:answers];
        self.answerIndex = answerIndex;
    }
    return self;
}

@end
