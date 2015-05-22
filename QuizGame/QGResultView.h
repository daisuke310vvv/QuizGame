//
//  QGResultView.h
//  QuizGame
//
//  Created by SatoDaisuke on 5/20/15.
//  Copyright (c) 2015 SatoDaisuke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, kQGResultViewButtonType)
{
    kQGResultViewButtonTypeBackToTop,
    kQGResultViewButtonTypeGoToExplanation
};

@protocol QGResultViewDelegate <NSObject>
-(void)didTouchUpInsideBtnWithType:(kQGResultViewButtonType)type;
@end

@interface QGResultView : UIView
@property(nonatomic,weak)id<QGResultViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *numberOfQuestionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfCorrectAnswerLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateOfCorrectLabel;


+(QGResultView*)resultView;
@end
