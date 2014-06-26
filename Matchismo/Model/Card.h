//
//  Card.h
//  Matchismo
//
//  Created by Yuon Flemming on 6/30/13.
//  Copyright (c) 2013 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isFaceUp) BOOL faceUp;

@property (nonatomic, getter=isUnplayable)BOOL unplayable;

@property (nonatomic, getter=isSelected) BOOL selected;

- (int)match:(NSArray *)otherCards;

@end
