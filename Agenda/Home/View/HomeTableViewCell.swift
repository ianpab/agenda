//
//  HomeTableViewCell.swift
//  Agenda
//
//  Created by Ândriu Coelho on 24/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageAluno: UIImageView!
    @IBOutlet weak var labelNomeDoAluno: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configuraCelula(_ aluno: Aluno){
        labelNomeDoAluno.text = aluno.nome
        
        //arredondar imagem
        imageAluno.layer.cornerRadius = imageAluno.frame.width / 2
        imageAluno.layer.masksToBounds = true
        
        if let imagemAluno = aluno.foto as? UIImage{
            imageAluno.image = imagemAluno
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}