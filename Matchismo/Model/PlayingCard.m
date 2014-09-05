//
//  PlayingCard.m
//  Matchismo
//
//  Created by Zhang Jin on 9/4/14.
//  Copyright (c) 2014 Zhang Jin. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *card = [otherCards firstObject];
        if ([card.suit isEqualToString:self.suit]) {
            score += 6;
        } else if (card.rank == self.rank) {
            score += 12;
        }
    } else if ([otherCards count] == 2) {
        PlayingCard *cardOne = [otherCards firstObject];
        PlayingCard *cardTwo = [otherCards lastObject];
        
        if (self.rank == cardOne.rank && cardOne.rank == cardTwo.rank) {
            score += 32;
        } else if ([self.suit isEqualToString:cardOne.suit] && [cardOne.suit isEqualToString:cardTwo.suit]) {
            score += 16;
        } else if (self.rank == cardOne.rank || cardOne.rank == cardTwo.rank || self.rank == cardTwo.rank) {
            score += 8;
        } else if ([self.suit isEqualToString:cardOne.suit] || [cardOne.suit isEqualToString:cardTwo.suit] || [self.suit isEqualToString:cardTwo.suit]){
            score += 4;
        }
    }
    
    return score;
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)contents {
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits {
    return @[@"♣", @"♥", @"♠", @"♦"];
}

+ (NSUInteger)maxRank {
    return [[PlayingCard rankStrings] count] - 1;
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

@end
