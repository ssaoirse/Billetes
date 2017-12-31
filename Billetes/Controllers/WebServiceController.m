//
//  WebServiceController.m
//  Billetes
//
//  Created by Saoirse on 12/31/17.
//  Copyright © 2017 Boletos. All rights reserved.
//

#import "WebServiceController.h"
#import "AppConstants.h"
#import "URLConstants.h"
#import "AppError.h"
#import "AppUtility.h"
#import "JSONResponseSerializerWithData.h"

@implementation WebServiceController

#pragma mark - Public methods.

// The shared instance.
static WebServiceController* sharedInstance = nil;

+(WebServiceController *) sharedInstance
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kServerBaseURL]];
    });
    return sharedInstance;
}

-(instancetype) initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    // Use the overridden response serializer.
    self.responseSerializer = [JSONResponseSerializerWithData serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.requestSerializer setValue:@"application/json; charset=utf-8"
                  forHTTPHeaderField:@"Content-Type"];
    return self;
}


// Generic GET method.
-(void) performGETForServicePath:(NSString*)servicePath
             withAuthCredentials:(NSDictionary*)credentials
                  serviceSuccess:( void(^)(NSDictionary* httpHeaders, id responseObject) )serviceSuccess
                  serviceFailure:( void(^)(AppError* error) )serviceFailure;
{
    // Add Authorization credentials.
    [self addAuthCredentials:credentials];
    
    [self GET:servicePath
   parameters:nil
     progress:nil
      success:^(NSURLSessionDataTask *task, id responseObject) {
          if (serviceSuccess) {
              NSDictionary* responseHeaders = [self getResponseHeadersFromTask:task];
              serviceSuccess(responseHeaders, responseObject);
          }
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          if (serviceFailure) {
              AppError* responseError = [self getResponseErrorFromResponse:task.response error:error];
              serviceFailure(responseError);
          }
      }];
}


// GET Request with Additional Request headers.
-(void) performGETForServicePath:(NSString*)servicePath
             withAuthCredentials:(NSDictionary*)credentials
                  requestHeaders:(NSDictionary*)requestHeaders
                  serviceSuccess:( void(^)(NSDictionary* httpHeaders, id responseObject) )serviceSuccess
                  serviceFailure:( void(^)(AppError* error) )serviceFailure
{
    // Add Authorization credentials.
    [self addAuthCredentials:credentials];
    
    // Add request headers.
    [self addRequestHeaders:requestHeaders];
    
    [self GET:servicePath
   parameters:nil
     progress:nil
      success:^(NSURLSessionDataTask *task, id responseObject) {
          if (serviceSuccess) {
              NSDictionary* responseHeaders = [self getResponseHeadersFromTask:task];
              serviceSuccess(responseHeaders, responseObject);
          }
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          if (serviceFailure) {
              AppError* responseError = [self getResponseErrorFromResponse:task.response error:error];
              serviceFailure(responseError);
          }
      }];
}


// General POST method.
-(void) performPOSTForServicePath:(NSString*)servicePath
              withInputParameters:(id)input
                  authCredentials:(NSDictionary*)credentials
                   serviceSuccess:( void(^)(NSDictionary* httpHeaders, id responseObject) )serviceSuccess
                   serviceFailure:( void(^)(AppError* error) )serviceFailure;
{
    // Add Authorization credentials.
    [self addAuthCredentials:credentials];
    
    [self performPOSTForServicePath:servicePath
                withInputParameters:input
                     serviceSuccess:serviceSuccess
                     serviceFailure:serviceFailure];
}


// Performs HTTP POST.
-(void) performPOSTForServicePath:(NSString*)servicePath
              withInputParameters:(id)input
                   serviceSuccess:( void(^)(NSDictionary* httpHeaders, id responseObject) )serviceSuccess
                   serviceFailure:( void(^)(AppError* error) )serviceFailure;
{
    [self POST:servicePath
    parameters:input
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject) {
           if(serviceSuccess){
               NSDictionary* responseHeaders = [self getResponseHeadersFromTask:task];
               serviceSuccess(responseHeaders, responseObject);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           if (serviceFailure) {
               AppError* responseError = [self getResponseErrorFromResponse:task.response error:error];
               serviceFailure(responseError);
           }
       }];
    
}





// General PUT method.
-(void) performPUTForServicePath:(NSString*)servicePath
             withInputParameters:(id)input
                 authCredentials:(NSDictionary*)credentials
                  serviceSuccess:( void(^)(NSDictionary* httpHeaders, id responseObject) )serviceSuccess
                  serviceFailure:( void(^)(AppError* error) )serviceFailure;
{
    // Add Authorization credentials.
    [self addAuthCredentials:credentials];
    
    [self PUT:servicePath
   parameters:input
      success:^(NSURLSessionDataTask *task, id responseObject) {
          if(serviceSuccess){
              NSDictionary* responseHeaders = [self getResponseHeadersFromTask:task];
              serviceSuccess(responseHeaders, responseObject);
          }
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          if (serviceFailure) {
              AppError* responseError = [self getResponseErrorFromResponse:task.response error:error];
              serviceFailure(responseError);
          }
      }];
}


// Generic DELETE method.
-(void) performDELETEForServicePath:(NSString*)servicePath
                withAuthCredentials:(NSDictionary*)credentials
                     serviceSuccess:( void(^)(id responseObject) )serviceSuccess
                     serviceFailure:( void(^)(AppError* error) )serviceFailure
{
    // Add Authorization credentials.
    [self addAuthCredentials:credentials];
    
    [self DELETE:servicePath
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             if (serviceSuccess) {
                 serviceSuccess(responseObject);
             }
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             if (serviceFailure) {
                 AppError* responseError = [self getResponseErrorFromResponse:task.response error:error];
                 serviceFailure(responseError);
             }
         }];
}


// Download file.
-(void) downloadFileFromURLPath:(NSString*)urlPath
                  andSaveToPath:(NSString*)saveToPath
            withCompletionBlock:( void(^)(NSURLResponse *response, NSError *error) )completionBlock
{
    NSURL *URL = [NSURL URLWithString:urlPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [self downloadTaskWithRequest:request
                                                                  progress:nil
    destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // Save the file at saveToPath.
        NSURL* saveURL = [NSURL fileURLWithPath:saveToPath];
        return saveURL;
    }
    completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        completionBlock(response, error);
        return;
    }];
    [downloadTask resume];
}

#pragma mark - Private Methods.

// Adds auth credentials to the request header.
// Authorization: bearer token......
// CultureCode: en-US
-(void) addAuthCredentials:(NSDictionary*)authCredentials
{
    // Get the auth type and token.
    NSString* authToken = [AppUtility getValidStringObjectForKey:kTokenKey
                                                  fromDictionary:authCredentials];
    if(authToken) {
        NSString* authHeader = [NSString stringWithFormat:@"%@",authToken];
        [self.requestSerializer setValue:authHeader forHTTPHeaderField:@"Token"];
    }
}


// Add Auth Credentials for Request Serializer.
-(void) addAuthCredentials:(NSDictionary*)authCredentials
      forRequestSerializer:(AFHTTPRequestSerializer*)serializer
{
    // Validate serializer.
    if(!(serializer && [serializer isKindOfClass:[AFHTTPRequestSerializer class]])) {
        return;
    }
    
    // Get the auth type and token.
    NSString* authToken = [AppUtility getValidStringObjectForKey:kTokenKey
                                                  fromDictionary:authCredentials];
    if(authToken) {
        NSString* authHeader = [NSString stringWithFormat:@"%@",authToken];
        [self.requestSerializer setValue:authHeader forHTTPHeaderField:@"Token"];
    }
}


// Set http request headers.
-(void) addRequestHeaders:(NSDictionary*)requestHeaders
{
    // Return if no headers are available.
    if(!(requestHeaders &&
         [requestHeaders isKindOfClass:[NSDictionary class]] &&
         [requestHeaders count] > 0)){
        return;
    }
    
    // Read all available key values and add to request.
    NSArray* allHeaders = [requestHeaders allKeys];
    for(NSString* item in allHeaders){
        NSString* value = [requestHeaders objectForKey:item];
        if(value){
            [self.requestSerializer setValue:value forHTTPHeaderField:item];
        }
    }
}


// Returns the response headers.
-(NSDictionary*) getResponseHeadersFromTask:(NSURLSessionTask*)task
{
    NSDictionary* responseHeaders = nil;
    if([task.response isKindOfClass:[NSHTTPURLResponse class]]){
        responseHeaders = [(NSHTTPURLResponse*)task.response allHeaderFields];
    }
    return responseHeaders;
}


// Parses and sets the error object based on the received response.
-(AppError*) getResponseErrorFromResponse:(NSURLResponse*)response
                                    error:(NSError*)error
{
    // Get the error dictionary.
    NSDictionary* errorDict = nil;
    // Using the key from the overridden implementation.
    NSData *data = error.userInfo[JSONResponseSerializerWithDataKey];
    if(data && [data isKindOfClass:[NSData class]]){
        NSError *jsonError;
        errorDict = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingMutableContainers
                                                      error:&jsonError];
    }
    
    // Validate dictionary.
    //
    //  ErrorDetails =     {
    //      additionalData = "<null>";
    //      errorCode = InvalidTimeAsPerTimeCard;
    //      message = "Please enter a valid time entry. Refer to the time card of the technician for more details.";
    //  };
    //
    // The error message can be part of 'StatusMessage' or 'Message' key.
    NSString* errorMsg = nil;
    NSInteger errorCode = -1;
    if(errorDict && [errorDict isKindOfClass:[NSDictionary class]]){
        // TODO: Use constants keys for status code and message.
        NSDictionary* errorDetails = [errorDict objectForKey:@"ErrorDetails"];
        if(errorDetails && [errorDetails isKindOfClass:[NSDictionary class]]) {
            errorMsg = [errorDetails objectForKey:@"message"];
        }
        
        // Try to handle error code as well.
    }
    
    // Check if values are found.
    if(errorMsg == nil){
        errorMsg = [error localizedDescription];
    }
    
    // Set Error Code.
    if(errorCode == -1){
        // set a default value.
        errorCode = ERROR_GENERAL;
        
        if([response isKindOfClass:[NSHTTPURLResponse class]]){
            NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
            NSInteger httpStatusCode = httpResponse.statusCode;
            switch(httpStatusCode)
            {
                case(400):
                    errorCode = ERROR_BAD_REQUEST;
                    break;
                case (401):
                case (403):
                    errorCode = ERROR_UNAUTHORIZED;
                    break;
                case (404):
                    errorCode = ERROR_RESOURCE_NOT_FOUND;
                    break;
                case (500):
                    errorCode = ERROR_SERVER;
                    break;
                default:
                    break;
            }
        }
    }
    // Return the error.
    AppError* responseError = [[AppError alloc] initWithErrorCode:(AppErrorCode)errorCode
                                                             desc:errorMsg];
    return responseError;
}

@end
