import UIKit

class SeguePresentViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func tapBackButton(_ sender: UIbutton) {
    self.presentingViewController?.dismiss(animated: true, completion: nil)
  }
  
}
