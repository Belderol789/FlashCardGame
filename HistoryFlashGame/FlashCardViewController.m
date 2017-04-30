//
//  FlashCardViewController.m
//  HistoryFlashGame
//
//  Created by Kemuel Clyde Belderol on 17/03/2017.
//  Copyright © 2017 Burst. All rights reserved.
//

#import "FlashCardViewController.h"

@interface FlashCardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *totalQuestionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionsRemainingLabel;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UITextView *answerTextView;
@property (weak, nonatomic) IBOutlet UIButton *submitAnswerButton;
@property (nonatomic, assign) NSInteger index;
@property (strong, nonatomic) NSMutableArray *questionList;
@property (strong, nonatomic) NSMutableArray *answerList;
@property (strong, nonatomic) NSMutableArray *hints;




@end

@implementation FlashCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionList = [[NSMutableArray alloc] initWithObjects:@"What year did Malaysia gain sovereignty from the British?", @"Which western power was the first to colonize Malacca?", @"Which island did the British first establish in Malaysia?", @"Who is the first Prime Minister of Malaysia?", @"Which country seprated from Malaysia on 9 August 1965?", nil];
    self.answerList = [[NSMutableArray alloc] initWithObjects:@"1957", @"Portuguese", @"Penang", @"Tunku Abdul Rahman", @"Singapore", nil];
    self.hints = [[NSMutableArray alloc] initWithObjects:@"Hint 1", @"Hint 2", @"Hint 3", @"Hint 4", @"Hint 5", nil];
    self.index = arc4random_uniform((unsigned long)[self.questionList count]);
    self.questionTextView.text = [self.questionList objectAtIndex:self.index];
    self.questionsRemainingLabel.text = [NSString stringWithFormat:@"Questions Remaining %lu", [self.questionList count]];
    self.totalQuestionsLabel.text = @"Total Answers: 5";
    self.answerTextView.text = @"Answer here...";
    
    
}


- (void)questionListChecker {
    if([self.questionList count] == 0) {
        UIAlertController *gameFinished = [UIAlertController alertControllerWithTitle:@"Congratulations!" message:@"You are a true history advocate." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *endGame = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL];
        [gameFinished addAction:endGame];
        [self presentViewController:gameFinished animated:YES completion:NULL];
    } else {
        self.index = arc4random_uniform([self.questionList count]);
        self.questionTextView.text = [self.questionList objectAtIndex:self.index];
        
    }
}

- (IBAction)userSubmitsAnswer:(id)sender {
    NSString *userAnswer = self.answerTextView.text; //user answers random question
   
    //user answers random question correctly
    
    if([userAnswer isEqualToString:self.answerList[self.index]]) {
        
        self.questionsRemainingLabel.text = [NSString stringWithFormat:@"Questions Remaining %lu", [self.questionList count] - 1]; //count is still 5
        [self.questionList removeObjectAtIndex:self.index]; //question is removed from array
        [self.answerList removeObjectAtIndex:self.index]; //answer is removed from array
        [self questionListChecker];
        
    } else {
        //create alert action
        NSString *message = [NSString stringWithFormat:@"%@", [self.hints objectAtIndex:self.index]];
        UIAlertController *wrongAnswer = [UIAlertController alertControllerWithTitle:@"Sorry, that is incorrect." message:message preferredStyle:UIAlertControllerStyleAlert];
        //create action in alert
        UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Continue playing" style:UIAlertActionStyleDestructive handler:NULL];
        //add action
        [wrongAnswer addAction:dismissAction];
        //present action and alert
        [self presentViewController:wrongAnswer animated:YES completion:NULL];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
