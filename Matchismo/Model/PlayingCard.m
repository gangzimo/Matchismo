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
