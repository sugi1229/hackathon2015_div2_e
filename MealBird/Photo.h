//
//  Photo.h
//  
//
//  Created by minami on 8/16/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSDate * date;

@end
