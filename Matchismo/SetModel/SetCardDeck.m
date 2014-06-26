//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Yuon Flemming on 8/20/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *shape in [SetCard validShape]) {
            for (NSNumber *alpha in [SetCard validAlpha]) {
                SetCard *card = [[SetCard alloc] init];
                card.shape = shape;
                card.alpha = alpha;
                [self addCard:card atTop:YES];
            }
        }
    }
    
    return self;
}


@end
