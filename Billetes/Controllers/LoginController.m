//
//  LoginController.m
//  Billetes
//
//  Created by Saoirse on 12/31/17.
//  Copyright © 2017 Boletos. All rights reserved.
//

#import "LoginController.h"
#import "AppError.h"
#import "AppUtility.h"
#import "AppConstants.h"
#import "URLConstants.h"
#import "WebServiceController.h"

@implementation LoginController

// Performs User login with Username and Password.
-(void) loginUserWithEmail:(NSString*)email
                  password:(NSString*)password
               withSuccess:( void(^)(id responseObject) )success
                   failure:( void(^)(AppError* error) )failure
{
    // Set the service request with username and password passed in the URL.
    NSString* servicePath = [AppUtility getAbsoluteURLForServicePath:kLoginServicePath];
    
    // Add request parameters.
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    
    // Email
    if(email){
        [params setObject:email forKey:kEmailKey];
    }
    // Password
    if(password){
        [params setObject:password forKey:kPasswordKey];
    }
    
    // Initiate web service call.
    WebServiceController* serviceController = [WebServiceController sharedInstance];
    [serviceController performPOSTForServicePath:servicePath
                             withInputParameters:params
    serviceSuccess:^(NSDictionary *httpHeaders, id responseObject) {
        // TODO: Check validity and update response.
    }
    serviceFailure:^(AppError *error) {
        // TODO: pass error information.
        if(failure){
            failure(error);
        }
        return;
    }];
}


// Perform Logout
-(void) logoutwithSuccess:( void(^)(id responseObject) )success
                  failure:( void(^)(AppError* error) )failure
{
    // TODO:s
    
}


@end
