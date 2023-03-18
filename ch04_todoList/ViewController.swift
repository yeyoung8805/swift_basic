import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet var editButton: UIBarButtonItem!
  var doneButton: UIBarButtonItem?
  var tasks = [Task]() {
    didSet {
      selft.saveTasks()
    }
    
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.loadTasks()
  }

  @objc func doneButtonTap() {
    self.navigationItem.leftBarButtonItem = self.editButton
    self.tableView.setEditing(false, animated: true)
  }

  @IBAction func tapEditButton(_ sender: UIBarButtonItem) {
    guard !self.tasks.isEmpty else { return } //비어있으면 수정할 필요가 없기 때문에 비어있지 않을 경우만 수정하게 한다.
    self.navigationItem.leftBarButtonItem = self.doneButton
    self.tableView.setEditing(true, animated: true)
  }

  @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert)
    let registerButton = UIAlertAction(title: "등록", style: .default, handler: {[weak self] _ in
      // debugPrint("\(alert.textField?[0].text)")
      guard let title = alert.textField?[0].text else { return }
      let task = Task(title: title, done: false)
      self?.tasks.append(task)
      self?.tableView.reloadData()
    })
    let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
    alert.addAction(cancelButton)
    alert.addAction(registerButton)
    alert.addTextField(configurationHandler: { textField in
      textField.placeHolder= "할 일을 입력해주세요."
    })
    self.present(alert, animated: true, completion: nil)
  }

  func saveTasks() {
    let data = self.tasks.map {
      [
        "title": $0.title,
        "done": $0.done
      ]
    }
    let userDefaults = userDefaults.standard
    userDefaults.set(data, forKey: "tasks")
  }

  func loadTasks() {
    let userDefaults = userDefaults.standard
    guard let data =  userDefaults.object(forKey: "tasks") as? [[String: Any]] else { return }
    self.tasks = data.compactMap {
      guard let title = $0["title"] as? String else { return nil }
      guard let done = $0["done"] as? Bool else { return nil }
      return Task(title: title, done: done)
    }
  }

}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
    return self.tasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let task = self.tasks[indexPath.row]
    cell.textLabel?.text = task.title
    if task.done {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
    return cell
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //선택한 셀을 삭제
    self.tasks.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .automatic)

    if self.tasks.isEmpty {
      self.doneButtonTap() //모두 삭제 되었으면, 편집모드로 빠져나오게 함.
    }
  }

  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    var tasks = self.tasks
    let task = tasks[sourceIndexPath.row]
    tasks.remove(at: sourceIndexPath.row) //원래 위치에 있던 할일을 삭제하고
    tasks.insert(task, at: destinationIndexPath.row) //이동할 위치를 at 으로 넘겨주고
    self.tasks = tasks //self.tasks에 tasks를 대입하여 재정렬 시켜준다.
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var task = self.tasks[indexPath.row]
    task.done !task.done
    self.tasks[indexPath.row] = task
    self.tableView.reloadRows(at: [indexPath], with: .automatic)
  }
}
