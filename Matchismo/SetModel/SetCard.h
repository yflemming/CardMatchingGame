//
//  SetCard.h
//  Matchismo
//
//  Created by Yuon Flemming on 8/20/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

+(NSArray *)validShape;
+(NSArray *)validAlpha;
+(NSArray *)validColor;
-(NSAttributedString *)makeCardStringFrom:(Card *)gameCard;

@property (strong, nonatomic)NSString *shape;
@property (nonatomic)NSNumber *alpha;
@property (nonatomic, readonly)NSString *color;


@end
