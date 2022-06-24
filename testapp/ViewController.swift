//
//  ViewController.swift
//  testapp
//
//  Created by Maciej Sałuda on 22/06/2022.
//

import UIKit

class ViewController: UIViewController

{
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var optionalTextField: UITextField!
    @IBOutlet weak var optionalTextColor: UITextField!
    @IBOutlet weak var optionalTextSize: UISlider!
    @IBOutlet weak var triangleButtonImage: UIImageView!
    @IBOutlet weak var giveMeACat: UIButton!
    @IBOutlet weak var optionalTextswitch: UISwitch!
    
    var tagPickerView = UIPickerView()
    var filterPickerView = UIPickerView()
    var colorPickerView = UIPickerView()
    
    var catOption: String?
    var filterOption: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpGesture()
    }
    
    func setUpGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissPicker))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    func setUpView() {
        APIService.loadFrom(URLAddress: "https://cataas.com/cat") { [weak self] loadedImage in
            self?.image.image = loadedImage
        }
        tagTextField.inputView = tagPickerView
        filterTextField.inputView = filterPickerView
        optionalTextColor.inputView = colorPickerView
        tagTextField.placeholder = "Wybierz Tag"
        filterTextField.placeholder = "Wybierz Filtr"
        filterTextField.textAlignment = .center
        tagTextField.textAlignment = .center
        optionalTextField.placeholder = "Opis"
        optionalTextField.textAlignment = .center
        optionalTextColor.placeholder = "Wybierz kolor"
        optionalTextColor.textAlignment = .center
        
        
        tagPickerView.delegate = self
        tagPickerView.dataSource = self
        filterPickerView.delegate = self
        filterPickerView.dataSource = self
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        
        tagPickerView.tag = 1
        filterPickerView.tag = 2
        colorPickerView.tag = 3
    }
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        if sender.isOn {
            optionalTextField.isHidden = false
            optionalTextSize.isHidden = false
            optionalTextColor.isHidden = false
            triangleButtonImage.isHidden = false
            imageLabel.isHidden = false
        }
        else {
            optionalTextField.isHidden = true
            optionalTextSize.isHidden = true
            optionalTextColor.isHidden = true
            triangleButtonImage.isHidden = true
            imageLabel.isHidden = true
        }
    }
    
    func prepareURL() -> String {
        let tagString = catOption != nil ? "&tag=\(catOption ?? "")" : ""
        let filterString = filterOption != nil ? "&filter=\(filterOption ?? "")" : ""
        let finalUrl = "https://cataas.com/cat?" + tagString + filterString
        return finalUrl
    }
    
    @IBAction func catButtonPressed(_ sender: UIButton) {
        APIService.loadFrom(URLAddress: prepareURL()) { [weak self] loadedImage in
            self?.image.image = loadedImage
        }
        
    }
    
    @IBAction func changeText(_ sender: UITextField) {
        imageLabel.text = optionalTextField.text
    }
    
    @IBAction func sizeChanged(_ sender: UISlider) {
        imageLabel.font = UIFont.systemFont(ofSize: CGFloat(sender.value))
        
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return TagsModel.tags.count
            
        case 2:
            return FilterModel.allCases.count
        case 3:
            return ColorModel.allCases.count
            
        default:
            return 1
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return TagsModel.tags[row]
            
        case 2:
            return FilterModel.allCases[row].filterTitle()
            
        case 3:
            return ColorModel.allCases[row].title()
        default:
            return "No data"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            catOption = TagsModel.tags[row]
            tagTextField.text = TagsModel.tags[row]
            view.endEditing(true)
        case 2:
            filterOption = FilterModel.allCases[row].filterTitle()
            filterTextField.text = FilterModel.allCases[row].filterTitle()
            view.endEditing(true)
        case 3:
            imageLabel.textColor = ColorModel.allCases[row].color()
            optionalTextColor.text = ColorModel.allCases[row].title()
            view.endEditing(true)
        default:
            return
        }
    }
}


