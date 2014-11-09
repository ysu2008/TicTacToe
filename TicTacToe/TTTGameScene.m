//
//  TTTGameScene.m
//  TicTacToe
//
//  Created by Yang Su on 11/8/14.
//  Copyright (c) 2014 Yang Su. All rights reserved.
//

#import "TTTGameScene.h"

#import "TTTCell.h"
#import "TTTGameManager.h"

@interface TTTGameScene()

@property (nonatomic, readwrite, strong) NSMutableArray *cells;

@end

@implementation TTTGameScene

- (void)createTTTScene {
    _cells = [NSMutableArray array];
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.frame),
                                 CGRectGetMidY(self.frame));
    
    TTTGameManager *manager = [TTTGameManager sharedManager];
    
    //add all minesweeper cells
    for (int i = 0; i < manager.size; i++){
        NSMutableArray *row = [NSMutableArray array];
        for (int j = 0; j < manager.size; j++){
            
            TTTCell *cell = [[TTTCell alloc] initWithRow:i column:j delegate:self];
            cell.anchorPoint = CGPointMake(0.5, 0.5);
            cell.position = CGPointMake(center.x + (i - (float)(manager.size - 1)/2.0) * (TTT_CELL_SIZE + TTT_CELL_PADDING),
                                        center.y + (j - (float)(manager.size - 1)/2.0) * (TTT_CELL_SIZE + TTT_CELL_PADDING));
            [self addChild:cell];
            [row addObject:cell];
        }
        [_cells addObject:row];
    }
}

- (void)refresh {
    TTTGameManager *manager = [TTTGameManager sharedManager];
    for (int i = 0; i < manager.size; i++){
        for (int j = 0; j < manager.size; j++){
            TTTCell *cell = self.cells[i][j];
            [cell refresh];
        }
    }
}

- (void)didMoveToView:(SKView *)view {
    self.backgroundColor = [UIColor blackColor];
    [self createTTTScene];
}

- (void)startNewGame {
    TTTGameManager *manager = [TTTGameManager sharedManager];
    [manager startNewGame];
    [self refresh];
}

#pragma mark - MineSweeperCellDelegate methods

- (void)didTapCellAtRow:(int)row column:(int)column {
    TTTGameManager *manager = [TTTGameManager sharedManager];
    [manager didSelectLocationX:row Y:column];
    [(TTTCell *)(self.cells[row][column]) refresh];
    Player player = [manager checkForWin];
    if (player != PLAYER_NONE){
        NSString *playerName = player == PLAYER_O ? @"O" : @"X";
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Play Again"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           [self startNewGame];
                                                       }];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Game Over"
                                                                            message:[NSString stringWithFormat:@"%@ Won!", playerName]
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:action];
        [self.viewController presentViewController:controller animated:YES completion:nil];
    }
    else if ([manager isGameOver]){
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Play Again"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           [self startNewGame];
                                                       }];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Game Over"
                                                                            message:@"Draw!"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:action];
        [self.viewController presentViewController:controller animated:YES completion:nil];
        
    }
}

@end
