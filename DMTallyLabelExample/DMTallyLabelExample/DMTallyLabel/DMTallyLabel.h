//
//  DMTallyLabel.h
//
//  Created by Daniel McCarthy on 11/12/13.
//  Copyright (c) 2013 Daniel McCarthy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMTallyLabel : UILabel
@property (strong, nonatomic) NSString *singularDescriptor;
@property (strong, nonatomic) NSString *pluralDescriptor;

- (id)initWithFrame:(CGRect)frame singularDescriptor:(NSString *)singular pluralDescriptor:(NSString *)plural countIsBiggerFont:(BOOL)countIsBigger;
- (void)startTallyingFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue outOfValue:(CGFloat)outOfValue shouldShowDescriptorText:(BOOL)addDescriptorText withDuration:(NSTimeInterval)duration andCompletionBlock:(void (^)(BOOL))block;

@end
