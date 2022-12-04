//
//  NotesVC.swift
//  bariumApp
//
//  Created by Kerem Safa Dirican on 3.12.2022.
//

import UIKit

class NotesVC: UIViewController {
    
    
    @IBOutlet weak var newNoteButton: UIButton!
    @IBOutlet weak var noNoteLabel: UILabel!
    @IBOutlet weak var notesTableView: UITableView!
    var notes: [Note] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.delegate = self
        notesTableView.dataSource = self
        updateList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toNoteDetail":
            if let note = sender as? Note{
                let goalVC = segue.destination as! NoteDetailVC
                goalVC.delegate = self
                goalVC.note = note
            }
            
        case "toNewNote":
            let goalVC = segue.destination as! NoteDetailVC
            goalVC.delegate = self
            
        default:
            print("identifier not found")
            
        }
    }
    
    
    func updateList(){
        notes = CoreDataManager.shared.getNotes()
        notes = notes.reversed()
        notesTableView.reloadData()
        if(notes.count > 0){
            noNoteLabel.isHidden = true
        }
        else{
            noNoteLabel.isHidden = false
        }
    }

    
}

extension NotesVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell")
        let obj = notes[indexPath.row]
        cell?.textLabel?.text = obj.noteTitle
        cell?.detailTextLabel?.text = "S\(obj.season)E\(obj.episode)"

        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = notes[indexPath.row]
        performSegue(withIdentifier: "toNoteDetail", sender: selectedNote)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = self.notes[indexPath.row]
        
            let deleteConfirmAction = UIContextualAction(style: .destructive, title: "Delete"){ (contextualAction, view, bool ) in
                let alert = UIAlertController(title: "Do you want to delete this note?", message: "\(note.noteTitle!)", preferredStyle: .actionSheet)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){action in
                    // after the cancel, that row cannot be swiped. it can only swiped if another row is swiped
                    tableView.reloadRows(at: [indexPath], with: .right)
                    tableView.reloadData()
            }
                
                alert.addAction(cancelAction)
                
                let yesAction = UIAlertAction(title: "Delete", style: .destructive){action in
                        CoreDataManager.shared.deleteNote(note: note)
                        tableView.reloadRows(at: [indexPath], with: .left)
                        self.updateList()

                }
                alert.addAction(yesAction)
                
                self.present(alert, animated: true)
                
            }
            return UISwipeActionsConfiguration(actions: [deleteConfirmAction])

    }
    
}


extension NotesVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == notesTableView{
            newNoteButton.isHidden = scrollView.contentOffset.y > 0
        }
    }
}
