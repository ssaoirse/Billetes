//
//  WebServiceController.h
//  Billetes
//
//  Created by Saoirse on 12/31/17.
//  Copyright © 2017 Boletos. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

// forward declaration.
@class AppError;

@interface WebServiceController : AFHTTPSessionManager

// Disabling alloc init.
-(instancetype) __unavailable init;

/*!
 * @brief returns the singleton shared instance.
 * @return The shared instance of the Class.
 */
+(WebServiceController*) sharedInstance;


// GENERIC HTTP GET METHOD.
/*!
 * @brief Performs a generic HTTP GET request for the specified service path,
 * @param  servicePath      The URL service path for the GET request.
 * @param  credentials      The authentication token and the User Id.
 * @param  serviceSuccess   A success block which returns nothing and has a reference to the response.
 * @param  serviceFailure   A failure block which returns the AppError* object.
 */
-(void) performGETForServicePath:(NSString*)servicePath
             withAuthCredentials:(NSDictionary*)credentials
                  serviceSuccess:( void(^)(NSDictionary* httpHeaders, id responseObject) )serviceSuccess
                  serviceFailure:( void(^)(AppError* error) )serviceFailure;

/*!
 * @brief Performs a generic HTTP GET request for the specified service path,
 * @param  servicePath      The URL service path for the GET request.
 * @param  credentials      The authentication token and the User Id.
 * @param  requestHeaders   The additional request headers to be added to the request.
 * @param  serviceSuccess   A success block which returns nothing and has a reference to the response.
 * @param  serviceFailure   A failure block which returns the AppError* object.
 */
-(void) performGETForServicePath:(NSString*)servicePath
             withAuthCredentials:(NSDictionary*)credentials
                  requestHeaders:(NSDictionary*)requestHeaders
                  serviceSuccess:( void(^)(NSDictionary* httpHeaders, id responseObject) )serviceSuccess
                  serviceFailure:( void(^)(AppError* error) )serviceFailure;



// GENERIC HTTP POST METHOD.
/*!
 * @brief Performs a generic HTTP post request for the specified service path, passing a dictionary
 *        which forms the Body of the POST.
 * @param  servicePath      The URL service path for the POST request.
 * @param  input            The input JSON dictionary which will be used as BODY for the POST request.
 * @param  credentials      The authentication token and the User Id.
 * @param  serviceSuccess   A success block which returns nothing and has a reference to the response.
 * @param  serviceFailure   A failure block which returns the SAwinError* object.
 */
-(void) performPOSTForServicePath:(NSString*)servicePath
              withInputParameters:(id)input
                  authCredentials:(NSDictionary*)credentials
                   serviceSuccess:( void(^)(NSDictionary* httpHeaders, id responseObject) )serviceSuccess
                   serviceFailure:( void(^)(AppError* error) )serviceFailure;

/*!
 * @brief Performs a generic HTTP post request for the specified service path, passing a dictionary
 *        which forms the Body of the POST.
 * @param  servicePath      The URL service path for the POST request.
 * @param  input            The input JSON dictionary which will be used as BODY for the POST request.
 * @param  serviceSuccess   A success block which returns nothing and has a reference to the response.
 * @param  serviceFailure   A failure block which returns the SAwinError* object.
 */
-(void) performPOSTForServicePath:(NSString*)servicePath
              withInputParameters:(id)input
                   serviceSuccess:( void(^)(NSDictionary* httpHeaders, id responseObject) )serviceSuccess
                   serviceFailure:( void(^)(AppError* error) )serviceFailure;

// GENERIC PUT:

/*!
 * @brief Performs a generic HTTP PUT request for the specified service path, passing a dictionary
 *        which forms the Body of the PUT.
 * @param  servicePath      The URL service path for the PUT request.
 * @param  input            The input JSON dictionary which will be used as BODY for the PUT request.
 * @param  credentials      The authentication token and the User Id.
 * @param  serviceSuccess   A success block which returns nothing and has a reference to the response.
 * @param  serviceFailure   A failure block which returns the AppError* object.
 */
-(void) performPUTForServicePath:(NSString*)servicePath
             withInputParameters:(id)input
                 authCredentials:(NSDictionary*)credentials
                  serviceSuccess:( void(^)(NSDictionary* httpHeaders, id responseObject) )serviceSuccess
                  serviceFailure:( void(^)(AppError* error) )serviceFailure;


// GENERIC HTTP DELETE METHOD.

/*!
 * @brief Performs a generic HTTP DELETE request for the specified service path,
 * @param  servicePath      The URL service path for the DELETE request.
 * @param  credentials      The authentication token and the User Id.
 * @param  serviceSuccess   A success block which returns nothing and has a reference to the response.
 * @param  serviceFailure   A failure block which returns the SAwinError* object.
 */

-(void) performDELETEForServicePath:(NSString*)servicePath
                withAuthCredentials:(NSDictionary*)credentials
                     serviceSuccess:( void(^)(id responseObject) )serviceSuccess
                     serviceFailure:( void(^)(AppError* error) )serviceFailure;

/*!
 * @brief Downloads the file at the remote URL and saves it to specified location on disk.
 * @param  urlPath          The URL of the remote file.
 * @param  saveToPath       The location on disk where file will be written.
 * @param  completionBlock  A completion block with the URLResponse and an NSError object.
 */
-(void) downloadFileFromURLPath:(NSString*)urlPath
                  andSaveToPath:(NSString*)saveToPath
            withCompletionBlock:( void(^)(NSURLResponse *response, NSError *error) )completionBlock;
@end
