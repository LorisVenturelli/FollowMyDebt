//
//  Expense.m
//  CorrectionExpenses
//
//  Created by Pierre Grabolosa on 23/02/2015.
//  Copyright (c) 2015 Pierre Grabolosa. All rights reserved.
//

#import "Debt.h"

@implementation Debt

// syntaxe d'appel : [[Debt alloc] initWithLabel:label amount:amount]
- (instancetype) initDebtBy:(Contact*)contact amount:(float)amount note:(NSString*)note {
    self = [super init];
    if (self != nil) {
        self.contact = contact;
        self.amount = amount;
        self.note = note;
    }
    return self;
}

// syntaxe d'appel : [Debt expenseWithLabel:label amount:amount]
+ (Debt*) debtBy:(Contact*)contact amount:(float)amount note:(NSString*)note; {
    return [[Debt alloc] initDebtBy:(Contact*)contact amount:(float)amount note:(NSString*)note];
}

@end
