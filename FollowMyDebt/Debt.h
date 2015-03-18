//
//  Expense.h
//  CorrectionExpenses
//
//  Created by Pierre Grabolosa on 23/02/2015.
//  Copyright (c) 2015 Pierre Grabolosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface Debt : NSObject

@property (strong) Contact* contact;
@property (strong) NSString* note;
@property (assign) float amount;

+ (Debt*) debtBy:(Contact*)contact amount:(float)amount note:(NSString*)note;

- (instancetype) initDebtBy:(Contact*)contact amount:(float)amount note:(NSString*)note;

@end
