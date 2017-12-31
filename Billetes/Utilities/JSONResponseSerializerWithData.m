//
//  JSONResponseSerializerWithData.m
//  SAwin
//
//  Created by Shashi Shaw on 07/06/17.
//  Copyright © 2017 SAWIN Service Automation Inc. All rights reserved.
//

#import "JSONResponseSerializerWithData.h"

@implementation JSONResponseSerializerWithData

// Implementation to override the default implementation for the response serializer.
-(id) responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id JSONObject = [super responseObjectForResponse:response data:data error:error];
    if (*error != nil) {
        NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
        if (data == nil) {
            //			// NOTE: You might want to convert data to a string here too, up to you.
            //userInfo[JSONResponseSerializerWithDataKey] = @"";
            userInfo[JSONResponseSerializerWithDataKey] = [NSData data];
        }
        else {
            //			// NOTE: You might want to convert data to a string here too, up to you.
            //userInfo[JSONResponseSerializerWithDataKey] = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            userInfo[JSONResponseSerializerWithDataKey] = data;
        }
        NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
        (*error) = newError;
    }
    
    return (JSONObject);
}

@end
