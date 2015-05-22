//
//  QGExplanationViewController.h
//  QuizGame
//
//  Created by SatoDaisuke on 5/20/15.
//  Copyright (c) 2015 SatoDaisuke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QGQuestion;

@interface QGExplanationViewController : UIViewController
@property(nonatomic,assign)NSInteger indexOfQuestions;

+(QGExplanationViewController*)explanationViewController;
@end
