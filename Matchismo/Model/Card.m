//
//  Card.m
//  Matchismo
//
//  Created by Zhang Jin on 9/4/14.
//  Copyright (c) 2014 Zhang Jin. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
