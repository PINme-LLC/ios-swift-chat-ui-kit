//
//  LanguageSelectionView.swift
//  CometChatSwift
//
//  Created by Pushpsen Airekar on 09/12/20.
//  Copyright © 2020 MacMini-03. All rights reserved.
//

import UIKit

enum Languages : String {
    case english = "English";
    case chinese = "Chinese (中文)";
    case spanish = "Spanish (Española)";
    case hindi = "Hindi (हिंदी)";
    case russian = "Russian (русский)";
    case arabic = "Arabic (عربى)";
    case portuguese = "Portuguese (Português)";
    case malay = "Malay (Bahasa Melayu)";
    case french = "French (Française)";
    case german = "German (Deutsche)";
    
}

class LanguageSelectionView: UITableViewController {

    var languages: [Languages] = [Languages]()
    var bundleKey: UInt8 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.setupLanguages()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupLanguages() {
        languages.append(.english)
        languages.append(.chinese)
        languages.append(.spanish)
        languages.append(.hindi)
        languages.append(.russian)
        languages.append(.arabic)
        languages.append(.portuguese)
        languages.append(.malay)
        languages.append(.french)
        languages.append(.german)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return languages.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if( !(cell != nil))
        {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        }
        let language = languages[indexPath.row]
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        cell!.textLabel?.text = language.rawValue
        return cell!
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        tableView.deselectRow(at: indexPath, animated: true)
        let numberOfRows = tableView.numberOfRows(inSection: section)
        for row in 0..<numberOfRows {
            if let cell = tableView.cellForRow(at: NSIndexPath(row: row, section: section) as IndexPath) {
                cell.accessoryType = row == indexPath.row ? .checkmark : .none
            }
        }
        
        
        if tableView.cellForRow(at: indexPath) != nil {
            
            switch languages[indexPath.row] {
            
            case .english:
                UserDefaults.standard.set("en", forKey: "lang")
                UserDefaults.standard.synchronize()
                tableView.reloadData()
            case .chinese:
                
                LanguageBundle.setLanguage("zh")
                UserDefaults.standard.set("zh", forKey: "lang")
                tableView.reloadData()
                
            case .spanish:
               
                LanguageBundle.setLanguage("es")
                UserDefaults.standard.set("es", forKey: "lang")
                tableView.reloadData()
                
            case .hindi:
               
                LanguageBundle.setLanguage("hi")
                UserDefaults.standard.set("hi", forKey: "lang")
                tableView.reloadData()
                
            case .russian:
               
                LanguageBundle.setLanguage("ru")
                UserDefaults.standard.set("ru", forKey: "lang")
                tableView.reloadData()
                
            case .arabic:
                
                LanguageBundle.setLanguage("ar")
                UserDefaults.standard.set("ar", forKey: "lang")
                tableView.reloadData()
                
            case .portuguese:
                
                LanguageBundle.setLanguage("pt")
                UserDefaults.standard.set("pt", forKey: "lang")
                tableView.reloadData()
                
            case .malay:
               
                LanguageBundle.setLanguage("ms")
                UserDefaults.standard.set("ms", forKey: "lang")
                tableView.reloadData()
            case .french:
               
                LanguageBundle.setLanguage("fr")
                UserDefaults.standard.set("fr", forKey: "lang")
                UserDefaults.standard.synchronize()
                tableView.reloadData()
                
            case .german:
               
                LanguageBundle.setLanguage("de")
                UserDefaults.standard.set("de", forKey: "lang")
                tableView.reloadData()
            
            }
        }
    }
}


extension String {
    
    func localized() ->String {
        
        LanguageBundle.setLanguage(Locale.current.languageCode ?? "en")
        UserDefaults.standard.set(Locale.current.languageCode, forKey: "lang")
        
        if let lang = UserDefaults.standard.value(forKey: "lang") as? String {
            let path = UIKitSettings.bundle.path(forResource: lang, ofType: "lproj")
            let bundle = Bundle(path: path!)
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }else{
            let path = UIKitSettings.bundle.path(forResource: "en", ofType: "lproj")
            let bundle = Bundle(path: path!)
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
        }
    }
}
