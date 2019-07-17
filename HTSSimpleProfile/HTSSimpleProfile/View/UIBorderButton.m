//
//  UIBorderButton.m
//  HTSSimpleProfile
//
//  Created by ハン・エンショウ on 2019/07/14.
//  Copyright © 2019 fan. All rights reserved.
//

#import "UIBorderButton.h"

@implementation UIBorderButton

- (void)drawRect:(CGRect)rect
{
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    
    [super drawRect:rect];
}

@end
