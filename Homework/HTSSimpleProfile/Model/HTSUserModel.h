//
//  HTSUserModel.h
//  Homework
//
//  Created by ハン・エンショウ on 2019/07/06.
//  Copyright © 2019 fan. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Mantle;

NS_ASSUME_NONNULL_BEGIN

@interface HTSUserModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, readwrite) NSString *avatarJpgUri;
@property (nonatomic, readwrite) NSString *birthdayDescription;
@property (nonatomic, readwrite) NSString *city;
@property (nonatomic, readwrite) NSNumber *fanTicketCount;
@property (nonatomic, readwrite) NSString *nickname;
@property (nonatomic, readwrite) NSString *payGradeBanner;
@property (nonatomic, readwrite) NSString *gradeIconUri;
@property (nonatomic, readwrite) NSString *signature;
@property (nonatomic, readwrite) NSNumber *followingCount;
@property (nonatomic, readwrite) NSNumber *followerCount;

+ (NSDictionary *)loadUserJSONFile;

@end

NS_ASSUME_NONNULL_END
