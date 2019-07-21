//
//  HTSUserModel.h
//  HTSSimpleProfile
//
//  Created by ハン・エンショウ on 2019/07/10.
//  Copyright © 2019 fan. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTSUserModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, readwrite) NSString *avatarJpgUriString;
@property (nonatomic, readwrite) NSString *birthdayDescriptionString;
@property (nonatomic, readwrite) NSString *cityString;
@property (nonatomic, readwrite) NSNumber *fanTicketCountNumber;
@property (nonatomic, readwrite) NSString *nicknameString;
@property (nonatomic, readwrite) NSString *payGradeBannerString;
@property (nonatomic, readwrite) NSString *gradeIconUriString;
@property (nonatomic, readwrite) NSString *signatureString;
@property (nonatomic, readwrite) NSNumber *followingCountNumber;
@property (nonatomic, readwrite) NSNumber *followerCountNumber;

@end

NS_ASSUME_NONNULL_END
