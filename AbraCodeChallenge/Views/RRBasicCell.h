//
//  RRBasicCell.h
//  Copyright (c) 2014 Razeware, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRBasicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
