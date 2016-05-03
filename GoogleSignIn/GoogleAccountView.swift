import UIKit

class GoogleAccountView: UIView {

  @IBOutlet weak var accountImageView: UIImageView!
  @IBOutlet weak var signInOutButton: UIButton!
  @IBOutlet weak var signInStatusLabel: UILabel!


  func configureAccountView(isSignedIn: Bool, profile: GIDProfileData) {
    if isSignedIn == true {
      self.signInStatusLabel.text = "Signed In as " + profile.email
      self.signInOutButton.setTitle("Sign Out", forState: .Normal)
    } else {
      self.signInStatusLabel.text = "Not Signed In"
      self.signInOutButton.setTitle("Sign In", forState: .Normal)
    }
  }


}
