//
//  ViewController.h
//  BaresOaxaca
//
//  Created by Alberto Cordero Arellanes on 16/02/15.
//  Copyright (c) 2015 AlbertoCorderoArellanes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface Home : UIViewController<ADBannerViewDelegate>
{
    ADBannerView *adView;
    BOOL bannerIsVisible;
}



@end

