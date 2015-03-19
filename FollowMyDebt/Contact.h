//
//  Contact.h
//  FollowMyDebt
//
//  Created by Loris on 18/03/2015.
//  Copyright (c) 2015 Loris Venturelli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import <UIKit/UIKit.h>

@interface Contact : RLMObject

@property (strong) NSString* firstname;
@property (strong) NSString* lastname;
@property (strong) NSString* phone;

+ (Contact*) contactWithFirstName:(NSString*)firstname lastName:(NSString*)lastname phone:(NSString*)phone;

- (instancetype) initWithFirstName:(NSString*)firstname lastName:(NSString*)lastname phone:(NSString*)phone;


@end
