//
//  HTSProfileViewModel.h
//  HTSSimpleProfile
//
//  Created by ハン・エンショウ on 2019/07/10.
//  Copyright © 2019 fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "HTSUserModel.h"
#import "HTSVideoModel.h"
//#import "HTSProfileViewController.h"
@class HTSProfileViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol HTSDelegate <NSObject>

@optional

- (void)didLoadLocation:(NSString *)locationString;
- (void)didSaveWithAvatar:(UIImage *)avatar;

@end

@interface HTSProfileViewModel : NSObject

@property (weak, nonatomic) id <HTSDelegate> delegate;
@property (strong, nonatomic) HTSUserModel *userModel;
@property (strong, nonatomic) NSMutableArray *videoModelArray;

- (instancetype) initWithUserModel:(HTSUserModel *)userModel videoModelArray:(NSMutableArray *) videoModelArray;
- (void)collectionViewCell:(UICollectionViewCell *)cell loadVideoCoverAtIndexPath:(NSIndexPath *)indexPath;
- (void)loadUserProfileView:(HTSProfileViewController *) userProfileViewController;
- (void)label:(UILabel *)likeCountLabel loadLikeCountAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
