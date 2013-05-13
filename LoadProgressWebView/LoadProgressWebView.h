#import <UIKit/UIKit.h>

#pragma mark - class
@class LoadProgressWebView;

#pragma mark - WebViewLoadProgressDelegate
@protocol WebResourceLoadProgressDelegate <NSObject>

@optional
- (void)webView:(LoadProgressWebView *)webView didReceiveResourceNumber:(NSInteger)resourceNumber totalResources:(NSInteger)totalResources;

@end

#pragma mark - interface
@interface LoadProgressWebView : UIWebView
{
}

#pragma mark - property
@property (nonatomic, assign) NSInteger resourceCount;
@property (nonatomic, assign) NSInteger resourceCompletedCount;
@property (nonatomic, assign) IBOutlet id<WebResourceLoadProgressDelegate> progressDelegate;

@end
