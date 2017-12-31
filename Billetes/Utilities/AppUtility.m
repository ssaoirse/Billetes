//
//  AppUtility.m
//  Billetes
//
//  Created by Saoirse on 12/31/17.
//  Copyright © 2017 Boletos. All rights reserved.
//

#import "AppUtility.h"
#import "URLConstants.h"

@implementation AppUtility

// Returns the Absolute URL for a service Path.
+(NSString*) getAbsoluteURLForServicePath:(NSString*)servicePath
{
    NSString* absoluteURL = nil;
    // Performing URL escape encoding for handling spaces.
    NSString* encodedPath = [servicePath stringByAddingPercentEncodingWithAllowedCharacters:
                             [NSCharacterSet URLPathAllowedCharacterSet]];
    absoluteURL = [NSString stringWithFormat:@"%@%@",kServerBaseURL,encodedPath];
    return absoluteURL;
}

// Returns a non-zero length string value for the specified key, else returns nil.
+(NSString*) getValidStringObjectForKey:(NSString*)key
                         fromDictionary:(NSDictionary*)dictionary
{
    if(!(dictionary && [dictionary isKindOfClass:[NSDictionary class]])){
        return nil;
    }
    NSString* strObject = [dictionary objectForKey:key];
    if(strObject && [strObject isKindOfClass:[NSString class]] && [strObject length] > 0){
        return strObject;
    }
    return nil;
}

@end
