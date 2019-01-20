//
//  MainVC.m
//  UDID Fetcher Objective C
//
//  Created by user on 1/20/19.
//  Copyright © 2019 MasonD3V. All rights reserved.
//

#import "MainVC.h"

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // classifying NSUserDefaults
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSObject *object = [prefs objectForKey:@"udid"];
    // Checks if UDID is fetched already, if so it will be printed into the Label.
    if(object == nil) {
        NSLog(@"UDID has not yet been fetched.");
    } else {
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"udid"];
        NSString *newUdid = [NSString stringWithFormat:@"%@", savedValue];
        newUdid = [newUdid stringByReplacingOccurrencesOfString:@"udid://?udid="
                                                     withString:@""];
        _udid.text = [NSString stringWithFormat:@"%@", newUdid];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        UIApplication *mySafari = [UIApplication sharedApplication];
        NSURL *myURL = [[NSURL alloc]initWithString:@"https://twitter.com/MasonD3V"];
        [mySafari openURL:myURL];
    } else if (indexPath.section == 0 && indexPath.row == 0) {
        
        if (![_udid.text  isEqual: @"Fetching Needed"]) {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:_udid.text];
            NSString *copiedUDID = [NSString stringWithFormat:@"You have copied your UDID to your clipboard.\n\n%@", _udid.text];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"UDID Fetcher" message:copiedUDID preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                // nothing ;)
            }];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIApplication *mySafari = [UIApplication sharedApplication];
            NSURL *myURL = [[NSURL alloc]initWithString:@"http://github.masond3v.us/UDID"];
            [mySafari openURL:myURL];
        }
        
    }
    
}

@end
