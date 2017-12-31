//
//  AppError.m
//  Billetes
//
//  Created by Saoirse on 12/31/17.
//  Copyright © 2017 Boletos. All rights reserved.
//

#import "AppError.h"

@implementation AppError

@synthesize errorCode;
@synthesize errorDesc;

// Initializer
-(AppError*) initWithErrorCode:(AppErrorCode)code desc:(NSString*)desc
{
    self = [super init];
    if(self){
        self.errorCode = code;
        self.errorDesc = desc;
    }
    return self;
}

@end
