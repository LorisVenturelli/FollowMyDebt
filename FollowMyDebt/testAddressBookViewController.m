//
//  testAddressBookViewController.m
//  FollowMyDebt
//
//  Created by Lucas Léonforté on 18/03/2015.
//  Copyright (c) 2015 Loris Venturelli. All rights reserved.
//

#import "testAddressBookViewController.h"


@interface testAddressBookViewController ()

@end

@implementation testAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showPicker:(id)sender {
  
  //On crée un objet de type ABPeoplePickerNavigationController et on l'initialise
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

// Called after a person has been selected by the user.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)persons property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
  
}

-(void)displayPerson:(ABRecordRef)person
{
  //__bridge_transfer change un pointeur non Objective-C en un pointeur Objective-C et transfère également la propriété
  //à  ARC qui sera responsale de la gestion mémoire
  NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
  self.prenom.text = name;
  
  NSString* lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
  self.nom.text = lastName;
  
  NSString* phone = nil;
  ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
  
  if(ABMultiValueGetCount(phoneNumbers)>0){
    phone = (__bridge_transfer NSString*)
    ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
  } else {
    phone = @"[None]";
  }
             self.numero.text = phone;
             CFRelease(phoneNumbers);
}

@end
