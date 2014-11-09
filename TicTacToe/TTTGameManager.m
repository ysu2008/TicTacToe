//
//  TTTGameManager.m
//  TicTacToe
//
//  Created by Yang Su on 11/8/14.
//  Copyright (c) 2014 Yang Su. All rights reserved.
//

#import "TTTGameManager.h"

#import "Config.h"

@interface TTTGameManager()

@property (nonatomic, readwrite, assign) Player currentPlayer;
@property (nonatomic, readwrite, assign) int size;
@property (nonatomic, readwrite, strong) NSMutableArray *board;

@end

static TTTGameManager *gameManager;

@implementation TTTGameManager

+ (TTTGameManager *)sharedManager {
    if (!gameManager){
        gameManager = [[TTTGameManager alloc] initWithBoardSize:BOARD_SIZE];
    }
    return gameManager;
}

- (id)initWithBoardSize:(int)size {
    if (self = [super init]){
        _size = size;
        _board = [NSMutableArray arrayWithCapacity:self.size];
        for (int i = 0; i < self.size; i++){
            NSMutableArray *row = [NSMutableArray arrayWithCapacity:self.size];
            for (int j = 0; j < self.size; j++){
                [row addObject:[NSNumber numberWithInt:PLAYER_NONE]];
            }
            [_board addObject:row];
        }
    }
    return self;
}

- (void)startNewGame {
    self.currentPlayer = PLAYER_O;
    for (int i = 0; i < self.size; i++){
        for (int j = 0; j < self.size; j++){
            self.board[i][j] = [NSNumber numberWithInt:PLAYER_NONE];
        }
    }
}

- (int)gameGridSize {
    return self.size;
}

- (void)didSelectLocationX:(int)x Y:(int)y {
    if ([self.board[x][y] intValue] == PLAYER_NONE){
        self.board[x][y] = [NSNumber numberWithInt:self.currentPlayer];
        self.currentPlayer = (self.currentPlayer == PLAYER_O) ? PLAYER_X : PLAYER_O;
    }
}

- (Player)playerAtLocationX:(int)x Y:(int)y {
    return [(self.board[x][y]) intValue];
}

- (Player)findHorizontalWin {
    for (int i = 0; i < self.size; i++){
        Player firstValue = [self.board[i][0] intValue];
        BOOL win = YES;
        for (int j = 1; j < self.size; j++){
            Player currentValue = [self.board[i][j] intValue];
            if (firstValue != currentValue){
                win = NO;
                break;
            }
        }
        if (win && firstValue != PLAYER_NONE){
            return firstValue;
        }
    }
    return PLAYER_NONE;
}

- (Player)findVerticalWin {
    for (int i = 0; i < self.size; i++){
        Player firstValue = [self.board[0][i] intValue];
        BOOL win = YES;
        for (int j = 1; j < self.size; j++){
            Player currentValue = [self.board[j][i] intValue];
            if (firstValue != currentValue){
                win = NO;
                break;
            }
        }
        if (win && firstValue != PLAYER_NONE){
            return firstValue;
        }
    }
    return PLAYER_NONE;
}

- (Player)findDiagonalWin {
    
    //diagonal 1
    Player firstValue = [self.board[0][0] intValue];
    BOOL win = YES;
    for (int i = 0; i < self.size; i++){
        Player currentValue = [self.board[i][i] intValue];
        if (firstValue != currentValue){
            win = NO;
            break;
        }
    }
    if (win && firstValue != PLAYER_NONE){
        return firstValue;
    }
    
    //diagonal 2
    firstValue = [self.board[0][self.size - 1] intValue];
    win = YES;
    for (int i = 0; i < self.size; i++){
        Player currentValue = [self.board[i][self.size - i - 1] intValue];
        if (firstValue != currentValue){
            win = NO;
            break;
        }
    }
    if (win && firstValue != PLAYER_NONE){
        return firstValue;
    }
    return PLAYER_NONE;
}

- (Player)checkForWin {
    //horizontal
    Player player = [self findHorizontalWin];
    if (player != PLAYER_NONE){
        return player;
    }
    
    //vertical
    player = [self findVerticalWin];
    if (player != PLAYER_NONE){
        return player;
    }
    
    //diagonal
    player = [self findDiagonalWin];
    if (player != PLAYER_NONE){
        return player;
    }
    return PLAYER_NONE;
}

- (BOOL)isGameOver {
    for (int i = 0; i < self.size; i++){
        for (int j = 0; j < self.size; j++){
            if ([self.board[i][j] intValue] == PLAYER_NONE){
                return NO;
            }
        }
    }
    return YES;
}

@end
