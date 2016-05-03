import UIKit

class DriveViewController: UIViewController {

  @IBOutlet weak var tableVIew: UITableView!
  @IBOutlet weak var accountView: GoogleAccountView!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.accountView.configureAccountView(false)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

