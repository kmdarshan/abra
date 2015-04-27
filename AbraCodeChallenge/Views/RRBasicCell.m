#import "RRBasicCell.h"

@implementation RRBasicCell
@synthesize imageView;
- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    self.contentView.frame = self.bounds;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView updateConstraintsIfNeeded];
    [self.contentView layoutIfNeeded];
    self.detailLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.detailLabel.frame);
}
@end
