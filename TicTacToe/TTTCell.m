//
//  TTTCell.m
//  TicTacToe
//
//  Created by Yang Su on 11/8/14.
//  Copyright (c) 2014 Yang Su. All rights reserved.
//

#import "TTTCell.h"

#import "TTTGameManager.h"

@interface TTTCell()

@property (nonatomic, readwrite, assign) int row;
@property (nonatomic, readwrite, assign) int column;
@property (nonatomic, readwrite, strong) id<TTTCellDelegate> delegate;
@property (nonatomic, readwrite, strong) SKLabelNode *label;

@end

@implementation TTTCell

- (id)initWithRow:(int)row column:(int)column delegate:(id<TTTCellDelegate>)delegate {
    if (self = [super initWithColor:TTT_CELL_COLOR_DEFAULT size:CGSizeMake(TTT_CELL_SIZE, TTT_CELL_SIZE)]){
        _delegate = delegate;
        _row = row;
        _column = column;
        self.userInteractionEnabled = YES;
        _label = [SKLabelNode labelNodeWithText:@"O"];
        _label.fontSize = TTT_CELL_LABEL_FONT_SIZE;
        _label.hidden = YES;
        _label.position = CGPointMake(self.position.x, self.position.y - _label.frame.size.height/2.0);
        [self addChild:_label];
        
    }
    return self;
}

- (void)refresh {
    TTTGameManager *manager = [TTTGameManager sharedManager];
    Player player = [manager playerAtLocationX:self.row Y:self.column];
    
    if (player != PLAYER_NONE){
        self.label.hidden = NO;
        if (player == PLAYER_O){
            self.label.text = @"O";
            self.color = TTT_CELL_COLOR_O;
        }
        else {
            self.label.text = @"X";
            self.color = TTT_CELL_COLOR_X;
        }
    }
    else {
        self.color = TTT_CELL_COLOR_DEFAULT;
        self.label.hidden = YES;
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate didTapCellAtRow:self.row column:self.column];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

@end
