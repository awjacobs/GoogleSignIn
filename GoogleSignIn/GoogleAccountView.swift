import UIKit

class GoogleAccountView: UIView {

  @IBOutlet weak var accountImageView: UIImageView!
  @IBOutlet weak var signInOutButton: UIButton!
  @IBOutlet weak var signInStatusLabel: UILabel!


  let session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())


  func configureAccountView(isSignedIn: Bool, profile: GIDProfileData) {
    if isSignedIn == true {
      self.signInStatusLabel.text = "Signed In as " + profile.email
      self.signInOutButton.setTitle("Sign Out", forState: .Normal)
      if profile.hasImage {
        self.configureImageWithURL(profile.imageURLWithDimension(100))
      }
    } else {
      self.signInStatusLabel.text = "Not Signed In"
      self.signInOutButton.setTitle("Sign In", forState: .Normal)
    }
  }

  func configureImageWithURL(url: NSURL) {
    let urlRequest = NSURLRequest(URL: url)
    session.downloadTaskWithRequest(urlRequest) { (location, urlResponse, error) -> Void in
      if error == nil {
        let data = NSData(contentsOfURL: location!)

        //  NSURLSession dowloads images on a background thread. When making changes to onscreen UI
        //  elements, it is required that you make those changes on the Main(UI) thread. We use
        //  grand central dispatch (GCD) to force the image to be created and shown on-screen on the
        //  main thread. See: (https://chritto.wordpress.com/2012/12/20/updating-the-ui-from-another-thread/ )
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          let profileImage = UIImage(data: data!)
          self.accountImageView.image = profileImage
        })
      }
    }.resume()
  }


}
