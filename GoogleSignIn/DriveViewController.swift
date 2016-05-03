import UIKit

class DriveViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

  @IBOutlet weak var tableVIew: UITableView!
  @IBOutlet weak var accountView: GoogleAccountView!

  override func viewDidLoad() {
    super.viewDidLoad()
    GIDSignIn.sharedInstance().delegate = self
    GIDSignIn.sharedInstance().uiDelegate = self
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    let signedInInstance = GIDSignIn.sharedInstance()
    if signedInInstance.currentUser == nil {
      signedInInstance.signIn()
    }

  }

  func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
    if error == nil {
      self.accountView.configureAccountView(true, profile: user.profile)
    }

  }

  func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {

  }

}

