//
//  UIWebView+LoadProgress.m
//  lama
//
//  Created by mac on 13-4-7.
//  Copyright (c) 2013年 babytree. All rights reserved.
//

#import "UIWebView+LoadProgress.h"
#import <objc/runtime.h>
#import "HLSRuntime.h"
#import "BBTopicDetail.h"


// resourceCount object keys
static void *s_resourceCountKey = &s_resourceCountKey;
// resourceCompletedCount object keys
static void *s_resourceCompletedCountKey = &s_resourceCompletedCountKey;
// oadProgressDelegate object keys
static void *s_loadProgressDelegateKey = &s_loadProgressDelegateKey;

/*
 -(id)webView:(id)view identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource;
 
 -(void)webView:(id)view resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource;
 
 -(void)webView:(id)view resource:(id)resource didFailLoadingWithError:(id)error fromDataSource:(id)dataSource;
 */

// Original implementation of the methods we swizzle
static id (*s_UIWebView__identifierForInitialRequest_Imp)(id, SEL, id, id, id) = NULL;
static void (*s_UIWebView__didFinishLoadingFromDataSource_Imp)(id, SEL, id, id, id) = NULL;
static void (*s_UIWebView__didFailLoadingWithError_Imp)(id, SEL, id, id, id, id) = NULL;

// Swizzled method implementations
static id swizzled_UIWebView__identifierForInitialRequest_Imp(UIWebView *self, SEL _cmd, id webView, id initialRequest, id dataSource);
static void swizzled_UIWebView__didFinishLoadingFromDataSource_Imp(UIWebView *self, SEL _cmd, id webView, id resource, id dataSource);
static void swizzled_UIWebView__didFailLoadingWithError_Imp(UIWebView *self, SEL _cmd, id webView, id resource, id error, id dataSource);

@implementation UIWebView (LoadProgress)
@dynamic resourceCount;
@dynamic resourceCompletedCount;
@dynamic loadProgressDelegate;


+ (void)load
{
    s_UIWebView__identifierForInitialRequest_Imp = (id (*)(id, SEL, id, id, id))HLSSwizzleSelector(self, @selector(webView:identifierForInitialRequest:fromDataSource:), (IMP)swizzled_UIWebView__identifierForInitialRequest_Imp);

    s_UIWebView__didFinishLoadingFromDataSource_Imp = (void (*)(id, SEL, id, id, id))HLSSwizzleSelector(self, @selector(webView:resource:didFinishLoadingFromDataSource:), (IMP)swizzled_UIWebView__didFinishLoadingFromDataSource_Imp);

    s_UIWebView__didFailLoadingWithError_Imp = (void (*)(id, SEL, id, id, id, id))HLSSwizzleSelector(self, @selector(webView:resource:didFailLoadingWithError:fromDataSource:), (IMP)swizzled_UIWebView__didFailLoadingWithError_Imp);
}

#pragma mark Accessors and mutators

- (NSInteger)resourceCount
{
    NSNumber *resourceCountNumber = objc_getAssociatedObject(self, s_resourceCountKey);
    if (! resourceCountNumber)
    {
        return 0;
    }
    else
    {
        return [resourceCountNumber integerValue];
    }
}

- (void)setResourceCount:(NSInteger)rCount
{
    objc_setAssociatedObject(self, s_resourceCountKey, [NSNumber numberWithInteger:rCount], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)resourceCompletedCount
{
    NSNumber *resourceCompletedCountNumber = objc_getAssociatedObject(self, s_resourceCompletedCountKey);
    if (! resourceCompletedCountNumber)
    {
        return 0;
    }
    else
    {
        return [resourceCompletedCountNumber integerValue];
    }
}

- (void)setResourceCompletedCount:(NSInteger)rCCount
{
    objc_setAssociatedObject(self, s_resourceCompletedCountKey, [NSNumber numberWithInteger:rCCount], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id <UIWebViewLoadProgressDelegate>)loadProgressDelegate
{
    id sloadProgressDelegate = objc_getAssociatedObject(self, s_loadProgressDelegateKey);
    
    if (! sloadProgressDelegate)
    {
        return 0;
    }
    else
    {
        return sloadProgressDelegate;
    }
}

- (void)setLoadProgressDelegate:(id <UIWebViewLoadProgressDelegate>)aDelegate
{
    objc_setAssociatedObject(self, s_loadProgressDelegateKey, aDelegate, OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark Swizzled method implementations

static id swizzled_UIWebView__identifierForInitialRequest_Imp(UIWebView *self, SEL _cmd, id webView, id initialRequest, id dataSource)
{
    (*s_UIWebView__identifierForInitialRequest_Imp)(self, _cmd, webView, initialRequest, dataSource);
    
    [self setResourceCount:self.resourceCount+1];
    
    return [NSNumber numberWithInteger:self.resourceCount];
}

static void swizzled_UIWebView__didFinishLoadingFromDataSource_Imp(UIWebView *self, SEL _cmd, id webView, id resource, id dataSource)
{
    (*s_UIWebView__didFinishLoadingFromDataSource_Imp)(self, _cmd, webView, resource, dataSource);
    
    [self setResourceCompletedCount:self.resourceCompletedCount+1];
        
    if ([self.loadProgressDelegate respondsToSelector:@selector(webView:didReceiveResourceNumber:totalResources:)])
    {
        [self.loadProgressDelegate webView:self didReceiveResourceNumber:self.resourceCompletedCount totalResources:self.resourceCount];
    }
}

static void swizzled_UIWebView__didFailLoadingWithError_Imp(UIWebView *self, SEL _cmd, id webView, id resource, id error, id dataSource)
{
    (*s_UIWebView__didFailLoadingWithError_Imp)(self, _cmd, webView, resource, error, dataSource);
    
    [self setResourceCompletedCount:self.resourceCompletedCount+1];
    
    if ([self.loadProgressDelegate respondsToSelector:@selector(webView:didReceiveResourceNumber:totalResources:)])
    {
        [self.loadProgressDelegate webView:self didReceiveResourceNumber:self.resourceCompletedCount totalResources:self.resourceCount];
    }
}

@end

