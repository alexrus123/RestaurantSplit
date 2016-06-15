//
//  ViewController.m
//  RestaurantSplit
//
//  Created by Aliaksei Lyskovich on 3/2/15.
//  Copyright (c) 2015 Aliaksei Lyskovich. All rights reserved.
//

#import "MainView.h"
#import "SettingsView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *CurrencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *CurrencyLabel1;
@property (weak, nonatomic) IBOutlet UIButton *SplitButton;
@property (strong, nonatomic) IBOutlet UITextField *AmountField;
@property (weak, nonatomic) IBOutlet UITextField *PartyPeople;
@property (weak, nonatomic) IBOutlet UILabel *DisplayResults;
@property (weak, nonatomic) IBOutlet UIButton *SettingsButton;
@property (weak, nonatomic) IBOutlet UIButton *CameraButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *getCurrencyFromSettings = [[NSUserDefaults standardUserDefaults] valueForKey:@"myKey"];
    if([getCurrencyFromSettings isEqualToString:@""]||[getCurrencyFromSettings length]==0)
    {
        self.CurrencyLabel.text = @"$";
    }
    else
    {
        NSString *needle1 = [getCurrencyFromSettings componentsSeparatedByString:@"("][1];
        NSString *needle2 = [needle1 componentsSeparatedByString:@")"][0];
        self.CurrencyLabel.text = needle2;
    }
    self.CurrencyLabel1.text = self.CurrencyLabel.text;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.AmountField resignFirstResponder];
    [self.PartyPeople resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)SplitButton:(id)sender
{
    float TotalAmount = [self.AmountField.text floatValue];
    int PartyPeople = [self.PartyPeople.text intValue];
    
    if(isnan(TotalAmount) || isinf(TotalAmount))
    {
        self.AmountField.layer.borderColor=[[UIColor redColor]CGColor];
        self.AmountField.layer.borderWidth= 3.0f;
        self.AmountField.layer.masksToBounds=YES;
    }
    if (PartyPeople == 0.0 || PartyPeople < 0.0)
    {
        self.PartyPeople.layer.borderColor = [[UIColor redColor]CGColor];
        self.PartyPeople.layer.borderWidth= 1.0f;
        self.PartyPeople.layer.masksToBounds=YES;
    }
    else
    {
        float Results = TotalAmount / PartyPeople;
        self.DisplayResults.text =[NSString stringWithFormat:@"%.2f", Results];
        [self.view endEditing:YES];
    }
    [self.view endEditing:YES];
}
-(IBAction)SettingsButton:(id)sender
{
    //SettingsView *view = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsView"];
    [self performSegueWithIdentifier: @"GoToSettings" sender: self];
}
-(IBAction)CameraButton:(id)sender
{
    
}

@end
