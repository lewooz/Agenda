//
//  ChooseDateViewController.swift
//  Agenda
//
//  Created by Levent Özkan on 10.12.2019.
//  Copyright © 2019 Levent Özkan. All rights reserved.
//

import UIKit
import CoreData

class ChooseDateViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UIPickerViewDelegate,UIPickerViewDataSource {
   
    var detailViewController: DetailViewController? = nil
    
    var ocakArray = [Int]()
    var subatArray = [Int]()
    var martArray = [Int]()
    var nisanArray = [Int]()
    var mayisArray = [Int]()
    var haziranArray = [Int]()
    var temmuzArray = [Int]()
    var agustosArray = [Int]()
    var eylulArray = [Int]()
    var ekimArray = [Int]()
    var kasimArray = [Int]()
    var aralikArray = [Int]()
    
    var ocakDaysArray : DaysForTheMonth?
    var subatDaysArray : DaysForTheMonth?
    var martDaysArray : DaysForTheMonth?
    var nisanDaysArray : DaysForTheMonth?
    var mayisDaysArray : DaysForTheMonth?
    var haziranDaysArray : DaysForTheMonth?
    var temmuzDaysArray : DaysForTheMonth?
    var agustosDaysArray : DaysForTheMonth?
    var eylulDaysArray : DaysForTheMonth?
    var ekimDaysArray : DaysForTheMonth?
    var kasimDaysArray : DaysForTheMonth?
    var aralikDaysArray : DaysForTheMonth?
    
    var allMonthDaysArray = [DaysForTheMonth]()
    
    var monthHeader : UIButton? = nil
    
    var canvasCurrentImage : NSData?
    var imageMap = [String : NSData]()
    var selectedYear = 2020
    
    
    @IBOutlet weak var yearPicker: UIPickerView!
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        tableview.delegate = self
        tableview.dataSource = self
        yearPicker.delegate = self
        yearPicker.dataSource = self
        
        
        
        
        for i in 1...getDaysForMonth(year: 2020, month: 1){
            ocakArray.append(i)
        }
        
        
        for i in 1...getDaysForMonth(year: 2020, month: 2){
            subatArray.append(i)
        }
        
        
        
        for i in 1...getDaysForMonth(year: 2020, month: 3){
            martArray.append(i)
        }
        
        
        for i in 1...getDaysForMonth(year: 2020, month: 4){
            nisanArray.append(i)
        }
        
        
        for i in 1...getDaysForMonth(year: 2020, month: 5){
            mayisArray.append(i)
        }
        
        
       
        for i in 1...getDaysForMonth(year: 2020, month: 6){
            haziranArray.append(i)
        }
        
        
        for i in 1...getDaysForMonth(year: 2020, month: 7){
            temmuzArray.append(i)
        }
        
        for i in 1...getDaysForMonth(year: 2020, month: 8){
            agustosArray.append(i)
        }
        
        for i in 1...getDaysForMonth(year: 2020, month: 9){
            eylulArray.append(i)
        }
        
        for i in 1...getDaysForMonth(year: 2020, month: 10){
            ekimArray.append(i)
        }
        
        for i in 1...getDaysForMonth(year: 2020, month: 11){
            kasimArray.append(i)
        }
        
        for i in 1...getDaysForMonth(year: 2020, month: 12){
            aralikArray.append(i)
        }
        
        ocakDaysArray = DaysForTheMonth(isExpanded: false, daysArray: ocakArray)
        subatDaysArray = DaysForTheMonth(isExpanded: false, daysArray: subatArray)
        martDaysArray = DaysForTheMonth(isExpanded: false, daysArray: martArray)
        nisanDaysArray = DaysForTheMonth(isExpanded: false, daysArray: nisanArray)
        mayisDaysArray = DaysForTheMonth(isExpanded: false, daysArray: mayisArray)
        haziranDaysArray = DaysForTheMonth(isExpanded: false, daysArray: haziranArray)
        temmuzDaysArray = DaysForTheMonth(isExpanded: false, daysArray: temmuzArray)
        agustosDaysArray = DaysForTheMonth(isExpanded: false, daysArray: agustosArray)
        eylulDaysArray = DaysForTheMonth(isExpanded: false, daysArray: eylulArray)
        ekimDaysArray = DaysForTheMonth(isExpanded: false, daysArray: ekimArray)
        kasimDaysArray = DaysForTheMonth(isExpanded: false, daysArray: kasimArray)
        aralikDaysArray = DaysForTheMonth(isExpanded: false, daysArray: aralikArray)
        
        allMonthDaysArray.append(ocakDaysArray!)
        allMonthDaysArray.append(subatDaysArray!)
        allMonthDaysArray.append(martDaysArray!)
        allMonthDaysArray.append(nisanDaysArray!)
        allMonthDaysArray.append(mayisDaysArray!)
        allMonthDaysArray.append(haziranDaysArray!)
        allMonthDaysArray.append(temmuzDaysArray!)
        allMonthDaysArray.append(agustosDaysArray!)
        allMonthDaysArray.append(eylulDaysArray!)
        allMonthDaysArray.append(ekimDaysArray!)
        allMonthDaysArray.append(kasimDaysArray!)
        allMonthDaysArray.append(aralikDaysArray!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name?(NSNotification.Name(rawValue: "imagesaved")), object: nil)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allMonthDaysArray.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        monthHeader = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 75))
        monthHeader?.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        monthHeader!.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        monthHeader?.isUserInteractionEnabled = true
        monthHeader?.addTarget(self, action: #selector(headerClicked), for: UIControl.Event.touchUpInside)
              switch section {
              case 0:
                monthHeader!.setTitle("Ocak", for: UIControl.State.normal)
                  case 1:
                    monthHeader!.setTitle("Şubat", for: UIControl.State.normal)
                  
                  case 2:
                  
                monthHeader!.setTitle("Mart", for: UIControl.State.normal)
                  case 3:
                  
                monthHeader!.setTitle("Nisan", for: UIControl.State.normal)
                  case 4:
                  
                monthHeader!.setTitle("Mayıs", for: UIControl.State.normal)
                  case 5:
                  
                monthHeader!.setTitle("Haziran", for: UIControl.State.normal)
                  case 6:
                 
                monthHeader!.setTitle("Temmuz", for: UIControl.State.normal)
                  case 7:
                 
                monthHeader!.setTitle("Ağustos", for: UIControl.State.normal)
                  case 8:
                  
                monthHeader!.setTitle("Eylül", for: UIControl.State.normal)
                  case 9:
                  
                monthHeader!.setTitle("Ekim", for: UIControl.State.normal)
                  case 10:
                  
                monthHeader!.setTitle("Kasım", for: UIControl.State.normal)
                  case 11:
                  
                monthHeader!.setTitle("Aralık", for: UIControl.State.normal)
              default:
                
                monthHeader!.setTitle("Ocak", for: UIControl.State.normal)
              }
        
        monthHeader!.tag = section
       
        return monthHeader
    }
    
    @objc func reloadTable(){
        imageMap.removeAll()
        self.tableview.reloadData()
        
    }
    
    @objc func headerClicked(header : UILabel){
        let section = header.tag
        print(section)
        allMonthDaysArray[section].isExpanded.toggle()
        var indexPaths = [IndexPath]()
        
        for row in allMonthDaysArray[section].daysArray.indices{
            let indexPath = IndexPath(row: row , section: section)
            indexPaths.append(indexPath)
        }

        if allMonthDaysArray[section].isExpanded{
            
            tableview.insertRows(at: indexPaths, with: UITableView.RowAnimation.fade)
        }else{
            tableview.deleteRows(at: indexPaths, with: UITableView.RowAnimation.fade)
        }
        
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toCanvas"{
            self.splitViewController?.preferredDisplayMode = .primaryHidden
            let indexPath = tableview.indexPathForSelectedRow
            let compareDay = String(indexPath!.row + 1)
            let compareMonth = String(indexPath!.section + 1)
            let compareYear = String(selectedYear)
            let compareString = compareDay + compareMonth + compareYear
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.selectedDay = indexPath!.row + 1
            controller.selectedMonth = indexPath!.section + 1
            controller.selectedYear = self.selectedYear
            
            if imageMap[compareString] != nil {
                controller.imageData = imageMap[compareString]
            }

            detailViewController = controller
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if allMonthDaysArray[section].isExpanded {
            return allMonthDaysArray[section].daysArray.count
            
        }else{
            
            return 0
        }
        
     
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        let month = allMonthDaysArray[indexPath.section]
        let compareDay = String(indexPath.row + 1)
        let compareMonth = String(indexPath.section + 1)
        let compareYear = String(selectedYear)
        let compareString = compareDay + compareMonth + compareYear
        cell?.textLabel?.text = String(month.daysArray[indexPath.row])
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedImages")
        fetchrequest.predicate = NSPredicate(format: "savedImageId = %@", compareString)
        fetchrequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchrequest)
            
            if results.count > 0{
                 
                cell?.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                
                for result in results as! [NSManagedObject]{
                    
                   canvasCurrentImage = result.value(forKey: "image") as? NSData
                imageMap.updateValue(canvasCurrentImage!, forKey: compareString)
                    print(compareString)
                }
                 
            }else{
                cell?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }

        } catch {
            print(error)
        }

        return cell!
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return 6
       }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "2020"
            case 1:
            return "2021"
            case 2:
            return "2022"
            case 3:
            return "2023"
            case 4:
            return "2024"
            case 5:
            return "2025"
        default:
            return "2020"
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        allMonthDaysArray.removeAll()
        ocakArray.removeAll()
        subatArray.removeAll()
        martArray.removeAll()
        nisanArray.removeAll()
        mayisArray.removeAll()
        haziranArray.removeAll()
        temmuzArray.removeAll()
        agustosArray.removeAll()
        eylulArray.removeAll()
        ekimArray.removeAll()
        kasimArray.removeAll()
        aralikArray.removeAll()
        
        
        switch row {
        case 0:
            selectedYear = 2020
            for i in 1...getDaysForMonth(year: 2020, month: 1){
                ocakArray.append(i)
                
            }
            
            for i in 1...getDaysForMonth(year: 2020, month: 2){
                subatArray.append(i)
            }
           
            for i in 1...getDaysForMonth(year: 2020, month: 3){
                martArray.append(i)
            }
          
            for i in 1...getDaysForMonth(year: 2020, month: 4){
                nisanArray.append(i)
            }
          
            for i in 1...getDaysForMonth(year: 2020, month: 5){
                mayisArray.append(i)
            }
            
           
            for i in 1...getDaysForMonth(year: 2020, month: 6){
                haziranArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2020, month: 7){
                temmuzArray.append(i)
            }
           
            for i in 1...getDaysForMonth(year: 2020, month: 8){
                agustosArray.append(i)
            }
        
            for i in 1...getDaysForMonth(year: 2020, month: 9){
                eylulArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2020, month: 10){
                ekimArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2020, month: 11){
                kasimArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2020, month: 12){
                aralikArray.append(i)
            }
            
            case 1:
            selectedYear = 2021
            for i in 1...getDaysForMonth(year: 2021, month: 1){
                ocakArray.append(i)
            }
           
            for i in 1...getDaysForMonth(year: 2021, month: 2){
                subatArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2021, month: 3){
                martArray.append(i)
            }
           
            for i in 1...getDaysForMonth(year: 2021, month: 4){
                nisanArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2021, month: 5){
                mayisArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2021, month: 6){
                haziranArray.append(i)
            }
          
            for i in 1...getDaysForMonth(year: 2021, month: 7){
                temmuzArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2021, month: 8){
                agustosArray.append(i)
            }
          
            for i in 1...getDaysForMonth(year: 2021, month: 9){
                eylulArray.append(i)
            }
           
            for i in 1...getDaysForMonth(year: 2021, month: 10){
                ekimArray.append(i)
            }
           
            for i in 1...getDaysForMonth(year: 2021, month: 11){
                kasimArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2021, month: 12){
                aralikArray.append(i)
            }
            case 2:
            selectedYear = 2022
            for i in 1...getDaysForMonth(year: 2022, month: 1){
                ocakArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2022, month: 2){
                subatArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2022, month: 3){
                martArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2022, month: 4){
                nisanArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2022, month: 5){
                mayisArray.append(i)
            }
            
           
            for i in 1...getDaysForMonth(year: 2022, month: 6){
                haziranArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2022, month: 7){
                temmuzArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2022, month: 8){
                agustosArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2022, month: 9){
                eylulArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2022, month: 10){
                ekimArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2022, month: 11){
                kasimArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2022, month: 12){
                aralikArray.append(i)
            }
            case 3:
            selectedYear = 2023
            for i in 1...getDaysForMonth(year: 2023, month: 1){
                ocakArray.append(i)
            }
           
            for i in 1...getDaysForMonth(year: 2023, month: 2){
                subatArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2023, month: 3){
                martArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2023, month: 4){
                nisanArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2023, month: 5){
                mayisArray.append(i)
            }
            
            
            for i in 1...getDaysForMonth(year: 2023, month: 6){
                haziranArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2023, month: 7){
                temmuzArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2023, month: 8){
                agustosArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2023, month: 9){
                eylulArray.append(i)
            }
           
            for i in 1...getDaysForMonth(year: 2023, month: 10){
                ekimArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2023, month: 11){
                kasimArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2023, month: 12){
                aralikArray.append(i)
            }
            case 4:
            selectedYear = 2024
            for i in 1...getDaysForMonth(year: 2024, month: 1){
                ocakArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2024, month: 2){
                subatArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2024, month: 3){
                martArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2024, month: 4){
                nisanArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2024, month: 5){
                mayisArray.append(i)
            }
            
            
            for i in 1...getDaysForMonth(year: 2024, month: 6){
                haziranArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2024, month: 7){
                temmuzArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2024, month: 8){
                agustosArray.append(i)
            }
           
            for i in 1...getDaysForMonth(year: 2024, month: 9){
                eylulArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2024, month: 10){
                ekimArray.append(i)
            }
           
            for i in 1...getDaysForMonth(year: 2024, month: 11){
                kasimArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2024, month: 12){
                aralikArray.append(i)
            }
            case 5:
            selectedYear = 2025
            for i in 1...getDaysForMonth(year: 2025, month: 1){
                ocakArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2025, month: 2){
                subatArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2025, month: 3){
                martArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2025, month: 4){
                nisanArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2025, month: 5){
                mayisArray.append(i)
            }
            
           
            for i in 1...getDaysForMonth(year: 2025, month: 6){
                haziranArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2025, month: 7){
                temmuzArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2025, month: 8){
                agustosArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2025, month: 9){
                eylulArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2025, month: 10){
                ekimArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2025, month: 11){
                kasimArray.append(i)
            }
            
            for i in 1...getDaysForMonth(year: 2025, month: 12){
                aralikArray.append(i)
            }
        default:
         
            break
        }
        ocakDaysArray = DaysForTheMonth(isExpanded: false, daysArray: ocakArray)
        subatDaysArray = DaysForTheMonth(isExpanded: false, daysArray: subatArray)
        martDaysArray = DaysForTheMonth(isExpanded: false, daysArray: martArray)
        nisanDaysArray = DaysForTheMonth(isExpanded: false, daysArray: nisanArray)
        mayisDaysArray = DaysForTheMonth(isExpanded: false, daysArray: mayisArray)
        haziranDaysArray = DaysForTheMonth(isExpanded: false, daysArray: haziranArray)
        temmuzDaysArray = DaysForTheMonth(isExpanded: false, daysArray: temmuzArray)
        agustosDaysArray = DaysForTheMonth(isExpanded: false, daysArray: agustosArray)
        eylulDaysArray = DaysForTheMonth(isExpanded: false, daysArray: eylulArray)
        ekimDaysArray = DaysForTheMonth(isExpanded: false, daysArray: ekimArray)
        kasimDaysArray = DaysForTheMonth(isExpanded: false, daysArray: kasimArray)
        aralikDaysArray = DaysForTheMonth(isExpanded: false, daysArray: aralikArray)
        
        allMonthDaysArray.append(ocakDaysArray!)
        allMonthDaysArray.append(subatDaysArray!)
        allMonthDaysArray.append(martDaysArray!)
        allMonthDaysArray.append(nisanDaysArray!)
        allMonthDaysArray.append(mayisDaysArray!)
        allMonthDaysArray.append(haziranDaysArray!)
        allMonthDaysArray.append(temmuzDaysArray!)
        allMonthDaysArray.append(agustosDaysArray!)
        allMonthDaysArray.append(eylulDaysArray!)
        allMonthDaysArray.append(ekimDaysArray!)
        allMonthDaysArray.append(kasimDaysArray!)
        allMonthDaysArray.append(aralikDaysArray!)
       
        
        DispatchQueue.main.async {
           self.tableview.reloadData()
            /*self.tableview.beginUpdates()
            self.tableview.endUpdates()*/
            
        }
        
    }
    
    func getDaysForMonth(year : Int , month : Int) -> Int{
        
        var dateComponents = DateComponents()
        dateComponents.year=year
        dateComponents.month = month
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)
        let range = calendar.range(of: Calendar.Component.day, in: Calendar.Component.month, for: date!)
        let numdays = range!.count
        
        return numdays
    }
    

}
