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

@implementation HTSVideoModelArray : NSObject

+ (NSMutableArray *)constructVideoModelArrayFromJSON: (NSString *)videoJSONString {
    NSError *error = nil;
    NSString *JSONFilePathString = [[NSBundle mainBundle] pathForResource:videoJSONString ofType:@"json"];
    NSString *JSONString = [[NSString alloc] initWithContentsOfFile:JSONFilePathString encoding:NSUTF8StringEncoding error: &error];
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *videoDictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&error];
    NSArray *videoArray = [videoDictionary objectForKey:@"data"];
    
    NSMutableArray *videoModelArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < videoArray.count; i++){
        HTSVideoModel *videoModel = [[HTSVideoModel alloc] init];
        videoModel = [MTLJSONAdapter modelOfClass:[HTSVideoModel class] fromJSONDictionary:[videoArray objectAtIndex:i] error:&error];
        [videoModelArray addObject:videoModel];
    }
    return videoModelArray;
}

@end
