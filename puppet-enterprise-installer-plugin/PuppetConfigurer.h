//
//  PuppetConfigurer.h
//  puppet-enterprise-installer-plugin
//
//  Created by moses on 1/16/14.
//  Copyright (c) 2014 Puppet Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

// PuppetConfigurer is a tiny class that does one thing:
// Write a file containing the user's entry of Puppet Master hostname and Puppet Agent certname that can be sourced by the puppet postinstall script.

@interface PuppetConfigurer : NSObject

@property NSString* agentCertname;
@property NSString* masterHostname;

- (void)displayConfigurationWarning:(NSString *)message :(NSString *)information;
- (void) writeConfigFile;

@end
