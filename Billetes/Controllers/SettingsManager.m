//
//  SettingsManager.m
//  Billetes
//
//  Created by Saoirse on 12/31/17.
//  Copyright © 2017 Boletos. All rights reserved.
//

#import "SettingsManager.h"
#import "AppConstants.h"


// Implementation.
@implementation SettingsManager

static SettingsManager* sharedInstance = nil;


+(SettingsManager*) sharedInstance
{
    @synchronized(self){
        if(sharedInstance == nil){
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}


// Initializer:
-(instancetype) init
{
    self = [super init];
    if(self){
        // Do required initialization.
        // Set default values for settings if not already set by user.
        if([[NSUserDefaults standardUserDefaults] objectForKey:kLoginDictionaryKey] == nil){
            [self initializeDefaultSettings];
        }
    }
    return self;
}

#pragma mark - Custom property synthesis.

// LoginInfo
-(NSDictionary*) loginInfo
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:kLoginDictionaryKey];
}

-(void) setLoginInfo:(NSDictionary*)info
{
    [[NSUserDefaults standardUserDefaults] setValue:[info copy] forKey:kLoginDictionaryKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - Private Methods.


-(void) initializeDefaultSettings
{
    NSMutableDictionary* defaultSettings = [[NSMutableDictionary alloc] init];
    
    // Dictionary to hold login info.
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithBool:NO] forKey:kLoggedInKey];
    [dict setObject:kDefaultToken forKey:kTokenKey];
    [defaultSettings setObject:dict forKey:kLoginDictionaryKey];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultSettings];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
