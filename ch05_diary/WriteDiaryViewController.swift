import UIKit

enum DiaryEditorMode {
  case new
  case edit(IndexPath, Diary)
}

protocol WriteDiaryViewDelegate: AnyObject {
  func didSelectRegister(diary: Diary)
}

class WriteDiaryViewController: UIViewController {

  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var contentsTextView: UITextView!
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var confirmButton: UIBarButtonItem!

  private let datePicker = UIDatePicker()
  private var diaryDate: Date?
  weak var delegate: WriteDiaryViewDelegate?
  var diaryEditorMode: DiaryEditorMode = .new

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureContentsTextView()
    self.configureDatePicker()
    self.configureInputField()
    self.configureEditMode()
    self.confirmButton.isEnabled = false //등록 버튼을 처음에 비활성화 되게 한다.
  }

  private func configureEditMode() {
    switch self.diaryEditorMode {
      case let .edit(_, diary):
        self.titleTextField.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateTextField.text = self.dateToString(date: diary.date)
        self.diaryDate = diary.date
        self.confirmButton.title = "수정"

      default:
        break
    }
  }

  private func dateToString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date)
  }

  private func configureContentsTextView() {
    let borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
    self.contentsTextView.layer.borderColor = borderColor.cgColor
    self.contentsTextView.layer.borderWidth = 0.5
    self.contentsTextView.layer.cornerRadius = 5.0

  }

  private func configureDatePicker() {
    self.datePicker.datePickerMode = .date
    self.datePicker.preferredDatePickerStyle = .wheels
    self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
    self.datePicker.locale = Locale(identifier: "ko-KR")
    self.dateTextField.inputView = self.datePicker // inputView 를 클릭하면 키보드가 아닌 DatePicker 가 뜨게 된다.
  }

  private func configureInputField() {
    self.contentsTextView.delegate = self
    self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
    self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
  }

  @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
    guard let title = self.titleTextField.text else { return }
    guard let contents = self.contentsTextView.text else { return }
    guard let date = self.diaryDate else { return }

    switch self.diaryEditorMode {
      case .new:
        let diary = Diary(
          uuidString: UUID().uuidString,
          title: title,
          contents: contents,
          date: date,
          isStar: false)
        self.delegate?.didSelectRegister(diary: diary)

      case let .edit(indexPath, diary):
        let diary = Diary(
          uuidString: diary.uuidString,
          title: title,
          contents: contents,
          date: date,
          isStar: diary.isStar)
        NotificationCenter.default.post(
          name: NSNotification.Name("editDiary"),
          object: diary,
          userInfo: nil
        )
    }
    self.navigationController?.popViewController(animated: true)
  }

  @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
    formatter.locale = Locale(identifier: "ko_KR")
    self.diaryDate = datePicker.date
    self.dateTextField.text = formatter.string(from: datePicker.date)
    self.dateTextField.sendActions(for: editingChanged)
  }

  @objc private func titleTextFieldDidChange(_ textField: UITextField) {
    self.validateInputField()
  }

  @objc private func dateTextFieldDidChange(_ textField: UITextField) {
    self.validateInputField()
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true) //빈 화면을 누를때마다  키보드나 datePicker 가 사라지게 한다.
  }

  private func validateInputField() {
    self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true)
      && !(self.dateTextField.text?.isEmpty ?? true) && !self.contentsTextView.text.isEmpty //모두 비어있지 않으면 -> confirm 버튼 활성화 시킨다.
  }
}

extension WriteDiaryViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    self.validateInputField()
  }
}
