import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var tasks = [Task]() {
    didSet {
      selft.saveTasks()
    }
    
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    self.loadTasks()
  }

  @IBAction func tapEditButton(_ sender: UIBarButtonItem) {

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
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var task = self.tasks[indexPath.row]
    task.done !task.done
    self.tasks[indexPath.row] = task
    self.tableView.reloadRows(at: [indexPath], with: .automatic)
  }
}
