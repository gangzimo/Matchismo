//
//  Deck.h
//  Matchismo
//
//  Created by Zhang Jin on 9/4/14.
//  Copyright (c) 2014 Zhang Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
