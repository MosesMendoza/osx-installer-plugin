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
    [self setPreviousEnabled:YES];
    
}

//Warn the user that we were unable to do something, they should do it themselves
- (void)displayConfigurationWarning:(NSString *)message :(NSString *)information
{
    NSAlert *warnDialog = [[NSAlert alloc] init];
    [warnDialog addButtonWithTitle:@"OK"];
    [warnDialog setMessageText:message];
    [warnDialog setInformativeText:information];
    [warnDialog setAlertStyle:NSInformationalAlertStyle];
    [warnDialog runModal];
}

- (BOOL)shouldExitPane:(InstallerSectionDirection)dir
{
    NSString *masterHostname = [puppetMasterHostname stringValue];
    NSString *agentCertname = [puppetAgentCertname stringValue];
    
    // if NSTask didn't want just a string, I would be doing *much* more correct file system access methodology.
    NSString *puppet = @"/opt/puppet/bin/puppet";
    
    // Pass the retrieved values to puppet config set
    NSTask *setMasterHostname = [NSTask launchedTaskWithLaunchPath:puppet arguments:@[@"config", @"set", @"server", masterHostname]];
    NSTask *setAgentCertname = [NSTask launchedTaskWithLaunchPath:puppet arguments:@[@"config", @"set", @"certname", agentCertname]];
    
    [setMasterHostname launch];
    [setMasterHostname waitUntilExit];
    int status = [setMasterHostname terminationStatus];
    
    if (status != 0)
    {
        //[self displayConfigurationWarning:@"Failed to set Puppet Master hostname" :@"The installer was unable to set your Puppet Master's hostname. Please add server=<hostname> to /etc/puppetlabs/puppet/puppet.conf to configure puppet"];
        NSLog(@"Hostname this failed!");
    }
    else
    {
        [setAgentCertname launch];
        [setAgentCertname waitUntilExit];
        int status = [setAgentCertname terminationStatus];
        
        if (status != 0)
        {
          //  [self displayConfigurationWarning:@"Failed to set Puppet Agent certname" :@"The installer was unable to set your Puppet Agent's certname. Please add certname=<certname> to /etc/puppetlabs/puppet/puppet.conf to configure puppet"];
            NSLog(@"Certname this failed!");
        }
    }
    return YES;
}

@end
