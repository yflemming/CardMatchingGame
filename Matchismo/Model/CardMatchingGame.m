//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Yuon Flemming on 7/5/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property(strong, nonatomic) NSMutableArray *cards;
@property(nonatomic, readwrite)int score;
@property(nonatomic, readwrite)NSString *gameLabel;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

//designated initializer
-(id)initWithCount:(NSUInteger)count usingDeck:(Deck *)deck
{
        
    self = [super init];
    
    if (self) {
        for(int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if(!card){
                self = nil;
            }else {
                self.cards[i] = card;
            }
        }
    }
 return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return(index < self.cards.count) ? self.cards[index]:nil;
}

#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4 
#define FLIP_COST 1

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isUnplayable) {
        if(!card.isFaceUp){
            self.gameLabel = [NSString stringWithFormat:@"Flipped up %@",card.contents];
            //see if the card creates a match here
            for(Card *otherCard in self.cards){
                if (otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.gameLabel = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", card.contents, otherCard.contents, matchScore*MATCH_BONUS];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.gameLabel = [NSString stringWithFormat:@"%@ & %@ don't match! -%d points!", card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

-(void)resetGameWithDeck:(Deck *)deck
{
    self.score = 0;
    self.gameLabel = @"Select Match Settings";
    for (int i = 0; i < self.cards.count; i++) {
        self.cards[i] = [deck drawRandomCard];
    }
}

#define T_MISMATCH_PENALTY 3
#define T_MATCH_BONUS 6

-(void)matchCardsToIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *matchingCards = [[NSMutableArray alloc]init];

    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.gameLabel = [NSString stringWithFormat:@"Flipped up %@",card.contents];

            for (int i = 0; i < self.cards.count && matchingCards.count < 2;i++) {
                Card *otherCard = self.cards[i];
                if (otherCard.isFaceUp && !otherCard.isUnplayable) [matchingCards addObject:otherCard];
            }
            if (matchingCards.count == 2) {
                int tripleMatch = [card match:matchingCards];
                if (tripleMatch) {
                    card.unplayable = YES;
                    
                    Card *item_1 = matchingCards[0];
                    item_1.unplayable = YES;
                    Card *item_2 = matchingCards[1];
                    item_2.unplayable = YES;
                    
                    self.score += tripleMatch*T_MATCH_BONUS;
                    self.gameLabel = [NSString stringWithFormat:@"Matched %@ & %@ & %@ for %d points", card.contents, item_1.contents, item_2.contents, tripleMatch*T_MATCH_BONUS];
                } else{
                    
                    Card *item_1 = matchingCards[0];
                    item_1.faceUp = NO;
                    Card *item_2 = matchingCards[1];
                    item_2.faceUp = NO;

                    self.gameLabel = [NSString stringWithFormat:@"%@ & %@ & %@ don't match! -%d points!",
                                      card.contents, item_1.contents, item_2.contents, MISMATCH_PENALTY];
                    for (int i = 0; i < 2; i++) {
                        Card *arrayCards = matchingCards[i];
                        arrayCards.faceUp = NO;
                    }
                     self.score -= MISMATCH_PENALTY;
                }
            }
           self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

//Code for playing a Game of Set
#define SET_SCORE 3
#define SET_PENALTY 1

-(void)makeSetWithCardAt:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (card.isSelected) {
            
            NSMutableArray *cardSet = [[NSMutableArray alloc]init];
            cardSet[0] = card;
            for (int i = 0; i < self.cards.count -1; i++) {
                Card *setCards = self.cards[i];
                if(setCards.isSelected&&setCards.isFaceUp)[cardSet addObject:setCards];
            }
            if (cardSet.count == 3) {
                int matchScore = [card match:cardSet];
                
                card.unplayable = YES;
                Card *item_1 = cardSet[1];
                item_1.unplayable = YES;
                Card *item_2 = [cardSet lastObject];
                item_2.unplayable = YES;
                
                self.score += matchScore*SET_SCORE;
                self.gameLabel = [NSString stringWithFormat:@"Made a SET with %@, %@ and %@ for %d", card.contents, item_1.contents, item_2.contents, self.score];
            } else{
                card.selected = NO;
                Card *item_1 = cardSet[1];
                item_1.selected = NO;
                Card *item_2 = [cardSet lastObject];
                item_2.selected = NO;
                
                self.gameLabel = [NSString stringWithFormat:@"%@ & %@ & %@ don't make a set!-%d points!", card.contents, item_1.contents, item_2.contents, MISMATCH_PENALTY];
                for (int i = 0; i < 2; i++) {
                    Card *arrayCards = cardSet[i];
                    arrayCards.selected = NO;
                }
                self.score -= SET_PENALTY;
            }
        }
        card.selected = !card.isSelected;
    }
}

@end
