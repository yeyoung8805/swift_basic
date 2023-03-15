import UIKit

class SettingViewController: UIViewController {

  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var yellowButton: UIButton!
  @IBOutlet weak var purpleButton: UIButton!
  @IBOutlet weak var greenButton: UIButton!
  @IBOutlet weak var blackButton: UIButton!
  @IBOutlet weak var blueButton: UIButton!
  @IBOutlet weak var orangeButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func tapTextColorButton(_ sender: UIButton) {
    if sender == self.yellowButton {
      self.changeTextColor(color: .yellow)
    } else if sender == self.purpleButton {
      self.changeTextColor(color: .purple)
    // } else if sender == self.greenButton {
    } else {
      self.changeTextColor(color: .green)
    }
  }

  @IBAction func tapBackgroundColorButton(_ sender: UIButton) {
    if sender == self.blackButton {
      self.changeBackgroundColorButton(color: .black)
    } else if sender == self.blueButton {
      self.changeBackgroundColorButton(color: .blue)
    // } else if sender == self.orangeButton {
    } else {
      self.changeBackgroundColorButton(color: .orange)
    }
  }

  @IBAction func tapSaveButton(_ sender: UIButton) {

  }

  private func changeTextColor(color: UIColor) {
    self.yellowButton.alpha = color == UIColor.yellow? 1: 0.2
    self.purpleButton.allpha = color == UIColor.purple? 1: 0.2
    self.greenButton.allpha = color == UIColor.green? 1: 0.2
  }

  private func changeBackgroundColorButton(color: UIColor) {
    self.blackButton.alpha = color == UIColor.black? 1: 0.2
    self.blueButton.allpha = color == UIColor.blue? 1: 0.2
    self.orangeButton.allpha = color == UIColor.orange? 1: 0.2
  }
}
