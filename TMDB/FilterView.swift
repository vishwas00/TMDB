
import UIKit


protocol FilterViewDelegate: NSObjectProtocol {
    
    func filtersSelected(minYear: String, maxYear: String)
}



class FilterView: UIView, UITextFieldDelegate {

    @IBOutlet weak var minYearTextfield: UITextField!
    @IBOutlet weak var maxYearTextfield: UITextField!
    
    weak var delegate: FilterViewDelegate!
    
    
    override func awakeFromNib() {
        minYearTextfield.delegate = self
        maxYearTextfield.delegate = self
    }
    
    @IBAction func doneButtonTapped(_ sender: Any)
    {
        delegate.filtersSelected(minYear: minYearTextfield.text!, maxYear: maxYearTextfield.text!)
        
        self.removeFromSuperview()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
