//
//  QGQuizViewController.m
//  QuizGame
//
//  Created by SatoDaisuke on 5/20/15.
//  Copyright (c) 2015 SatoDaisuke. All rights reserved.
//

#import "QGQuizViewController.h"
#import "QGQuestion.h"
#import "QGQuestionManager.h"
#import "QGResultView.h"
#import "QGExplanationViewController.h"

@interface QGQuizViewController ()<QGResultViewDelegate>

@end

@implementation QGQuizViewController
{
    
    IBOutletCollection(UIButton) NSArray *answerButtons;
    __weak IBOutlet UITextView *sentenceTextView;
    
    NSInteger questionCount;
    NSInteger correctAnswerCount;
    
    QGResultView *resultView;
}

#pragma mark - Life Cycle Methods.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    questionCount = 0;
    correctAnswerCount = 0;
    
    //シングルトン生成
    [QGQuestionManager sharedInstance];
    
    //ランダムに
    [[QGQuestionManager sharedInstance] randomQuestions];
    [[QGQuestionManager sharedInstance] randomAnswers];

    
    [self setQuestionWithIndex:questionCount];
}

#pragma mark - Private Methods.
-(void)setQuestionWithIndex:(NSInteger)index{
    
    QGQuestion *q = [QGQuestionManager sharedInstance].questions[index];
    
    for(NSInteger i = 0;i<answerButtons.count;i++){
        UIButton *btn = answerButtons[i];
        [btn setEnabled:YES];
        [btn setTitle:q.answers[i] forState:UIControlStateNormal];
    }
    
    sentenceTextView.text = q.sentence;
}

-(void)showResultWithFlag:(BOOL)flag{
    
    UIImageView *_resultView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_resultView];
    
    if(flag){
        [_resultView setImage:[UIImage imageNamed:@"seikai"]];
        correctAnswerCount++;
    }else{
        [_resultView setImage:[UIImage imageNamed:@"hazure"]];
    }
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(doNext:) userInfo:_resultView repeats:NO];
}

-(void)doNext:(NSTimer*)timer{
    
    
    UIImageView *imgView = (UIImageView*)[timer userInfo];
    [imgView removeFromSuperview];
    imgView = nil;
    
    questionCount++;
    
    if(questionCount < 5){
        //次の問題へ
        [self setQuestionWithIndex:questionCount];
    }else{
        [self finishQuiz];
    }
    
    
    if(timer) [timer invalidate];
}

-(void)finishQuiz{
    
    UIView *blackFilterView = [[UIView alloc]initWithFrame:self.view.frame];
    [blackFilterView setBackgroundColor:[UIColor blackColor]];
    blackFilterView.alpha = 0.5;
    [self.view addSubview:blackFilterView];
    
    
    //結果画面の表示
    resultView = [QGResultView resultView];
    resultView.delegate = self;
    resultView.numberOfQuestionsLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[QGQuestionManager sharedInstance].questions.count];
    resultView.numberOfCorrectAnswerLabel.text = [NSString stringWithFormat:@"%lu",correctAnswerCount];
    resultView.rateOfCorrectLabel.text = [NSString stringWithFormat:@"%d%%",(int)(((float)correctAnswerCount / (float)[QGQuestionManager sharedInstance].questions.count) * 100)];
    
    resultView.frame = CGRectMake(10, self.view.frame.size.height, self.view.frame.size.width-20, 360);
    [self.view addSubview:resultView];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        resultView.frame = CGRectMake(10, (self.view.frame.size.height - 360)/2, self.view.frame.size.width- 20, 360);
        
    }];
    
}

-(void)goToExplanation{
    
    //タブバーに格納するViewControllerの配列
    NSMutableArray *viewControllers = @[].mutableCopy;
    
    for(NSInteger i = 0;i<[QGQuestionManager sharedInstance].questions.count;i++){
        
        QGExplanationViewController *explanationViewController = [QGExplanationViewController explanationViewController];
        explanationViewController.indexOfQuestions  = i;
        
        [viewControllers addObject:explanationViewController];
    }
    
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    [tabBarController setViewControllers:viewControllers];
    [self.navigationController pushViewController:tabBarController animated:YES];
}

#pragma mark - Button Action Methods.
- (IBAction)didTouchUpInsideBtn:(UIButton *)sender {
    
    if(sender.tag == 10){
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        for(UIButton *btn in answerButtons) //全ボタンのタップを不可に
            [btn setEnabled:NO];
        
        
        QGQuestion *q = [QGQuestionManager sharedInstance].questions[questionCount];
        
        [self showResultWithFlag:[[QGQuestionManager sharedInstance] checkAnswerQuestion:q answerIndex:sender.tag]];
        
    }
}


#pragma mark - <QGResultViewDelegate>
-(void)didTouchUpInsideBtnWithType:(kQGResultViewButtonType)type{
    
    switch (type) {
        case kQGResultViewButtonTypeBackToTop:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case kQGResultViewButtonTypeGoToExplanation:
            [self goToExplanation];
            break;
            
        default:
            break;
    }
    
}
@end
