//
//  DateScreenViewController.swift
//  MeachineTask
//
//  Created by Senthilnathan M on 06/02/21.
//

import UIKit
import CoreData

class DateScreenViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var Tableview: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context:NSManagedObjectContext!
    @IBOutlet weak var DatePickerview: UIView!
    var date:String = ""
    @IBOutlet weak var SelectTime: UITextField!
    @IBOutlet weak var Datepicker: UIDatePicker!
    @IBOutlet weak var TimeEntryView: UIView!
    @IBOutlet weak var ViewDetailView: UIView!
    var Date = [String]()
    var Time = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        TimeEntryView.isHidden=true
        DatePickerview.isHidden=true
        ViewDetailView.isHidden=true
        let cellReuseIdentifier = "cell"
        self.Tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
              
              // (optional) include this line if you want to remove the extra empty cell divider lines
              // self.tableView.tableFooterView = UIView()

              // This view controller itself will provide the delegate methods and row data for the table view.
        Tableview.delegate = self
        Tableview.dataSource = self
        // Do any additional setup after loading the view.
    }
    @IBAction func Back(_ sender: Any) {
        TimeEntryView.isHidden=true
    }
    @IBAction func SelectDate(_ sender: Any) {
        DatePickerview.isHidden=false
        if TimeEntryView.isHidden==true {
            Datepicker.datePickerMode = .date
        }
        else
        {
            Datepicker.datePickerMode = .time
        }
        
    }
    
    @IBAction func Viewdetails(_ sender: Any) {
        ViewDetailView.isHidden=false
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TimeEntry")
                request.returnsObjectsAsFaults = false
                do {
                    
                        let result = try context.fetch(request)
                        for data in result as! [NSManagedObject] {
                            Time.append(data.value(forKey: "time") as! String)
                            Date.append(data.value(forKey: "date") as! String)
                        }
                        self.Tableview.reloadData()
        
                    
                } catch {
                    print("Fetching data Failed")
                }
        
    }
    @IBAction func Cancel(_ sender: Any) {
        DatePickerview.isHidden=true
    }
    @IBAction func Done(_ sender: Any) {
        DatePickerview.isHidden=true
        if TimeEntryView.isHidden==true {
            TimeEntryView.isHidden=false
            let formatter = DateFormatter()
               formatter.dateFormat = "dd-MM-yyyy"
            date = formatter.string(from: Datepicker.date)
        }
        else
        {
            let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "h:mm a" // set this date format string
                SelectTime.text = timeFormatter.string(from: Datepicker.date)
        }
        
    }
    @IBAction func TimeEntrySubmit(_ sender: Any) {
        if SelectTime.text==nil {
            let alert = UIAlertController(title: "Alert", message: "Kindly Select the Time", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            openDatabse()
        }
        
    }
    func openDatabse()
        {
            context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "TimeEntry", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            saveData(UserDBObj:newUser)
        }

        func saveData(UserDBObj:NSManagedObject)
        {
            UserDBObj.setValue(date, forKey: "date")
            UserDBObj.setValue(SelectTime.text, forKey: "time")
            print("Storing Data..")
            do {
                try context.save()
                let alert = UIAlertController(title: "Alert", message: "Entry added Successfully", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.TimeEntryView.isHidden=true
            } catch {
                print("Storing data Failed")
            }

           
        }
    @IBAction func SelectTimePicker(_ sender: Any) {
        Datepicker.datePickerMode = .time
        DatePickerview.isHidden=false
    }
    

    @IBAction func ViewDetailBAck(_ sender: Any) {
        ViewDetailView.isHidden=true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.Date.count
        }
        
        // create a cell for each table view row
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // create a new cell if needed or reuse an old one
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateEntryTableViewCell") as! DateEntryTableViewCell
            cell.Date.text=Date[indexPath.row]
            cell.Time.text=Time[indexPath.row]
            return cell
        }
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
