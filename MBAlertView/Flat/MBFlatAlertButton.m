//
//  MBFlatAlertButton.m
//  Freebie
//
//  Created by Mo Bitar on 6/12/13.
//  Copyright (c) 2013 Ora Interactive. All rights reserved.
//

#import "MBFlatAlertButton.h"

@implementation MBFlatAlertButton

- (UIFont*)textFont
{
    if(_type == MBFlatAlertButtonTypeNormal)
        return [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    else return [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];;
}

- (UILabel*)textLabel
{
    if(!_textLabel) {
        _textLabel = [UILabel newForAutolayoutAndAddToView:self];
        _textLabel.numberOfLines = 0;
        _textLabel.textColor = [UIColor colorWithRed:0.000 green:0.471 blue:0.965 alpha:1];
        _textLabel.font = [self textFont];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.backgroundColor = [UIColor clearColor];
    }
    return _textLabel;
}

- (void)layoutSubviews
{
    self.contentMode = UIViewContentModeRedraw;

    [super layoutSubviews];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self configureTextLabel];
        [self.superview addConstraint:constraintHeight(self, _textLabel, 20)];
    });
}

- (void)configureTextLabel
{
    CGFloat const padding = 10;
    self.textLabel.text = self.title;
    [self addConstraints:@[
         constraintCenterX(_textLabel, self),
         constraintCenterY(_textLabel, self),
         constraintWidth(_textLabel, self, -padding * 2)
     ]];
//    [_textLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _textLabel.preferredMaxLayoutWidth = self.bounds.size.width - padding * 2;
    
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    self.highlighted ? [[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1] setFill]: [[UIColor clearColor] setFill];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillRect(context, rect);
    
    CGFloat const strokeSize = 0.75;

    // draw top stroke
    [self drawStrokeForRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, strokeSize)];
    
    if(_hasRightStroke) {
        [self drawStrokeForRect:CGRectMake(rect.origin.x + rect.size.width - strokeSize, rect.origin.y, strokeSize, rect.size.height)];
    }
    
    if(_hasBottomStroke) {
        [self drawStrokeForRect:CGRectMake(rect.origin.x, rect.origin.y + rect.size.height - strokeSize, rect.size.width, strokeSize)];
    }
}

- (void)drawStrokeForRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    [[UIColor colorWithRed:0.757 green:0.773 blue:0.776 alpha:1] setFill];
    [path fill];
    
}

@end