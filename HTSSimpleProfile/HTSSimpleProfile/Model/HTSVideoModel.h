//
//  HTSVideoModel.h
//  HTSSimpleProfile
//
//  Created by ハン・エンショウ on 2019/07/10.
//  Copyright © 2019 fan. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTSVideoModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, readwrite) NSNumber *digCountNumber;
@property (nonatomic, readwrite) NSString *videoUriString;

@end

@interface HTSVideoModelArray : NSObject

@property (nonatomic, readwrite) NSMutableArray *userVideoArray;

+ (NSMutableArray *)constructVideoModelArrayFromLocalJSON:(NSString *)videoJSONString;

@end

NS_ASSUME_NONNULL_END
