//
//  PBPlayerModel.h
//  PBTicTacToe
//
//  Created by Kenan Pulak on 6/10/14.
//  Copyright (c) 2014 Kenan Pulak. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PBGamePiece){
    PBGamePieceCircle = 0,
    PBGamePieceX
};

typedef NS_ENUM(NSUInteger, PBPlayerType){
    PBPlayerTypeUser = 0,
    PBPlayerTypeComputer
};

@interface PBPlayerModel : NSObject

-(id)initWithPlayerType:(enum PBPlayerType)playerType andGamePiece:(enum PBGamePiece)gamePiece;

@property(nonatomic) enum PBGamePiece gamePiece;
@property(nonatomic) enum PBPlayerType playerType;

@end
