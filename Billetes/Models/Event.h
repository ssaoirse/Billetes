//
//  Event.h
//  Billetes
//
//  Created by Saoirse on 12/31/17.
//  Copyright © 2017 Boletos. All rights reserved.
//

#import <Foundation/Foundation.h>

//----------------------------------------------------------------------------------------------------------------------------------
//                                                          EVENT
//----------------------------------------------------------------------------------------------------------------------------------

/*!
 * @brief Data model to represent an Event.
 */
@interface Event : NSObject

@property (copy, nonatomic) NSString* eventId;
@property (copy, nonatomic) NSString* title;
@property (strong, nonatomic) NSDate* dateTime;
@property (copy, nonatomic) NSString* thumbnailURL;

/*!
 * @brief Returns an array of Event objects from the json array passed.
 * @param  jsonArray                    A JSON array containing dictionaries of Event.
 * @return NSArray                      Returns an array of Event objects.
 */
+(NSArray*) getEventArrayFromJSONArray:(NSArray*)jsonArray;

/*!
 * @brief Initializer. Returns an instance of the Event object from the dictionary passed.
 * @param  dictionary                   Dictionary containing properties for a Event item.
 * @return Event                        A pointer to the Event Object.
 */
-(Event*) initWithDictionary:(NSDictionary*)dictionary;

@end


//----------------------------------------------------------------------------------------------------------------------------------
//                                                          EVENT DETAIL
//----------------------------------------------------------------------------------------------------------------------------------

/*!
 * @brief Data model to represent an EventDetail.
 */
@interface EventDetail : NSObject

@property (copy, nonatomic) NSString* imageURL;
@property (copy, nonatomic) NSString* eventURL;
@property (copy, nonatomic) NSString* address;
@property (assign, nonatomic) NSInteger ticketsSold;
@property (assign, nonatomic) double amount;

/*!
 * @brief Initializer. Returns an instance of the EventDetail object from the dictionary passed.
 * @param  dictionary                   Dictionary containing properties for a EventDetail item.
 * @return EventDetail                  A pointer to the EventDetail Object.
 */
-(EventDetail*) initWithDictionary:(NSDictionary*)dictionary;

@end
