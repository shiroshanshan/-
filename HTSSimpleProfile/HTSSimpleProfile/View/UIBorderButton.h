//
//  UIBorderButton.h
//  HTSSimpleProfile
//
//  Created by ハン・エンショウ on 2019/07/14.
//  Copyright © 2019 fan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBorderButton : UIButton

@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;

@end

NS_ASSUME_NONNULL_END
