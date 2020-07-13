//
//  Mensagem.swift
//  Agenda
//
//  Created by Ian Pablo on 15/08/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import MessageUI


class Mensagem: NSObject, MFMessageComposeViewControllerDelegate {
    
    var delegate:MFMessageComposeViewControllerDelegate?
    
    func setaDelegate() -> MFMessageComposeViewControllerDelegate? {
        delegate = self
        return delegate
    }

    // MARK: - Metodos
    
    func enviaSMS(_ aluno:Aluno, controller:UIViewController){
        if MFMessageComposeViewController.canSendText(){
        let componenteMensagem = MFMessageComposeViewController()
        guard let numeroAlunos = aluno.telefone else { return }
        componenteMensagem.recipients = [numeroAlunos]
            guard let delegate = setaDelegate() else { return }
        componenteMensagem.messageComposeDelegate = delegate
            controller.present(componenteMensagem, animated: true, completion: nil)
        
        }
    }
    
    // MARK: - MenssageComposeDelegate
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
