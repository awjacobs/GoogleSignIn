import UIKit

class GoogleDriveDataSource: NSObject, UITableViewDataSource {

  let kCellReuseId = "DriveItemCell"
  let service: GTLServiceDrive
  var driveFiles = [GTLDriveFile]()

  weak var parent: DriveViewController?

  init(user: GIDGoogleUser, parent:DriveViewController) {
    self.service = GTLServiceDrive()
    self.parent = parent

    self.service.authorizer = user.authentication.fetcherAuthorizer()
  }

  // MARK: UITableViewDataSource
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellReuseId)!
    let driveFile = driveFiles[indexPath.row]
    cell.textLabel?.text = driveFile.name
    return cell
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return driveFiles.count
  }

  func fetchFiles() {
    let query = GTLQueryDrive.queryForFilesList()
    query.pageSize = 15 // Number of files to retrieve
    query.fields = "nextPageToken, files(id, name)"
    self.service.executeQuery(query) { (ticket: GTLServiceTicket!, fileList: AnyObject!, error) -> Void in
      if error == nil {
        let files = fileList.files as! [GTLDriveFile]
        self.driveFiles.appendContentsOf(files)
        self.parent?.refreshTable()
      } else if error.code == 403 { // Not Authorized
        self.requestGoogleDrivePermissions()
      }
    }
  }

  func requestGoogleDrivePermissions() {
    let signIn = GIDSignIn.sharedInstance()
    let driveScope = kGTLAuthScopeDriveMetadataReadonly

    // Request from user to append Drive authentication
    var currentScopes = signIn.scopes
    currentScopes.append(driveScope)
    signIn.scopes = currentScopes

    signIn.signIn()
  }
}
