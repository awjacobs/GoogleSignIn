import UIKit

class GoogleAccountView: UIView {

  @IBOutlet weak var accountImageView: UIImageView!
  @IBOutlet weak var signInOutButton: UIButton!
  @IBOutlet weak var signInStatusLabel: UILabel!


  func configureAccountView(isSignedIn: Bool) {
    if isSignedIn == true {

    } else {
      self.signInStatusLabel.text = "Not Signed In"
      self.signInOutButton.setTitle("Sign In", forState: .Normal)
    }
  }


}
