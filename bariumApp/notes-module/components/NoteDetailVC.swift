//
//  NoteDetailVC.swift
//  bariumApp
//
//  Created by Kerem Safa Dirican on 3.12.2022.
//

import UIKit

class NoteDetailVC: UIViewController {

    
    @IBOutlet weak var noteTitleOutlet: UITextField!
    
    @IBOutlet weak var noteTextField: UITextView!
    
    @IBOutlet weak var seasonTextField: UITextField!
    
    @IBOutlet weak var episodeTextField: UITextField!
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    weak var delegate:NotesVC?
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTitleOutlet.delegate = self
        noteTextField.delegate = self
        setDetailPage()
        
    }
    

    
    @IBAction func saveAction(_ sender: Any) {
        if let obj = note{
            CoreDataManager.shared.editNote(obj: obj, season: Int(seasonTextField.text ?? "0") ?? 0, episode: Int(episodeTextField.text ?? "0") ?? 0, noteTitle: noteTitleOutlet.text ?? "Unnamed Note", noteDetail: noteTextField.textColor != UIColor.placeholderText ? noteTextField.text: "")
        }
        else{
            _ = CoreDataManager.shared.saveNote(season: Int(seasonTextField.text ?? "0") ?? 0, episode: Int(episodeTextField.text ?? "0") ?? 0, noteTitle: noteTitleOutlet.text ?? "Unnamed Note", noteDetail: noteTextField.textColor != UIColor.placeholderText ? noteTextField.text: "")
        }
        
        delegate?.updateList()
        self.dismiss(animated: true)
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func setDetailPage(){
        if let obj = note{
            noteTitleOutlet.text = obj.noteTitle
            noteTextField.text = obj.noteDetail
            seasonTextField.text = String(obj.season)
            episodeTextField.text = String(obj.episode)
            saveButtonOutlet.isEnabled = true
        }
        
        if (noteTextField.text == ""){
            noteTextField.text = "Enter Your Note Here..."
            noteTextField.textColor = UIColor.placeholderText
        }
        
    }
}


extension NoteDetailVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if noteTextField.textColor == UIColor.placeholderText{
            noteTextField.text = nil
            noteTextField.textColor = UIColor.label
        
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if noteTextField.text.isEmpty {
            noteTextField.text = "Enter Your Note Here..."
            noteTextField.textColor = UIColor.placeholderText
        }
    }
}

extension NoteDetailVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let oldText = textField.text else {
            return false
        }
        
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
        saveButtonOutlet.isEnabled = !newText.isEmpty
        return true
    }
}
