//
//  BorderUIButton.m
//  Homework
//
//  Created by ハン・エンショウ on 2019/07/08.
//  Copyright © 2019 fan. All rights reserved.
//

#import "BorderUIButton.h"

@implementation BorderUIButton

- (void)drawRect:(CGRect)rect
{
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    
    [super drawRect:rect];
}

@end
