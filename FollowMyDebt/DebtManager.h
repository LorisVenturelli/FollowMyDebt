//
//  ExpenseManager.h
//  CorrectionExpenses
//
//  Created by Pierre Grabolosa on 23/02/2015.
//  Copyright (c) 2015 Pierre Grabolosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Debt.h"

@interface DebtManager : NSObject

+ (DebtManager*) sharedInstance;

- (void) addDebt:(Debt*)aDebt;
- (void) removeDebt:(Debt*)aDebt;

- (void) removeAllDebts;

@property (readonly) NSUInteger count;
- (Debt*) debtAtIndex:(NSUInteger)index;
- (float) amountFor:(Contact*)contact;

@property (readonly) NSNumber* maximum;
@property (readonly) NSNumber* minimum;
@property (readonly) NSNumber* average;

@end
