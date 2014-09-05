//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Zhang Jin on 9/5/14.
//  Copyright (c) 2014 Zhang Jin. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite, getter = isPlaying) BOOL playing;
@property (nonatomic, strong) NSString *mode;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSMutableArray *historyRecords; // of NSString
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)historyRecords {
    if (!_historyRecords) _historyRecords = [[NSMutableArray alloc] init];
    return _historyRecords;
}

- (instancetype)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)setGameMode:(NSString *)gameMode {
    self.mode = gameMode;
}
- (NSArray *)touchHistory {
    return [self.historyRecords copy];
}

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    if (!self.isPlaying) {
        self.playing = YES;
    }
    
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            [self.historyRecords addObject:[NSString stringWithFormat:@"Flip %@", card.contents]];
        } else {
            NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [chosenCards addObject:otherCard];
                }
            }
            
            if ([chosenCards count] == 0) {
                [self.historyRecords addObject:[NSString stringWithFormat:@"Touch %@", card.contents]];
            } else if (([self.mode isEqualToString:@"2-Card"] && [chosenCards count] == 1)
                       || ([self.mode isEqualToString:@"3-Card"] && [chosenCards count] == 2)) {
                int matchScore = [card match:[chosenCards copy]];
                if (matchScore) {
                    int winScore = matchScore * MATCH_BONUS;
                    self.score += winScore;
                    card.matched = YES;
                    NSString *record = @"Matched ";
                    for (Card *chosenCard in chosenCards) {
                        chosenCard.matched = YES;
                        record = [record stringByAppendingString:[NSString stringWithFormat:@"%@ ", chosenCard.contents]];
                    }
                    record = [record stringByAppendingString:[NSString stringWithFormat:@"%@ for %d", card.contents, winScore]];
                    [self.historyRecords addObject:record];
                } else {
                    self.score -= MISMATCH_PENALTY;
                    NSString *record = @"Unmatched ";
                    for (Card *chosenCard in chosenCards) {
                        chosenCard.chosen = NO;
                        record = [record stringByAppendingString:[NSString stringWithFormat:@"%@ ", chosenCard.contents]];
                    }
                    record = [record stringByAppendingString:[NSString stringWithFormat:@"%@ for -%d", card.contents, MISMATCH_PENALTY]];
                    [self.historyRecords addObject:record];
                }
            }

            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
    }
}

@end
