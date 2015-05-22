//
//  QGExplanationViewController.m
//  QuizGame
//
//  Created by SatoDaisuke on 5/20/15.
//  Copyright (c) 2015 SatoDaisuke. All rights reserved.
//

#import "QGExplanationViewController.h"
#import "QGQuestion.h"
#import "QGQuestionManager.h"

@interface QGExplanationViewController ()

@end

@implementation QGExplanationViewController
{
    UITabBarController *tabBarController;
    
    __weak IBOutlet UITextView *sentenceTextView;
    __weak IBOutlet UITextView *explanationTextView;
    IBOutletCollection(UILabel) NSArray *answerLabels;
}

+(QGExplanationViewController*)explanationViewController{
    
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

-(void)awakeFromNib{
    
    self.tabBarItem = [[UITabBarItem alloc]initWithTitle:[NSString stringWithFormat:@"問題%ld",(long)self.indexOfQuestions+1] image:nil tag:self.indexOfQuestions];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupQuestion];
}
- (IBAction)didTouchUpInsideBtn:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupQuestion{
    
    QGQuestion *question = [QGQuestionManager sharedInstance].questions[self.indexOfQuestions];
    
    sentenceTextView.text = question.sentence;
    explanationTextView.text = question.explanation;
    
    for(NSInteger i = 0;i<answerLabels.count;i++){
        UILabel *label =answerLabels[i];
        label.text = question.answers[i];
    }
}

@end
