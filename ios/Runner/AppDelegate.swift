import UIKit
import Flutter
import AuthenticationServices

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var appleSignResult: FlutterResult?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channelSift = FlutterMethodChannel(name: "com.kigabyte.laofitness/apple_sign",  binaryMessenger: controller.binaryMessenger)
        channelSift.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if (call.method == "init") {
                self.appleSignResult = result
                self.handleAppleIdRequest()
            } else {
                result(FlutterMethodNotImplemented)
            }
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func handleAppleIdRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

extension AppDelegate: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("User id is \(userIdentifier) \n Given Name is \(String(describing: fullName?.givenName)) \n Family Name is \(String(describing: fullName?.familyName)) \n Email id is \(String(describing: email))")
//            appleSignResult!(["user": userIdentifier, "fullName": (fullName?.givenName)! + " " + (fullName?.familyName)!, "email": email! as String])
            appleSignResult!(appleIDCredential.identityToken)
        } else {
            appleSignResult!("Not found any auth")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        appleIDProvider.getCredentialState(forUserID: userID) {  (credentialState, error) in
//            switch credentialState {
//            case .authorized:
//                break
//            case .revoked:
//                appleSignResult!("revoked")
//                break
//            case .notFound:
//                appleSignResult!("notFound")
//                break
//            default:
//                break
//            }
//        }
    }
}
