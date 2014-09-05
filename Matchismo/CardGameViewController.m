//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Zhang Jin on 9/4/14.
//  Copyright (c) 2014 Zhang Jin. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardbutton:(UIButton *)sender {
    if (!self.game.isPlaying) {
        [self.game setGameMode:[self.gameMode titleForSegmentAtIndex:self.gameMode.selectedSegmentIndex]];
    }
    
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    int currentValue = sender.value;
    self.historyLabel.text = [self.game touchHistory][currentValue];
}

- (void)updateUI {
    if (self.game.isPlaying) {
        self.gameMode.enabled = NO;
    } else {
        self.gameMode.enabled = YES;
    }
    
    for (UIButton *button in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:cardIndex];
        [button setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        button.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    self.historySlider.minimumValue = 0;
    self.historySlider.maximumValue = [self.game.touchHistory count] - 1;
    self.historySlider.value = self.historySlider.maximumValue;
    self.historySlider.enabled = [self.game.touchHistory count] ? YES : NO;
    self.historyLabel.text = [self.game.touchHistory lastObject];
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:(card.isChosen ? @"cardfront" : @"cardback")];
}

- (IBAction)touchRedealButton {
    self.game = nil;
    [self updateUI];
}

@end
