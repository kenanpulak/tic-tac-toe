//
//  PBGameBoard.h
//  PBTicTacToe
//
//  Created by Kenan Pulak on 6/14/14.
//  Copyright (c) 2014 Kenan Pulak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBPlayerModel.h"

@interface PBGameBoardModel : NSObject

+ (PBGameBoardModel *)sharedSingleton;

-(void)clearBoard;
-(void)setMoveMadeAtRow:(int)row andColumn:(int)column withPlayer:(enum PBPlayerType)playerType;
-(NSArray*)computerBestMove;
-(NSArray*)userMoveWithIndex:(int)index;
-(NSNumber*)gameWon;
-(int)getIndexWithArray:(NSArray*)array;
-(BOOL)gameOver;
-(BOOL)checkDraw;

@end
