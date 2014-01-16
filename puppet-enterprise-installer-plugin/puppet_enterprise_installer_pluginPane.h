//
//  puppet_enterprise_installer_pluginPane.h
//  puppet-enterprise-installer-plugin
//
//  Created by moses on 1/14/14.
//  Copyright (c) 2014 Puppet Labs. All rights reserved.
//

#import <InstallerPlugins/InstallerPlugins.h>

@interface puppet_enterprise_installer_pluginPane : InstallerPane

{
    IBOutlet NSTextField *puppetMasterHostname;
    IBOutlet NSTextField *puppetAgentCertname;
}

- (void) displayConfigurationWarning:(NSString *)message :(NSString *)information;

@end
