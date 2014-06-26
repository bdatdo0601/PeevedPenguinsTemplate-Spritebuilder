//
//  waitingPenguin.m
//  PeevedPenguins
//
//  Created by Dat Do on 6/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "waitingPenguin.h"

@implementation waitingPenguin
- (void)didLoadFromCCB
{
    //generate a random number btw 0.0 and 2.0;
    float delay = (arc4random()% 2000) /1000.f;
    //call method to start after random delay
    [self performSelector:@selector(startBlinkAndJump) withObject:nil afterDelay:delay];
}
- (void)startBlinkAndJump
{
    //the animation manager of each node is stored in'animation manager'
    CCAnimationManager* animationManager = self.animationManager;
    //timelines can be referenced and run by name
    [animationManager runAnimationsForSequenceNamed:@"BlinkAndJump"];
}
@end
