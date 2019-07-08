//
//  BorderUIButton.h
//  Homework
//
//  Created by ハン・エンショウ on 2019/07/08.
//  Copyright © 2019 fan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BorderUIButton : UIButton

@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;

@end

NS_ASSUME_NONNULL_END
