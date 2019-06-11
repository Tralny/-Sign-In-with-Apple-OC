//
//  ViewController.m
//  SignInwithAppleObj-C
//
//  Created by Tralny on 2019/6/11.
//  Copyright © 2019 tralny. All rights reserved.
//

#import "ViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>
@interface ViewController ()<ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>


@property (weak, nonatomic) IBOutlet UILabel *user;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *givenName;
@property (weak, nonatomic) IBOutlet UILabel *familyName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)signInWithApple:(id)sender {
    NSLog(@"🌚🌚");
    ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
    ASAuthorizationAppleIDRequest *request = [appleIDProvider createRequest];
    request.requestedScopes = @[ASAuthorizationScopeFullName,ASAuthorizationScopeEmail];
    
    ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
    authorizationController.delegate = self;
    authorizationController.presentationContextProvider = self;
    [authorizationController performRequests];
    
}


-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization{
    
    NSLog(@"~~~");
    
    ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
    self.user.text = appleIDCredential.user;
    self.email.text = appleIDCredential.email;
    self.familyName.text = appleIDCredential.fullName.familyName;
    self.givenName.text = appleIDCredential.fullName.givenName;
    NSData *identityToken = appleIDCredential.identityToken;
    NSData *authorizationCode = appleIDCredential.authorizationCode;
    
    
    NSLog(@"user:%@ \n,email:%@ \n,familyName:%@ \n,identityToken:%@ \n,authorizationCode:%@ \n",self.user.text,self.email.text,self.familyName.text,identityToken,authorizationCode);
    
    
}

@end
