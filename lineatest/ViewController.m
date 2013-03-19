//
//  ViewController.m
//  lineatest
//
//  Created by Martin Skow Røed on 19.03.13.
//  Copyright (c) 2013 Martin Skow Røed. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    linea=[Linea sharedDevice];
	[linea addDelegate:self];
    [linea barcodeSetScanMode:BARCODE_TYPE_DEFAULT error:nil];
    
    [linea connect];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

bool scanActive = false;

-(IBAction)scanDown:(id)sender;
{
    NSError *error=nil;
    
	//refresh the screen
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    int scanMode;
    
    if([linea getScanMode:&scanMode error:&error] && scanMode==MODE_MOTION_DETECT)
    {
        if(scanActive)
        {
            scanActive=false;
            [linea stopScan:&error];
        }else {
            scanActive=true;
            [linea startScan:&error];
        }
    }else
        [linea startScan:&error];
}

-(IBAction)scanUp:(id)sender;
{
    NSError *error;
    
    int scanMode;
    
    if([linea getScanMode:&scanMode error:&error] && scanMode!=MODE_MOTION_DETECT)
        [linea stopScan:&error];
}

-(void)connectionState:(int)state {
	switch (state) {
		case CONN_DISCONNECTED:
            NSLog(@"disconncted");
            break;
		case CONN_CONNECTING:
            NSLog(@"not connected");
            
			break;
		case CONN_CONNECTED:
            NSLog(@"connected");
            [linea msStartScan:nil];
            [linea barcodeEnginePowerControl:YES error:nil];
			break;
	}
}

-(void)barcodeData:(NSString *)barcode type:(int)type {
    [self.barcodeLabel setText:barcode];
    NSLog(@"barcode data sent, %@", barcode);
}


- (void) deviceButtonPressed:(int) btn {
    NSLog(@"a button on the scanner is pressed");
}

@end
