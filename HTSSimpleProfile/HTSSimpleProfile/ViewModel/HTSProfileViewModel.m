//
//  HTSProfileViewModel.m
//  HTSSimpleProfile
//
//  Created by ハン・エンショウ on 2019/07/10.
//  Copyright © 2019 fan. All rights reserved.
//

#import "HTSProfileViewModel.h"
#import "HTSProfileViewController.h"//;

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

- (void)loadUserProfileView:(HTSProfileViewController *) userProfileViewController {
    UIImageView *userAvatarImageView = userProfileViewController.userAvatarImageView;
    [userAvatarImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.avatarJpgUriString] placeholderImage:[UIImage imageNamed:@"cat"]];
    
    UILabel *fanTicketCountLabel = userProfileViewController.fanTicketCountLabel;
    fanTicketCountLabel.text = [self.userModel.fanTicketCountNumber stringValue];
    
    UILabel *followingCountLabel = userProfileViewController.followingCountLabel;
    followingCountLabel.text = [self.userModel.followingCountNumber stringValue];
    
    UILabel *followerCountLabel = userProfileViewController.followerCountLabel;
    followerCountLabel.text = [self.userModel.followerCountNumber stringValue];
    
    UILabel *badgeLabel = userProfileViewController.badgeLabel;
    badgeLabel.text = self.userModel.payGradeBannerString;

    if ([self.delegate respondsToSelector:@selector(didLoadLocation:)]) {
        [self.delegate didLoadLocation:self.userModel.cityString];
    } else {
        NSLog(@"%@", self.userModel.cityString);
    }

    UILabel *ageLabel = userProfileViewController.ageLabel;
    ageLabel.text = self.userModel.birthdayDescriptionString;
    
    UITextView *signatureLabel = userProfileViewController.signatureTextView;
    signatureLabel.text = self.userModel.signatureString;
}

@end
