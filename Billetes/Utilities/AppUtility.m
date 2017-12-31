//
//  AppUtility.m
//  Billetes
//
//  Created by Saoirse on 12/31/17.
//  Copyright © 2017 Boletos. All rights reserved.
//

#import "AppUtility.h"

@implementation AppUtility

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
