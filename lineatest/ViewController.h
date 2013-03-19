//
//  ViewController.h
//  lineatest
//
//  Created by Martin Skow Røed on 19.03.13.
//  Copyright (c) 2013 Martin Skow Røed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineaSDK.h"

@interface ViewController : UIViewController <LineaDelegate> {
    Linea *linea;
}

-(IBAction)scanDown:(id)sender;
-(IBAction)scanUp:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *barcodeLabel;

@end
