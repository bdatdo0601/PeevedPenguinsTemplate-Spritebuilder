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
    CCNode *_levelNode;
    CCPhysicsNode *_physicsNode;
    CCNode *_catapultArm;
    CCNode *_contentNode;
}
// called when CCB file completed loading
- (void)didLoadFromCCB
{
    //Start accept touches
    self.userInteractionEnabled = TRUE;
    CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    [_levelNode addChild:level];
    //visualize physics bodies & joints
    _physicsNode.debugDraw = True;
}
// called on every touch in scene
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self lauchPenguin];
}
- (void)retry
{[[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"GamePlay"]];
}
- (void)lauchPenguin
{
    //loads Penguin.ccb in spritebuilder
    CCNode* penguin = [CCBReader load:@"penguin"];
    //position penguin at catapult
    penguin.position =ccpAdd(_catapultArm.position, ccp(16,50));
    //add the penguin to the physicNode of this scene (its physics enabled)
    [_physicsNode addChild:penguin];
    // manually create & apply force to launch penguin
    CGPoint launchDirection = ccp(1,0);
    CGPoint force = ccpMult(launchDirection, 8000);
    [penguin.physicsBody applyForce:force];
    self.position = ccp(0,0);
    CCActionFollow *follow = [CCActionFollow actionWithTarget:penguin worldBoundary:self.boundingBox];
    [_contentNode runAction:follow];
}
@end
