//
//  HTSUserModel.m
//  Homework
//
//  Created by ハン・エンショウ on 2019/07/06.
//  Copyright © 2019 fan. All rights reserved.
//

#import "HTSUserModel.h"

@implementation HTSUserModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"avatarJpgUri": @"data.avatar_jpg_uri",
             @"birthdayDescription": @"data.birthday_description",
             @"city": @"data.city",
             @"fanTicketCount": @"data.fan_ticket_count",
             @"nickname": @"data.nickname",
             @"payGradeBanner": @"data.pay_grade.grade_banner",
             @"gradeIconUri": @"data.pay_grade.grade_icon_uri",
             @"signature": @"data.signature",
             @"followingCount": @"data.stats.following_count",
             @"followerCount": @"data.stats.follower_count"
             };
}

+ (NSDictionary *)loadUserJSONFile{
    NSError *error = nil;
    NSString *JSONFilePath = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"json"];
    NSString *JSONString = [[NSString alloc] initWithContentsOfFile:JSONFilePath encoding:NSUTF8StringEncoding error: &error];
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *userDictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&error];
    return userDictionary;
}

@end
