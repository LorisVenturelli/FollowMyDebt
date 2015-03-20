//
//  ContactWithDebtTableViewCell.h
//  FollowMyDebt
//
//  Created by Loris on 18/03/2015.
//  Copyright (c) 2015 Loris Venturelli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactWithDebtTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameContact;
@property (weak, nonatomic) IBOutlet UILabel *amountDebt;

@end
