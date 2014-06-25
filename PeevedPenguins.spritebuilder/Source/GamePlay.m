//
//  GamePlay.m
//  PeevedPenguins
//
//  Created by Dat Do on 6/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay
{
    CCPhysicsNode *_physicsNode;
    CCNode *_catapultArm;
}
// called when CCB file completed loading
- (void)didLoadFromCCB
{
    //Start accept touches
    self.userInteractionEnabled = TRUE;
}
// called on every touch in scene
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self lauchPenguin];
}

- (void)lauchPenguin
{
    //loads Penguin.ccb in spritebuilder
    CCNode* penguin = [CCBReader load:@"Penguin"];
    //position penguin at catapult
    penguin.position =ccpAdd(_catapultArm.position, ccp(0,0));
    //add the penguin to the physicNode of this scene (its physics enabled)
    [_physicsNode addChild:penguin];
    // manually create & apply force to launch penguin
    CGPoint launchDirection = ccp(1,0);
    CGPoint force = ccpMult(launchDirection, 8000);
    [penguin.physicsBody applyForce:force];
}
@end
