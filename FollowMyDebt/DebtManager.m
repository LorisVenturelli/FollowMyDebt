//
//  ExpenseManager.m
//  CorrectionExpenses
//
//  Created by Pierre Grabolosa on 23/02/2015.
//  Copyright (c) 2015 Pierre Grabolosa. All rights reserved.
//

#import "DebtManager.h"

@implementation DebtManager {
    NSMutableArray* _debts;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _debts = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (DebtManager*) sharedInstance {
    static DebtManager* instance = nil;
    
    if (instance == nil) {
        instance = [[DebtManager alloc] init];
    }
    
    return instance;
}

- (void) addDebt:(Debt *)aDebt {
    
    [_debts insertObject:aDebt atIndex:0];
    
}

- (void) removeDebt:(Debt *)aDebt {
    [_debts removeObject:aDebt];
}

- (NSUInteger) count {
    return _debts.count;
}

- (Debt*) debtAtIndex:(NSUInteger)index {
    return [_debts objectAtIndex:index];
}

- (float) amountFor:(Contact*)contact {
    
    float amount = 0.0;
    
    for(Debt* debt in _debts) {
        if(debt.contact == contact){
            if(debt.debtForMe)
                amount += debt.amount;
            else
                amount -= debt.amount;
        }
        
    }
    
    return amount;
    
}
- (NSInteger) countDebtsFor:(Contact*)contact {
    
    NSInteger count = 0;
    
    for(Debt* debt in _debts) {
        if(debt.contact == contact){
            count += 1;
        }
    }
    
    return count;
}

- (Debt*) debtOf:(Contact*)contact atIndex:(NSUInteger)index {
    
    NSUInteger count = -1;
    
    for(Debt* debt in _debts) {
        if(debt.contact == contact){
            count += 1;
            if(count == index)
                return debt;
        }
    }
    
    return nil;
}

- (NSNumber*) maximum {
    if (_debts.count == 0) {
        return nil;
    }
    
    Debt* first = _debts.firstObject;
    float tmpMaximum = first.amount;
    
    for(Debt* debt in _debts) {
        if (debt.amount > tmpMaximum) {
            tmpMaximum = debt.amount;
        }
    }
    
    return [NSNumber numberWithFloat:tmpMaximum];
}

- (NSNumber*) minimum {
    if (_debts.count == 0) {
        return nil;
    }
    
    Debt* first = _debts.firstObject;
    float tmpMinimum = first.amount;
    
    for(Debt* debt in _debts) {
        if (debt.amount < tmpMinimum) {
            tmpMinimum = debt.amount;
        }
    }
    
    return [NSNumber numberWithFloat:tmpMinimum];
}

- (NSNumber*) average {
    if (_debts.count == 0) {
        return nil;
    }
    
    float sum = 0;
    
    for(Debt* debt in _debts) {
        sum += debt.amount;
    }
    
    return [NSNumber numberWithFloat:sum/_debts.count];
}

- (void) removeAllDebts {
    [_debts removeAllObjects];
//    for (int i = 0; i < [self count]; i++)
//    {
//        Debt* exp = [self debtAtIndex:i];
//        [self removeDebt:exp];
//    }
}

@end
