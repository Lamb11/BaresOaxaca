//
//  HomeMaps.h
//  BaresOaxaca
//
//  Created by Alberto Cordero Arellanes on 21/02/15.
//  Copyright (c) 2015 AlbertoCorderoArellanes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Accounts/Accounts.h>
#import <iAd/iAd.h>

@interface HomeMaps : UIViewController<ADBannerViewDelegate,CLLocationManagerDelegate>{
    ADBannerView *adView;
    BOOL bannerIsVisible;
}

@property (strong,nonatomic)CLLocationManager *locationManager;
@property (strong,nonatomic)CLLocation *location;

@property (strong, nonatomic) IBOutlet UIView *viewMap;

@property (strong, nonatomic) IBOutlet UIButton *btnMap;

- (IBAction)btnMapPressed:(id)sender;

@end
