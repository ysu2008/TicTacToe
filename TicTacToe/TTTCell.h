//
//  TTTCell.h
//  TicTacToe
//
//  Created by Yang Su on 11/8/14.
//  Copyright (c) 2014 Yang Su. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define TTT_CELL_SIZE 100
#define TTT_CELL_PADDING 20
#define TTT_CELL_COLOR_DEFAULT [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]
#define TTT_CELL_COLOR_X [UIColor colorWithRed:0.8 green:0.4 blue:0.4 alpha:1.0]
#define TTT_CELL_COLOR_O [UIColor colorWithRed:0.4 green:0.8 blue:0.4 alpha:1.0]
#define TTT_CELL_LABEL_FONT_SIZE 80

@protocol TTTCellDelegate

- (void)didTapCellAtRow:(int)row column:(int)column;

@end

@interface TTTCell : SKSpriteNode

@property (nonatomic, readonly, assign) int row;
@property (nonatomic, readonly, assign) int column;

- (id)initWithRow:(int)row column:(int)column delegate:(id<TTTCellDelegate>)delegate;

- (void)refresh;

@end
