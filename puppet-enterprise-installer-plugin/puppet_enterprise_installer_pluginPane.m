//
//  puppet_enterprise_installer_pluginPane.m
//  puppet-enterprise-installer-plugin
//
//  Created by moses on 1/14/14.
//  Copyright (c) 2014 Puppet Labs. All rights reserved.
//

#import "puppet_enterprise_installer_pluginPane.h"

@implementation puppet_enterprise_installer_pluginPane

- (NSString *)title
{
	return [[NSBundle bundleForClass:[self class]] localizedStringForKey:@"PaneTitle" value:nil table:nil];
}

@end
