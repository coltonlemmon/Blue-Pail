//
//  TagCreationTableViewController.swift
//  Blue-Pail
//
//  Created by David Sadler on 6/1/19.
//  Copyright © 2019 David Sadler. All rights reserved.
//

import UIKit

class TagCreationTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - TextField Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Rounding corners:
        #warning("TODO: - subclass UIbutton and make a Rounded Button subclass")
        ViewHelper.roundCornersOf(viewLayer: deleteTagButton.layer, withRoundingCoefficient: 15.0)
        ViewHelper.roundCornersOf(viewLayer: redButton.layer, withRoundingCoefficient: 5.0)
        ViewHelper.roundCornersOf(viewLayer: redOrangeButton.layer, withRoundingCoefficient: 5.0)
        ViewHelper.roundCornersOf(viewLayer: yellowOrangeButton.layer, withRoundingCoefficient: 5.0)
        ViewHelper.roundCornersOf(viewLayer: yellowButton.layer, withRoundingCoefficient: 5.0)
        ViewHelper.roundCornersOf(viewLayer: limeGreenButton.layer, withRoundingCoefficient: 5.0)
        ViewHelper.roundCornersOf(viewLayer: greenButton.layer, withRoundingCoefficient: 5.0)
        ViewHelper.roundCornersOf(viewLayer: tealButton.layer, withRoundingCoefficient: 5.0)
        ViewHelper.roundCornersOf(viewLayer: blueButton.layer, withRoundingCoefficient: 5.0)
        ViewHelper.roundCornersOf(viewLayer: darkBlueButton.layer, withRoundingCoefficient: 5.0)
        ViewHelper.roundCornersOf(viewLayer: purpleButton.layer, withRoundingCoefficient: 5.0)
        ViewHelper.roundCornersOf(viewLayer: magentaButton.layer, withRoundingCoefficient: 5.0)
        ViewHelper.roundCornersOf(viewLayer: pinkButton.layer, withRoundingCoefficient: 5.0)
        ViewHelper.roundCornersOf(viewLayer: selectedColorView.layer, withRoundingCoefficient: 5.0)
        
        // Gesture recognizer Setup:
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        // TextField Setup:
        tagTextField.delegate = self
        
        // Edit Setup:
        if tag != nil {
            updateElements()
        }
        
    }
    var tagTitle: String?
    var tagColorNumber: Double?
    var tag: Tag?
    
    // MARK: - Outlets
    #warning("TODO: Differentiate darkblue from purple more - update the color values in Color.swift")
    
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var selectedColorView: UIView!
    @IBOutlet weak var deleteTagButton: UIButton!
    @IBOutlet weak var selectedColorLabel: UILabel!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var redOrangeButton: UIButton!
    @IBOutlet weak var yellowOrangeButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var limeGreenButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var tealButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var darkBlueButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var magentaButton: UIButton!
    @IBOutlet weak var pinkButton: UIButton!
    
    // MARK: - Actions
    
    // Save Button:
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let newTagTitle = tagTextField.text.nilIfEmpty else {
            let noTitleAlert = UIAlertController(title: "No Title Entered", message: "Please enter a title for your new tag.", preferredStyle: .alert)
            noTitleAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(noTitleAlert, animated: true)
            return
        }
        guard let newTagColorNumber = tagColorNumber else {
            let noColorAlert = UIAlertController(title: "No Color Selected", message: "Please tap a color that you want to use for your new tag.", preferredStyle: .alert)
            noColorAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(noColorAlert, animated: true)
            return
        }
        guard let selectedTag = tag else {
            if TagController.shared.IsTagUnique(givenTagTitle: newTagTitle) {
                TagController.shared.createTag(tagTitle: newTagTitle, colorNumber: newTagColorNumber)
                self.navigationController?.popViewController(animated: true)
                return
            } else {
                let nonUniqueCreationAlert = UIAlertController(title: "Tag Already Exists", message: "A tag already exists with the title you entered. Please enter a different title.", preferredStyle: .alert)
                nonUniqueCreationAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(nonUniqueCreationAlert, animated: true)
                return
            }
        }
        TagController.shared.updateTag(selectedTag: selectedTag, withNewTitle: newTagTitle, withNewColorNumber: newTagColorNumber)
        self.navigationController?.popViewController(animated: true)
       
    }
    
    // Cancel Button:
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Color Buttons:
    @IBAction func redButtonPressed(_ sender: Any) {
        updateColorChoice(colorID: 6.0)
    }
    
    @IBAction func redOrangeButtonPressed(_ sender: Any) {
        updateColorChoice(colorID: 7.0)
    }
    
    @IBAction func yellowOrangeButtonPressed(_ sender: Any) {
         updateColorChoice(colorID: 8.0)
    }
    
    @IBAction func yellowButtonPressed(_ sender: Any) {
         updateColorChoice(colorID: 9.0)
    }
    
    @IBAction func limeGreenButtonPressed(_ sender: Any) {
         updateColorChoice(colorID: 10.0)
    }
    
    @IBAction func greenButtonPressed(_ sender: Any) {
         updateColorChoice(colorID: 11.0)
    }
    
    @IBAction func tealButtonPressed(_ sender: Any) {
         updateColorChoice(colorID: 12.0)
    }
    
    @IBAction func blueButtonPressed(_ sender: Any) {
         updateColorChoice(colorID: 13.0)
    }
    
    @IBAction func darkBlueButtonPressed(_ sender: Any) {
         updateColorChoice(colorID: 14.0)
    }
    
    @IBAction func purpleButtonPressed(_ sender: Any) {
         updateColorChoice(colorID: 15.0)
    }
    
    @IBAction func magentaButtonPressed(_ sender: Any) {
         updateColorChoice(colorID: 16.0)
    }
    
    @IBAction func pinkButtonPressed(_ sender: Any) {
         updateColorChoice(colorID: 17.0)
    }
    
    @IBAction func deleteTagButtonPressed(_ sender: Any) {
        guard let tagTitle = tag?.title else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        let confirmDeletionAlert = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete your '\(tagTitle)' tag? This will delete all the plants associated with this tag as well.", preferredStyle: .alert)
        confirmDeletionAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        confirmDeletionAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: deleteTagPressed(action:)))
        self.present(confirmDeletionAlert, animated: true)
    }
    
    // MARK: - Internal Methods
    
    /// Deletes the selected tag if there was one passed in, and pops the viewController.
    func deleteTagPressed(action: UIAlertAction) {
        guard let tagToDelete = tag else {
            return
        }
        TagController.shared.deleteTag(selectedTag: tagToDelete)
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Updates the tagColorNumber property and updates the selectedColorView to reflect the selected color.
    private func updateColorChoice(colorID: Double) {
        tagColorNumber = colorID
        selectedColorView.backgroundColor = ColorHelper.colorFrom(colorNumber: colorID)
    }
   
    /// Updates the titleTextField, and the color view if there was a Tag passed in.
    private func updateElements() {
        guard let selectedTag = tag else { return }
        updateColorChoice(colorID: selectedTag.colorNumber)
        tagTextField.text = selectedTag.title
        self.navigationItem.title = selectedTag.title
    }
}

