//
//  SettingsView.m
//  RestaurantSplit
//
//  Created by Aliaksei Lyskovich on 3/3/15.
//  Copyright (c) 2015 Aliaksei Lyskovich. All rights reserved.
//

#import "MainView.h"
#import "SettingsView.h"

@interface SettingsView()
@property (weak, nonatomic) IBOutlet UILabel *CurrentCurrencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *DefaultLanguage;
@property (strong, nonatomic) IBOutlet UIPickerView *CurrencyPicker;
- (IBAction)SelectCurrencyButton:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *NavBar;
@property NSArray *CurrencyPickerData;
@property NSUserDefaults *defaults;
@property NSString *MyCurrency;
//@property NSLocale *preferredLanguages;

@end

@implementation SettingsView
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _CurrencyPickerData = @[@"($) US Dollar", @"(E) Euro", @"(R) Rub"];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
    NSString *l1 = [locale displayNameForKey:NSLocaleIdentifier value:@"en"];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    _MyCurrency = [[NSUserDefaults standardUserDefaults] valueForKey:@"myKey"];
    if([self.MyCurrency isEqualToString:@""]||[self.MyCurrency length]==0)
    {
        [self.defaults setValue:[self.CurrencyPickerData objectAtIndex:0] forKey:@"myKey"];
        //self.CurrentCurrencyLabel.text = [_CurrencyPickerData objectAtIndex:0];
        self.CurrentCurrencyLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"myKey"];
    }
    else
    {
        self.CurrentCurrencyLabel.text= self.MyCurrency;
    }
    self.DefaultLanguage.text =l1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)CurrencyPicker
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)CurrencyPicker numberOfRowsInComponent:(NSInteger)component
{
    return _CurrencyPickerData.count;
}

- (NSString *) pickerView: (UIPickerView *) CurrencyPicker
              titleForRow: (NSInteger) row forComponent: (NSInteger) component{
        return [self.CurrencyPickerData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)CurrencyPicker didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.defaults setValue:[self.CurrencyPickerData objectAtIndex:row] forKey:@"myKey"];
    self.CurrentCurrencyLabel.text = [self.CurrencyPickerData objectAtIndex:row];
}

-(IBAction)GoToMain:(id)sender
{
    [self performSegueWithIdentifier: @"GoToMain" sender: self];
}

- (IBAction)SelectCurrencyButton:(id)sender {
    NSLog(@"THis is tap!");
    NSString *GetLabelText;
    GetLabelText = self.CurrentCurrencyLabel.text;
    NSUInteger indexOfTheObject = [self.CurrencyPickerData indexOfObject: GetLabelText];
    [self.CurrencyPicker reloadAllComponents];
    [self.CurrencyPicker selectRow:indexOfTheObject inComponent:0 animated:YES];
    if (self.CurrencyPicker.hidden == NO) {
        self.CurrencyPicker.hidden = YES;
    } else {
        self.CurrencyPicker.hidden = NO;
        
    }
    //self.CurrencyPicker.hidden = NO;
}


@end
