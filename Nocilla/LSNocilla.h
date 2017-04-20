#import <Foundation/Foundation.h>
#import "Nocilla.h"

@class LSStubRequest;
@class LSStubResponse;
@class LSHTTPClientHook;
@protocol LSHTTPRequest;

extern NSString * const LSUnexpectedRequest;

@interface LSNocilla : NSObject
+ (LSNocilla *)sharedInstance;

@property (nonatomic, strong, readonly) NSArray *stubbedRequests;
@property (nonatomic, assign, readonly, getter = isStarted) BOOL started;
@property (nonatomic, copy) void (^failureHandler)(id<LSHTTPRequest>);

- (void)start;
- (void)stop;
- (void)addStubbedRequest:(LSStubRequest *)request;
- (void)clearStubs;

- (void)resetFailureHandlerToDefault;
- (void)registerHook:(LSHTTPClientHook *)hook;

- (LSStubResponse *)responseForRequest:(id<LSHTTPRequest>)request;
@end
