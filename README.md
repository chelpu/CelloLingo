CelloLingo
==========
This is an application meant to help people learn more about playing cello. To get the full experience of the app, an instrument is required.

## Installation
    git clone git@github.com:chelpu/CelloLingo.git

## Usage
To run the app, you'll need a SoundCloud developer account. Once you've created an app on SoundCloud, you'll receive a Client ID and a Client secret. Using these, you can create a secrets class which will be used to authenticate requests to SoundCloud.

# Example
        //
        //  Secrets.h
        //  CelloLingo
        //
        
        #import <Foundation/Foundation.h>
        
        @interface Secrets : NSObject
        
        @property (strong, nonatomic) NSString *SCClientID;
        @property (strong, nonatomic) NSString *SCSecret;
        
        - (id)init;
        
        @end
        
        //
        //  Secrets.m
        //  CelloLingo
        //
        
        #import "Secrets.h"
        
        @implementation Secrets
        
        - (id)init {
            if(self = [super init]) {
                self.SCClientID = @"{ Your SoundCloud app client id }";
                self.SCSecret = @"{ Your SoundCloud app secret }";
            }
            return self;
        }
        
        @end


