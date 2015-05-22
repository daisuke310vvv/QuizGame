//
//  QGQuiz.m
//  QuizGame
//
//  Created by SatoDaisuke on 5/20/15.
//  Copyright (c) 2015 SatoDaisuke. All rights reserved.
//

#import "QGQuestion.h"

@implementation QGQuestion

-(id)initWithSentence:(NSString*)sentense answers:(NSArray*)answers answer:(NSInteger)indexOfAnswer explanation:(NSString*)explanation{
    
    self = [super init];
    if(self){
        self.sentence = sentense;
        self.answers = answers;
        self.indexOfAnswer = indexOfAnswer;
        self.explanation = explanation;
    }
    
    return self;
}
@end
