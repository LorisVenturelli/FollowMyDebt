//
//  ProfileViewController.m
//  FollowMyDebt
//
//  Created by Loris on 19/03/2015.
//  Copyright (c) 2015 Loris Venturelli. All rights reserved.
//

#import "ProfileViewController.h"
#import "DebtManager.h"
#import "HistoryTableViewCell.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.HistoryTableView.dataSource = self;
    
    self.TabBar.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self popupAddDebtSetHidden:YES];
    [self refreshDataView];
    [self.HistoryTableView reloadData];
    
}
-(void)refreshDataView{
    float amount = [[DebtManager sharedInstance] amountFor:self.contact];
    
    NSString *amountString = [NSString stringWithFormat:@"%0.2f€", amount];
    
    if(amount < 0.0){
        [self.amountProfile setTextColor:[UIColor redColor]];
    }
    else if(amount > 0.0){
        amountString = [NSString stringWithFormat:@"+%0.2f€", amount];
        [self.amountProfile setTextColor:[UIColor greenColor]];
    }
    else {
        [self.amountProfile setTextColor:[UIColor blueColor]];
    }
    
    self.lastnameProfile.text = self.contact.lastname;
    self.firstnameProfile.text = self.contact.firstname;
    self.phoneProfile.text = self.contact.phone;
    self.amountProfile.text = amountString;
}

-(void)popupAddDebtSetHidden:(bool)hidden {
    [self.blackFilter setHidden:hidden];
    [self.popupNewDebt setHidden:hidden];
    
    if(hidden)
        self.addDebtButton.title = @"Nouvelle dette";
    else
        self.addDebtButton.title = @"Fermer";
    
    [self.view endEditing:YES];
}

- (IBAction)addDebt:(id)sender {
    if([self.addDebtButton.title isEqualToString:@"Fermer"]){
        [self popupAddDebtSetHidden:YES];
    }
    else {
        [self popupAddDebtSetHidden:NO];
    }
    [self showSMS];
    
}
- (IBAction)saveNewDebt:(id)sender {
    [self popupAddDebtSetHidden:YES];
    
    BOOL debtForMe = YES;
    
    if(self.debtInOut.selectedSegmentIndex == 0)
        debtForMe = NO;
    
    DebtManager *debtMgr = [DebtManager sharedInstance];
    [debtMgr addDebt:[Debt debtBy:self.contact amount:self.amountNewDebt.text.floatValue note:@"Note by popup" debtForMe:(BOOL)debtForMe]];
    
    [self refreshDataView];
    [self.HistoryTableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[DebtManager sharedInstance] countDebtsFor:self.contact];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell" forIndexPath:indexPath];
    
    Debt* debt = [[DebtManager sharedInstance] debtOf:self.contact atIndex:indexPath.row];
    
    NSString* amountString = [NSString stringWithFormat:@"-%0.2f€", debt.amount];
    
    if(debt.debtForMe){
        amountString = [NSString stringWithFormat:@"+%0.2f€", debt.amount];
        [cell.amount setTextColor:[UIColor greenColor]];
    }
    else {
        [cell.amount setTextColor:[UIColor redColor]];
    }
    
    cell.note.text = debt.note;
    cell.amount.text = amountString;
    
    return cell;
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) showSMS {
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = @[self.contact.phone];
    NSString *message = @"";
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}
-(void) callContact {
    NSString* phoneNumber = [self.contact.phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    else
        NSLog(@"Ne peux pas lancer l'application Phone");
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag==0) {
        [self showSMS];
    }
    else if (item.tag==1) {
        [self callContact];
    }
    else if (item.tag==2) {
        NSLog(@"Tab 2");
    }
}

@end
