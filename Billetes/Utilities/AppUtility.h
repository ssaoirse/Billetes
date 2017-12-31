//
//  AppUtility.h
//  Billetes
//
//  Created by Saoirse on 12/31/17.
//  Copyright © 2017 Boletos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtility : NSObject

/*!
 * @brief Returns the absolute URL for the specified service Path. Reads the Server Base URL from Settings.
 @ @param  servicePath                  The relative url service path for the web service.
 * @return NSString*                    The absolute url for the web service.
 */
+ (NSString*) getAbsoluteURLForServicePath:(NSString*)servicePath;

/*!
 * @brief returns the non zero length string object for the specified key from the dictionary, else return nil.
 * @param  key                      The key for the string object.
 * @param  dictionary               The dictionary containing the key value.
 * @return NSString                 A pointer to the string object if found, else nil.
 */
+(NSString*) getValidStringObjectForKey:(NSString*)key
                         fromDictionary:(NSDictionary*)dictionary;
@end
