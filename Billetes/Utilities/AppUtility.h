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
 * @brief returns the non zero length string object for the specified key from the dictionary, else return nil.
 * @param  key                      The key for the string object.
 * @param  dictionary               The dictionary containing the key value.
 * @return NSString                 A pointer to the string object if found, else nil.
 */
+(NSString*) getValidStringObjectForKey:(NSString*)key
                         fromDictionary:(NSDictionary*)dictionary;
@end
