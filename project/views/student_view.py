from controllers.student_controller import StudentController

class StudentView:
    def __init__(self):
        self.controller = StudentController()

    def menu(self):
        while True:
            print("\n--- Student Information System ---")
            print("1. Add Student")
            print("2. List Students")
            print("3. Exit")
            choice = input("Enter your choice: ")

            if choice == '1':
                self.controller.add_student()
            elif choice == '2':
                self.controller.list_students()
            elif choice == '3':
                break
            else:
                print("Invalid choice. Try again.")
