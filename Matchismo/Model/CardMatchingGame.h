//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Zhang Jin on 9/5/14.
//  Copyright (c) 2014 Zhang Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

- (void)setGameMode:(NSString *)gameMode;
- (NSArray *)touchHistory;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly, getter = isPlaying) BOOL playing;

@end
