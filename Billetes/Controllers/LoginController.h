//
//  LoginController.h
//  Billetes
//
//  Created by Saoirse on 12/31/17.
//  Copyright © 2017 Boletos. All rights reserved.
//

#import <Foundation/Foundation.h>

// forward declaration.
@class AppError;

/*!
 * @brief Class to perform login for users.
 */
@interface LoginController : NSObject

/*!
 * @brief Performs user login.
 * @param  email                The email entered in the Username/Email field
 * @param  password             The password for the User.
 * @param  success              The completion block to handle success. Returns the response JSON dictionary on success.
 * @param  failure              The completion block to handle failure. Passes the received Error object.
 */
-(void) loginUserWithEmail:(NSString*)email
                  password:(NSString*)password
               withSuccess:( void(^)(id responseObject) )success
                   failure:( void(^)(AppError* error) )failure;

/*!
 * @brief Performs user logout with success failure..
 * @param  success              The completion block to handle success. Returns the response JSON dictionary on success.
 * @param  failure              The completion block to handle failure. Passes the received Error object.
 */
-(void) logoutwithSuccess:( void(^)(id responseObject) )success
                  failure:( void(^)(AppError* error) )failure;
@end

