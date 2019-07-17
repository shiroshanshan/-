//
//  ViewController.m
//  HTSSimpleProfile
//
//  Created by ハン・エンショウ on 2019/07/09.
//  Copyright © 2019 fan. All rights reserved.
//

#import "HTSProfileViewController.h"

@interface HTSProfileViewController ()

@end

@implementation HTSProfileViewController

- (instancetype) initWithViewModel : (HTSProfileViewModel *)viewModel {
    self = [super init];
    if (!self) return nil;
    
    self.viewModel = viewModel;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.cellInsetInt = 3;
//    CGFloat originX = [[UIScreen mainScreen] bounds].origin.x;
//    CGFloat originY = [[UIScreen mainScreen] bounds].origin.y;

    self.navigationItem.title = @"userProfile";
    
    // update
    self.viewModel.delegate = self;
    [self loadUserProfile];
    
    [self bindViewModel];
}

- (void)loadUserProfile {
    [self setSuperView];
    [self setAvatar];
    [self setLabel];
    [self setButton];
    [self setDescriptionTextView];
    [self setBadge];
    [self setLocation];
    [self setCollectionView];
}

- (void)bindViewModel {
    self.navigationItem.title = self.viewModel.userModel.nicknameString;
    [self.viewModel loadUserProfileView:self.view];
}

- (void)editUserProfile {
    HTSProfileEditViewController *profileEditViewController = [[HTSProfileEditViewController alloc] initWithViewModel:self.viewModel];
    profileEditViewController.delegate = self;
    [self.navigationController pushViewController:profileEditViewController animated:YES];
}

- (void)setSuperView {
    CGFloat userProfileUpperOffset = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    CGRect rect = CGRectMake(0, userProfileUpperOffset, self.view.frame.size.width, self.view.frame.size.height * 0.15);
    UIView *userProfileViewUpper = [[UIView alloc] initWithFrame:rect];
    userProfileViewUpper.tag = 1;
    [self.view addSubview:userProfileViewUpper];
    rect = CGRectMake(0, userProfileUpperOffset + self.view.frame.size.height * 0.15, self.view.frame.size.width, self.view.frame.size.height * 0.15);
    UIView *userProfileViewLower = [[UIView alloc] initWithFrame:rect];
    userProfileViewLower.tag = 2;
    [self.view addSubview:userProfileViewLower];
}

- (void)setAvatar {
    UIView *userProfileViewUpper = [self.view viewWithTag:1];
    CGRect rect = CGRectMake(0, userProfileViewUpper.frame.origin.y, userProfileViewUpper.frame.size.height, userProfileViewUpper.frame.size.height);
    UIView *superView = [[UIView alloc] initWithFrame:rect];
    UIImageView *userAvatarImageView = [[UIImageView alloc] init];
    [self.view addSubview:superView];
    [self.view addSubview:userAvatarImageView];
    userAvatarImageView.tag = 3;
    [userAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.mas_equalTo(superView);
        make.size.mas_equalTo(superView).sizeOffset(CGSizeMake(-40, -40));
    }];
    userAvatarImageView.layer.cornerRadius  = (userProfileViewUpper.frame.size.height - 40) / 2;
    userAvatarImageView.clipsToBounds = YES;
}

- (void)setLabel {
    UIView *userProfileViewUpper = [self.view viewWithTag:1];
    CGRect rect = CGRectMake(userProfileViewUpper.frame.size.height, userProfileViewUpper.frame.origin.y, userProfileViewUpper.frame.size.width - userProfileViewUpper.frame.size.height, userProfileViewUpper.frame.size.height/2);
    UIView *superView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:superView];
    
    UILabel *fanTicketCountLabel = [[UILabel alloc] init];
    UILabel *fanTicketCountDescriptionLabel = [[UILabel alloc] init];
    [superView addSubview:fanTicketCountDescriptionLabel];
    [superView addSubview:fanTicketCountLabel];
    fanTicketCountLabel.text = @"77777";
    fanTicketCountLabel.tag = 4;
    fanTicketCountDescriptionLabel.text = @"火力";
    fanTicketCountLabel.font = [UIFont systemFontOfSize:20];
    fanTicketCountDescriptionLabel.textColor = [UIColor scrollViewTexturedBackgroundColor];
    fanTicketCountDescriptionLabel.font = [UIFont systemFontOfSize:16];
    [fanTicketCountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(superView.mas_top).with.inset(20);
        make.left.mas_equalTo(superView.mas_left).with.inset(superView.frame.size.width * 10 / 15);
    }];
    [fanTicketCountDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(fanTicketCountLabel.mas_bottom).with.inset(5);
        make.left.mas_equalTo(fanTicketCountLabel.mas_left);
    }];
    
    UILabel *followingCountLabel = [[UILabel alloc] init];
    UILabel *followingCountDescriptionLabel = [[UILabel alloc] init];
    [superView addSubview:followingCountDescriptionLabel];
    [superView addSubview:followingCountLabel];
    followingCountLabel.text = @"88888";
    followingCountLabel.tag = 5;
    followingCountDescriptionLabel.text = @"关注";
    followingCountLabel.font = [UIFont systemFontOfSize:20];
    followingCountDescriptionLabel.textColor = [UIColor scrollViewTexturedBackgroundColor];
    followingCountDescriptionLabel.font = [UIFont systemFontOfSize:16];
    [followingCountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(superView.mas_top).with.inset(20);
        make.left.mas_equalTo(superView.mas_left).with.inset(superView.frame.size.width * 11 / 30);
    }];
    [followingCountDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(followingCountLabel.mas_bottom).with.inset(5);
        make.left.mas_equalTo(followingCountLabel.mas_left);
    }];
    
    UILabel *followerCountLabel = [[UILabel alloc] init];
    UILabel *followerCountDescriptionLabel = [[UILabel alloc] init];
    [superView addSubview:followerCountDescriptionLabel];
    [superView addSubview:followerCountLabel];
    followerCountLabel.text = @"99999";
    followerCountLabel.tag = 6;
    followerCountDescriptionLabel.text = @"粉丝";
    followerCountLabel.font = [UIFont systemFontOfSize:20];
    followerCountDescriptionLabel.textColor = [UIColor scrollViewTexturedBackgroundColor];
    followerCountDescriptionLabel.font = [UIFont systemFontOfSize:16];
    [followerCountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(superView.mas_top).with.inset(20);
        make.left.mas_equalTo(superView.mas_left).with.inset(superView.frame.size.width * 1 / 15);
    }];
    [followerCountDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(followerCountLabel.mas_bottom).with.inset(5);
        make.left.mas_equalTo(followerCountLabel.mas_left);
    }];

}

- (void)setButton {
    UIView *userProfileViewUpper = [self.view viewWithTag:1];
    CGRect rect = CGRectMake(userProfileViewUpper.frame.size.height, userProfileViewUpper.frame.origin.y + userProfileViewUpper.frame.size.height / 2, userProfileViewUpper.frame.size.width - userProfileViewUpper.frame.size.height, userProfileViewUpper.frame.size.height / 2);
    UIView *superView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:superView];
    CGFloat UIButtonHeightFloat = userProfileViewUpper.frame.size.height / 2;
    UIBorderButton *editButton = [UIBorderButton buttonWithType:UIButtonTypeRoundedRect];
    editButton.cornerRadius = (UIButtonHeightFloat - 35) / 2;
    editButton.borderWidth = 1;
    editButton.borderColor = [UIColor redColor];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    editButton.tintColor = [UIColor redColor];
    [superView addSubview:editButton];
    [editButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_equalTo(superView.mas_bottom).with.inset(10);
        make.size.mas_equalTo(superView).sizeOffset(CGSizeMake(-40, -35));
        make.centerX.mas_equalTo(superView);
    }];
    [editButton addTarget:self action:@selector(editUserProfile) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setBadge {
    UIView *userProfileViewLower = [self.view viewWithTag:2];
    CGRect rect = CGRectMake(0, userProfileViewLower.frame.origin.y, userProfileViewLower.frame.size.width, userProfileViewLower.frame.size.height / 4);
    UIView *superView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:superView];
    UIImageView *badgeImageView = [[UIImageView alloc] init];
    [superView addSubview:badgeImageView];
    [badgeImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.left.mas_equalTo(superView.mas_left).with.inset(20);
        make.top.mas_equalTo(superView.mas_top).with.inset(4);
    }];
    badgeImageView.image = [UIImage imageNamed:@"iconVHotsoon"];
    
    UILabel *badgeLabel = [[UILabel alloc] init];
    badgeLabel.text = @"badge description";
    badgeLabel.tag = 7;
    badgeLabel.font = [UIFont systemFontOfSize:18];
    [superView addSubview:badgeLabel];
    [badgeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(badgeImageView);
        make.left.mas_equalTo(badgeImageView.mas_right).with.inset(3);
    }];
}

- (void)setLocation {
    UIView *userProfileViewLower = [self.view viewWithTag:2];
    CGRect rect = CGRectMake(0, userProfileViewLower.frame.origin.y + userProfileViewLower.frame.size.height / 4, userProfileViewLower.frame.size.width, userProfileViewLower.frame.size.height / 4);
    UIView *superView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:superView];
    UIImageView *locationImageView = [[UIImageView alloc] init];
    [superView addSubview:locationImageView];
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.left.mas_equalTo(superView.mas_left).with.inset(20);
        make.bottom.mas_equalTo(superView.mas_bottom).inset(4);
    }];
    locationImageView.image = [UIImage imageNamed:@"iconLocation"];

    
    UILabel *locationLabel = [[UILabel alloc] init];
    locationLabel.text = @"location";
    locationLabel.tag = 8;
    locationLabel.font = [UIFont systemFontOfSize:18];
    [superView addSubview:locationLabel];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(locationImageView);
        make.left.mas_equalTo(locationImageView.mas_right).with.inset(3);;
    }];
    
    UILabel *ageLabel = [[UILabel alloc] init];
    ageLabel.text = @"age description";
    ageLabel.tag = 9;
    ageLabel.font = [UIFont systemFontOfSize:18];
    [superView addSubview:ageLabel];
    [ageLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(locationImageView);
        make.left.mas_equalTo(locationLabel.mas_right).with.inset(15);
    }];
}

- (void)setDescriptionTextView {
    UIView *userProfileViewLower = [self.view viewWithTag:2];
    CGRect rect = CGRectMake(0, userProfileViewLower.frame.origin.y + userProfileViewLower.frame.size.height / 2, userProfileViewLower.frame.size.width, userProfileViewLower.frame.size.height / 2);
    UIView *superView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:superView];
    UITextView *signatureTextView = [[UITextView alloc] init];
    [superView addSubview:signatureTextView];
    [signatureTextView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(superView).sizeOffset(CGSizeMake(-30, -10));
        make.top.mas_equalTo(superView.mas_top);
        make.centerX.mas_equalTo(superView);
    }];
    signatureTextView.text = @"To be edited. To be edited. To be edited. To be edited. To be edited. To be edited. ";
    signatureTextView.tag = 10;
    signatureTextView.textColor = [UIColor scrollViewTexturedBackgroundColor];
    signatureTextView.font = [UIFont systemFontOfSize:16];
}

- (void)setCollectionView {
    // magic height
    CGFloat userProfileOffset = self.navigationController.navigationBar.frame.size.height;
    CGFloat collectionViewHeightFloat = self.view.frame.size.height * 0.7 - userProfileOffset;
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, collectionViewHeightFloat);
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[self collectionLayout]];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.bounces = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo([self.view viewWithTag:2].mas_bottom);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, collectionViewHeightFloat));
    }];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
}

- (UICollectionViewFlowLayout *)collectionLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return layout;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.cellInsetInt;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.cellInsetInt;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel.videoModelArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    [self.viewModel collectionViewCell:cell loadVideoCoverAtIndexPath:indexPath];
    [self setLikeCountWithCell:cell AtIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidthNumber = (self.view.frame.size.width - self.cellInsetInt * 2) / 3;
    CGFloat cellHeightNumber = cellWidthNumber / 3 * 4;
    return CGSizeMake(cellWidthNumber, cellHeightNumber);
}

- (void)setLikeCountWithCell:(UICollectionViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath {
    UIImageView *likeCountImageView = [[UIImageView alloc] init];
    [cell.contentView addSubview:likeCountImageView];
    [likeCountImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.mas_equalTo(cell.contentView.mas_right).with.inset(40);
        make.bottom.mas_equalTo(cell.contentView.mas_bottom).with.inset(8);
    }];
    likeCountImageView.image = [UIImage imageNamed:@"iconProfileLikeTransparent"];
    UILabel *likeCountLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:likeCountLabel];
    [likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(likeCountImageView);
        make.left.mas_equalTo(likeCountImageView.mas_right).with.inset(2);
    }];
    [self.viewModel label:likeCountLabel loadLikeCountAtIndexPath:indexPath];
    likeCountLabel.font = [UIFont boldSystemFontOfSize:12];
    likeCountLabel.textColor = [UIColor whiteColor];
}

- (void)didLoadLocation:(NSString *)locationString {
    UILabel *locationLabel = [self.view viewWithTag:8];
    locationLabel.text = locationString;
    
    UILabel *ageLabel = [self.view viewWithTag:9];
    [ageLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(locationLabel.mas_right).with.inset(15);
    }];
}

- (void)didSave{
    [self bindViewModel];
}

@end
