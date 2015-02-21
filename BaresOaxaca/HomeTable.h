//
//  HomeTable.h
//  BaresOaxaca
//
//  Created by Alberto Cordero Arellanes on 20/02/15.
//  Copyright (c) 2015 AlbertoCorderoArellanes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <iAd/iAd.h>

@interface HomeTable : UIViewController<ADBannerViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    ADBannerView *adView;
    BOOL bannerIsVisible;
}

- (IBAction)btnRefreshPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tblMain;

@end
