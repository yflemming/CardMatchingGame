//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Yuon Flemming on 8/23/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "Deck.h"
#import "SetCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"
#import "SetCard.h"


@interface SetCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *setCards;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *gameResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@end

@implementation SetCardGameViewController

-(CardMatchingGame *)game{
    if(!_game) _game = [[CardMatchingGame alloc]initWithCount:self.setCards.count usingDeck:[[SetCardDeck alloc]init] ];
    return _game;
}

-(void)setCardButtons:(NSArray *)setCards
{
    _setCards = setCards;
}

/*
-(NSAttributedString *)makeCardStringFrom:(Card *)gameCard
{
    NSString *cardShape = [gameCard.contents substringFromIndex:0];
    float cardAlpha = [[gameCard.contents substringFromIndex:2] floatValue];
    NSString *cardColor = [gameCard.contents substringFromIndex:4];
    
    NSMutableAttributedString *finalCard = [[NSMutableAttributedString alloc]initWithString:cardShape];
    
    if ([cardColor isEqualToString:@"Green"]) {
        UIColor *setCardGreen = [[UIColor greenColor] colorWithAlphaComponent:cardAlpha];
        [finalCard addAttributes:@{NSForegroundColorAttributeName: setCardGreen} range:NSMakeRange(0, LONG_MAX)];
    }else if ([cardColor isEqualToString:@"Red"]) {
        UIColor *setCardRed = [[UIColor redColor] colorWithAlphaComponent:cardAlpha];
        [finalCard addAttributes:@{NSForegroundColorAttributeName: setCardRed} range:NSMakeRange(0, LONG_MAX)];
    }else if ([cardColor isEqualToString:@"Blue"]) {
        UIColor *setCardBlue = [[UIColor blueColor] colorWithAlphaComponent:cardAlpha];
        [finalCard addAttributes:@{NSForegroundColorAttributeName: setCardBlue} range:NSMakeRange(0, LONG_MAX)];
    }
   
    NSAttributedString *card = [finalCard copy];
    
    return card;
}
*/

-(void)displaySetCards:(UIButton *)cardButton usingCard:(SetCard *)card
{
    [cardButton setAttributedTitle:[card makeCardStringFrom:card] forState:UIControlStateNormal];
}


- (IBAction)selectSetCard:(id)sender
{
    [self.game makeSetWithCardAt:[self.setCards indexOfObject:sender]];
    NSLog(@"here");
}













@end
