//
//  PBViewController.m
//  PBTicTacToe
//
//  Created by Kenan Pulak on 6/9/14.
//  Copyright (c) 2014 Kenan Pulak. All rights reserved.
//

#import "PBMainViewController.h"
#import "PBSingleBoardView.h"
#import "PBPlayerModel.h"
#import "PBGameBoardModel.h"
#import "UIColor+PBColors.h"

typedef NS_ENUM(NSUInteger, PBGameState){
    PBGameStatePlayer = 0,
    PBGameStateComputer,
    PBGameStatePlayerWin,
    PBGameStateComputerWin
};

@interface PBMainViewController ()

@property(nonatomic) enum PBGameState gameState;
@property (nonatomic,strong) PBPlayerModel *userPlayer;
@property (nonatomic,strong) PBPlayerModel *computerPlayer;
@property (nonatomic,strong) UIView *boardView;
@property (nonatomic,strong) PBSingleBoardView *boardTopLeft;
@property (nonatomic,strong) PBSingleBoardView *boardTopCenter;
@property (nonatomic,strong) PBSingleBoardView *boardTopRight;
@property (nonatomic,strong) PBSingleBoardView *boardMiddleLeft;
@property (nonatomic,strong) PBSingleBoardView *boardMiddleCenter;
@property (nonatomic,strong) PBSingleBoardView *boardMiddleRight;
@property (nonatomic,strong) PBSingleBoardView *boardBottomLeft;
@property (nonatomic,strong) PBSingleBoardView *boardBottomCenter;
@property (nonatomic,strong) PBSingleBoardView *boardBottomRight;
@property (nonatomic,strong) UIView *firstVerticalLineView;
@property (nonatomic,strong) UIView *secondVerticalLineView;
@property (nonatomic,strong) UIView *firstHorizontalLineView;
@property (nonatomic,strong) UIView *secondHorizontalLineView;
@property (nonatomic,strong) NSArray *boardArray;

@end

@implementation PBMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *newGameButton = [[UIBarButtonItem alloc]initWithTitle:@"New Game" style:UIBarButtonItemStylePlain target:self action:@selector(newGameButtonPressed)];
    
    [self.navigationItem setRightBarButtonItem:newGameButton];
    [self.navigationItem setTitle:@"Tic-Tac-Toe"];
    [self.navigationController.navigationBar setBarTintColor:[UIColor PBGreenColor]];

    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.navigationController.navigationBar.translucent = NO;

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.userPlayer = [[PBPlayerModel alloc]initWithPlayerType:PBPlayerTypeUser andGamePiece:PBGamePieceX];
    self.computerPlayer = [[PBPlayerModel alloc]initWithPlayerType:PBPlayerTypeComputer andGamePiece:PBGamePieceCircle];
    
}

-(void)viewWillAppear:(BOOL)animated{


}

-(void)viewDidAppear:(BOOL)animated{
    [self setupViews];
}

-(void)setupViews{
    
    float boardHorizontalSpacing = 10;
    float boardWidth = (self.view.frame.size.width - 2*boardHorizontalSpacing);
    
    self.boardView = [[UIView alloc]initWithFrame:CGRectMake(boardHorizontalSpacing, (self.view.frame.size.height - boardWidth)/2, boardWidth, boardWidth)];
    [self.boardView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.boardView];
    
    //top row left column image view setup
    self.boardTopLeft = [[PBSingleBoardView alloc] init];
    [self.boardTopLeft setTag:0];
    [self.boardTopLeft setTranslatesAutoresizingMaskIntoConstraints:NO];
    __weak typeof(self) wself = self;

    [self.boardTopLeft setOnBoardClicked:^{
        [wself playerClickedBoard:wself.boardTopLeft];
    }];
    
    [self.boardView addSubview:self.boardTopLeft];
    
    //top row center column image view setup
    self.boardTopCenter = [[PBSingleBoardView alloc] init];
    [self.boardTopCenter setTag:1];
    [self.boardTopCenter setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.boardTopCenter setOnBoardClicked:^{
        [wself playerClickedBoard:wself.boardTopCenter];

    }];
    [self.boardView addSubview:self.boardTopCenter];
    
    //top row right column image view setup
    self.boardTopRight = [[PBSingleBoardView alloc] init];
    [self.boardTopRight setTag:2];
    [self.boardTopRight setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.boardTopRight setOnBoardClicked:^{
        [wself playerClickedBoard:wself.boardTopRight];
        
    }];
    [self.boardView addSubview:self.boardTopRight];
    
    //middle row left column image view setup
    self.boardMiddleLeft = [[PBSingleBoardView alloc] init];
    [self.boardMiddleLeft setTag:3];

    [self.boardMiddleLeft setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.boardMiddleLeft setOnBoardClicked:^{
        [wself playerClickedBoard:wself.boardMiddleLeft];
        
    }];
    [self.boardView addSubview:self.boardMiddleLeft];
    
    //middle row center column image view setup
    self.boardMiddleCenter = [[PBSingleBoardView alloc] init];
    [self.boardMiddleCenter setTag:4];

    [self.boardMiddleCenter setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.boardMiddleCenter setOnBoardClicked:^{
        [wself playerClickedBoard:wself.boardMiddleCenter];
        
    }];
    [self.boardView addSubview:self.boardMiddleCenter];
    
    //middle row right column image view setup
    self.boardMiddleRight = [[PBSingleBoardView alloc] init];
    [self.boardMiddleRight setTag:5];
    [self.boardMiddleRight setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.boardMiddleRight setOnBoardClicked:^{
        [wself playerClickedBoard:wself.boardMiddleRight];
        
    }];
    [self.boardView addSubview:self.boardMiddleRight];
    
    //bottom row left column image view setup
    self.boardBottomLeft = [[PBSingleBoardView alloc] init];
    [self.boardBottomLeft setTag:6];
    [self.boardBottomLeft setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.boardBottomLeft setOnBoardClicked:^{
        [wself playerClickedBoard:wself.boardBottomLeft];
        
    }];
    [self.boardView addSubview:self.boardBottomLeft];
    
    //bottom row center column image view setup
    self.boardBottomCenter = [[PBSingleBoardView alloc] init];
    [self.boardBottomCenter setTag:7];
    [self.boardBottomCenter setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.boardBottomCenter setOnBoardClicked:^{
        [wself playerClickedBoard:wself.boardBottomCenter];
        
    }];
    [self.boardView addSubview:self.boardBottomCenter];
    
    //bottom row right column image view setup
    self.boardBottomRight = [[PBSingleBoardView alloc] init];
    [self.boardBottomRight setTag:8];
    [self.boardBottomRight setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.boardBottomRight setOnBoardClicked:^{
        [wself playerClickedBoard:wself.boardBottomRight];
        
    }];
    [self.boardView addSubview:self.boardBottomRight];
    
    self.boardArray = @[_boardTopLeft,_boardTopCenter,_boardTopRight,_boardMiddleLeft,_boardMiddleCenter,_boardMiddleRight,_boardBottomLeft,_boardBottomCenter,_boardBottomRight];
    
    [self configureConstraints];
    
}

-(void)configureConstraints{
    
    NSDictionary* views = NSDictionaryOfVariableBindings(_boardTopLeft,_boardTopCenter,_boardTopRight,_boardMiddleLeft,_boardMiddleCenter,_boardMiddleRight,_boardBottomLeft,_boardBottomCenter,_boardBottomRight);
    NSDictionary* metrics = @{@"spacing": @5};
    
    NSMutableArray* constraints = [[NSMutableArray alloc] init];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_boardTopLeft]-spacing-[_boardMiddleLeft(==_boardTopLeft)]-spacing-[_boardBottomLeft(==_boardTopLeft)]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_boardTopCenter]-spacing-[_boardMiddleCenter(==_boardTopCenter)]-spacing-[_boardBottomCenter(==_boardTopCenter)]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_boardTopRight]-spacing-[_boardMiddleRight(==_boardTopRight)]-spacing-[_boardBottomRight(==_boardTopRight)]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_boardTopLeft]-spacing-[_boardTopCenter(==_boardTopLeft)]-spacing-[_boardTopRight(==_boardTopLeft)]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_boardMiddleLeft]-spacing-[_boardMiddleCenter(==_boardMiddleLeft)]-spacing-[_boardMiddleRight(==_boardMiddleLeft)]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_boardBottomLeft]-spacing-[_boardBottomCenter(==_boardBottomLeft)]-spacing-[_boardBottomRight(==_boardBottomLeft)]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    [self.boardView addConstraints:constraints];

}

-(void)setBoardView:(PBSingleBoardView*)boardView WithState:(enum PBViewState)viewState{
    
    [boardView setState:viewState];
    [boardView setBoardUsed];
}

-(void)playerClickedBoard:(PBSingleBoardView*)boardView{
    if (self.gameState == PBGameStatePlayer) {
        [self.view setUserInteractionEnabled:NO];
        NSArray *playerMove = [[PBGameBoardModel sharedSingleton]userMoveWithIndex:boardView.tag];
        
        NSNumber *row = [playerMove objectAtIndex:0];
        NSNumber *column = [playerMove objectAtIndex:1];
        if (self.userPlayer.gamePiece == PBGamePieceX) {
            [self setBoardView:boardView WithState:PBViewStateX];
            
            [[PBGameBoardModel sharedSingleton]setMoveMadeAtRow:[row intValue] andColumn:[column intValue]withPlayer:PBPlayerTypeUser];
        }
        if (self.userPlayer.gamePiece == PBGamePieceCircle) {
            [self setBoardView:boardView WithState:PBViewStateCircle];
            
            [[PBGameBoardModel sharedSingleton]setMoveMadeAtRow:[row intValue] andColumn:[column intValue]withPlayer:PBPlayerTypeUser];
        }
        
        if(![self checkForWin]){
            [self performSelector:@selector(setComputerTurn) withObject:nil afterDelay:.1];
        }
    }
}

-(void)newGameButtonPressed{
    
    self.gameState = PBGameStatePlayer;
    [self resetGameBoard];
    
}

-(void)resetGameBoard{
    
    for (PBSingleBoardView *board in self.boardArray) {
        [board resetBoard];
    }
    [self.view setUserInteractionEnabled:YES];
    
    [[PBGameBoardModel sharedSingleton]clearBoard];
}

-(void)setPlayerTurn{
    self.gameState = PBGameStatePlayer;
    [self.view setUserInteractionEnabled:YES];
}

-(void)setComputerTurn{
    self.gameState = PBGameStateComputer;
    [self performComputerTurn];
}

-(void)performComputerTurn{
    NSArray *bestComputerMove = [[PBGameBoardModel sharedSingleton]computerBestMove];
    
    NSNumber *rowNumber = [bestComputerMove objectAtIndex:0];
    NSNumber *columnNumber = [bestComputerMove objectAtIndex:1];
    
    int bestMoveIndex = [[PBGameBoardModel sharedSingleton]getIndexWithArray:bestComputerMove];
    
    NSLog(@"Best Move index %i: %@",bestMoveIndex, bestComputerMove);
    
    PBSingleBoardView *currentGameBoardView = [self.boardArray objectAtIndex:bestMoveIndex];
    
        if (self.computerPlayer.gamePiece == PBGamePieceX) {
            [self setBoardView:currentGameBoardView WithState:PBViewStateX];
            [[PBGameBoardModel sharedSingleton]setMoveMadeAtRow:[rowNumber intValue] andColumn:[columnNumber intValue] withPlayer:PBPlayerTypeComputer];
        }
        if (self.computerPlayer.gamePiece == PBGamePieceCircle) {
            [self setBoardView:currentGameBoardView WithState:PBViewStateCircle];
            [[PBGameBoardModel sharedSingleton]setMoveMadeAtRow:[rowNumber intValue] andColumn:[columnNumber intValue] withPlayer:PBPlayerTypeComputer];
        }
    
    if(![self checkForWin]){
        [self setPlayerTurn];
    }
}

-(BOOL)checkForWin{
        
    if ([[PBGameBoardModel sharedSingleton]checkDraw]) {
        [self gameDraw];
        return YES;
    }
    
    if ([[[PBGameBoardModel sharedSingleton]gameWon] isEqualToNumber:@0]){
        return NO;
    }
    
    if ([[[PBGameBoardModel sharedSingleton]gameWon] isEqualToNumber:@1]){
        [self userWins];
        return YES;
    }
    
    if ([[[PBGameBoardModel sharedSingleton]gameWon] isEqualToNumber:@2]){
        [self computerWins];
        return YES;
    }
    
    return NO;
}

-(void)userWins{
    [self.view setUserInteractionEnabled:NO];

    UIAlertView* userWinAlert = [[UIAlertView alloc]initWithTitle:@"User Wins!" message:@"Click New Game To Start Again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [userWinAlert show];
}

-(void)computerWins{
    
    [self.view setUserInteractionEnabled:NO];

    UIAlertView* computerWinAlert = [[UIAlertView alloc]initWithTitle:@"Computer Wins!" message:@"Click New Game To Start Again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [computerWinAlert show];
    
}

-(void)gameDraw{
    
    [self.view setUserInteractionEnabled:NO];

    UIAlertView* drawAlert = [[UIAlertView alloc]initWithTitle:@"Game Draw!" message:@"Click New Game To Start Again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [drawAlert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
