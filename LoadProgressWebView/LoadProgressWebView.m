#import "LoadProgressWebView.h"


#pragma mark - interface
@interface UIWebView ()

/* ***** UIWebView Private APIs ***** */
-(id)webView:(id)view identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource;

-(void)webView:(id)view resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource;

-(void)webView:(id)view resource:(id)resource didFailLoadingWithError:(id)error fromDataSource:(id)dataSource;

@end


#pragma mark - implementation
@implementation LoadProgressWebView


#pragma mark - synthesize
@synthesize resourceCount;
@synthesize resourceCompletedCount;
@synthesize progressDelegate;


#pragma mark - initializer


#pragma mark - private api
-(id)webView:(id)view identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource
{
    if ([super respondsToSelector:@selector(webView:identifierForInitialRequest:fromDataSource:)])
    {
        [super webView:view identifierForInitialRequest:initialRequest fromDataSource:dataSource];
    }

    return [NSNumber numberWithInteger:self.resourceCount++];
}

- (void)webView:(id)view resource:(id)resource didFailLoadingWithError:(id)error fromDataSource:(id)dataSource
{
    if ([super respondsToSelector:@selector(webView:resource:didFailLoadingWithError:fromDataSource:)])
    {
        [super webView:view resource:resource didFailLoadingWithError:error fromDataSource:dataSource];
        self.resourceCompletedCount++;
    }

    if ([self.progressDelegate respondsToSelector:@selector(webView:didReceiveResourceNumber:totalResources:)])
    {
        [self.progressDelegate webView:self didReceiveResourceNumber:self.resourceCompletedCount totalResources:self.resourceCount];
    }
}

-(void)webView:(id)view resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource
{
    if ([super respondsToSelector:@selector(webView:resource:didFinishLoadingFromDataSource:)])
    {
        [super webView:view resource:resource didFinishLoadingFromDataSource:dataSource];
        self.resourceCompletedCount++;
    }

    if ([self.progressDelegate respondsToSelector:@selector(webView:didReceiveResourceNumber:totalResources:)])
    {
        [self.progressDelegate webView:self didReceiveResourceNumber:self.resourceCompletedCount totalResources:self.resourceCount];
    }
}

@end
