//
//  DMTallyLabel.m
//
//  Created by Daniel McCarthy on 11/12/13.
//  Copyright (c) 2013 Daniel McCarthy. All rights reserved.
//

#import "DMTallyLabel.h"
@interface UILabelTally : NSObject
@property CGFloat rate;
@end

@interface DMTallyLabel () {
    CGFloat         startFloat;
    CGFloat         endFloat;
    NSTimeInterval  progressInterval;
    NSTimeInterval  previousTallyInterval;
    NSTimeInterval  total;
    BOOL            shouldShowDescriptorText;
    BOOL            countIsBiggerFont;
}

@property (copy, nonatomic) void (^theBlock)(BOOL done);
@property (strong, nonatomic) UILabelTally *tallyLbl;
@property (strong, nonatomic) NSString *outOfString;

@end

@implementation DMTallyLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame singularDescriptor:(NSString *)singular pluralDescriptor:(NSString *)plural countIsBiggerFont:(BOOL)countIsBigger
{
    self = [super initWithFrame:frame];
    if (self) {
        self.singularDescriptor = singular;
        self.pluralDescriptor   = plural;
        countIsBiggerFont       = countIsBigger;
    }
    return self;
}

- (void)startTallyingFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue outOfValue:(CGFloat)outOfValue shouldShowDescriptorText:(BOOL)addDescriptorText withDuration:(NSTimeInterval)duration andCompletionBlock:(void (^)(BOOL))block {
    if (outOfValue > 0.0f) {
        int outOfInt = (int)outOfValue;
        _outOfString = [NSString stringWithFormat:@"%i",outOfInt];
    } else {
        _outOfString = nil;
    }
    
    if (addDescriptorText == YES) {
        shouldShowDescriptorText = YES;
    } else {
        shouldShowDescriptorText = NO;
    }
    previousTallyInterval   = [NSDate timeIntervalSinceReferenceDate];
    startFloat              = fromValue;
    endFloat                = toValue;
    total                   = duration;
    progressInterval        = 0;
    _tallyLbl.rate          = 3.0f;
    _theBlock               = block;
    
    self.adjustsFontSizeToFitWidth = YES;
    NSTimer *theTimer = [NSTimer timerWithTimeInterval:1.0f/30.0f
                                                target:self
                                              selector:@selector(updateTallyWithTimer:)
                                              userInfo:nil
                                               repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:theTimer
                              forMode:NSDefaultRunLoopMode];
}

- (void)updateTallyWithTimer:(NSTimer *)timer {
    if (total == 0.0) {
        CGFloat currentValue =  endFloat;
        if (_outOfString != nil) {
            if (shouldShowDescriptorText == YES) {
                NSString *pointTotalStr             = [NSString stringWithFormat:@"%d / %@", (int)currentValue, _outOfString];
                NSMutableAttributedString *lblStr   = [self attributedStringWithDescriptorTextFromString:pointTotalStr withCount:(int)currentValue];
                self.attributedText                 = lblStr;
            } else {
                self.text = [NSString stringWithFormat:@"%d / %@", (int)currentValue, _outOfString];
            }
        } else {
            if (shouldShowDescriptorText == YES) {
                NSString *pointTotalStr             = [NSString stringWithFormat:@"%d", (int)currentValue];
                NSMutableAttributedString *lblStr   = [self attributedStringWithDescriptorTextFromString:pointTotalStr withCount:(int)currentValue];
                self.attributedText                 = lblStr;
            } else {
                self.text = [NSString stringWithFormat:@"%d", (int)currentValue];
            }
        }
        
        if (progressInterval == total) {
            if (_theBlock) {
                _theBlock (YES);
                _theBlock = nil;
            }
        }
        
    } else {
        NSTimeInterval currentTimeInterval = [NSDate timeIntervalSinceReferenceDate];
        progressInterval += currentTimeInterval - previousTallyInterval;
        previousTallyInterval = currentTimeInterval;
        
        if (progressInterval >= total) {
            [timer invalidate];
            progressInterval = total;
        }
        
        CGFloat percent         = progressInterval / total;
        CGFloat currentValue    =  startFloat +  (percent * (endFloat - startFloat));
        if (_outOfString != nil) {
            if (shouldShowDescriptorText == YES) {
                NSString *pointTotalStr             = [NSString stringWithFormat:@"%d / %@", (int)currentValue, _outOfString];
                NSMutableAttributedString *lblStr   = [self attributedStringWithDescriptorTextFromString:pointTotalStr withCount:(int)currentValue];
                self.attributedText                 = lblStr;
            } else {
                self.text = [NSString stringWithFormat:@"%d / %@", (int)currentValue, _outOfString];
            }
        }
        else {
            if (shouldShowDescriptorText == YES) {
                NSString *pointTotalStr             = [NSString stringWithFormat:@"%d", (int)currentValue];
                NSMutableAttributedString *lblStr   = [self attributedStringWithDescriptorTextFromString:pointTotalStr withCount:(int)currentValue];
                self.attributedText                 = lblStr;
            } else {
                self.text = [NSString stringWithFormat:@"%d", (int)currentValue];
            }
        }
        
        if (progressInterval == total) {
            if (_theBlock) {
                _theBlock (YES);
                _theBlock = nil;
            }
        }
    }
}

- (NSMutableAttributedString *)attributedStringWithDescriptorTextFromString:(NSString *)string withCount:(int)count {
    NSString *descriptorString;
    if (count == 1)
        descriptorString = [NSString stringWithFormat:@" %@", self.singularDescriptor];
    else
        descriptorString = [NSString stringWithFormat:@" %@", self.pluralDescriptor];
    NSInteger pointTotalLength  = string.length;
    NSInteger pointLabelLength  = descriptorString.length;
    NSString *constructedString = [NSString stringWithFormat:@"%@%@", string, descriptorString];
    UIFont *theFont;
    
    if (countIsBiggerFont == YES)
        theFont = [UIFont fontWithName:self.font.fontName size:self.font.pointSize/2];
    else
        theFont = self.font;
    
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:constructedString attributes:@{NSFontAttributeName:self.font}];
    [attString addAttributes:@{NSFontAttributeName:theFont} range:NSMakeRange(pointTotalLength, pointLabelLength)];
    return attString;
}

@end
