//
//  PBSingleBoardView.h
//  PBTicTacToe
//
//  Created by Kenan Pulak on 6/9/14.
//  Copyright (c) 2014 Kenan Pulak. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OnBoardClicked)(void);

typedef NS_ENUM(NSUInteger , PBViewState){
    PBViewStateEmpty = 0,
    PBViewStateCircle,
    PBViewStateX
};

@interface PBSingleBoardView : UIView

@property (nonatomic, copy) OnBoardClicked onBoardClicked;

-(void)resetBoard;
-(void)setState:(enum PBViewState)viewState;
-(void)setBoardUsed;

@end
