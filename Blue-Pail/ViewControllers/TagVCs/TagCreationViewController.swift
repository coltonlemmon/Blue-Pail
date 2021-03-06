//
//  TagCreationViewController.swift
//  Blue-Pail
//
//  Created by David Sadler on 6/18/19.
//  Copyright © 2019 David Sadler. All rights reserved.
//

import UIKit

class TagCreationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - PickerView DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if tagPickerTitles.isEmpty {
            return 1
        } else {
            return tagPickerTitles.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if tagPickerTitles.isEmpty {
            return "Please Create A Tag"
        } else {
            return tagPickerTitles[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if tagPickerTitles.isEmpty == false {
            let tagTitle = tagPickerTitles[row]
            let tag = TagController.shared.getSelectedTag(givenTagTitle: tagTitle)
            let title = NSAttributedString(string: tagTitle, attributes: [NSAttributedString.Key.foregroundColor: ColorHelper.colorFrom(colorNumber: tag.colorNumber)])
            return title
        }
        return nil
    }
    
    // MARK: - PickerView Delegate Methods
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if tagPickerTitles.isEmpty {
            return
        } else {
            let selectedTagTitle = tagPickerTitles[row]
            let tag = TagController.shared.getSelectedTag(givenTagTitle: selectedTagTitle)
            selectedTag = tag
        }
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // PickerView Setup:
        self.tagCollectionPickerView.delegate = self
        self.tagCollectionPickerView.dataSource = self
        self.tagCollectionPickerView.reloadComponent(0)
        
        // Check if Tag Collection is empty:
        if tagPickerTitles.isEmpty == false {
            selectedTag = TagController.shared.getSelectedTag(givenTagTitle: tagPickerTitles[0])
            tagCollectionPickerView.selectRow(0, inComponent: 0, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tagCollectionPickerView.reloadComponent(0)
    }
    
    // MARK: - Stored Properties
    
    var selectedTag: Tag?
    
    // MARK: - Computed Properties
    
    var tagPickerTitles: [String] {
        get {
            let tags = TagController.shared.tags
            var tagTitles = [String]()
            for tag in tags {
                guard let tagTitle = tag.title else { return [] }
                tagTitles.append(tagTitle)
            }
            return tagTitles
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var tagCollectionPickerView: UIPickerView!
    
    // MARK: - Methods
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditTag" {
            guard let detailVC = segue.destination as? TagCreationTableViewController else { return }
            guard let tagToPass = selectedTag else {
                let noTagSelectedAlert = UIAlertController(title: "No Tag Selected", message: "Please select the tag you wish to edit.", preferredStyle: .alert)
                noTagSelectedAlert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self.present(noTagSelectedAlert, animated: true)
                return
            }
            detailVC.tag = tagToPass
        }
    }

}
