//
//  VenueCell.m
//  OnTheParty
//
//  Created by Dener Wilian Pereira do Carmo on 31/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VenueCell.h"

@implementation VenueCell
@synthesize localName;
@synthesize address;
@synthesize category;
@synthesize distance;
@synthesize imageView;
@synthesize disclosureButton;
@synthesize userData,delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)viewVenueDetailAction:(id)sender {
    [self.delegate viewVenueDetail:self];
}

@end
