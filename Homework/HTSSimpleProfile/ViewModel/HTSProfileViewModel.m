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
    subView.image = [UIImage imageNamed:htsvideo.videoUri];
    
    for (int i = 1; i < videoNumber; i++) {
        subView = [UIImageView new];
        [self addSubview:subView];
//        subView.backgroundColor = [UIColor greenColor];
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self);
            make.height.mas_equalTo(userVideoHeight);
            make.width.mas_equalTo(containerSizeWidth);
            make.left.mas_equalTo(lastSubView.mas_right).with.offset(userVideoInterval);
        }];
        lastSubView = subView;
        HTSVideo *htsvideo = [userVideoSubArray objectAtIndex:i];
        subView.image = [UIImage imageNamed:htsvideo.videoUri];
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
