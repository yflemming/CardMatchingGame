//
//  SetCard.m
//  Matchismo
//
//  Created by Yuon Flemming on 8/20/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()
@property (nonatomic, readwrite)NSString *color;
@end

@implementation SetCard

@synthesize shape = _shape;
@synthesize color = _color;

-(int)match:(NSArray *)otherCards;
{
    int score = 0;
    
    if (otherCards.count == 3) {
        SetCard* frstCard = otherCards[0];
        SetCard* secCard = otherCards[1];
        SetCard* thrdCard = [otherCards lastObject];
        
        if (([self doesShapeOn:frstCard match:secCard]&&
            [self doesShapeOn:secCard match:thrdCard])||
            (![self doesShapeOn:frstCard match:secCard]&&
            ![self doesShapeOn:secCard match:thrdCard]))
        {            
            if (([self doesAlphaOn:frstCard match:secCard]&&
                 [self doesAlphaOn:secCard match:thrdCard])||
                (![self doesAlphaOn:frstCard match:secCard]&&
                 ![self doesAlphaOn:secCard match:thrdCard]))
            {
                if (([self doesColorOn:frstCard match:secCard]&&
                     [self doesColorOn:secCard match:thrdCard])||
                    (![self doesColorOn:frstCard match:secCard]&&
                     ![self doesColorOn:secCard match:thrdCard])) {
                        score = 3;
                }
            }
        }
    }
    return  score;
}

+(NSArray *)validShape
{
    return @[@"•",@"••",@"•••",@"▪",@"▪▪",@"▪▪▪",@"▴",@"▴▴",@"▴▴▴"];
}

+(NSArray *)validAlpha
{
    return @[@1.0, @0.6, @0.2];
}

+(NSArray *)validColor
{
    return @[@"Red", @"Green", @"Blue"];
}

-(NSString *)shape
{
    return _shape ? _shape : @"?";
}

-(NSString *)color
{
    return _color ? _color : @"?";
}


-(BOOL)doesShapeOn:(SetCard *)card_1 match:(SetCard *)card_2
{
    BOOL match = false;
    
    if ([[card_1 shape] isEqualToString:[card_2 shape]]) {
        match = true;
        return match;
    } else {
        return match;
    }
}


//helper method for match

-(BOOL)doesAlphaOn:(SetCard *)card_1 match:(SetCard *)card_2
{
    BOOL match = false;
    
    if ([[card_1 alpha] isEqualToNumber:[card_2 alpha]]) {
        match = true;
        return match;
    } else{
        return match;
    }
}

//helper method for match

-(BOOL)doesColorOn:(SetCard *)card_1 match:(SetCard *)card_2
{
    BOOL match = false;
    
    if ([[card_1 color] isEqualToString:[card_2 color]]) {
        match = true;
        return match;
    } else{
        return match;
    }
}

//Sets Card shape

-(void)setShape:(NSString *)shape
{
    if ([[SetCard validShape]containsObject:shape]) {
        _shape = shape;
    }
}

//Sets Card Alpha

-(void)setAplha:(NSNumber *)alphaSetting
{
    if ([[SetCard validAlpha]containsObject:alphaSetting]) {
        _alpha = alphaSetting;
    }
}

//Sets card color

-(void)setColor:(NSString *)color
{
    if ([[SetCard validColor] containsObject:color]) {
        _color = color;
    }
}

//Returns string with the info of the card

-(NSString *)contents
{
    return [NSString stringWithFormat:@"%@,%@,%@", self.shape, self.alpha, self.color];
}

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


@end

