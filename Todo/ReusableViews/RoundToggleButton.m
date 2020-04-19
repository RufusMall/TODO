//
//  RoundToggleButton.m
//  Todo
//
//  Created by Rufus on 19/04/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

#import "RoundToggleButton.h"

@implementation RoundToggleButton

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        [self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, self.tintColor.CGColor);
    
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGFloat radius = 0.7 * center.x;
    CGFloat startAngle = -((float)M_PI / 2);
    CGFloat endAngle = ((2 * (float)M_PI) + startAngle);
    CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, 0);
    CGContextStrokePath(context);
    
    if (self.isSelected) {
        CGContextSetFillColorWithColor(context, self.tintColor.CGColor);
        CGContextAddArc(context, center.x, center.y, radius - 2, startAngle, endAngle, 0);
        CGContextFillPath(context);
    }
}

-(void)buttonPressed:(id)sender {
    self.selected = !self.selected;
}
@end

