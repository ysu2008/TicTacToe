//
//  TTTGameScene.h
//  TicTacToe
//
//  Created by Yang Su on 11/8/14.
//  Copyright (c) 2014 Yang Su. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "TTTCell.h"
#import "TTTViewController.h"

@interface TTTGameScene : SKScene<TTTCellDelegate>

@property (nonatomic, readwrite, weak) TTTViewController *viewController;

@end
