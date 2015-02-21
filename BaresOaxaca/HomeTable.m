//
//  HomeTable.m
//  BaresOaxaca
//
//  Created by Alberto Cordero Arellanes on 20/02/15.
//  Copyright (c) 2015 AlbertoCorderoArellanes. All rights reserved.
//

#import "HomeTable.h"
#import "cellOaxaca.h"
#import "SBJson.h"
#import "AppDelegate.h"

UIAlertView     *alert;
NSDictionary    *jsonResponse;
NSString        *userID;

@interface HomeTable ()

@end

@implementation HomeTable

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initController];
    [self cfgiAdBanner];
    [self loadService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**********************************************************************************************
 Table Functions
 **********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return lblName.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellOaxaca");
    static NSString *CellIdentifier = @"cellOaxaca";
    
    cellOaxaca *cell = (cellOaxaca *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[cellOaxaca alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.lblName.text       = lblName[indexPath.row];
    cell.lblDescripcion.text       = maDescrip[indexPath.row];
    //cell.lblAge.text        = maAge[indexPath.row];
    
    //NSURL *url = [NSURL URLWithString: maImgs[indexPath.row]];
    // NSData *data =
    //  UIImage *img = [[UIImage alloc] initWithData:data cache:NO];
    //  CGSize size = img.size;
    
    
    
    NSLog(@"URL::: %@", imgUser[indexPath.row]);
    //   cell.imgUser.image      = [UIImage imageNamed: maImgs[indexPath.row]];
    cell.imgUser.image  = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUser[indexPath.row]]]];
    
    
    //    cell.imgUser.image      = [UIImage imageNamed: maImgs[indexPath.row]];
    
    return cell;
}

/*******************************************************************************
 Web Service
 *******************************************************************************/
//-------------------------------------------------------------------------------
- (void) postService
{
    NSLog(@"postService");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadService) object:nil];
    [queue addOperation:operation];
}
//-------------------------------------------------------------------------------
- (void) loadService
{
    @try
    {
        NSString *post = [[NSString alloc] initWithFormat:@"id=%@", userID];
        NSLog(@"postService: %@",post);
        NSURL *url = [NSURL URLWithString:@"http://ec2-54-148-72-192.us-west-2.compute.amazonaws.com/"];
        NSLog(@"URL postService = %@", url);
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        [NSURLRequest requestWithURL:url];
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        //-------------------------------------------------------------------------------
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            jsonResponse = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
        }
        else
        {
            if (error)
            {
                NSLog(@"Error");
                
            }
            else
            {
                NSLog(@"Conect Fail");
            }
        }
        //-------------------------------------------------------------------------------
    }
    @catch (NSException * e)
    {
        NSLog(@"Exception");
    }
    //-------------------------------------------------------------------------------
    NSLog(@"jsonResponse %@", jsonResponse);
    
    lblName         = [jsonResponse valueForKey:@"nombre"];
    NSLog(@"maNames %@", lblName);
    
    maDescrip         = [jsonResponse valueForKey:@"descripcion"];
    NSLog(@"maNames %@", maDescrip);
    
    
    imgUser        = [jsonResponse valueForKey:@"imagen"];
    NSLog(@"maImgs %@", imgUser);
    
}


- (IBAction)btnRefreshPressed:(id)sender {
    [self.tblMain reloadData];
    
}

- (void)initController
{
    [self postService];
    [self.tblMain reloadData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)function: (int) x
{
    
}

- (void)cfgiAdBanner
{
    // Setup iAdView
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    
    //Tell the add view the origin depending on iPhone size
    CGRect adFrame      = adView.frame;
    adFrame.origin.y    = self.view.frame.size.height - 50;
    NSLog(@"adFrame.origin.y: %f",adFrame.origin.y);
    adView.frame        = adFrame;
    
    [adView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    [self.view addSubview:adView];
    adView.delegate = self;
    adView.hidden = YES;
    self->bannerIsVisible = NO;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self->bannerIsVisible)
    {
        adView.hidden = NO;
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        [UIView commitAnimations];
        self->bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self->bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // banner is visible and we move it out of the screen, due to connection issue
        [UIView commitAnimations];
        adView.hidden = YES;
        self->bannerIsVisible = NO;
    }
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"Banner view is beginning an ad action");
    BOOL shouldExecuteAction = YES;
    if (!willLeave && shouldExecuteAction)
    {
        // stop all interactive processes in the app
        // [video pause];
        // [audio pause];
    }
    return shouldExecuteAction;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    // resume everything you've stopped
    // [video resume];
    // [audio resume];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

@end
