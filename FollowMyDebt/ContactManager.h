//
//  ContactManager.h
//  FollowMyDebt
//
//  Created by Loris on 18/03/2015.
//  Copyright (c) 2015 Loris Venturelli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface ContactManager : NSObject

+ (ContactManager*) sharedInstance;

- (void) addContact:(Contact*)aContact;
- (void) removeContact:(Contact*)aContact;

@property (readonly) NSUInteger count;
- (Contact*) contactAtIndex:(NSUInteger)index;

@end
