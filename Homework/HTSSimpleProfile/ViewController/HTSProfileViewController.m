//
//  HTSProfileViewController.m
//  Homework
//
//  Created by ハン・エンショウ on 2019/07/06.
//  Copyright © 2019 fan. All rights reserved.
//

#import "HTSProfileViewController.h"
#import "HTSProfileViewModel.h"

@interface HTSProfileViewController ()

@property (nonatomic) int userVideoHeight;
@property (nonatomic) int userVideoInterval;
@property (nonatomic) int userVideoNumber;
@property (nonatomic) int row;
@property (nonatomic) int column;

@property (strong, nonatomic) NSArray *userVideos;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UINavigationBar *nickname;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *fanTicketCount;
@property (weak, nonatomic) IBOutlet UILabel *gradeBanner;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *birthdayDescription;
@property (weak, nonatomic) IBOutlet UITextView *signature;
@property (weak, nonatomic) IBOutlet UIImageView *gradeIconUri;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@end

@implementation HTSProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // definition
    self.userVideoHeight = 180;
    self.userVideoInterval = 5;
    self.userVideoNumber = 9;
    self.column = 3;
    self.row = self.userVideoNumber / self.column;
    if (self.userVideoNumber % self.column != 0){
        self.row += 1;
    }
    
    //load user model data
    NSError *error = nil;
    NSDictionary *userDictionary;
    userDictionary = [HTSUserModel loadUserJSONFile];
    HTSUserModel *usermodel = [MTLJSONAdapter modelOfClass:[HTSUserModel class] fromJSONDictionary:userDictionary error: &error];
    self.nickname.topItem.title = usermodel.nickname;
    self.followerCount.text = [usermodel.followerCount stringValue];
    self.followingCount.text = [usermodel.followingCount stringValue];
    self.fanTicketCount.text = [usermodel.fanTicketCount stringValue];
    self.gradeBanner.text = usermodel.payGradeBanner;
    self.city.text = usermodel.city;
    self.birthdayDescription.text = usermodel.birthdayDescription;
    self.signature.text = usermodel.signature;
    [self.gradeIconUri sd_setImageWithURL:[NSURL URLWithString:usermodel.gradeIconUri]
               placeholderImage:[UIImage imageNamed:@"cat.jpg"]];
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:usermodel.avatarJpgUri]
                         placeholderImage:[UIImage imageNamed:@"cat.jpg"]];
//    self.gradeIconUri.image = [UIImage imageNamed:usermodel.gradeIconUri];
//    self.avatarImage.image = [UIImage imageNamed:usermodel.avatarJpgUri];
    self.avatarImage.layer.cornerRadius  = self.avatarImage.frame.size.width/2;
    self.avatarImage.clipsToBounds = YES;
    
    //load video model data
    NSDictionary *videoDictionary;
    videoDictionary = [HTSVideoModel loadVideoJSONFile];
    NSArray *videoArray;
    videoArray = [videoDictionary objectForKey:@"data"];
    NSMutableArray *videoModelArray = [HTSVideoModel convertToVideoModelFromArray:videoArray];
    
    // construct sub view and container.
    UIScrollView *sv = [UIScrollView new];
    sv.tag = 1;
    sv.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.signature.mas_bottom);
        make.height.mas_equalTo(self.userVideoHeight*self.row+self.userVideoInterval*(self.row-1));
    }];
    NSArray *sliceVideoArray = [videoModelArray subarrayWithRange:NSMakeRange(0, 3)];
    [sv fillViewWith:self.row Containers:sliceVideoArray OfHeight:self.userVideoHeight AndInterval:self.userVideoInterval];
    for (UIView *container in sv.subviews) {
        [container fillRowWith:self.column SubView:sliceVideoArray OfHeight:self.userVideoHeight AndInterval:self.userVideoInterval];
    }
    
}

-(void)viewDidLayoutSubviews {
    UIScrollView *sv = [self.view viewWithTag:1];
    [sv setContentSize: CGSizeMake([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)];
    [sv flashScrollIndicators];
}

@end
