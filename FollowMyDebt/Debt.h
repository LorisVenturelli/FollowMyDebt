//
//  Expense.h
//  CorrectionExpenses
//
//  Created by Pierre Grabolosa on 23/02/2015.
//  Copyright (c) 2015 Pierre Grabolosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Contact.h"

@interface Debt : RLMObject

@property Contact* contact;
@property (strong) NSString* note;
@property (assign) float amount;
@property (assign) BOOL debtForMe;
@property (assign) BOOL isRemboursed;

+ (Debt*) debtBy:(Contact*)contact amount:(float)amount note:(NSString*)note debtForMe:(BOOL)debtForMe;

- (instancetype) initDebtBy:(Contact*)contact amount:(float)amount note:(NSString*)note debtForMe:(BOOL)debtForMe;

@end
