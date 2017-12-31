//
//  AppError.h
//  Billetes
//
//  Created by Saoirse on 12/31/17.
//  Copyright © 2017 Boletos. All rights reserved.
//

#import <Foundation/Foundation.h>

/// constants used for Errors.
typedef enum
{
    ERROR_NONE = 1000,
    
    ERROR_BAD_REQUEST = 4000,
    ERROR_RESOURCE_NOT_FOUND,
    
    // Unauthorized, access denied, forbidden.
    ERROR_UNAUTHORIZED = 4010,
    
    // Internal Server Error.
    ERROR_SERVER = 5000,
    
    
    // General error
    ERROR_GENERAL = 10000
    
} AppErrorCode;

/*!
 * @brief Class to encapsulate the error in application.
 */
@interface AppError : NSObject

@property (assign, nonatomic) AppErrorCode errorCode;
@property (copy, nonatomic) NSString* errorDesc;

/*!
 * @brief Initializes a AppError object with the error code and description.
 * @param  code                     The error code for the error.
 * @param  desc                     The description for the error.
 * @return AppError*                An initialized AppError error object.
 */
-(AppError*) initWithErrorCode:(AppErrorCode)code desc:(NSString*)desc;

@end
