import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    spuer.viewDidLoad()
  }

  @IBAction func tapCodePresentButton(_ sender: UIButton) {
    guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") else {return}
    viewController.modalPresentationStyle = .fullScreen
    self.present(viewController, animated: true, completion: nil)
  }

  @IBAction func tapCodePushButton(_ sender: UIButton) {
    guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePushViewController") else {return}
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}
