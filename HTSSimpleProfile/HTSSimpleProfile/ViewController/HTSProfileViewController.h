//
//  ViewController.h
//  HTSSimpleProfile
//
//  Created by ハン・エンショウ on 2019/07/09.
//  Copyright © 2019 fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "HTSProfileViewModel.h"
#import "UIBorderButton.h"
#import "HTSProfileEditViewController.h"

@interface HTSProfileViewController : UIViewController <HTSDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) HTSProfileViewModel *viewModel;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) int cellIntervalInt;
@property (nonatomic) CGFloat viewHeightFloat;
@property (nonatomic) CGFloat viewWidthFloat;
@property (nonatomic) CGFloat userProfileUpperInset;
@property (nonatomic) UIView *userProfileViewUpper;
@property (nonatomic) UIView *userProfileViewLower;
@property (nonatomic) UIImageView *userAvatarImageView;
@property (nonatomic) UILabel *fanTicketCountLabel;
@property (nonatomic) UILabel *followingCountLabel;
@property (nonatomic) UILabel *followerCountLabel;
@property (nonatomic) UIBorderButton *editButton;
@property (nonatomic) UIImageView *badgeImageView;
@property (nonatomic) UILabel *badgeLabel;
@property (nonatomic) UIImageView *locationImageView;
@property (nonatomic) UILabel *locationLabel;
@property (nonatomic) UILabel *ageLabel;
@property (nonatomic) UITextView *signatureTextView;

- (instancetype)initWithViewModel : (HTSProfileViewModel *)viewModel;

@end

