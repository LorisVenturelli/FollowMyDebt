//
//  ListDebtTableViewController.h
//  FollowMyDebt
//
//  Created by Loris on 18/03/2015.
//  Copyright (c) 2015 Loris Venturelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ListDebtTableViewController : UITableViewController <ABPeoplePickerNavigationControllerDelegate>

- (IBAction)researchContact:(id)sender;
@property (strong) NSIndexPath* lastIndexPath;

@end
