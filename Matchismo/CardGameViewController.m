//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Yuon Flemming on 6/30/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameResultLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *changeMatching;

@end

@implementation CardGameViewController

-(CardMatchingGame *)game{
    if(!_game) _game = [[CardMatchingGame alloc]initWithCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init] ];
    return _game; 
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
   [self updateUI];
}

-(void)updateUI
{
    UIImage *minecraftBack = [UIImage imageNamed:@"cardback.jpg"];
    
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setImage:(card.isFaceUp ? nil : minecraftBack) forState:UIControlStateNormal];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3:1.0;
        self.gameResultLabel.text = self.game.gameLabel;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
   if ([self.changeMatching selectedSegmentIndex] == 0) {
       
       [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
       [self.changeMatching setEnabled:NO forSegmentAtIndex:1];
    }else if ([self.changeMatching selectedSegmentIndex] == 1) {
        [self.game matchCardsToIndex:[self.cardButtons indexOfObject:sender]];
        [self.changeMatching setEnabled:NO forSegmentAtIndex:0];
       }
    
    self.flipCount++;
    [self updateUI];
}

- (IBAction)resetGame
{
    [self.game resetGameWithDeck:[[PlayingCardDeck alloc] init]];
    for (int i = 0; i < 2; i++) {
        [self.changeMatching setEnabled:YES forSegmentAtIndex:i];
        [self.changeMatching setSelected:NO];
    }
    self.flipCount = 0;
    [self updateUI];
}







@end
