
#import "Kiwi.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "Nocilla.h"

SPEC_BEGIN(NocillaSpec)

// networksetup -setwebproxy "Wi-Fi" 127.0.0.1 12345
// networksetup -setwebproxystate "Wi-Fi" off

it(@"should stub the request", ^{
    [[LSNocilla sharedInstace] start];
    
    stubRequest(@"POST", @"http://localhost:12345/say-hello").
    withHeader(@"Content-Type", @"text/plain; charset=utf8").
    withHeader(@"Cacatuha!!!", @"sisisi").
    andBody(@"caca").
    andReturn(403).
    withHeader(@"Content-Type", @"text/plain").
    withBody(@"Hello World!");
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://localhost:12345/say-hello"]];
    [request addRequestHeader:@"Content-Type" value:@"text/plain; charset=utf8"];
    [request addRequestHeader:@"Cacatuha!!!" value:@"sisisi"];
    [request appendPostData:[[@"caca" dataUsingEncoding:NSUTF8StringEncoding] mutableCopy]];
    
    [request setRequestMethod:@"POST"];
    
    [request startSynchronous];
    
    NSLog(@"%@", request.error);
    NSLog(@"%@", request.responseString);
    NSLog(@"%d", request.responseStatusCode);
    NSLog(@"%@", request.responseHeaders);
});

SPEC_END