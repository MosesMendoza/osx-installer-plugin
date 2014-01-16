//
//  PuppetConfigurer.m
//  puppet-enterprise-installer-plugin
//
//  Created by moses on 1/16/14.
//  Copyright (c) 2014 Puppet Labs. All rights reserved.
//

#import "PuppetConfigurer.h"

@implementation PuppetConfigurer


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


-(void) writeConfigFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *installerDir = [[[NSProcessInfo processInfo] environment] objectForKey:@"TMPDIR"];
    NSURL *installerURL = [NSURL URLWithString:installerDir];
    NSURL *configFile = [installerURL URLByAppendingPathComponent:@"PuppetEnterpriseInterviewConfiguration.txt"];
    
    NSString *configFileContents = [[NSString alloc] initWithFormat:@"PUPPET_MASTER_HOSTNAME=%@\nPUPPET_AGENT_CERTNAME=%@", [self agentCertname], [self masterHostname]];
    
    NSData *configFileData = [configFileContents dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *configFileAttributes = [[NSMutableDictionary alloc] init];
    [configFileAttributes setObject:[NSNumber numberWithInt:896] forKey:NSFilePosixPermissions]; /*896 is Decimal for 1600 octal*/
    [configFileAttributes setObject: @"admin" forKey:NSFileGroupOwnerAccountName];
   
    NSLog(@"Puppet Enterprise: Creating temporary configuration file for setting puppet agent certname and master hostname");
    
    BOOL success = [fileManager createFileAtPath:[configFile path] contents:configFileData attributes:configFileAttributes];

    if (success == NO)
    {
        [self displayConfigurationWarning:@"Unable to configure Puppet" :@"Please set certname=< this Agent certname > and server=< Puppet Master Hostname > entries in /etc/puppetlabs/puppet/puppet.conf"];
    }
    else
    {
        
        NSLog(@"Puppet Enterprise: Successfully created configuration file.");
 
    }

}

@end
