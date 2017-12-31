//
//  Event.m
//  Billetes
//
//  Created by Saoirse on 12/31/17.
//  Copyright © 2017 Boletos. All rights reserved.
//

#import "Event.h"

//----------------------------------------------------------------------------------------------------------------------------------
//                                                          EVENT
//----------------------------------------------------------------------------------------------------------------------------------

// Data model to represent an event
@implementation Event

// Returns an array of Event object from JSON array.
+(NSArray*) getEventArrayFromJSONArray:(NSArray*)jsonArray
{
    // Initialize the result array.
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    if(resultArray == nil){
        return resultArray;
    }
    
    // validate input array.
    if(!(jsonArray && [jsonArray isKindOfClass:[NSArray class]] && [jsonArray count] > 0)) {
        return resultArray;
    }
    
    // Loop through and extract each item.
    for(NSDictionary* item in jsonArray){
        Event* listItem = [[Event alloc] initWithDictionary:item];
        if(listItem){
            [resultArray addObject:listItem];
        }
    }

    // Default sorted by DateTime
    if([resultArray count] > 0) {
        NSSortDescriptor* sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"dateTime"
                                                                     ascending:YES
                                                                     selector:@selector(localizedStandardCompare:)];
        [resultArray sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
    }
    return resultArray;
}


// Initializer.
-(Event*) initWithDictionary:(NSDictionary*)dictionary
{
    // Initializer.
    self = [super init];
    if(self) {
        
        
    }
    return self;
}

@end


//----------------------------------------------------------------------------------------------------------------------------------
//                                                          EVENT DETAIL
//----------------------------------------------------------------------------------------------------------------------------------

// Data model to represent an EventDetail
@implementation EventDetail

// Initializer.
-(EventDetail*) initWithDictionary:(NSDictionary*)dictionary
{
    // Initializer.
    self = [super init];
    if(self) {
        
        
    }
    return self;
}

@end
