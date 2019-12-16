//
//  DetailViewController.swift
//  Agenda
//
//  Created by Levent Özkan on 9.12.2019.
//  Copyright © 2019 Levent Özkan. All rights reserved.
//

import UIKit
import PencilKit
import CoreData
import MaterialComponents.MaterialSnackbar

class DetailViewController: UIViewController, PKCanvasViewDelegate {
    
    @IBOutlet weak var dayLbl: UILabel!
    
    @IBOutlet weak var detailNavItem: UINavigationItem!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    var selectedDay : Int = 0
    var selectedYear : Int = 0
    var selectedMonth : Int = 0
    let canvasView = PKCanvasView()
    var imageView = UIImageView()
    var imageData : NSData? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let kaydetButton = UIBarButtonItem(title: "Kaydet", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveImage))
        
        let kalemButton = UIBarButtonItem(title: "Araç Çubuğu", style: UIBarButtonItem.Style.plain, target: self, action: #selector(toggleToolPK))
        
        let temizleButton = UIBarButtonItem(title: "Temizle", style: UIBarButtonItem.Style.plain, target: self, action: #selector(clearBoard))
        
         detailNavItem.rightBarButtonItem = kaydetButton
         detailNavItem.rightBarButtonItems?.append(kalemButton)
         detailNavItem.rightBarButtonItems?.append(temizleButton)
        
        createCanvasView()
        createImageView()
        
         
        
        canvasView.delegate = self
        dayLbl.text = String(selectedDay)
        yearLbl.text = String(selectedYear)
        
        switch selectedMonth {
        case 1:
            monthLbl.text = "Ocak"
            case 2:
            monthLbl.text = "Şubat"
            case 3:
            monthLbl.text = "Mart"
            case 4:
            monthLbl.text = "Nisan"
            case 5:
            monthLbl.text = "Mayıs"
            case 6:
            monthLbl.text = "Haziran"
            case 7:
            monthLbl.text = "Temmuz"
            case 8:
            monthLbl.text = "Ağustos"
            case 9:
            monthLbl.text = "Eylül"
            case 10:
            monthLbl.text = "Ekim"
            case 11:
            monthLbl.text = "Kasım"
            case 12:
            monthLbl.text = "Aralık"
        default:
            monthLbl.text = "Ocak"
        }
        
        if imageData != nil {

            do{
                canvasView.drawing = try PKDrawing(data: imageData as! Data)
            }catch{
                print(error)
            }
            
            
        }else{
            canvasView.drawing = PKDrawing()
            
            
        }
       
    }
    
    @objc func saveImage(){
        
        let message = MDCSnackbarMessage(text: "Görüntü Kaydedildi.")
        
 
        let alert = UIAlertController(title: "Görüntü Kaydet", message: "Görüntüyü kaydetmek istediğinize eminmisiniz?", preferredStyle: UIAlertController.Style.alert)
        let yesAction = UIAlertAction(title: "Evet", style: UIAlertAction.Style.default) { (UIAlertAction) in
            let image = self.canvasView.drawing.image(from: self.canvasView.drawing.bounds, scale: 1.0)
            let newdata = self.canvasView.drawing.dataRepresentation()
                   //let imageData = image.jpegData(compressionQuality: 0.5)
                   let appDelegate = UIApplication.shared.delegate as! AppDelegate
                   let context = appDelegate.persistentContainer.viewContext
                   
                   let newImage = NSEntityDescription.insertNewObject(forEntityName: "SavedImages", into: context)
            newImage.setValue(String(self.selectedDay) + String(self.selectedMonth) + String(self.selectedYear), forKey: "savedImageId")
                   newImage.setValue(newdata, forKey: "image")
                   do {
                       try context.save()
                    MDCSnackbarManager.default.alignment = .center
                    MDCSnackbarManager.messageTextColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                    MDCSnackbarManager.default.setBottomOffset(100.0)
                    MDCSnackbarManager.default.show(message)
                       NotificationCenter.default.post(name: NSNotification.Name("imagesaved"), object: nil)
                   } catch  {
                       print(error)
                   }
        }
        let noAction = UIAlertAction(title: "Hayır", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert,animated: true,completion: nil)
 
    }
    
    @objc func toggleToolPK(){
        if canvasView.isFirstResponder{
            
            canvasView.resignFirstResponder()
        }else{
            canvasView.becomeFirstResponder()
        }
        
    }
    
    @objc func clearBoard(){
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedImages")
        fetchrequest.predicate = NSPredicate(format: "savedImageId = %@", String(selectedDay) + String(selectedMonth) + String(selectedYear))
        fetchrequest.returnsObjectsAsFaults = false
        do{
           let results = try context.fetch(fetchrequest)
            if results.count > 0 {
                for result in results{
                    context.delete(result as! NSManagedObject)
                    NotificationCenter.default.post(name: NSNotification.Name("imagesaved"), object: nil)
                    print(String(selectedDay) + String(selectedMonth) + String(selectedYear))
                    
                }
            }
            
            try context.save()
            
        }catch{
            print(error)
        }
        
        canvasView.drawing = PKDrawing()
        
    }
    
    func createCanvasView(){
        
        canvasView.isOpaque = false
        canvasView.backgroundColor = UIColor.clear
        self.view.addSubview(canvasView)
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        canvasView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: self.yearLbl.bottomAnchor).isActive = true
        canvasView.allowsFingerDrawing = true
        
        
    }
    
    func createImageView(){
        imageView.contentMode = .center
        //self.view.addSubview(imageView)
        self.canvasView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: self.canvasView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.canvasView.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.canvasView.bottomAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.canvasView.topAnchor).isActive = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let window = view.window,
            let toolPicker = PKToolPicker.shared(for: window) else{return}
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
    
    

}

