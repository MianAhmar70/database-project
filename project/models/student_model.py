from config.db_config import get_connection

class StudentModel:
    def create_student(self, name, dob, email, department_id):
        conn = get_connection()
        cursor = conn.cursor()
        query = "INSERT INTO students (name, dob, email, department_id) VALUES (%s, %s, %s, %s)"
        cursor.execute(query, (name, dob, email, department_id))
        conn.commit()
        cursor.close()
        conn.close()

    def get_all_students(self):
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("""
            SELECT s.id, s.name, s.dob, s.email, d.name 
            FROM students s 
            INNER JOIN departments d ON s.department_id = d.id
        """)
        result = cursor.fetchall()
        cursor.close()
        conn.close()
        return result
