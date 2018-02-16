//
//  ViewController.swift
//  GPACalc
//
//  Created by Mit Amin on 2/13/18.
//  Copyright © 2018 Mit Amin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var courseName: UITextField!
    
    @IBOutlet weak var assignmentPoint: UITextField!
    
    @IBOutlet weak var assignmentMax: UITextField!
    
    @IBOutlet weak var assignmentPercent: UITextField!
    
    @IBOutlet weak var midtermPoint: UITextField!
    
    @IBOutlet weak var midtermMax: UITextField!
    
    @IBOutlet weak var midtermPercent: UITextField!
    
    @IBOutlet weak var finalPoint: UITextField!
    
    @IBOutlet weak var finalMax: UITextField!
    
    @IBOutlet weak var finalPercent: UITextField!
    
    @IBOutlet weak var credits: UITextField!
    
    @IBOutlet weak var addCourse: UIButton!
    
    @IBOutlet weak var deleteCourse: UIButton!
    
    @IBOutlet weak var courseList1: UILabel!
    
    @IBOutlet weak var courseList2: UILabel!
    
    @IBOutlet weak var courseList3: UILabel!
    
    @IBOutlet weak var courseList4: UILabel!
    
    @IBOutlet weak var grade1: UIImageView!
    
    @IBOutlet weak var grade2: UIImageView!
    
    @IBOutlet weak var grade3: UIImageView!
    
    @IBOutlet weak var grade4: UIImageView!
    
    @IBOutlet weak var GPA: UILabel!
    
    @IBOutlet weak var deleteCourseNum: UITextField!
    
    var courses = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseName.delegate = self
        credits.delegate = self
        assignmentMax.delegate = self
        assignmentPoint.delegate = self
        assignmentPercent.delegate = self
        midtermMax.delegate = self
        midtermPoint.delegate = self
        midtermPercent.delegate = self
        finalMax.delegate = self
        finalPoint.delegate = self
        finalPercent.delegate = self
        deleteCourseNum.delegate = self
        
//        let course = Course()
//        let assessment = Assessment()
//        let midterm = Assessment()
//        let final = Assessment()
//
//        course.courseName = courseName.text
//        course.courseNum = courses.count
//        course.credits = Int(credits.text!)
//
//
//        assessment.max = Int(assignmentMax.text!)
//        assessment.point = Int(assignmentPoint.text!)
//        assessment.percentage = Int(assignmentPercent.text!)
//
//        midterm.percentage = Int(midtermPercent.text!)
//        midterm.max = Int(midtermMax.text!)
//        midterm.point  = Int(midtermPoint.text!)
//
//        final.percentage = Int(finalPercent.text!)
//        final.point = Int(finalPoint.text!)
//        final.max = Int(finalMax.text!)


    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func onClickAddCourse(_ sender: UIButton) {
        if let max = Int(assignmentMax.text!),
            let point = Int(assignmentPoint.text!),
            let percent = Int(assignmentPercent.text!),
            let mPercent = Int(midtermPercent.text!),
            let mMax = Int(midtermMax.text!),
            let mPoint  = Int(midtermPoint.text!),
            let fPercentage = Int(finalPercent.text!),
            let fPoint = Int(finalPoint.text!),
            let fMax = Int(finalMax.text!),
            let courseN = courseName.text,
            let courseCred = Int(credits.text!)
            {
                let course = Course()
                let assessment = Assessment()
                let midterm = Assessment()
                let final = Assessment()
                
                assessment.max = max
                assessment.point = point
                assessment.percentage = percent
                
                midterm.percentage = mPercent
                midterm.max = mMax
                midterm.point  = mPoint
                
                final.percentage = fPercentage
                final.point = fPoint
                final.max = fMax
                
                let percentSum = fPercentage + mPercent + percent
                
                let grade = gradeCalc(assesment: assessment, midterm: midterm, final: final)
                
                course.courseName = courseN
                course.courseNum = courses.count
                course.credits = courseCred
                course.grade = grade
                if (course.grade! >= 90.0 && course.grade! <= 100.0 ){
                    course.letterGrade = 4.0
                }
                else if (course.grade! < 90.0 && course.grade! >= 80.0 ){
                    course.letterGrade = 3.0
                }
                else if (course.grade! < 80.0 && course.grade! >= 70.0 ){
                    course.letterGrade = 2.0
                }
                else if (course.grade! < 70.0 && course.grade! >= 60.0 ){
                    course.letterGrade = 1.0
                    
                }
                else {
                    course.letterGrade = 0.0
                }
                
                
                
                if courses.count < 4 &&
                    percentSum == 100 &&
                    point <= max &&
                    mPoint <= mMax &&
                    fPoint <= fMax &&
                    point >= 0 &&
                    mPoint >= 0 &&
                    fPoint >= 0 &&
                    max >= 0 &&
                    mMax >= 0 &&
                    fMax >= 0 &&
                    percent >= 0 &&
                    mPercent >= 0 &&
                    fPercentage >= 0 &&
                    !courses.contains(where: {$0.courseName == course.courseName}){
                    courses.append(course)
                    if courses.isEmpty == false{
                        let tex = String(format: "%.2f", (gpaCalc(courses: courses)))
                        GPA.text = "GPA: \(tex)"
                        if gpaCalc(courses: courses) >= 3.0{
                            GPA.textColor = UIColor.green
                        }
                        else if gpaCalc(courses: courses) >= 2.0 && gpaCalc(courses: courses) < 3.0{
                            GPA.textColor = UIColor.orange
                        }
                        else if gpaCalc(courses: courses) >= 0.0 && gpaCalc(courses: courses) < 2.0 {
                            GPA.textColor = UIColor.red
                        }
                        else {GPA.textColor = UIColor.white}
                    }
                    else{
                        GPA.text = "GPA:"
                        GPA.textColor = UIColor.white
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                }
                else if courses.count > 4{
                    createAlert(title: "WARNING", message: "Too Many Courses Please Delete 1 or More Courses")
                }
                else if percentSum != 100{
                    createAlert(title: "Warning", message: "Your % fields don't add up to 100")
                }
                else if point > max ||
                    mPoint > mMax ||
                    fPoint > fMax {
                    createAlert(title: "Warning", message: "One of your Point fields is greater than it's Max")
                }
                else if point < 0 ||
                    mPoint < 0 ||
                    fPoint < 0 ||
                    max < 0 ||
                    mMax < 0 ||
                    fMax < 0 ||
                    percent < 0 ||
                    mPercent < 0 ||
                    fPercentage < 0 {
                    createAlert(title: "Warning", message: "One of your fields is less than 0")
                }
                else if courses.contains(where: {$0.courseName == course.courseName}) {
                    createAlert(title: "Warning", message: "You can't add the same course twice")
                }
            listCourse(courses: courses)
        }
        else{
            createAlert(title: "WARNING", message: "Not All Boxes Have Been Filled")
        }
    }
    
    @IBAction func onClickDeleteCourse(_ sender: UIButton) {
        let courseDel = Int(deleteCourseNum.text!)! - 1
        if courseDel < courses.count{
            courses.remove(at: courseDel )
            if courses.isEmpty{
                GPA.text = "GPA:"
                GPA.textColor = UIColor.white
                print("im here")
            }
            else{
                let tex = String(format: "%.2f", (gpaCalc(courses: courses)))
                GPA.text = "GPA: \(tex)"
                if gpaCalc(courses: courses) >= 3.0{
                    GPA.textColor = UIColor.green
                }
                else if gpaCalc(courses: courses) >= 2.0 && gpaCalc(courses: courses) < 3.0{
                    GPA.textColor = UIColor.orange
                }
                else if gpaCalc(courses: courses) >= 0.0 && gpaCalc(courses: courses) < 2.0 {
                    GPA.textColor = UIColor.red
                }
                else{
                    GPA.textColor = UIColor.white
                }
            }
            
            
            switch courseDel {
                case 0:
                    if courses.count == 0{
                        courseList1.text = " "
                        grade1.image = nil
                    }
                    else if courses.count == 1{
                        courseList1.text = "1) \(String(describing: courses[0].courseName!)) | \(String(describing: courses[0].credits!))"
                        setGradeImage(course: courses[0], grade1: grade1)
                        courseList2.text = " "
                        grade2.image = nil
                    }
                    else if courses.count == 2{
                        courseList1.text = "1) \(String(describing: courses[0].courseName!)) | \(String(describing: courses[0].credits!))"
                        setGradeImage(course: courses[0], grade1: grade1)
                        courseList2.text = "2) \(String(describing: courses[1].courseName!)) | \(String(describing: courses[1].credits!))"
                        setGradeImage(course: courses[1], grade1: grade2)

                        courseList3.text = " "
                        grade3.image = nil
                    }
                    else if courses.count == 3{
                        courseList1.text = "1) \(String(describing: courses[0].courseName!)) | \(String(describing: courses[0].credits!))"
                        setGradeImage(course: courses[0], grade1: grade1)
                        courseList2.text = "2) \(String(describing: courses[1].courseName!)) | \(String(describing: courses[1].credits!))"
                        setGradeImage(course: courses[1], grade1: grade2)
                        courseList3.text = "3) \(String(describing: courses[2].courseName!)) | \(String(describing: courses[2].credits!))"
                        setGradeImage(course: courses[2], grade1: grade3)
                        courseList4.text = " "
                        grade4.image = nil

                    }
                case 1:
                    if courses.count == 1{
                        courseList2.text = " "
                        grade2.image = nil
                    }
                    else if courses.count == 2{
                        courseList2.text = "2) \(String(describing: courses[1].courseName!)) | \(String(describing: courses[1].credits!))"
                        setGradeImage(course: courses[1], grade1: grade2)
                        courseList3.text = " "
                        grade3.image = nil
                    }
                    else if courses.count == 3 {
                        courseList2.text = "2) \(String(describing: courses[1].courseName!)) | \(String(describing: courses[1].credits!))"
                        setGradeImage(course: courses[1], grade1: grade2)
                        courseList3.text = "3) \(String(describing: courses[2].courseName!)) | \(String(describing: courses[2].credits!))"
                        setGradeImage(course: courses[2], grade1: grade3)
                        courseList4.text = " "
                    }
                case 2:
                    if courses.count == 2{
                        courseList2.text = "2) \(String(describing: courses[1].courseName!)) | \(String(describing: courses[1].credits!))"
                        setGradeImage(course: courses[1], grade1: grade2)
                        courseList3.text = " "
                        grade3.image = nil
                    }
                    else if courses.count == 3 {
                        courseList3.text = "3) \(String(describing: courses[2].courseName!)) | \(String(describing: courses[2].credits!))"
                        setGradeImage(course: courses[2], grade1: grade3)
                        courseList4.text = " "
                        grade4.image = nil
                    }
                case 3:
                        courseList4.text = " "
                        grade4.image = nil
                default:
                    createAlert(title: "INVALID", message: "YOUR INPUT WAS NOT A VALID COURSE NUMBER")
            }
        }
    }
    
    
    func gradeCalc(assesment: Assessment, midterm: Assessment, final: Assessment) -> Double {
        let grade = (((Double(assesment.percentage!))*(0.01)) * ((Double(assesment.point!)) / (Double(assesment.max!)))) +
            (((Double(midterm.percentage!))*(0.01)) * ((Double(midterm.point!)) / (Double(midterm.max!)))) +
            (((Double(final.percentage!))*(0.01)) * ((Double(final.point!)) / (Double(final.max!))))
        return grade * 100
    }
    
    func listCourse(courses:Array<Course> ){
        
        if courses.count == 1{
            courseList1.text = "1) \(String(describing: courses[0].courseName!)) | \(String(describing: courses[0].credits!))"
            
            setGradeImage(course: courses[0], grade1: grade1)
        
        }
        else if courses.count == 2{
            courseList2.text = "2) \(String(describing: courses[1].courseName!)) | \(String(describing: courses[1].credits!))"
            setGradeImage(course: courses[1], grade1: grade2)
        }
        else if courses.count == 3{
            courseList3.text = "3) \(String(describing: courses[2].courseName!)) | \(String(describing: courses[2].credits!))"
            setGradeImage(course: courses[2], grade1: grade3)
        }
        else if courses.count == 4{
            courseList4.text = "4) \(String(describing: courses[3].courseName!)) | \(String(describing: courses[3].credits!))"
            setGradeImage(course: courses[3], grade1: grade4)
        }
    }
    
    func gpaCalc (courses: Array<Course>) -> Double{
        var sum : Double = 0
        var totCredits: Int = 0
        for index in courses{
            print("calc called")
            print(index.credits)
            print(index.letterGrade)
            sum += (Double (index.credits!) * index.letterGrade!)
            totCredits += index.credits!
        }
        var gpa : Double
        gpa = sum / Double(totCredits)
        return gpa
    }
    
    func setGradeImage (course: Course, grade1: UIImageView){
        if (course.grade! >= 90.0 && course.grade! <= 100.0 ){
            grade1.image = #imageLiteral(resourceName: "grade_a.png")
            course.letterGrade = 4.0
        }
        else if (course.grade! < 90.0 && course.grade! >= 80.0 ){
            grade1.image = #imageLiteral(resourceName: "grade_b.png")
            course.letterGrade = 3.0
        }
        else if (course.grade! < 80.0 && course.grade! >= 70.0 ){
            grade1.image = #imageLiteral(resourceName: "grade_c.png")
            course.letterGrade = 2.0
        }
        else if (course.grade! < 70.0 && course.grade! >= 60.0 ){
            grade1.image = #imageLiteral(resourceName: "grade_d.png")
            course.letterGrade = 1.0
        }
        else {
            grade1.image = #imageLiteral(resourceName: "grade_f.png")
            course.letterGrade = 0.0
        }
    }
    
    
    func createAlert (title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

