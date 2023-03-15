import UIKit

class SeguePushViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func tapBackButton(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    // self.navigationController?.popToRootViewController(animated: true)
  }
}
