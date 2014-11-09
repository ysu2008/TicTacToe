//
//  TTTGameManager.h
//  TicTacToe
//
//  Created by Yang Su on 11/8/14.
//  Copyright (c) 2014 Yang Su. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    PLAYER_X,
    PLAYER_O,
    PLAYER_NONE
} Player;

@interface TTTGameManager : NSObject

@property (nonatomic, readonly, assign) Player currentPlayer;
@property (nonatomic, readonly, assign) int size;

+ (TTTGameManager *)sharedManager;

- (id)initWithBoardSize:(int)size;
- (void)didSelectLocationX:(int)x Y:(int)y;
- (Player)playerAtLocationX:(int)x Y:(int)y;
- (void)startNewGame;
- (Player)checkForWin;
- (BOOL)isGameOver;

@end
