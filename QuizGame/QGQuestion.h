//
//  QGQuestion.h
//  QuizGame
//
//  Created by SatoDaisuke on 5/20/15.
//  Copyright (c) 2015 SatoDaisuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QGQuestion : NSObject
@property(nonatomic,copy)NSString *sentence;
@property(nonatomic,copy)NSArray *answers;
@property(nonatomic,assign)NSInteger indexOfAnswer;
@property(nonatomic,copy)NSString *explanation;

-(id)initWithSentence:(NSString*)sentense answers:(NSArray*)answers answer:(NSInteger)indexOfAnswer explanation:(NSString*)explanation;


@end
