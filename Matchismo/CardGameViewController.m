//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Zhang Jin on 9/4/14.
//  Copyright (c) 2014 Zhang Jin. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) NSInteger flipCount;
@property (strong, nonatomic) Deck *deck;
@end

@implementation CardGameViewController

- (Deck *)deck {
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void)setFlipCount:(NSInteger)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"Flips count is changed to %d", self.flipCount);
}

- (IBAction)touchCardbutton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
         Card *randomCard = [self.deck drawRandomCard];
        if (randomCard) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
            [sender setTitle:randomCard.contents forState:UIControlStateNormal];
        } else {
            sender.enabled = NO;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"End" message:@"This is no card anymore!" delegate:self cancelButtonTitle:@"Back" otherButtonTitles:nil];
            [alertView show];
        }

    }
    self.flipCount++;
}


@end
