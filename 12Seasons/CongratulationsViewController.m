//
//  CongratulationsViewController.m
//  12Seasons
//
//  Created by Maciej Czechowski on 24.03.2015.
//  Copyright (c) 2015 Maciej Czechowski. All rights reserved.
//

#import "CongratulationsViewController.h"
#import <FacebookSDK/FacebookSDK.h>

#import <MBProgressHUD.h>
@interface CongratulationsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
- (IBAction)shareAction:(id)sender;
- (IBAction)closeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;

@end

@implementation CongratulationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblScore.text=[NSString stringWithFormat:@"You just received  %d points!",self.score ];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)createGraphObjectWithPlaceId:(id)placeId
{
    
}

- (IBAction)shareAction:(id)sender {
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   
    NSMutableDictionary<FBOpenGraphObject> *object = [FBGraphObject openGraphObjectForPost];
    
    NSNumber *latitude=[NSNumber numberWithDouble:self.location.coordinate.latitude];
    NSNumber *longitude=[NSNumber numberWithDouble:self.location.coordinate.longitude];;
    
    
    // specify that this Open Graph object will be posted to Facebook
    object.provisionedForPost = YES;
    
    // for og:title
    object[@"title"] = self.productName;
    object[@"description"] = self.venue;
    // for og:type, this corresponds to the Namespace you've set for your app and the object type name
  //  object[@"type"] = @"foodatlocation";
   // object[@"data:location:latitude"]=latitude;
   // object[@"data:location:longitude"]=longitude;
    //object[@"location:latitude"]=latitude;
   // object[@"location:longitude"]=longitude;
   // object[@"place:location:latitude"]=latitude;
   // object[@"place:location:longitude"]=longitude;
   // object[@"place:locaa"] = @{
    //                        @"location" : @{ @"longitude": longitude, @"latitude": latitude} };
    //[object setObject:@{ @"longitude": longitude, @"latitude": latitude} forKey:@"place:location"];
    
    //[object setObject:@{@"place:location": @{ @"longitude": longitude, @"latitude": latitude } } forKey:@"data"];

  //  object[@"place:location"] =
    //                     @{ @"longitude": longitude, @"latitude": latitude} ;

  ////  object[@"data"] =@{@"place": @{ @"location": @{
    //                                          @"longitude": longitude,
    //                                            @"latitude": latitude
     //                                        }
       //                             }
     //                  };

   
    
    
    
    
    // for og:description
    
    //    // for og:url, we cover how this is used in the "Deep Linking" section below
    //  object[@"url"] = @"http://example.com/roasted_pumpkin_seeds";
    
    // for og:image we assign the image that we just staged, using the uri we got as a response
    // the image has to be packed in a dictionary like this:
    
 //   [FBRequestConnection startForPostOpenGraphObject:object completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
     //   if(!error) {
            // get the object ID for the Open Graph object that is now stored in the Object API
      //  NSString *objectId = [result objectForKey:@"id"];
      //  NSLog([NSString stringWithFormat:@"object id: %@", objectId]);
            
        id<FBOpenGraphAction> action = (id<FBOpenGraphAction>)[FBGraphObject graphObject];
        [action setObject:object forKey:@"foodatlocation"];
    
            [action setObject:@{ @"longitude": longitude, @"latitude": latitude} forKey:@"location"];
    
      //  action[@"location:latitude"]=latitude;
     //   action[@"location:longitude"]=longitude;
    
   // action[@"data:location:latitude"]=latitude;
   // action[@"data:location:longitude"]=longitude;
    
        NSLog(@"Action: %@",[action description]);
    
    
       [FBRequestConnection startForPostWithGraphPath:@"me/seasoneater:pin"
                                               graphObject:action
                                         completionHandler:^(FBRequestConnection *connection,
                                                             id result,
                                                             NSError *error) {
                        if(!error) {
                            NSLog(@"saved at id %@",result[@"id"]);
                            if (self.delegate)
                               [self.delegate finished];
     
                          }
                            else {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            NSString *errorMessage = [error localizedDescription];
                                                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook error"
                                                 message:errorMessage
                                                 delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"Dismiss", nil];
                            [alert show];

                                                 
                                                 // An error occurred
                                                 NSLog(@"Error posting the Open Graph object to the Object API: %@", error);
                                             }
                                         }];
      //  } else {
     //       [MBProgressHUD hideHUDForView:self.view animated:YES];
     //       // An error occurred
     //       NSLog(@"Error posting the Open Graph object to the Object API: %@", error);
     //       NSString *errorMessage = [error localizedDescription];
     //       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook error"
     //                                                       message:errorMessage
     //                                                      delegate:nil
     //                                             cancelButtonTitle:nil
     //                                             otherButtonTitles:@"Dismiss", nil];
     //       [alert show];

     //   }
  //  }];
  
}

- (IBAction)closeAction:(id)sender {
    if (self.delegate)
        [self.delegate finished];
}
@end
