//
//  TechniqueQuizViewController.m
//  CelloLingo
//
//  Created by Chelsea Pugh on 3/4/14.
//  Copyright (c) 2014 Chelsea Pugh. All rights reserved.
//

#import "TechniqueQuizViewController.h"
#import "QuizQuestion.h"

@interface TechniqueQuizViewController ()

@end

@implementation TechniqueQuizViewController {
    NSMutableArray *_questionsAndAnswers;
    NSMutableArray *_answerLabels;
    NSMutableArray *_selectionButtons;
    NSInteger _answerIndex;
    NSInteger _curQuestionIndex;
    int _numLvls;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _numLvls = 5;
        _questionsAndAnswers = [[NSMutableArray alloc] init];
        _answerLabels = [[NSMutableArray alloc] init];
        _selectionButtons = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *level = [defaults objectForKey:@"level"];
    NSNumber *curQ = [defaults objectForKey:@"curQuestion"];
    NSInteger qIndex = [curQ intValue];
    PFQuery *query = [PFQuery queryWithClassName:@"TechniqueQuestion"];
    [query whereKey:@"level" equalTo:level];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (int i = 0; i < objects.count; i++) {
                PFObject *quizObject = objects[i];
                QuizQuestion *curQQ = [[QuizQuestion alloc] initWithQuestion:quizObject[@"question"]
                                                                     answers:quizObject[@"answers"]
                                                                 answerIndex:[quizObject[@"correct"] intValue]];
                [_questionsAndAnswers addObject:curQQ];
            }
            _curQuestionIndex = qIndex;
            [self repopulateQuestionViewWithQuestionIndex:_curQuestionIndex];
            [hud hide:YES];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)answerButtonSelected:(id)sender {
    NSInteger index = (NSInteger)[_selectionButtons indexOfObject:sender];
    UIButton *button = (UIButton *)sender;
    if (index == _answerIndex) {
        [button setBackgroundImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        for (int i = 0; i < _selectionButtons.count; i++) {
            [_selectionButtons[i] setBackgroundColor:[UIColor clearColor]];
            if(i != _answerIndex) {
                [_selectionButtons[i] setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
            }
        }
        [button setBackgroundColor:[UIColor clearColor]];
        [self loadNewQuestion];
    } else {
        [button setBackgroundColor:[UIColor clearColor]];
        [button setBackgroundImage:[UIImage imageNamed:@"x.png"] forState:UIControlStateNormal];
    }
}

- (void)repopulateQuestionViewWithQuestionIndex:(NSInteger)index {
    QuizQuestion *quizQ = [_questionsAndAnswers objectAtIndex:index];
    self.questionLabel.text = [NSString stringWithFormat:@"%@", quizQ.question];
    [self.questionLabel setFont:[UIFont fontWithName:@"Roboto-Bold" size:40.0f]];

    QuizQuestion *qq = _questionsAndAnswers[index];
    _answerIndex = qq.answerIndex;
    for(int j = 0; j < qq.answers.count; j++) {
        UILabel *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(150.0f, 195 + 90.0*j, 568, 120)];
        UIButton *selectionButton = [[UIButton alloc] initWithFrame:CGRectMake(50.0f, 215 + 90.0*j, 80.0f, 80.0f)];
        [selectionButton addTarget:self
                            action:@selector(answerButtonSelected:)
                  forControlEvents:UIControlEventTouchUpInside];
        [selectionButton setBackgroundImage:[UIImage imageNamed:@"noteKeyboardButton.png"] forState:UIControlStateNormal];
        
        [_selectionButtons addObject:selectionButton];
        [_answerLabels addObject:answerLabel];
        [answerLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:30.0]];
        answerLabel.text = qq.answers[j];
        [self.view addSubview:answerLabel];
        [self.view addSubview:selectionButton];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearStructures {
    for(UIView *view in self.view.subviews) {
        if(view != self.questionLabel)
            [view removeFromSuperview];
    }
    self.questionLabel.text = @"";
    [_selectionButtons removeAllObjects];
    [_answerLabels removeAllObjects];
}

- (void)loadNewQuestion {
    [self clearStructures];
    if(_curQuestionIndex + 1 < _questionsAndAnswers.count) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *curQ = [NSNumber numberWithInt:(_curQuestionIndex + 1)];
        _curQuestionIndex++;
        [defaults setObject:curQ forKey:@"curQuestion"];
        [defaults synchronize];
        [self repopulateQuestionViewWithQuestionIndex:_curQuestionIndex];
    } else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *num = [defaults objectForKey:@"level"];
        NSNumber *level = [NSNumber numberWithInt:([num intValue] + 1)];
        NSNumber *curQ = [NSNumber numberWithInt:0];
        if([level intValue] < _numLvls) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Level %@ Completed!", num]
                                                            message:@"You completed the level."
                                                           delegate:Nil
                                                  cancelButtonTitle:@"Move On"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            [_questionsAndAnswers removeAllObjects];
            [defaults setObject:level forKey:@"level"];
            [defaults setObject:curQ forKey:@"curQuestion"];
            [defaults synchronize];

            [self viewDidLoad];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Quiz Completed!"
                                                            message:@"You completed the entire quiz."
                                                           delegate:Nil
                                                  cancelButtonTitle:@"Start Over"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            _curQuestionIndex = 0;
            [_questionsAndAnswers removeAllObjects];
            [defaults setObject:[NSNumber numberWithInt:1] forKey:@"level"];
            [defaults synchronize];
            [self viewDidLoad];
        }
    }
}


@end
