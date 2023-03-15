import UIKit

class ViewController: UIViewController {
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
    guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") else {return}
    viewController.modalPresentationStyle = .fullScreen
    self.present(viewController, animated: true, completion: nil)
  }

  @IBAction func tapCodePushButton(_ sender: UIButton) {
    guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePushViewController") else {return}
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}
