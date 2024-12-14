//package com.example.demo_application.serviceImpl;
//
//import com.example.demo_application.enatity.Student;
//import com.example.demo_application.reposotiry.StudentRepo;
//import com.example.demo_application.service.StudentService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//
//@Service
//@RequiredArgsConstructor
//public class StudentServiceImpl implements StudentService {
//
//    private final StudentRepo studentRepo;
//
//
//    @Override
//    public Student save(Student student) {
//        return studentRepo.save(student);
//    }
//
//    @Override
//    public List<Student> saveListStudents(List<Student> students) {
//        List<Student> student=studentRepo.saveAll(students);
//        return student;
//    }
//
//    @Override
//    public Student getAll() {
//        return studentRepo.findAll();
//    }
//
//}
