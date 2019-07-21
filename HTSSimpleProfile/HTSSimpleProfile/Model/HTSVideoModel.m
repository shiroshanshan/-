//
//  HTSVideoModel.m
//  HTSSimpleProfile
//
//  Created by ハン・エンショウ on 2019/07/10.
//  Copyright © 2019 fan. All rights reserved.
//

#import "HTSVideoModel.h"

@implementation HTSVideoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"digCountNumber": @"data.stats.digg_count",
             @"videoUriString": @"data.video.cover.uri"
             };
}

@end
