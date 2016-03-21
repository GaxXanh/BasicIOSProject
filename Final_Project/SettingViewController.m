//
//  SettingViewController.m
//  Final_Project
//
//  Created by Pham Anh on 3/21/16.
//  Copyright © 2016 com.gaxxanh. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldCurrentCity;

@end

@implementation SettingViewController

#pragma mark - View Life Cycle

- (void) viewDidLoad {
    
    self.textFieldCurrentCity.delegate = self;
    self.navigationItem.title = @"Setting";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem = backButton;
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    self.textFieldCurrentCity.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"City"];
    
}

#pragma mark - Private Methods

- (void) pop;
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - TextField Delegate

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    
    [textField becomeFirstResponder];
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    [[NSUserDefaults standardUserDefaults] setObject:[textField text] forKey:@"City"];
    
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textFieldCurrentCity resignFirstResponder];
}

@end
