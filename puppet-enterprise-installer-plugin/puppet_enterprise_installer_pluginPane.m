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


- (void)didEnterPane:(InstallerSectionDirection)dir
{
    // Initialize the text fields to empty
    [puppetMasterHostname setStringValue:@"puppet.localdomain"];
    [puppetAgentCertname setStringValue:[[NSHost currentHost] name]];
    
    // Enable the continue and go back buttons
    [self setNextEnabled:YES];
    [self setNextEnabled:YES];
    
}

- (IBAction)registerCheck:(id)aSnd
{
    // This will be renamed and used for actually writing our puppet.conf file
}

@end
