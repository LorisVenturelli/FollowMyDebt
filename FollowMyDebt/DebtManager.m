//
//  ExpenseManager.m
//  CorrectionExpenses
//
//  Created by Pierre Grabolosa on 23/02/2015.
//  Copyright (c) 2015 Pierre Grabolosa. All rights reserved.
//

#import "DebtManager.h"

@implementation DebtManager {
    RLMResults* _debts;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _debts = [Debt allObjects];
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
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    aDebt.isRemboursed = NO;
    
    [realm beginWriteTransaction];
    [realm addObject:aDebt];
    [realm commitWriteTransaction];
    
    _debts = [Debt allObjects];
    
    NSLog(@"Add debt : %@",_debts);
}

- (void) removeDebt:(Debt *)aDebt {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    [realm deleteObject:aDebt];
    [realm commitWriteTransaction];
    
    _debts = [Debt allObjects];
    
    NSLog(@"Remove debt : %@",_debts);
}

- (NSUInteger) count {
    if(_debts != nil)
        return _debts.count;
    return 0;
}

- (Debt*) debtAtIndex:(NSUInteger)index {
    _debts = [Debt allObjects];
    return [_debts objectAtIndex:index];
}

- (float) amountFor:(Contact*)contact {
    
    float amount = 0.0;
    
    for(Debt* debt in _debts) {
        if([debt.contact.phone isEqualToString:contact.phone] && debt.isRemboursed == NO){
            if(debt.debtForMe)
                amount += debt.amount;
            else
                amount -= debt.amount;
        }
        
    }
    
    return amount;
    
}
- (NSInteger) countDebtsFor:(Contact*)contact {
    _debts = [Debt allObjects];
    NSInteger count = 0;
    
    for(Debt* debt in _debts) {
        if([debt.contact.phone isEqualToString:contact.phone]){
            count += 1;
        }
    }
    
    return count;
}

- (Debt*) debtOf:(Contact*)contact atIndex:(NSUInteger)index {
    _debts = [Debt allObjects];
    NSUInteger count = -1;
    
    for(Debt* debt in _debts) {
        if([debt.contact.phone isEqualToString:contact.phone]){
            count += 1;
            if(count == index)
                return debt;
        }
    }
    
    return nil;
}

-(void) debtIsRemboused:(Debt*)debt {
    _debts = [Debt allObjects];
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    debt.isRemboursed = YES;
    [realm commitWriteTransaction];
}

-(void) debtsAllRemboursedOf:(Contact*)contact {
    _debts = [Debt allObjects];
    for(Debt* debt in _debts) {
        if([debt.contact.phone isEqualToString:contact.phone]){
            [self debtIsRemboused:debt];
        }
    }
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

@end
