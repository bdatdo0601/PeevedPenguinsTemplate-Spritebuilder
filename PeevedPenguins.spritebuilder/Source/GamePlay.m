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
    CCNode *_pullbackNode;
    CCNode *_mouseJointNode;
    CCPhysicsJoint *_mouseJoint;
}
// called when CCB file completed loading
- (void)didLoadFromCCB
{
    //Start accept touches
    self.userInteractionEnabled = TRUE;
    CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    [_levelNode addChild:level];
    //visualize physics bodies & joints
    _physicsNode.debugDraw = TRUE;
    //nothing shall collide
    _pullbackNode.physicsBody.collisionMask = @[];
    _mouseJointNode.physicsBody.collisionMask = @[];
}
// called on every touch in scene
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:_contentNode];
    // start catapult dragging when a touch inside the catapult arm occurs
    if (CGRectContainsPoint([_catapultArm boundingBox], touchLocation))
    {
        //move mouseJoint to touch position
        _mouseJointNode.position = touchLocation;
        //setup a spring joint between mouseJointNode and the catapult arm
            _mouseJoint = [CCPhysicsJoint connectedSpringJointWithBodyA:_mouseJointNode.physicsBody bodyB:_catapultArm.physicsBody anchorA:ccp(0, 0) anchorB:ccp(34, 138) restLength:0.f stiffness:3000.f damping:150.f];
    }
}
- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
        //whenever touches move, update the position of the mouseJointNode --> touch location
    CGPoint touchLocation =[touch locationInNode:_contentNode];
    _mouseJointNode.position = touchLocation;
}
- (void)releaseCatapult {
    if (_mouseJoint != nil)
    {
        // releases the joint and lets the catapult snap back
        [_mouseJoint invalidate];
        _mouseJoint = nil;
    }
}
- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //when the touches end, meaning the user releases finger, release catapult
    [self releaseCatapult];
}
- (void)touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    
//when touches are cancelled, meaning the user drags finger off screen or onto sth else, release catapult
    [self releaseCatapult];
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
