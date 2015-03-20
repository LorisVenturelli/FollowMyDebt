//
//  ContactManager.m
//  FollowMyDebt
//
//  Created by Loris on 18/03/2015.
//  Copyright (c) 2015 Loris Venturelli. All rights reserved.
//

#import "ContactManager.h"
#import <Realm/Realm.h>


@implementation ContactManager {
    RLMResults* _contacts;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _contacts = [Contact allObjects];
    }
    return self;
}

+ (ContactManager*) sharedInstance {
    static ContactManager* instance = nil;
    
    if (instance == nil) {
        instance = [[ContactManager alloc] init];
    }
    
    return instance;
}

- (void) addContact:(Contact *)aContact {
  
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:aContact];
    [realm commitWriteTransaction];
    
    _contacts = [Contact allObjects];
  
}

- (void) removeContact:(Contact *)aContact {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:aContact];
    [realm commitWriteTransaction];
    
    _contacts = [Contact allObjects];
}

- (NSUInteger) count {
    if(_contacts == nil)
        return 0;
    
    return _contacts.count;
}

- (Contact*) contactAtIndex:(NSUInteger)index {
    _contacts = [Contact allObjects];
    NSLog(@"All contacts : %@", _contacts);
    return [_contacts objectAtIndex:index];
}



@end
