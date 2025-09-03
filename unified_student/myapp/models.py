from django.db import models

# Create your models here.

class Login(models.Model):
    username=models.CharField(max_length=200)
    password=models.CharField(max_length=200)
    type=models.CharField(max_length=200)

class Student(models.Model):
    name=models.CharField(max_length=200)
    email=models.CharField(max_length=200)
    phone=models.BigIntegerField()
    dob=models.DateField()
    gender=models.CharField(max_length=200)
    place=models.CharField(max_length=200)
    post = models.CharField(max_length=200)
    pin = models.BigIntegerField()
    district = models.CharField(max_length=200)
    college_name = models.CharField(max_length=200)
    course  = models.CharField(max_length=200)
    department = models.CharField(max_length=200)
    semester = models.CharField(max_length=200)
    photo = models.CharField(max_length=200)
    LOGIN=models.ForeignKey(Login,on_delete=models.CASCADE)
class Activity(models.Model):
    point = models.IntegerField()
    category = models.CharField(max_length=200)
    level = models.CharField(max_length=200)



class Event_Coordinator(models.Model):
    name=models.CharField(max_length=200)
    email=models.CharField(max_length=200)
    phone=models.BigIntegerField()
    dob=models.DateField()
    gender=models.CharField(max_length=200)
    place=models.CharField(max_length=200)
    post = models.CharField(max_length=200)
    pin = models.BigIntegerField()
    district = models.CharField(max_length=200)
    photo = models.CharField(max_length=200)
    status = models.CharField(max_length=200)
    college_name = models.CharField(max_length=200)
    LOGIN=models.ForeignKey(Login,on_delete=models.CASCADE)




class Event_details(models.Model):
     event_name = models.CharField(max_length=200)
     date = models.DateField()
     duration = models.CharField(max_length=200)
     venue = models.CharField(max_length=200)
     College_name = models.CharField(max_length=200)
     poster = models.CharField(max_length=200)
     ACTIVITY = models.ForeignKey(Activity, on_delete=models.CASCADE)
     amount = models.IntegerField()
     latitude=models.CharField(max_length=200)
     longitude=models.CharField(max_length=200)
     EVENT_COORDINATOR = models.ForeignKey(Event_Coordinator, on_delete=models.CASCADE)


class Ticket(models.Model):
    date = models.DateField()
    ticket_no = models.BigIntegerField()
    EVENT_DETAILS = models.ForeignKey(Event_details, on_delete=models.CASCADE)
    STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)


class Report(models.Model):
    date = models.DateField()
    report = models.CharField(max_length=200)
    EVENT_DETAILS = models.ForeignKey(Event_details, on_delete=models.CASCADE)
    EVENT_COORDINATOR = models.ForeignKey(Event_Coordinator, on_delete=models.CASCADE)


class Feedback(models.Model):
    date = models.DateField()
    feedback = models.CharField(max_length=200)
    EVENT_DETAILS = models.ForeignKey(Event_details, on_delete=models.CASCADE)
    STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)

class Notification(models.Model):
    date = models.DateField()
    title = models.CharField(max_length=200)
    notification = models.CharField(max_length=200)
    EVENT_COORDINATOR = models.ForeignKey(Event_Coordinator, on_delete=models.CASCADE)

class Booking(models.Model):
    date = models.DateField()
    status = models.CharField(max_length=200)
    STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)
    EVENT_DETAILS = models.ForeignKey(Event_details, on_delete=models.CASCADE)

class Payment(models.Model):
    date = models.DateField()
    status = models.CharField(max_length=200)
    STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)
    BOOKING = models.ForeignKey(Booking, on_delete=models.CASCADE)

class Certificate(models.Model):
    date = models.DateField()
    certificate = models.CharField(max_length=200)
    STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)
    EVENT_DETAILS=models.ForeignKey(Event_details, on_delete=models.CASCADE)


# class Activity_point(models.Model):
#     point = models.BigIntegerField()
#     EVENT_COORDINATOR = models.ForeignKey(Event_Coordinator, on_delete=models.CASCADE)
#     STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)
#     EVENT_DETAILS=models.ForeignKey(Event_details, on_delete=models.CASCADE)

# class Activity_point(models.Model):
#     CATEGORY_CHOICES = [
#         ("Technical", "Technical"),
#         ("Sports", "Sports"),
#         ("Arts", "Arts"),
#         ("Volunteering", "Volunteering"),
#         ("Entrepreneurship", "Entrepreneurship"),
#     ]
#
#     LEVEL_CHOICES = [
#         ("College", "College Level"),
#         ("University", "University Level"),
#         ("National", "National Level"),
#     ]
#
#     point = models.PositiveIntegerField()
#     category = models.CharField(max_length=50, choices=CATEGORY_CHOICES, default="Technical")
#     level = models.CharField(max_length=50, choices=LEVEL_CHOICES, default="College")
#     remarks = models.TextField(blank=True, null=True)  # Optional additional details
#
#     EVENT_COORDINATOR = models.ForeignKey(Event_Coordinator, on_delete=models.CASCADE, related_name="activity_points")
#     STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE, related_name="activity_points")
#     EVENT_DETAILS = models.ForeignKey(Event_details, on_delete=models.CASCADE, related_name="activity_points")
#
#     def __str__(self):
#         return f"{self.STUDENT.name} - {self.point} Points ({self.category}, {self.level})"
#
#


class Activity_point(models.Model):
    EVENT_COORDINATOR = models.ForeignKey(Event_Coordinator, on_delete=models.CASCADE)
    STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)
    EVENT_DETAILS = models.ForeignKey(Event_details, on_delete=models.CASCADE)
    date=models.CharField(max_length=200,default='')

class Complaint(models.Model):
    date = models.DateField()
    complaint = models.CharField(max_length=200)
    reply = models.CharField(max_length=200)
    status = models.CharField(max_length=200)
    STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)



class Location(models.Model):
    LOGIN=models.ForeignKey(Login,on_delete=models.CASCADE)
    date = models.DateField()
    latitude = models.CharField(max_length=200)
    longitude = models.CharField(max_length=200)

# class StdActivitypoint(models.Model):
#     STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)
#     s_w_ktu1 = models.CharField(max_length=250)
#     s_w_ktu2 = models.CharField(max_length=250)
#     s_w_ni1 = models.CharField(max_length=250)
#     s_w_ni2 = models.CharField(max_length=250)
#     pp_ktu1 = models.CharField(max_length=250)
#     pp_ktu2 = models.CharField(max_length=250)
#     pp_ni1 = models.CharField(max_length=250)
#     pp_ni2 = models.CharField(max_length=250)
#     intern = models.CharField(max_length=250)
#     sports1 = models.CharField(max_length=250)
#     sports2 = models.CharField(max_length=250)
#     sports3 = models.CharField(max_length=250)
#     sports4 = models.CharField(max_length=250)
#     sports5 = models.CharField(max_length=250)
#     sports6 = models.CharField(max_length=250)
#     sports7 = models.CharField(max_length=250)
#     marks=models.CharField(max_length=250)

class StdActivitypoint(models.Model):
    STUDENT = models.ForeignKey(Student, on_delete=models.CASCADE)
    file = models.CharField(max_length=250)
    marks = models.CharField(max_length=250)
    ACTIVITY = models.ForeignKey(Activity, on_delete=models.CASCADE)
    date = models.DateField()



