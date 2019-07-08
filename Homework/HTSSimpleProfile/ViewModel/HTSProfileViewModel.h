//
//  HTSProfileViewModel.h
//  Homework
//
//  Created by ハン・エンショウ on 2019/07/06.
//  Copyright © 2019 fan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HTSVideoModel.h"
@import Masonry;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HTSProfileViewModel)

- (void)fillRowWith:(NSInteger)videonumber SubView:(NSArray *)userVideoSubArray OfHeight:(int)userVideoHeight AndInterval:(int)userVideoInterval;
- (void)fillViewWith:(NSInteger)containerNumber Containers:(NSArray *)userVideoArray OfHeight:(int)userVideoHeight AndInterval:(int)userVideoInterval;

@end

NS_ASSUME_NONNULL_END
