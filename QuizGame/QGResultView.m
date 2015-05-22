//
//  QGResultView.m
//  QuizGame
//
//  Created by SatoDaisuke on 5/20/15.
//  Copyright (c) 2015 SatoDaisuke. All rights reserved.
//

#import "QGResultView.h"


@implementation QGResultView

+(QGResultView*)resultView{
    
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    
    QGResultView *resultView = (QGResultView*)vc.view;
    resultView.frame = CGRectMake(10, ([UIScreen mainScreen].bounds.size.height - 400)/2, [UIScreen mainScreen].bounds.size.width - 20, 400);
    
    return (QGResultView*)vc.view;
}

- (IBAction)touchUpInsideBtn:(UIButton *)sender {
    
    if([self.delegate respondsToSelector:@selector(didTouchUpInsideBtnWithType:)])
        [self.delegate didTouchUpInsideBtnWithType:sender.tag];
    
}
@end