//
//  QGQuetionManager.h
//  QuizGame
//
//  Created by SatoDaisuke on 5/20/15.
//  Copyright (c) 2015 SatoDaisuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QGQuestion;

@interface QGQuestionManager : NSObject
@property(nonatomic,readonly)NSMutableArray *questions;

/**
 * シングルトン
 */
+(QGQuestionManager*)sharedInstance;

/*
 * 問題のロード
 */
-(void)initQuestions;

/**
 * 選択肢のランダム
 */
-(void)randomAnswers;

/**
 * 問題をランダムに
 */
-(void)randomQuestions;

/**
 * 答えを確認
 */
-(BOOL)checkAnswerQuestion:(QGQuestion*)question answerIndex:(NSInteger)index;


@end
