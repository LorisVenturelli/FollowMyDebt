//
//  Contact.m
//  FollowMyDebt
//
//  Created by Loris on 18/03/2015.
//  Copyright (c) 2015 Loris Venturelli. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (instancetype) initWithFirstName:(NSString *)firstname lastName:(NSString *)lastname phone:(NSString *)phone {
    self = [super init];
    if (self != nil) {
        self.firstname = firstname;
        self.lastname = lastname;
        self.phone = phone;
    }
    return self;
}

+ (Contact *)contactWithFirstName:(NSString *)firstname lastName:(NSString *)lastname phone:(NSString *)phone {
    return [[Contact alloc] initWithFirstName:firstname lastName:lastname phone:phone];
}

@end
