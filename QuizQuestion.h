//
//  QuizQuestion.h
//  
//
//  Created by Chelsea Pugh on 3/4/14.
//
//

#import <Foundation/Foundation.h>

@interface QuizQuestion : NSObject

@property (strong, nonatomic) NSString *question;
@property (strong, nonatomic) NSArray *answers;
@property NSInteger answerIndex;

- (id)initWithQuestion:(NSString *)question answers:(NSArray *)answers answerIndex:(NSInteger)answerIndex;


@end
