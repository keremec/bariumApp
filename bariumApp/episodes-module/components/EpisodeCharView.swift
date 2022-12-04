//
//  EpisodeCharView.swift
//  bariumApp
//
//  Created by Kerem Safa Dirican on 27.11.2022.
//

import UIKit

class EpisodeCharView: UIView{
    
    weak var delegateDetail:EpisodesVC?
    
    @IBOutlet weak var labelOutlet: UILabel!
    
    @IBOutlet weak var textViewOutlet: UITextView!
    
    override init(frame:CGRect){
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder:NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit(){
        let nib = UINib(nibName: "EpisodeCharView", bundle: nil)
        if let view = nib.instantiate(withOwner: self).first as? UIView{
            view.layer.cornerRadius = 10
            addSubview(view)
            view.frame = self.bounds
        }
        
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        delegateDetail?.episodeCharView.isHidden = true
        delegateDetail?.charViewBlocker.isHidden = true
    }
}
