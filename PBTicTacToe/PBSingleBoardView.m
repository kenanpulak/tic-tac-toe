//
//  PBSingleBoardView.m
//  PBTicTacToe
//
//  Created by Kenan Pulak on 6/9/14.
//  Copyright (c) 2014 Kenan Pulak. All rights reserved.
//

#import "PBSingleBoardView.h"

@interface PBSingleBoardView()

@property (nonatomic,strong)UIImageView *boardImageView;
@property (nonatomic,strong)UIImageView *boardMoveImageView;

@property BOOL used;
@property(nonatomic) enum PBViewState gamePiece;

@end

@implementation PBSingleBoardView

-(id)init{
    self = [super init];
    if (self) {
        [self setup];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped)];
        [self addGestureRecognizer:tapGestureRecognizer];
        [self resetBoard];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setup{
    
    self.boardImageView = [[UIImageView alloc] init];
    [self.boardImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.boardImageView setBackgroundColor:[UIColor whiteColor]];
    
    self.boardMoveImageView = [[UIImageView alloc] init];
    [self.boardMoveImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.boardMoveImageView setBackgroundColor:[UIColor clearColor]];
    [self.boardMoveImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:self.boardImageView];
    [self addSubview:self.boardMoveImageView];

    NSMutableArray* constraints = [[NSMutableArray alloc] init];
    NSDictionary* views = NSDictionaryOfVariableBindings(_boardMoveImageView,_boardImageView);

    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_boardMoveImageView]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_boardMoveImageView]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_boardImageView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_boardImageView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    
    [self addConstraints:constraints];
    
}

-(void)viewTapped{
    if (!self.used) {
        self.onBoardClicked();
    }
}

-(void)setState:(enum PBViewState)viewState{
    
    if (viewState == PBViewStateEmpty) {
        [self.boardMoveImageView setBackgroundColor:[UIColor clearColor]];
        [self.boardMoveImageView setImage:nil];
    }
    else if (viewState == PBViewStateCircle){
        if ([self isiPad]) {
            [self.boardMoveImageView setImage:[UIImage imageNamed:@"circle-ipad"]];
        }
        else{
            [self.boardMoveImageView setImage:[UIImage imageNamed:@"circle-iphone"]];

        }
    }
    else if (viewState == PBViewStateX){
        if ([self isiPad]) {
            [self.boardMoveImageView setImage:[UIImage imageNamed:@"x-ipad-blue"]];
        }
        else{
            [self.boardMoveImageView setImage:[UIImage imageNamed:@"x-iphone-blue"]];
            
        }
    }
    else{
        [self.boardMoveImageView setBackgroundColor:[UIColor clearColor]];
    }
}

-(void)resetBoard{
    self.gamePiece = PBViewStateEmpty;
    [self setState:self.gamePiece];
    [self setUsed:NO];
}

-(void)setBoardUsed{
    [self setUsed:YES];
}

-(BOOL) isiPad {
    return UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
