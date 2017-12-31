//
//  JSONResponseSerializerWithData.h
//  SAwin
//
//  Created by Shashi Shaw on 07/06/17.
//  Copyright © 2017 SAWIN Service Automation Inc. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

static NSString * const JSONResponseSerializerWithDataKey = @"JSONResponseSerializerWithDataKey";

/*!
 * @brief: In order to read the web service response body in case of errors,
 *         override the default implementation of the response serializer.
 *         Original source: http://blog.gregfiumara.com/archives/239
 */
@interface JSONResponseSerializerWithData : AFJSONResponseSerializer

@end
