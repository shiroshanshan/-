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

@synthesize viewHeightFloat;
@synthesize viewWidthFloat;
@synthesize cellIntervalInt;
@synthesize userProfileUpperInset;
@synthesize userProfileViewUpper;
@synthesize userProfileViewLower;
@synthesize userAvatarImageView;
@synthesize fanTicketCountLabel;
@synthesize followingCountLabel;
@synthesize followerCountLabel;
@synthesize editButton;
@synthesize badgeImageView;
@synthesize badgeLabel;
@synthesize locationImageView;
@synthesize locationLabel;
@synthesize ageLabel;
@synthesize signatureTextView;

#pragma mark - Lifecycle

- (instancetype) initWithViewModel : (HTSProfileViewModel *)viewModel {
    self = [super init];
    if (!self) return nil;
    
    self.viewModel = viewModel;
    
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewHeightFloat = self.view.frame.size.height;
    viewWidthFloat = self.view.frame.size.width;
    cellIntervalInt = 3;
    userProfileUpperInset = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.title = @"userProfile";
    
    self.viewModel.delegate = self;
    
    [self loadUserProfile];
    
    [self bindViewModel];
}

#pragma mark - Plotting

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

#pragma mark - Bindings

- (void)bindViewModel {
    self.navigationItem.title = self.viewModel.userModel.nicknameString;
    [self.viewModel loadUserProfileView:self];
}

#pragma mark - Navigation Controlling

- (void)editUserProfile {
    HTSProfileEditViewController *profileEditViewController = [[HTSProfileEditViewController alloc] initWithViewModel:self.viewModel];
    profileEditViewController.delegate = self;
    [self.navigationController pushViewController:profileEditViewController animated:YES];
}

- (void)setSuperView {
    CGRect rect = CGRectMake(0, userProfileUpperInset, viewWidthFloat, viewHeightFloat * 0.15);
    userProfileViewUpper = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:userProfileViewUpper];
    rect = CGRectMake(0, userProfileUpperInset + viewHeightFloat * 0.15, viewWidthFloat, viewHeightFloat * 0.15);
    userProfileViewLower = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:userProfileViewLower];
}

- (void)setAvatar {
    CGRect rect = CGRectMake(0, userProfileViewUpper.frame.origin.y, userProfileViewUpper.frame.size.height, userProfileViewUpper.frame.size.height);
    UIView *superView = [[UIView alloc] initWithFrame:rect];
    userAvatarImageView = [[UIImageView alloc] init];
    [self.view addSubview:superView];
    [self.view addSubview:userAvatarImageView];
    [userAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.mas_equalTo(superView);
        make.size.mas_equalTo(superView).sizeOffset(CGSizeMake(-40, -40));
    }];
    userAvatarImageView.layer.cornerRadius  = (userProfileViewUpper.frame.size.height - 40) / 2;
    userAvatarImageView.clipsToBounds = YES;
}

- (void)setLabel {
    int labelTopInsetInt = 20;
    int labelDescriptionTopInsetInt = 5;
    UIFont *userProfileCountLabelFont = [UIFont systemFontOfSize:20];
    UIFont *userProfileDescriptionLabelFont = [UIFont systemFontOfSize:16];
    UIColor *userProfileDescriptionLabelColor = [UIColor scrollViewTexturedBackgroundColor];
    CGRect rect = CGRectMake(userProfileViewUpper.frame.size.height, userProfileViewUpper.frame.origin.y, userProfileViewUpper.frame.size.width - userProfileViewUpper.frame.size.height, userProfileViewUpper.frame.size.height/2);
    UIView *superView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:superView];
    
    fanTicketCountLabel = [[UILabel alloc] init];
    UILabel *fanTicketCountDescriptionLabel = [[UILabel alloc] init];
    [superView addSubview:fanTicketCountDescriptionLabel];
    [superView addSubview:fanTicketCountLabel];
    fanTicketCountLabel.text = @"77777";
    fanTicketCountDescriptionLabel.text = @"火力";
    fanTicketCountLabel.font = userProfileCountLabelFont;
    fanTicketCountDescriptionLabel.textColor = userProfileDescriptionLabelColor;
    fanTicketCountDescriptionLabel.font = userProfileDescriptionLabelFont;
    [fanTicketCountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(superView.mas_top).with.inset(labelTopInsetInt);
        make.left.mas_equalTo(superView.mas_left).with.inset(superView.frame.size.width * 10 / 15);
    }];
    [fanTicketCountDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self->fanTicketCountLabel.mas_bottom).with.inset(labelDescriptionTopInsetInt);
        make.left.mas_equalTo(self->fanTicketCountLabel.mas_left);
    }];
    
    followingCountLabel = [[UILabel alloc] init];
    UILabel *followingCountDescriptionLabel = [[UILabel alloc] init];
    [superView addSubview:followingCountDescriptionLabel];
    [superView addSubview:followingCountLabel];
    followingCountLabel.text = @"88888";
    followingCountDescriptionLabel.text = @"关注";
    followingCountLabel.font = userProfileCountLabelFont;
    followingCountDescriptionLabel.textColor = userProfileDescriptionLabelColor;
    followingCountDescriptionLabel.font = userProfileDescriptionLabelFont;
    [followingCountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(superView.mas_top).with.inset(labelTopInsetInt);
        make.left.mas_equalTo(superView.mas_left).with.inset(superView.frame.size.width * 11 / 30);
    }];
    [followingCountDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self->followingCountLabel.mas_bottom).with.inset(labelDescriptionTopInsetInt);
        make.left.mas_equalTo(self->followingCountLabel.mas_left);
    }];
    
    followerCountLabel = [[UILabel alloc] init];
    UILabel *followerCountDescriptionLabel = [[UILabel alloc] init];
    [superView addSubview:followerCountDescriptionLabel];
    [superView addSubview:followerCountLabel];
    followerCountLabel.text = @"99999";
    followerCountDescriptionLabel.text = @"粉丝";
    followerCountLabel.font = userProfileCountLabelFont;
    followerCountDescriptionLabel.textColor = userProfileDescriptionLabelColor;
    followerCountDescriptionLabel.font = userProfileDescriptionLabelFont;
    [followerCountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(superView.mas_top).with.inset(labelTopInsetInt);
        make.left.mas_equalTo(superView.mas_left).with.inset(superView.frame.size.width * 1 / 15);
    }];
    [followerCountDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self->followerCountLabel.mas_bottom).with.inset(labelDescriptionTopInsetInt);
        make.left.mas_equalTo(self->followerCountLabel.mas_left);
    }];

}

- (void)setButton {
    UIColor *buttonColor = [UIColor redColor];
    CGRect rect = CGRectMake(userProfileViewUpper.frame.size.height, userProfileViewUpper.frame.origin.y + userProfileViewUpper.frame.size.height / 2, userProfileViewUpper.frame.size.width - userProfileViewUpper.frame.size.height, userProfileViewUpper.frame.size.height / 2);
    UIView *superView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:superView];
    CGFloat editButtonHeightFloat = userProfileViewUpper.frame.size.height / 2;
    editButton = [UIBorderButton buttonWithType:UIButtonTypeRoundedRect];
    editButton.cornerRadius = (editButtonHeightFloat - 35) / 2;
    editButton.borderWidth = 1;
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    editButton.borderColor = buttonColor;
    editButton.tintColor = buttonColor;
    [superView addSubview:editButton];
    [editButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.mas_equalTo(superView.mas_bottom).with.inset(10);
        make.size.mas_equalTo(superView).sizeOffset(CGSizeMake(-40, -35));
        make.centerX.mas_equalTo(superView);
    }];
    [editButton addTarget:self action:@selector(editUserProfile) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setBadge {
    int iconSizeInt = 22;
    int iconLeftInsetInt = 20;
    int iconUpInsetInt = 4;
    UIFont *badgeLabelFont = [UIFont systemFontOfSize:18];
    CGRect rect = CGRectMake(0, userProfileViewLower.frame.origin.y, userProfileViewLower.frame.size.width, userProfileViewLower.frame.size.height / 4);
    UIView *superView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:superView];
    badgeImageView = [[UIImageView alloc] init];
    [superView addSubview:badgeImageView];
    [badgeImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(iconSizeInt, iconSizeInt));
        make.left.mas_equalTo(superView.mas_left).with.inset(iconLeftInsetInt);
        make.top.mas_equalTo(superView.mas_top).with.inset(iconUpInsetInt);
    }];
    badgeImageView.image = [UIImage imageNamed:@"iconVHotsoon"];
    
    badgeLabel = [[UILabel alloc] init];
    badgeLabel.text = @"badge description";
    badgeLabel.font = badgeLabelFont;
    [superView addSubview:badgeLabel];
    [badgeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(self->badgeImageView);
        make.left.mas_equalTo(self->badgeImageView.mas_right).with.inset(3);
    }];
}

- (void)setLocation {
    int iconSizeInt = 22;
    int iconLeftInsetInt = 20;
    int iconUpInsetInt = 4;
    int locationLabelLeftInsetInt = 3;
    int ageLabelLeftInsetInt = 15;
    UIFont *locationLabelFont = [UIFont systemFontOfSize:18];
    CGRect rect = CGRectMake(0, userProfileViewLower.frame.origin.y + userProfileViewLower.frame.size.height / 4, userProfileViewLower.frame.size.width, userProfileViewLower.frame.size.height / 4);
    UIView *superView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:superView];
    locationImageView = [[UIImageView alloc] init];
    [superView addSubview:locationImageView];
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(iconSizeInt, iconSizeInt));
        make.left.mas_equalTo(superView.mas_left).with.inset(iconLeftInsetInt);
        make.bottom.mas_equalTo(superView.mas_bottom).inset(iconUpInsetInt);
    }];
    locationImageView.image = [UIImage imageNamed:@"iconLocation"];

    locationLabel = [[UILabel alloc] init];
    locationLabel.text = @"location";
    locationLabel.font = locationLabelFont;
    [superView addSubview:locationLabel];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(self->locationImageView);
        make.left.mas_equalTo(self->locationImageView.mas_right).with.inset(locationLabelLeftInsetInt);;
    }];
    
    ageLabel = [[UILabel alloc] init];
    ageLabel.text = @"age description";
    ageLabel.font = locationLabelFont;
    [superView addSubview:ageLabel];
    [ageLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(self->locationImageView);
        make.left.mas_equalTo(self->locationLabel.mas_right).with.inset(ageLabelLeftInsetInt);
    }];
}

- (void)setDescriptionTextView {
    int signatureHeightOffSetInt = -10;
    int signatureWidthOffSetInt = -30;
    UIFont *signatureFont = [UIFont systemFontOfSize:16];
    UIColor *signatureColor = [UIColor scrollViewTexturedBackgroundColor];
    CGRect rect = CGRectMake(0, userProfileViewLower.frame.origin.y + userProfileViewLower.frame.size.height / 2, userProfileViewLower.frame.size.width, userProfileViewLower.frame.size.height / 2);
    UIView *superView = [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:superView];
    signatureTextView = [[UITextView alloc] init];
    [superView addSubview:signatureTextView];
    [signatureTextView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(superView).sizeOffset(CGSizeMake(signatureWidthOffSetInt, signatureHeightOffSetInt));
        make.top.mas_equalTo(superView.mas_top);
        make.centerX.mas_equalTo(superView);
    }];
    signatureTextView.text = @"To be edited. To be edited. To be edited. To be edited. To be edited. To be edited. ";
    signatureTextView.textColor = signatureColor;
    signatureTextView.font = signatureFont;
}

- (void)setCollectionView {
    CGFloat collectionViewHeightFloat = 0.71 * (viewHeightFloat - userProfileUpperInset);
    CGRect rect = CGRectMake(0, 0, viewWidthFloat, collectionViewHeightFloat);
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[self collectionLayout]];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.bounces = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(self->userProfileViewLower.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(self->viewWidthFloat, collectionViewHeightFloat));
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
    
    return cellIntervalInt;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return cellIntervalInt;
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
    CGFloat cellWidthNumber = (viewWidthFloat - cellIntervalInt * 2) / 3;
    CGFloat cellHeightNumber = cellWidthNumber / 3 * 4;
    
    return CGSizeMake(cellWidthNumber, cellHeightNumber);
}

- (void)setLikeCountWithCell:(UICollectionViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath {
    int likeIconSize = 20;
    int likeIconButtomInset = 8;
    int likeIconRightInset = 40;
    int likeCountLeftInset = 1;
    UIFont *likeCountFont = [UIFont boldSystemFontOfSize:12];
    UIColor *likeCountColor = [UIColor whiteColor];
    UIImageView *likeCountImageView = [[UIImageView alloc] init];
    [cell.contentView addSubview:likeCountImageView];
    [likeCountImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(likeIconSize, likeIconSize));
        make.right.mas_equalTo(cell.contentView.mas_right).with.inset(likeIconRightInset);
        make.bottom.mas_equalTo(cell.contentView.mas_bottom).with.inset(likeIconButtomInset);
    }];
    likeCountImageView.image = [UIImage imageNamed:@"iconProfileLikeTransparent"];
    UILabel *likeCountLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:likeCountLabel];
    [likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(likeCountImageView);
        make.left.mas_equalTo(likeCountImageView.mas_right).with.inset(likeCountLeftInset);
    }];
    [self.viewModel label:likeCountLabel loadLikeCountAtIndexPath:indexPath];
    likeCountLabel.font = likeCountFont;
    likeCountLabel.textColor = likeCountColor;
}

- (void)didLoadLocation:(NSString *)locationString {
    locationLabel.text = locationString;
    
    [ageLabel mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self->locationLabel.mas_right).with.inset(15);
    }];
}

- (void)didSave{
    [self bindViewModel];
}

@end
