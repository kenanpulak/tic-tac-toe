//
//  PBGameBoard.m
//  PBTicTacToe
//
//  Created by Kenan Pulak on 6/14/14.
//  Copyright (c) 2014 Kenan Pulak. All rights reserved.
//

#import "PBGameBoardModel.h"

@interface PBGameBoardModel()

@property (nonatomic,strong) NSMutableArray *board;

@end

@implementation PBGameBoardModel{
}

static int MinVal = -10000000;
static int MaxVal = 10000000;

static PBGameBoardModel *sPBGameBoard;

+ (void)initialize {
    NSAssert(self == [PBGameBoardModel class], @"Singleton is not designed to be subclassed.");
    
    sPBGameBoard = [PBGameBoardModel new];
    sPBGameBoard.board = [[NSMutableArray alloc] initWithCapacity: 3];
    
    [sPBGameBoard.board insertObject:[NSMutableArray arrayWithObjects:@0,@0,@0,nil] atIndex:0];
    [sPBGameBoard.board insertObject:[NSMutableArray arrayWithObjects:@0,@0,@0,nil] atIndex:1];
    [sPBGameBoard.board insertObject:[NSMutableArray arrayWithObjects:@0,@0,@0,nil] atIndex:2];
}

+ (PBGameBoardModel *)sharedSingleton {
    return sPBGameBoard;
}

-(void)clearBoard{
    //[[PBGameBoard sharedSingleton].board = [[NSMutableArray alloc] initWithCapacity: 3];
    [[PBGameBoardModel sharedSingleton]setBoard:[[NSMutableArray alloc]initWithCapacity:3]];
     
     [[PBGameBoardModel sharedSingleton].board insertObject:[NSMutableArray arrayWithObjects:@0,@0,@0,nil] atIndex:0];
     [[PBGameBoardModel sharedSingleton].board insertObject:[NSMutableArray arrayWithObjects:@0,@0,@0,nil] atIndex:1];
     [[PBGameBoardModel sharedSingleton].board insertObject:[NSMutableArray arrayWithObjects:@0,@0,@0,nil] atIndex:2];
}

-(BOOL)gameOverWithBoard:(NSMutableArray*)board{
    if (![[self checkWinnerWithBoard:board]isEqualToNumber:@0] || [self checkFullBoardWithBoard:board]) {
        return YES;
    }
    return NO;
}

-(BOOL)checkFullBoardWithBoard:(NSMutableArray*)board{
    for (int n = 0; n < 3; n++) {
        for (int m = 0; m < 3; m++) {
            if ([board[n][m] isEqualToNumber:@0]) {
                return NO;
            }
        }
    }
    return YES;
}

-(NSNumber*)checkWinnerWithBoard:(NSMutableArray*)board{

    //diagonal win '\'
    if (![board[0][0] isEqualToNumber:@0] && [board[0][0] isEqualToNumber:board[1][1]] && [board[0][0] isEqualToNumber:board[2][2]]) {
        return board[0][0];
    }
    //diagonal win '/'
    if (![board[0][2] isEqualToNumber:@0] && [board[0][2] isEqualToNumber:board[1][1]] && [board[0][2] isEqualToNumber:board[2][0]]) {
        return board[0][2];
    }
    
    for (int n = 0; n<3; n++) {
        // vertical line win
        if (![board[n][0] isEqualToNumber:@0] && [board[n][0] isEqualToNumber:board[n][1]] && [board[n][0] isEqualToNumber:board[n][2]]) {
            return board[n][0];
        }
        //horizontal line win
        if (![board[0][n] isEqualToNumber:@0] && [board[0][n] isEqualToNumber:board[1][n]] && [board[0][n] isEqualToNumber:board[2][n]]) {
            return board[0][n];
        }
    }
    
    return @0;
    
}

-(BOOL)fullBoard{
    return [self checkFullBoardWithBoard:[PBGameBoardModel sharedSingleton].board];
}

-(NSNumber*)gameWon{
    return [self checkWinnerWithBoard:[PBGameBoardModel sharedSingleton].board];
}

-(BOOL)checkDraw{
    if ([self checkFullBoardWithBoard:[PBGameBoardModel sharedSingleton].board]) {
        if ([[self checkWinnerWithBoard:[PBGameBoardModel sharedSingleton].board] isEqualToNumber:@0]) {
            return YES;
        }
        else{
            return NO;
        }
    }
    return NO;
}

-(BOOL)gameOver{
    return [self gameOverWithBoard:[PBGameBoardModel sharedSingleton].board];
}

-(int)minWithBoard:(NSMutableArray*)board{
    
    if ([self gameOverWithBoard:board]) {
        if (![[self checkWinnerWithBoard:board] isEqualToNumber:@0] ) {
            return 1;
        }
        else{
            return 0;
        }
    }
    int value = MaxVal;
    int result;
    
    for (int n = 0; n<3; n++) {
        for (int m = 0; m<3; m++) {
            if ([board[n][m] isEqualToNumber:@0]) {
                board[n][m] = @1;
                result = [self maxWithBoard:board];
                
                if (result < value) {
                    value = result;
                }
                board[n][m] = @0;
            }
        }
    }
    return value;
}

-(int)maxWithBoard:(NSMutableArray*)board{
    if ([self gameOverWithBoard:board]) {
        if (![[self checkWinnerWithBoard:board] isEqualToNumber:@0] ) {
            return -1;
        }
        else{
            return 0;
        }
    }
    int value = MinVal;
    int result;
    
    for (int n = 0; n<3; n++) {
        for (int m = 0; m<3; m++) {
            if ([board[n][m] isEqualToNumber:@0]) {
                board[n][m] = @2;
                result = [self minWithBoard:board];
                
                if (result > value) {
                    value = result;
                }
                board[n][m] = @0;
            }
        }
    }
    return value;
}

-(NSArray*)computerBestMove{
    
    // deep copy the current game board into 2 dimensional array
    NSMutableArray *board = [[NSMutableArray alloc]initWithCapacity:3];
    NSMutableArray *boardRow1 = [[NSMutableArray alloc]initWithArray:[[PBGameBoardModel sharedSingleton].board objectAtIndex:0] copyItems:YES];
    NSMutableArray *boardRow2 = [[NSMutableArray alloc]initWithArray:[[PBGameBoardModel sharedSingleton].board objectAtIndex:1] copyItems:YES];
    NSMutableArray *boardRow3 = [[NSMutableArray alloc]initWithArray:[[PBGameBoardModel sharedSingleton].board objectAtIndex:2] copyItems:YES];
    
    [board insertObject:boardRow1 atIndex:0];
    [board insertObject:boardRow2 atIndex:1];
    [board insertObject:boardRow3 atIndex:2];

    if (![self gameOverWithBoard:board]) {
        int row = 0, column = 0;
        int value = MinVal;
        int result;
        
        for (int n = 0; n < 3; n++) {
            for (int m = 0; m < 3; m++) {
                if ([board[n][m] isEqualToNumber:@0]) {
                    board[n][m] = @2;
                    
                    result = [self minWithBoard:board];
                    if (result > value) {
                        value = result;
                        row = n;
                        column = m;
                    }
                    board[n][m] = @0;
                }
            }
        }
        return @[[NSNumber numberWithInt:row],[NSNumber numberWithInt:column]];
    }
    
    return nil;
}

-(int)getIndexWithArray:(NSArray*)array{
    
    if ([[array objectAtIndex:0] isEqualToNumber:@0]) {
        if ([[array objectAtIndex:1] isEqualToNumber:@0]) {
            return 0;
        }
        if ([[array objectAtIndex:1] isEqualToNumber:@1]) {
            return 1;
        }
        if ([[array objectAtIndex:1] isEqualToNumber:@2]) {
            return 2;
        }
    }
    else if ([[array objectAtIndex:0] isEqualToNumber:@1]) {
        if ([[array objectAtIndex:1] isEqualToNumber:@0]) {
            return 3;
        }
        if ([[array objectAtIndex:1] isEqualToNumber:@1]) {
            return 4;
        }
        if ([[array objectAtIndex:1] isEqualToNumber:@2]) {
            return 5;
        }
    }
    else if ([[array objectAtIndex:0] isEqualToNumber:@2]) {
       
        if ([[array objectAtIndex:1] isEqualToNumber:@0]) {
            return 6;
        }
        if ([[array objectAtIndex:1] isEqualToNumber:@1]) {
            return 7;
        }
        if ([[array objectAtIndex:1] isEqualToNumber:@2]) {
            return 8;
        }
    }
    else{
        return -1;
    }
    return -1;
}

-(void)setMoveMadeAtRow:(int)row andColumn:(int)column withPlayer:(enum PBPlayerType)playerType{
    
    if (playerType == PBPlayerTypeComputer) {
        [PBGameBoardModel sharedSingleton].board[row][column] = @2;
    }
    if (playerType == PBPlayerTypeUser) {
        [PBGameBoardModel sharedSingleton].board[row][column] = @1;
    }
}

-(NSArray*)userMoveWithIndex:(int)index{
    
    if (index == 0) {
        return @[@0,@0];
    }
    else if (index == 1) {
        return @[@0,@1];
    }
    else if (index == 2) {
        return @[@0,@2];
    }
    else if (index == 3) {
        return @[@1,@0];
    }
    else if (index == 4) {
        return @[@1,@1];
    }
    else if (index == 5) {
        return @[@1,@2];
    }
    else if (index == 6) {
        return @[@2,@0];
    }
    else if (index == 7) {
        return @[@2,@1];
    }
    else if (index == 8) {
        return @[@2,@2];
    }
    else{
        return nil;
    }
}

@end
