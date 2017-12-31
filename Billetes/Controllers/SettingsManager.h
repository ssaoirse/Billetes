//
//  SettingsManager.h
//  Billetes
//
//  Created by Saoirse on 12/31/17.
//  Copyright © 2017 Boletos. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @brief Class to manage persistent storage for app settings and other details.
 */
@interface SettingsManager : NSObject

// Disabling alloc init.
-(instancetype) __unavailable init;

/*!
 * @brief Returns the shared instance of the settings controller.
 * @return  SettingsManager*            Returns a shared instance of the settings controller.
 */
+(SettingsManager*) sharedInstance;

// Stores Basic login information for User.
// LoggedInStatus: YES/NO
@property (copy,nonatomic) NSDictionary* loginInfo;

@end
