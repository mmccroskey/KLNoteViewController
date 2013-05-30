//
//  KLCustomViewController.m
//  KLNoteViewController
//
//  Created by Kieran Lafferty on 2013-01-03.
//  Copyright (c) 2013 Kieran Lafferty. All rights reserved.
//

#import "KLCustomViewController.h"

@implementation KLCustomViewController
-(void) viewDidLoad {
    [super viewDidLoad];
    
    UIImage *barBackgroundImage = [UIImage imageNamed:[self.info objectForKey:@"background_image_name"]];
    if (barBackgroundImage)
    {
        [self.navigationController.navigationBar setBackgroundImage: [[UIImage imageNamed:[self.info objectForKey:@"background_image_name"]] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 8, 0, 8)]
                                                      forBarMetrics: UIBarMetricsDefault];
    }
    else
    {
        NSNumber *red = [self.info objectForKey:@"red"];
        NSNumber *green = [self.info objectForKey:@"green"];
        NSNumber *blue = [self.info objectForKey:@"blue"];
        CGFloat redValue = [red floatValue];
        CGFloat greenValue = [green floatValue];
        CGFloat blueValue = [blue floatValue];
        CGFloat adjustmentValue = 0.8;
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:(redValue*adjustmentValue) green:(greenValue*adjustmentValue) blue:(blueValue*adjustmentValue) alpha:1]];
    }
    
    UIImage *icon = [UIImage imageNamed:[self.info objectForKey:@"icon_name"]];
    NSString *title = [self.info objectForKey:@"title"];
    if (icon)
    {
        NSLog(@"font names: %@", [UIFont fontNamesForFamilyName:@"Open Sans"]);
        
        CGFloat spacingBetweenIconViewAndTitleLabel = 12;
        UIFont *fontForLabel = [UIFont fontWithName:@"OpenSans-Semibold" size:20];
        
        UIImageView *iconView = [[UIImageView alloc] initWithImage:icon];
        CGSize textSize = [title sizeWithFont:fontForLabel];
        CGFloat requisiteHeight = textSize.height > iconView.frame.size.height ? textSize.height : iconView.frame.size.height;
        CGFloat requisiteWidth  = iconView.frame.size.width + textSize.width + spacingBetweenIconViewAndTitleLabel;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((iconView.frame.size.width+spacingBetweenIconViewAndTitleLabel), ((requisiteHeight-textSize.height)/2), textSize.width, textSize.height)];
        [titleLabel setFont:fontForLabel];
        [titleLabel setText:title];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        
        NSNumber *redForText = [self.info objectForKey:@"text_color_red"];
        NSNumber *greenForText = [self.info objectForKey:@"text_color_green"];
        NSNumber *blueForText = [self.info objectForKey:@"text_color_blue"];
        if (redForText && greenForText && blueForText)
        {
            [titleLabel setTextColor:[UIColor colorWithRed:[redForText floatValue] green:[greenForText floatValue] blue:[blueForText floatValue] alpha:1.0]];
        }
        else
        {
            [titleLabel setTextColor:[UIColor whiteColor]];
        }
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(8, 0, requisiteWidth, requisiteHeight)];
        [titleView addSubview:iconView];
        [titleView addSubview:titleLabel];
        UIView *containingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame), CGRectGetHeight(titleView.frame))];
        [containingView addSubview:titleView];
        
        UIBarButtonItem *leftAlignedTitleView = [[UIBarButtonItem alloc] initWithCustomView:containingView];
        [self.navigationItem setLeftBarButtonItem:leftAlignedTitleView];
    }
    else
    {
        [self.navigationItem setTitle:title];
    }
}

@end
