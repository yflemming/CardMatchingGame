//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Yuon Flemming on 7/5/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

-(id)initWithCount:(NSUInteger)cardCount
         usingDeck:(Deck *)deck;
-(void)flipCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
-(void)resetGameWithDeck:(Deck *)deck;
@property (nonatomic, readonly)int score;
@property (nonatomic, readonly)NSString *gameLabel;
-(void)matchCardsToIndex:(NSUInteger)index;
-(void)makeSetWithCardAt:(NSUInteger)index;
@end
