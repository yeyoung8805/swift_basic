import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var contentsLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.contentsLabel.textColor = .yellow
  }
}
