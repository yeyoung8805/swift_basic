import UIKit

class ViewController: UIViewController, SendDataDelegate {
  override func viewDidLoad() {
    spuer.viewDidLoad()
    print("ViewController 뷰가 로드 되었다.")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("ViewController 뷰가 나타날 것이다.")
  }

  override func viewDidAppear(_ animated: Bool) {
    spuer.viewDidAppear(animated)
    print("ViewController 뷰가 나타났다.")
  }

  override func viewWillDisappear(_ animated: Bool) {
    spuer.viewWillDisappear(animated)
    print("ViewController 뷰가 사라질 것이다.")
  }

  override func viewDidDisappear(_ animated: Bool) {
    spuer.viewDidDisappear(animated)
    print("ViewController 뷰가 사라졌다.")
  }

  @IBAction func tapCodePresentButton(_ sender: UIButton) {
    guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") as? CodePresentViewController else {return}
    viewController.modalPresentationStyle = .fullScreen
    viewController.name = "Young"
    viewController.delegate = self
    self.present(viewController, animated: true, completion: nil)
  }

  @IBAction func tapCodePushButton(_ sender: UIButton) {
    guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePushViewController") as? CodePushViewController else {return}
    viewController.name = "Young"
    self.navigationController?.pushViewController(viewController, animated: true)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let viewController = segue.destination as? SeguePushViewController {
      viewController.name = "Young"
    }
  }

  func sendData(name: String) {
    self.nameLabel.text = name
    self.nameLabel.sizeToFit()
  }
}
