//
//  CongratulationsViewController.h
//  12Seasons
//
//  Created by Maciej Czechowski on 24.03.2015.
//  Copyright (c) 2015 Maciej Czechowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@protocol CongratulationsDelegate <NSObject>
@required
-(void)finished;
@end

@interface CongratulationsViewController : UIViewController
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *venue;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, weak) id<CongratulationsDelegate> delegate;
@property int score;
@end
