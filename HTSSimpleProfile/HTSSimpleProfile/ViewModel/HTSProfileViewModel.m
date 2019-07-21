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

@synthesize loadThroughInternet;
@synthesize userModel;
@synthesize videoModelArray;

#pragma mark - Lifecycle

- (instancetype) initWithModels:(NSDictionary *)modelsDictionary throughInternet:(BOOL)InternetSwitch {
    self = [super init];
    if (!self) return nil;
    
    loadThroughInternet = InternetSwitch;
    
    if (!loadThroughInternet) {
        userModel = [self constructUserModelFromLocalJSON:[[NSBundle mainBundle] pathForResource:modelsDictionary[@"localUserModelString"] ofType:@"json"]];
        videoModelArray = [self constructVideoModelArrayFromLocalJSON:[[NSBundle mainBundle] pathForResource:modelsDictionary[@"localVideoModelString"] ofType:@"json"]];
    } else {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

        NSURL *URL = [NSURL URLWithString:modelsDictionary[@"remoteUserModelString"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];

        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            NSLog(@"File downloaded to: %@", filePath);
            self->userModel = [self constructUserModelFromLocalJSON:[filePath path]];
            if ([self.delegate respondsToSelector:@selector(bindViewModel)]) {
                [self.delegate bindViewModel];
            }
        }];
        [downloadTask resume];
        
        URL = [NSURL URLWithString:modelsDictionary[@"remoteVideoModelString"]];
        request = [NSURLRequest requestWithURL:URL];
        
        downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            NSLog(@"File downloaded to: %@", filePath);
            self->videoModelArray = [self constructVideoModelArrayFromLocalJSON:[filePath path]];
            if ([self.delegate respondsToSelector:@selector(setCollectionView)]) {
                [self.delegate setCollectionView];
            }
        }];
        [downloadTask resume];
    }
    
    return self;
}

#pragma mark - Load user model json

- (HTSUserModel *)constructUserModelFromLocalJSON: (NSString *)userJSONFilePathString {
    NSError *error = nil;
    NSString *JSONString = [[NSString alloc] initWithContentsOfFile:userJSONFilePathString encoding:NSUTF8StringEncoding error: &error];
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *userModelDictionary = (NSDictionary*) [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&error];
    HTSUserModel *userModel = [MTLJSONAdapter modelOfClass:[HTSUserModel class] fromJSONDictionary:userModelDictionary error: &error];
    
    return userModel;
}

#pragma mark - load video model json

- (NSMutableArray *)constructVideoModelArrayFromLocalJSON: (NSString *)videoJSONFilePathString {
    NSError *error = nil;
    NSString *JSONString = [[NSString alloc] initWithContentsOfFile:videoJSONFilePathString encoding:NSUTF8StringEncoding error: &error];
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *videoDictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&error];
    NSArray *videoArray = [videoDictionary objectForKey:@"data"];
    NSMutableArray *videoModelArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < videoArray.count; i++){
        HTSVideoModel *videoModel = [[HTSVideoModel alloc] init];
        videoModel = [MTLJSONAdapter modelOfClass:[HTSVideoModel class] fromJSONDictionary:[videoArray objectAtIndex:i] error:&error];
        [videoModelArray addObject:videoModel];
    }
    return videoModelArray;
}

#pragma mark - Collection view cell

- (void)collectionViewCell:(UICollectionViewCell *)cell loadVideoCoverAtIndexPath:(NSIndexPath *)indexPath {
    HTSVideoModel *videoModel = [videoModelArray objectAtIndex:(int)indexPath.row];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    if (!loadThroughInternet) {
        imageView.image = [UIImage imageNamed:videoModel.videoUriString];
    } else {
        [imageView sd_setImageWithURL:[NSURL URLWithString:videoModel.videoUriString] placeholderImage:[UIImage imageNamed:@"cat"]];
    }
    [cell.contentView addSubview:imageView];
}

- (void)label:(UILabel *)likeCountLabel loadLikeCountAtIndexPath:(NSIndexPath *)indexPath {
    HTSVideoModel *videoModel = [videoModelArray objectAtIndex:(int)indexPath.row];
    
    likeCountLabel.text = [videoModel.digCountNumber stringValue];
}

#pragma mark - Update view controller

- (void)loadUserProfileView:(HTSProfileViewController *) userProfileViewController {
    UIImageView *userAvatarImageView = userProfileViewController.userAvatarImageView;
    if (!loadThroughInternet) {
        userAvatarImageView.image = [UIImage imageNamed:userModel.avatarJpgUriString];
    } else {
        [userAvatarImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatarJpgUriString] placeholderImage:[UIImage imageNamed:@"cat"]];
    }
    
    UILabel *fanTicketCountLabel = userProfileViewController.fanTicketCountLabel;
    fanTicketCountLabel.text = [userModel.fanTicketCountNumber stringValue];
    
    UILabel *followingCountLabel = userProfileViewController.followingCountLabel;
    followingCountLabel.text = [userModel.followingCountNumber stringValue];
    
    UILabel *followerCountLabel = userProfileViewController.followerCountLabel;
    followerCountLabel.text = [userModel.followerCountNumber stringValue];
    
    UILabel *badgeLabel = userProfileViewController.badgeLabel;
    badgeLabel.text = userModel.payGradeBannerString;

    if ([self.delegate respondsToSelector:@selector(didLoadLocation:)]) {
        [self.delegate didLoadLocation:userModel.cityString];
    } else {
        NSLog(@"%@", userModel.cityString);
    }

    UILabel *ageLabel = userProfileViewController.ageLabel;
    ageLabel.text = userModel.birthdayDescriptionString;
    
    UITextView *signatureLabel = userProfileViewController.signatureTextView;
    signatureLabel.text = userModel.signatureString;
}

@end
