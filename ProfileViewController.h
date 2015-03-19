//
//  ProfileViewController.h
//  FollowMyDebt
//
//  Created by Loris on 19/03/2015.
//  Copyright (c) 2015 Loris Venturelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ContactManager.h"

@interface ProfileViewController : UIViewController <UITableViewDataSource,MFMessageComposeViewControllerDelegate,UITabBarControllerDelegate,UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageProfile;
@property (weak, nonatomic) IBOutlet UILabel *lastnameProfile;
@property (weak, nonatomic) IBOutlet UILabel *firstnameProfile;
@property (weak, nonatomic) IBOutlet UILabel *phoneProfile;
@property (weak, nonatomic) IBOutlet UILabel *amountProfile;

@property (weak, nonatomic) IBOutlet UITabBar *TabBar;

@property (weak, nonatomic) Contact *contact;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addDebtButton;
- (IBAction)addDebt:(id)sender;

-(void)popupAddDebtSetHidden:(bool)hidden;
@property (weak, nonatomic) IBOutlet UIView *blackFilter;
@property (weak, nonatomic) IBOutlet UIView *popupNewDebt;

@property (weak, nonatomic) IBOutlet UISegmentedControl *debtInOut;
@property (weak, nonatomic) IBOutlet UITextField *amountNewDebt;
- (IBAction)saveNewDebt:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *HistoryTableView;

@end
