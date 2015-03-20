//
//  ListDebtTableViewController.m
//  FollowMyDebt
//
//  Created by Loris on 18/03/2015.
//  Copyright (c) 2015 Loris Venturelli. All rights reserved.
//

#import "ListDebtTableViewController.h"
#import "ContactManager.h"
#import "DebtManager.h"
#import "ContactWithDebtTableViewCell.h"
#import "ProfileViewController.h"

@interface ListDebtTableViewController ()

@end

@implementation ListDebtTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ProfileViewController* dest = segue.destinationViewController;

    NSInteger cell = self.tableView.indexPathForSelectedRow.row;
    Contact* contact = [[ContactManager sharedInstance] contactAtIndex:cell];
        
    dest.contact = contact;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ContactManager sharedInstance] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactWithDebtTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactWithDebt" forIndexPath:indexPath];
    
    Contact* contact = [[ContactManager sharedInstance] contactAtIndex:indexPath.row];
    
    DebtManager* debts = [DebtManager sharedInstance];
    
    cell.nameContact.text = [NSString stringWithFormat:@"%@ %@", contact.lastname, contact.firstname];
    
    float amount = [debts amountFor:contact];
    NSString *amountString = [NSString stringWithFormat:@"%0.2f€", amount];
    
    if(amount < 0.0){
        [cell.amountDebt setTextColor:[UIColor redColor]];
    }
    else if(amount > 0.0){
        amountString = [NSString stringWithFormat:@"+%0.2f€", amount];
        [cell.amountDebt setTextColor:[UIColor greenColor]];
    }
    else {
        [cell.amountDebt setTextColor:[UIColor blueColor]];
    }
    
    cell.amountDebt.text = amountString;
    
    CFErrorRef error = nil; // no asterisk
    ABAddressBookRef addressBook =
    ABAddressBookCreateWithOptions(NULL, &error); // indirection
    if (!addressBook) // test the result, not the error
    {
        NSLog(@"ERROR!!!");
    }
    CFArrayRef arrayOfPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSLog(@"%@", arrayOfPeople); // let's see how we did
    
    return cell;
}


- (IBAction)researchContact:(id)sender {//On crée un objet de type ABPeoplePickerNavigationController et on l'initialise
  //implementation which creates a new people picker
  ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
  picker.peoplePickerDelegate = self;
  
  [self presentViewController:picker animated:YES completion:nil];
  
}

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

// Called after a person has been selected by the user.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person{
  
  [self displayPerson:person];
  [self dismissViewControllerAnimated:YES completion:nil];
  
}

-(void)displayPerson:(ABRecordRef)person
{

  ContactManager* contactMgr = [ContactManager sharedInstance];

  //__bridge_transfer change un pointeur non Objective-C en un pointeur Objective-C et transfère également la propriété
  //à  ARC qui sera responsale de la gestion mémoire
  NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
  NSString* lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
  NSString* phone = nil;

  ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);

  if(ABMultiValueGetCount(phoneNumbers)>0){
    phone = (__bridge_transfer NSString*)
    ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
  } else {
    phone = @"[None]";
  }
    
    if(name!=nil && lastName!=nil && phone!=nil){
        Contact* newContact = [[Contact alloc]init];
        newContact.firstname = name;
        newContact.lastname = lastName;
        newContact.phone = phone;
        
        [contactMgr addContact:newContact];
        [self.tableView reloadData];
    }
    
    CFRelease(phoneNumbers);
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        self.lastIndexPath = indexPath;
        ContactManager *contactMgr = [ContactManager sharedInstance];
        [contactMgr removeContact:[contactMgr contactAtIndex:self.lastIndexPath.row]];
        [self.tableView reloadData];
    }
}

@end
