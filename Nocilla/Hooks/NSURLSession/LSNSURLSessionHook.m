//
//  LSNSURLSessionHook.m
//  Nocilla
//
//  Created by Luis Solano Bonet on 08/01/14.
//  Copyright (c) 2014 Luis Solano Bonet. All rights reserved.
//

#import "LSNSURLSessionHook.h"
#import "LSHTTPStubURLProtocol.h"
#import <objc/runtime.h>

IMP originalProtocolClassesImplementation = nil;

@implementation LSNSURLSessionHook

- (void)load {
    Class cls = NSClassFromString(@"__NSCFURLSessionConfiguration") ?: NSClassFromString(@"NSURLSessionConfiguration");
    
    SEL selector = @selector(protocolClasses);
    Method originalMethod = class_getInstanceMethod(cls, selector);
    Method stubMethod = class_getInstanceMethod([self class], selector);
    IMP stubImplementation = method_getImplementation(stubMethod);
    originalProtocolClassesImplementation = method_getImplementation(originalMethod);
    method_setImplementation(originalMethod, stubImplementation);
}

- (void)unload {
    if (originalProtocolClassesImplementation == nil){
        return;
    }
    
    Class cls = NSClassFromString(@"__NSCFURLSessionConfiguration") ?: NSClassFromString(@"NSURLSessionConfiguration");
    
    SEL selector = @selector(protocolClasses);
    Method originalMethod = class_getInstanceMethod(cls, selector);
    method_setImplementation(originalMethod, originalProtocolClassesImplementation);
}

- (NSArray *)protocolClasses {
    return @[[LSHTTPStubURLProtocol class]];
}


@end
