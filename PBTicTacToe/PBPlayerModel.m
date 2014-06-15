//
//  PBPlayerModel.m
//  PBTicTacToe
//
//  Created by Kenan Pulak on 6/10/14.
//  Copyright (c) 2014 Kenan Pulak. All rights reserved.
//

#import "PBPlayerModel.h"

@implementation PBPlayerModel

-(id)initWithPlayerType:(enum PBPlayerType)playerType andGamePiece:(enum PBGamePiece)gamePiece{
    self = [super init];
    if (self) {
        self.playerType = playerType;
        self.gamePiece = gamePiece;
    }
    return self;
}

@end
