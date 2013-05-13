//
//  UIWebView+UIWebView_LoadProgress.h
//  lama
//
//  Created by mac on 13-4-7.
//  Copyright (c) 2013年 babytree. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIWebViewLoadProgressDelegate;

@interface UIWebView (LoadProgress)

@property (nonatomic, assign) NSInteger resourceCount;
@property (nonatomic, assign) NSInteger resourceCompletedCount;
@property (nonatomic, assign) id <UIWebViewLoadProgressDelegate> loadProgressDelegate;

@end

@protocol UIWebViewLoadProgressDelegate <NSObject>

@optional
- (void)webView:(UIWebView *)webView didReceiveResourceNumber:(NSInteger)resourceNumber totalResources:(NSInteger)totalResource;


@end