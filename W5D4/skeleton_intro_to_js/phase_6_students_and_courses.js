
function Student(first, last) {
  this.first = first;
  this.last = last;
  this.courses = [];
}

Student.prototype.name = function() {
  return `${this.first} ${this.last}`;
};

Student.prototype.enroll = function(course) {
  if (this.courses.indexOf(course) !== -1) {
    this.courses.push(course.name);
    course.students.push(this.name);
  }
};

Student.prototype.courseLoad = function() {

};

function Course(name, department, credits, daysOfWeek, timeBlock) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.daysOfWeek = daysOfWeek;
  this.timeBlock = timeBlock;
  this.students = [];
}

Course.prototype.addStudent = function(student) {
  student.enroll(this);
};
