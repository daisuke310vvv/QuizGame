//
//  QGQuestionManager.m
//  QuizGame
//
//  Created by SatoDaisuke on 5/20/15.
//  Copyright (c) 2015 SatoDaisuke. All rights reserved.
//

#import "QGQuestionManager.h"
#import "QGQuestion.h"

@interface QGQuestionManager()
@property(nonatomic,readwrite)NSMutableArray *questions;
@end

static QGQuestionManager *sharedInstance = nil;

@implementation QGQuestionManager

+(QGQuestionManager*)sharedInstance{
    
    if(!sharedInstance)
        sharedInstance = [QGQuestionManager new];
    
    return sharedInstance;
}

-(id)init{
    
    self = [super init];
    if(self){
        //do something...
        
        [self initQuestions];
        
    }
    
    return self;
}

-(void)initQuestions{
    
    //JSONから問題文読み込み
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"Question" ofType:@"json"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:jsonFilePath]) // ファイルの存在チェック
    {
        return;
    }
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    
    NSError *error;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                               options:NSJSONReadingAllowFragments
                                                                 error:&error];
    
    
    if(!self.questions) self.questions = @[].mutableCopy;
    
    NSArray *parsedQuestions = jsonObject[@"questions"];
    for(NSDictionary *d in parsedQuestions){
        
        QGQuestion *q = [[QGQuestion alloc]initWithSentence:d[@"sentence"] answers:d[@"answer"] answer:[d[@"indexOfNumber"] intValue] explanation:d[@"explanation"]];
        
        [self.questions addObject:q];
    }
}

-(void)randomAnswers{
    
    
    for(QGQuestion *q in self.questions){
        
        NSMutableArray *randomizeArr = q.answers.mutableCopy;
        
        for(NSInteger i = randomizeArr.count-1;i>0;i--){
            NSInteger rand = arc4random() % 1;
            [randomizeArr exchangeObjectAtIndex:i withObjectAtIndex:rand];
            
            if(i == q.indexOfAnswer)
                q.indexOfAnswer = rand;
            else if(rand == q.indexOfAnswer)
                q.indexOfAnswer = i;
            
        }
        
        q.answers = randomizeArr;
    }
    
}

-(void)randomQuestions{
    //ランダムに
    
    for(NSInteger i = self.questions.count - 1;i>0;i--){
        NSInteger rand = arc4random() % i;
        [self.questions exchangeObjectAtIndex:i withObjectAtIndex:rand];
    }
    
}

-(BOOL)checkAnswerQuestion:(QGQuestion*)question answerIndex:(NSInteger)index{
    
    return question.indexOfAnswer == index? YES:NO;
    
}
@end
