//
//  HTSProfileViewModel.m
//  HTSSimpleProfile
//
//  Created by ハン・エンショウ on 2019/07/10.
//  Copyright © 2019 fan. All rights reserved.
//

#import "HTSProfileViewModel.h"

@implementation HTSProfileViewModel

- (instancetype) initWithUserModel : (HTSUserModel *)userModel videoModelArray:(NSMutableArray *)videoModelArray{
    self = [super init];
    if (!self) return nil;
    
    self.userModel = userModel;
    self.videoModelArray = videoModelArray;
    
    return self;
}

- (void)collectionViewCell:(UICollectionViewCell *)cell loadVideoCoverAtIndexPath:(NSIndexPath *)indexPath {
    HTSVideoModel *videoModel = [self.videoModelArray objectAtIndex:(int)indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    [imageView sd_setImageWithURL:[NSURL URLWithString:videoModel.videoUriString] placeholderImage:[UIImage imageNamed:@"cat"]];
    [cell.contentView addSubview:imageView];
}

- (void)label:(UILabel *)likeCountLabel loadLikeCountAtIndexPath:(NSIndexPath *)indexPath {
    HTSVideoModel *videoModel = [self.videoModelArray objectAtIndex:(int)indexPath.row];
    likeCountLabel.text = [videoModel.digCountNumber stringValue];
}

- (void)loadUserProfileView:(UIView *) userProfileView {
    UIImageView *userAvatarImageView = [userProfileView viewWithTag:3];
    [userAvatarImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.avatarJpgUriString] placeholderImage:[UIImage imageNamed:@"cat"]];
    UILabel *fanTicketCountLabel = [userProfileView viewWithTag:4];
    fanTicketCountLabel.text = [self.userModel.fanTicketCountNumber stringValue];
    UILabel *followingCountLabel = [userProfileView viewWithTag:5];
    followingCountLabel.text = [self.userModel.followingCountNumber stringValue];
    UILabel *followerCountLabel = [userProfileView viewWithTag:6];
    followerCountLabel.text = [self.userModel.followerCountNumber stringValue];
    UILabel *badgeLabel = [userProfileView viewWithTag:7];
    badgeLabel.text = self.userModel.payGradeBannerString;
//    UILabel *locationLabel = [userProfileView viewWithTag:8];
    if ([self.delegate respondsToSelector:@selector(didLoadLocation:)]) {
        [self.delegate didLoadLocation:self.userModel.cityString];
    } else {
        NSLog(@"%@", self.userModel.cityString);
    }
//    locationLabel.text = self.userModel.cityString;
    UILabel *ageLabel = [userProfileView viewWithTag:9];
    ageLabel.text = self.userModel.birthdayDescriptionString;
    UILabel *signatureLabel = [userProfileView viewWithTag:10];
    signatureLabel.text = self.userModel.signatureString;
}

@end
