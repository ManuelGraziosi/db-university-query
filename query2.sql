-- 1 Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT students.*, degrees.name AS 'degree_name'
FROM students
INNER JOIN degrees
ON degrees.id = students.degree_id
WHERE degrees.name = 'Corso di Laurea in Economia'

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT degrees.name AS 'degree_name', departments.name AS 'department_name'
FROM degrees
INNER JOIN departments
ON departments.id = degrees.department_id
WHERE departments.name = 'Dipartimento di Neuroscienze'
AND degrees.level = 'magistrale'

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT DISTINCT teachers.*, courses.name
FROM teachers
INNER JOIN course_teacher
ON teachers.id =  course_teacher.teacher_id
INNER JOIN courses
ON courses.id = course_teacher.course_id
WHERE teachers.id = 44

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento,
-- in ordine alfabetico per cognome e nome
SELECT students.*, degrees.name AS 'degree_name', departments.name AS 'department_name'
FROM students
INNER JOIN degrees
ON degrees.id = students.degree_id
INNER JOIN departments
ON departments.id = degrees.department_id
ORDER BY students.surname, students.name

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT degrees.name AS 'degree_name', courses.name AS 'course_name', teachers.name AS 'teacher_name', teachers.surname AS 'teacher_surename'
FROM degrees
INNER JOIN courses
ON degrees.id = courses.degree_id
INNER JOIN course_teacher
ON courses.id = course_teacher.course_id
INNER JOIN teachers
ON teachers.id = course_teacher.teacher_id
ORDER BY degrees.name 

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT distinct teachers.*, departments.name AS 'department_name'
FROM teachers
INNER JOIN course_teacher
ON teachers.id = course_teacher.teacher_id
INNER JOIN courses
ON courses.id = course_teacher.course_id
INNER JOIN degrees
ON degrees.id = courses.degree_id
INNER JOIN departments
ON departments.id = degrees.department_id
WHERE departments.id = 5
ORDER BY teachers.surname, teachers.name

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
SELECT students.id AS 'student_id', students.surname AS 'student_surname', students.name AS 'student_name', courses.name AS 'course_name', COUNT(exam_student.vote) AS 'exam_attempt', MAX(exam_student.vote) AS 'voto_massimo'
FROM students 
LEFT JOIN exam_student
ON students.id = exam_student.student_id
LEFT JOIN exams
ON exams.id = exam_student.exam_id
LEFT JOIN courses
ON courses.id = exams.course_id
GROUP BY students.id, courses.name
HAVING voto_massimo >= 18
ORDER BY exam_attempt
