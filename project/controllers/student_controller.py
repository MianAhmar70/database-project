from models.student_model import StudentModel

class StudentController:
    def __init__(self):
        self.model = StudentModel()

    def add_student(self):
        name = input("Enter name: ")
        dob = input("Enter DOB (YYYY-MM-DD): ")
        email = input("Enter email: ")
        dept = input("Enter department ID: ")
        self.model.create_student(name, dob, email, dept)
        print("Student added successfully!")

    def list_students(self):
        students = self.model.get_all_students()
        for s in students:
            print(f"ID: {s[0]}, Name: {s[1]}, DOB: {s[2]}, Email: {s[3]}, Dept: {s[4]}")
