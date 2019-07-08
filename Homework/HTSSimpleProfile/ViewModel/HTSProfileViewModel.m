//
//  HTSProfileViewModel.m
//  Homework
//
//  Created by ハン・エンショウ on 2019/07/06.
//  Copyright © 2019 fan. All rights reserved.
//

#import "HTSProfileViewModel.h"

@implementation UIView (HTSProfileViewModel)

-(void)fillRowWith:(NSInteger)videoNumber SubView:(NSArray *)userVideoSubArray OfHeight:(int)userVideoHeight AndInterval:(int)userVideoInterval{
    UIImageView *lastSubView = nil;
    CGFloat containerSizeWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat numberOfVideo = 3;
    containerSizeWidth /= numberOfVideo;
    UIImageView *subView = [UIImageView new];
    [self addSubview:subView];
//    subView.backgroundColor = [UIColor greenColor];
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.bottom.mas_equalTo(self);
        make.height.mas_equalTo(userVideoHeight);
        make.width.mas_equalTo(containerSizeWidth);
    }];
    lastSubView = subView;
    HTSVideo *htsvideo = [userVideoSubArray objectAtIndex:0];
    [subView sd_setImageWithURL:[NSURL URLWithString:htsvideo.videoUri]
               placeholderImage:[UIImage imageNamed:@"cat.jpg"]];
//    subView.image = [UIImage imageNamed:htsvideo.videoUri];
    UIImageView *digCountImage = [UIImageView new];
    [subView addSubview:digCountImage];
    [digCountImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(subView.mas_bottom).with.offset(-10);
        make.right.mas_equalTo(subView.mas_right).with.offset(-40);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    digCountImage.image = [UIImage imageNamed:@"iconProfileLikeTransparent"];
    UILabel *digCount = [UILabel new];
    [subView addSubview:digCount];
    [digCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(subView.mas_bottom).with.offset(-10);
        make.left.mas_equalTo(digCountImage.mas_right).with.offset(0);
    }];
    digCount.text = [htsvideo.digCount stringValue];
    digCount.textColor = [UIColor whiteColor];
    digCount.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16];
    
    for (int i = 1; i < videoNumber; i++) {
        subView = [UIImageView new];
        [self addSubview:subView];
//        subView.backgroundColor = [UIColor greenColor];
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.mas_equalTo(self);
            make.height.mas_equalTo(userVideoHeight);
            make.width.mas_equalTo(containerSizeWidth);
            make.left.mas_equalTo(lastSubView.mas_right).with.offset(userVideoInterval);
        }];
        lastSubView = subView;
        HTSVideo *htsvideo = [userVideoSubArray objectAtIndex:i];
        [subView sd_setImageWithURL:[NSURL URLWithString:htsvideo.videoUri]
                     placeholderImage:[UIImage imageNamed:@"cat.jpg"]];
        //load local image
//        subView.image = [UIImage imageNamed:htsvideo.videoUri];
        UIImageView *digCountImage = [UIImageView new];
        [subView addSubview:digCountImage];
        [digCountImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(subView.mas_bottom).with.offset(-10);
            make.right.mas_equalTo(subView.mas_right).with.offset(-40);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        digCountImage.image = [UIImage imageNamed:@"iconProfileLikeTransparent"];
        UILabel *digCount = [UILabel new];
        [subView addSubview:digCount];
        [digCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(subView.mas_bottom).with.offset(-10);
            make.left.mas_equalTo(digCountImage.mas_right).with.offset(0);
        }];
        digCount.text = [htsvideo.digCount stringValue];
        digCount.textColor = [UIColor whiteColor];
        digCount.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16];
    }
}

-(void)fillViewWith:(NSInteger)containerNumber Containers:(NSArray *)userVideoArray OfHeight:(int)userVideoHeight AndInterval:(int)userVideoInterval{
    UIView *lastContainer = nil;
    UIView *container = [UIView new];
    container.backgroundColor = [UIColor whiteColor];
    [self addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make)
    {make.top.left.bottom.and.right.mas_equalTo(self).with.insets(UIEdgeInsetsMake(userVideoInterval, 0, 0, 0));
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(userVideoHeight);
    }];
    lastContainer = container;
    
    for (int i = 1; i < containerNumber; i++) {
        container = [UIView new];
        [self addSubview:container];
        container.backgroundColor = [UIColor whiteColor];
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lastContainer.mas_bottom).with.offset(userVideoInterval);
            make.left.and.right.mas_equalTo(self);
            make.width.mas_equalTo(self);
            make.height.mas_equalTo(userVideoHeight);
         }];
        lastContainer = container;
    }
}

@end
