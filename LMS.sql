CREATE TABLE department (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_name NVARCHAR(200)
);

CREATE TABLE students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(100),
    second_name NVARCHAR(100),
    surname NVARCHAR(100),
    birthday_student DATE,
    finished_date DATE,
    is_currently_studying BIT
);

CREATE TABLE Teachers (
    teacher_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(100),
    second_name NVARCHAR(100),
    surname NVARCHAR(100),
    is_employed_at_university BIT
);

CREATE TABLE Employment (
    employment_id INT IDENTITY(1,1) PRIMARY KEY,
    teacher_id INT NOT NULL,
    department_id INT NOT NULL,
    employment_type NVARCHAR(100),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

CREATE TABLE Discipline (
    discipline_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200),
    development_year INT,
    ordering_department NVARCHAR(200)
);

CREATE TABLE DisciplineAuthor (
    discipline_id INT NOT NULL,
    teacher_id INT NOT NULL,
    NewAttribute NVARCHAR(200),
    PRIMARY KEY (discipline_id, teacher_id),
    FOREIGN KEY (discipline_id) REFERENCES Discipline(discipline_id),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

CREATE TABLE Competency (
    competency_id INT IDENTITY(1,1) PRIMARY KEY,
    description NVARCHAR(MAX)
);

CREATE TABLE PrerequisiteCompetency (
    Prerequisite_id INT IDENTITY(1,1) PRIMARY KEY,
    discipline_id INT NOT NULL,
    competency_id INT NOT NULL,
    FOREIGN KEY (discipline_id) REFERENCES Discipline(discipline_id),
    FOREIGN KEY (competency_id) REFERENCES Competency(competency_id)
);

CREATE TABLE Section (
    section_id INT IDENTITY(1,1) PRIMARY KEY,
    discipline_id INT NOT NULL,
    title NVARCHAR(200),
    short_description NVARCHAR(MAX),
    auditory_hours INT,
    FOREIGN KEY (discipline_id) REFERENCES Discipline(discipline_id)
);

CREATE TABLE LearningOutcome (
    learning_outcome_id INT IDENTITY(1,1) PRIMARY KEY,
    section_id INT NOT NULL,
    competency_id INT NOT NULL,
    FOREIGN KEY (section_id) REFERENCES Section(section_id),
    FOREIGN KEY (competency_id) REFERENCES Competency(competency_id)
);

CREATE TABLE sectionOutcome (
    sectionOutcome_id INT IDENTITY(1,1) PRIMARY KEY,
    resaut NVARCHAR(MAX)
);

CREATE TABLE StudentDiscipline (
    student_discipline_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT NOT NULL,
    discipline_id INT NOT NULL,
    status NVARCHAR(100),
    grade NVARCHAR(10),
    completion_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (discipline_id) REFERENCES Discipline(discipline_id)
);

IF OBJECT_ID('sectionOutcome', 'U') IS NOT NULL
    DROP TABLE sectionOutcome;

CREATE TABLE sectionOutcome (
    sectionOutcome_id INT IDENTITY(1,1) PRIMARY KEY,
    section_id INT NOT NULL,
    learning_outcome_id INT NOT NULL,
    resaut NVARCHAR(MAX),
    FOREIGN KEY (section_id) REFERENCES Section(section_id),
    FOREIGN KEY (learning_outcome_id) REFERENCES LearningOutcome(learning_outcome_id)
);

IF OBJECT_ID('StudentDiscipline', 'U') IS NOT NULL
    DROP TABLE StudentDiscipline;
