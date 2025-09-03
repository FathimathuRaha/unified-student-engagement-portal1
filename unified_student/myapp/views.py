import random
from datetime import datetime

from django.core.files.storage import FileSystemStorage
from django.db.models import Q, Sum
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render

# Create your views here.
from myapp.models import *


def login_get(request):
    return render(request,'Login.html')

def login_post(request):
    username=request.POST['textfield']
    password=request.POST['textfield2']

    a=Login.objects.filter(username=username,password=password)
    if a.exists():
        a1 = Login.objects.get(username=username, password=password)
        request.session['lid']=a1.id
        if a1.type=='admin':
            return HttpResponse("<script>alert('admin login success');window.location='/myapp/admin_home/'</script>")
        elif a1.type=='coordinator':
            return HttpResponse("<script>alert('coordinator login success');window.location='/myapp/coordinator_home/'</script>")

        else:
            return HttpResponse("<script>alert('invalid usename or password');window.location='/myapp/login_get/'</script>")
    else:
        return HttpResponse("<script>alert('user not found');window.location='/myapp/login_get/'</script>")




# ------------------------Admin------------------

def admin_home(request):
    return render(request,'admin/admin_index.html')

def changepassword_get(request):
    return render(request,'admin/Change password.html')

def changepassword_post(request):
    CurrentPassword=request.POST['textfield']
    Newpassword=request.POST['textfield2']
    ConfirmPassword=request.POST['textfield3']

    a=Login.objects.filter(id=request.session['lid'],password=CurrentPassword)
    if a.exists():
        if Newpassword==ConfirmPassword:
            a1 = Login.objects.filter(id=request.session['lid'], password=CurrentPassword).update(password=Newpassword)
            return HttpResponse("<script>alert('password change success');window.location='/myapp/login_get/'</script>")
        else:
            return HttpResponse("<script>alert('password does not match');window.location='/myapp/changepassword_get/'</script>")
    else:
        return HttpResponse("<script>alert('not found');window.location='/myapp/changepassword_get/'</script>")


def add_activity_get(request):
    return render(request, 'admin/Manage Activity.html')

def add_activity_post(request):
    if request.method == "POST":
        Point = request.POST.get('point', '')
        Category = request.POST.get('category', '')
        Level = request.POST.get('level', '')

        # Saving the activity point
        b = Activity(
            point=int(Point),
            category=Category,
            level=Level,
        )
        b.save()

        return HttpResponse("<script>alert('Activity Added Successfully');window.location='/myapp/admin_home/'</script>")



def view_activity_get(request):
    data=Activity.objects.all()

    return render(request,'admin/View Activity .html',{'data':data})

def view_activity_post(request):
    SEARCH = request.POST['textfield']
    data=Activity.objects.filter(category__icontains=SEARCH)

    return render(request,'admin/View Activity .html',{'data':data})


def delete_activity(request,id):
    Activity.objects.get(id=id).delete()
    return HttpResponse("<script>alert('delete success');window.location='/myapp/view_activity_get/'</script>")



def add_ticket_get(request):
    stud=Student.objects.all()
    eventd=Event_details.objects.all()
    return render(request,'admin/Ticket Management.html',{'student':stud,'eventd':eventd})

def add_ticket_post(request):
    Ticketno = request.POST['textfield']
    Date = request.POST['textfield2']
    Studentname = request.POST['select1']
    Eventname = request.POST['select']

    a=Ticket()
    a.ticket_no=Ticketno
    a.date=Date
    a.EVENT_DETAILS_id=Eventname
    a.STUDENT_id=Studentname
    a.save()
    return HttpResponse("<script>alert('add success');window.location='/myapp/admin_home/'</script>")


def view_ticket_get(request):
    ticket=Ticket.objects.all()
    return render(request,'admin/View Ticket.html',{"data":ticket})

def view_ticket_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    ticket=Ticket.objects.filter(date__range=[From,To])


    return HttpResponse("ok")

def edit_ticket_get(request,id):
    b=Ticket.objects.get(id=id)
    s=Student.objects.all()
    eventd=Event_details.objects.all()
    return render(request,'admin/Edit Ticket.html',{'data':b,'student':s,'eventd':eventd})

def edit_ticket_post(request):
    Ticketno = request.POST['textfield']
    Date = request.POST['textfield2']
    Studentname = request.POST['select1']
    Eventname = request.POST['select']
    id=request.POST['id']

    a = Ticket.objects.get(id=id)
    a.ticket_no = Ticketno
    a.date = Date
    a.EVENT_DETAILS_id = Eventname
    a.STUDENT_id = Studentname
    a.save()
    return HttpResponse("<script>alert('edit success');window.location='/myapp/view_ticket_get/'</script>")


def delete_ticket(request,id):
    Ticket.objects.get(id=id).delete()
    return HttpResponse("<script>alert('delete success');window.location='/myapp/view_ticket_get/'</script>")

def add_eventdetails_report_get(request):
    eventd=Event_details.objects.all()
    date=Event_Coordinator.objects.all()
    return render(request,'admin/Event Details Report.html',{'eventd':eventd,'date':date})

def add_eventdetails_report_post(request):
    Event = request.POST['events']
    cord = request.POST['select1']
    report = request.POST['textarea']
    a=Report()
    a.date=datetime.now().today()
    a.report=report
    a.EVENT_DETAILS_id=Event
    a.EVENT_COORDINATOR_id=cord
    a.save()
    return HttpResponse("<script>alert('add success');window.location='/myapp/admin_home/'</script>")

def view_eventdetails_report_get(request):
    details=Report.objects.all()

    return render(request,'admin/View Report.html',{"data":details})

def view_eventdetails_report_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    details=Report.objects.filter(date__range=[From,To])

    return render(request,'admin/View Report.html',{"data":details})


def edit_eventdetails_report_get(request):
    return render(request,'admin/Edit Event Reports.html')

def edit_eventdetails_report_post(request):
    Event = request.POST['events']
    Date = request.POST['textfield']
    Report = request.POST['textarea']

    return render(request,'admin/Edit Event Reports.html')

def delete_eventdetails_report(request,id):
    Event_details.objects.get(id=id).delete()
    return HttpResponse("<script>alert('delete success');window.location='/myapp/view_eventdetails_report_get/'</script>")


def view_coordinator_get(request):
    coordinator=Event_Coordinator.objects.filter(status='pending')

    return render(request,'admin/View coordinator approve or reject.html',{"data":coordinator})

def view_coordinator_post(request):
    SEARCH = request.POST['textfield']

    coordinator=Event_Coordinator.objects.filter(status='pending',name__icontains=SEARCH)

    return render(request,'admin/View coordinator approve or reject.html',{"data":coordinator})


def approve_coordinator(request,id):
    Event_Coordinator.objects.filter(LOGIN=id).update(status='approved')
    Login.objects.filter(id=id).update(type='coordinator')
    return HttpResponse("<script>alert('approved coordinator');window.location='/myapp/view_coordinator_get/'</script>")



def reject_coordinator(request,id):
    Event_Coordinator.objects.filter(LOGIN=id).update(status='rejected')
    Login.objects.filter(id=id).update(type='rejected')
    return HttpResponse("<script>alert('rejected coordinator');window.location='/myapp/view_coordinator_get/'</script>")






def view_approvedcoordinator_get(request):
    approve=Event_Coordinator.objects.filter(status='approved')
    return render(request,'admin/View approved coordinator.html',{"data":approve})

def view_approvedcoordinator_post(request):
    SEARCH = request.POST['textfield']
    approve=Event_Coordinator.objects.filter(status='approved',name__icontains=SEARCH)

    return render(request,'admin/View approved coordinator.html',{"data":approve})


def view_rejectedcoordinator_get(request):
    reject=Event_Coordinator.objects.filter(status='rejected')

    return render(request,'admin/View Rejected coordinator.html',{"data":reject})

def view_rejectedcoordinator_post(request):
    SEARCH = request.POST['textfield']

    reject=Event_Coordinator.objects.filter(status='rejected',name__icontains=SEARCH)


    return render(request,'admin/View Rejected coordinator.html',{"data":reject})

def view_complaint_get(request):
    complaint=Complaint.objects.all()

    return render(request,'admin/View Complaint.html',{'data':complaint})

def view_complaint_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    complaint=Complaint.objects.filter(date__range=[From,To])


    return render(request,'admin/View Complaint.html',{'data':complaint})


def view_sendreply_get(request,id):
    return render(request,'admin/Send Reply.html',{'id':id})
# def view_sendreply_get(request):
#     return render(request,'admin/Send Reply.html')

def view_sendreply_post(request):
    reply=request.POST['textarea']
    id=request.POST['id']


    cobj=Complaint.objects.get(id=id)
    cobj.reply=reply
    cobj.status="replied"
    cobj.save()


    return render(request,'admin/Send Reply.html',{'id':id})

def view_events_get(request):
    event=Event_details.objects.all()
    return render(request,'admin/View Events.html',{'data':event})

def view_events_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    event=Event_details.objects.filter(date__range=[From,To])


    return render(request,'admin/View Events.html',{'data':event})

def view_feedback_get(request):
    feedback=Feedback.objects.all()
    return render(request,'admin/View Feedback.html',{'data':feedback})

def view_feedback_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    feedback=Feedback.objects.filter(date__range=[From,To])


    return render(request,'admin/View Feedback.html',{'data':feedback})

def view_notification_get(request):
    notification=Notification.objects.all()
    return render(request,'admin/View Notification.html',{'data':notification})

def view_notification_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    notification=Notification.objects.filter(date__range=[From,To])


    return render(request,'admin/View Notification.html',{'data':notification})

def view_issuedcertificate_get(request):
    certi=Certificate.objects.all()
    return render(request,'admin/View Issued Certificate.html',{'data':certi})

def view_issuedcertificate_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    certi=Certificate.objects.filter(date__range=[From,To])


    return render(request,'admin/View Issued Certificate.html',{'data':certi})


def view_payment_get(request):
    pay=Payment.objects.all()
    return render(request,'admin/View Payment.html',{'data':pay})

def view_payment_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    pay=Payment.objects.filter(date__range=[From,To])


    return render(request,'admin/View Payment.html',{'data':pay})

def view_student_get(request):
    stud=Student.objects.all()
    return render(request,'admin/View Student.html',{'data':stud})

def view_student_post(request):
    SEARCH = request.POST['textfield']
    stud=Student.objects.filter(name__icontains=SEARCH)


    return render(request,'admin/View Student.html',{'data':stud})

#----------------event coordinator---------------


def co_view_student_get(request,id):
    request.session['eid']=id
    stud=Booking.objects.filter(EVENT_DETAILS=id,status="paid")
    l=[]
    for i in stud:
        h="no"
        if Activity_point.objects.filter(STUDENT_id=i.STUDENT.id,EVENT_DETAILS=i.EVENT_DETAILS.id).exists():
            h="yes"
        l.append({"id":i.STUDENT.id,"name":i.STUDENT.name,"h":h,"email":i.STUDENT.email,"phone":i.STUDENT.phone,"dob":i.STUDENT.phone,"gender":i.STUDENT.gender,"college_name":i.STUDENT.college_name,"department":i.STUDENT.department,"semester":i.STUDENT.semester,"photo":i.STUDENT.photo,"place":i.STUDENT.place,"post":i.STUDENT.post,"pin":i.STUDENT.pin,"district":i.STUDENT.district})
    return render(request,'Event Coordinator/View Student.html',{'data':l})

def co_view_student_post(request):
    SEARCH = request.POST['textfield']
    stud=Booking.objects.filter(EVENT_DETAILS=request.session['eid'],status="paid",name__icontains=SEARCH)
    return render(request,'Event Coordinator/View Student.html',{'data':stud})

def markattend(request):
    sid=request.POST.getlist('stid')
    print(sid)

    for i in sid:
        if Activity_point.objects.filter(EVENT_DETAILS_id=request.session['eid'],STUDENT_id=i).exists():
            pass
        else:
            v=Activity_point()
            v.EVENT_DETAILS_id=request.session['eid']
            v.STUDENT_id=i
            v.date=datetime.now().date()
            v.EVENT_COORDINATOR=Event_Coordinator.objects.get(LOGIN=request.session['lid'])
            v.save()
    return HttpResponse("<script>alert(' attendence marked successfully');window.location='/myapp/coordinator_home/'</script>")



def event_change_password_get(request):
    return render(request,'Event Coordinator/Change Password.html')

def event_change_password_post(request):
    CurrentPassword = request.POST['textfield']
    NewPassword = request.POST['textfield2']
    ConfirmPassword = request.POST['textfield3']

    return HttpResponse("ok")

def event_add_event_get(request):
    activity = Activity.objects.all()
    return render(request,'Event Coordinator/Add event.html',{'activity':activity})

def event_add_event_post(request):
    Date = request.POST['textfield']
    CollegeName = request.POST['textfield6']
    EventName = request.POST['textfield2']
    Duration = request.POST['Duration']
    Venue = request.POST['textfield4']
    ActivityPoint = request.POST['select']
    amount = request.POST['textfield7']
    poster = request.FILES['textfield6']
    latitude=request.POST['textfield8']
    longitude=request.POST['textfield9']

    dt = datetime.now().strftime('%Y%m%d-%H%M%S') + ".jpg"
    fs = FileSystemStorage()
    fs.save(dt, poster)
    path = fs.url(dt)

    a=Event_details()
    a.event_name=EventName
    a.date=Date
    a.EVENT_COORDINATOR= Event_Coordinator.objects.get(LOGIN_id=request.session['lid'])
    a.duration=Duration
    a.venue=Venue
    a.College_name=CollegeName
    a.ACTIVITY_id=ActivityPoint
    a.amount=amount
    a.poster=path
    a.latitude=latitude
    a.longitude=longitude
    a.save()

    return HttpResponse("<script>alert('Event added successfully');window.location='/myapp/coordinator_home/'</script>")

def add_activitypoint_get(request):
    activity=Activity.objects.all()
    student=Student.objects.all()
    event=Event_details.objects.all()
    return render(request, 'Event Coordinator/Manage Activity point.html',{'activity':activity,'student':student,'event':event})

def add_activitypoint_post(request):
    if request.method == "POST":
        activity = request.POST['select']
        event = request.POST['select1']
        student = request.POST['select2']
        # activity = request.POST.get('select', '')
        # event = request.POST.get('select1', '')
        # student = request.POST.get('select2', '')

        # Saving the activity point
        b = Activity_point(
            EVENT_COORDINATOR=Event_Coordinator.objects.get(LOGIN=request.session['lid']),
            EVENT_DETAILS_id=event,
            STUDENT_id=student

        )
        b.save()

    return HttpResponse("<script>alert('Activity point Added Successfully');window.location='/myapp/coordinator_home/'</script>")



def view_activitypoint_get(request):
    data=Activity_point.objects.all()
    return render(request,'Event Coordinator/View Activity point.html',{'data':data})

def view_activitypoint_post(request):
    SEARCH = request.POST['textfield']
    data=Activity_point.objects.filter(category__icontains=SEARCH)

    return render(request,'Event Coordinator/View Activity point.html',{'data':data})


def delete_activitypoint(request,id):
    Activity_point.objects.get(id=id).delete()
    return HttpResponse("<script>alert('delete success');window.location='/myapp/view_activitypoint_get/'</script>")



def event_edit_event_get(request,id):
    res=Event_details.objects.get(id=id)
    activity=Activity.objects.all()

    return render(request,'Event Coordinator/edit event.html',{'data':res,"activity":activity})


def event_edit_event_post(request):
    Date = request.POST['textfield']
    CollegeName = request.POST['textfield6']
    EventName = request.POST['textfield2']
    Duration = request.POST['textfield3']
    Venue = request.POST['textfield4']
    ActivityPoint = request.POST['select']
    amount = request.POST['textfield66']
    id = request.POST['id']


    a=Event_details.objects.get(id=id)
    a.event_name=EventName
    a.date=Date
    # a.EVENT_COORDINATOR= Event_Coordinator.objects.get(LOGIN_id=request.session['lid'])
    a.duration=Duration
    a.venue=Venue
    a.College_name=CollegeName
    a.ACTIVITY_id=ActivityPoint
    a.amount=amount
    a.save()

    return HttpResponse("<script>alert('Event edited successfully');window.location='/myapp/event_view_event_get/'</script>")


def event_view_event_get(request):
    v=Event_details.objects.filter(EVENT_COORDINATOR__LOGIN=request.session['lid'])
    return render(request,'Event Coordinator/view event.html',{"data":v})

def event_view_event_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']

    return HttpResponse("ok")

def delete_event(request,id):
    Event_details.objects.get(id=id).delete()
    return HttpResponse("<script>alert('delete success');window.location='/myapp/event_view_event_get/'</script>")




def coordinator_home(request):
    return render(request,'Event Coordinator/ec_index.html')



def event_register_get(request):
    return render(request,'Event Coordinator/Register.html')

def event_register_post(request):
    Name = request.POST['textfield']
    Email = request.POST['textfield2']
    PhoneNo = request.POST['textfield3']
    Place = request.POST['textfield4']
    Post = request.POST['textfield5']
    Pin = request.POST['textfield6']
    District = request.POST['textfield7']
    DOB = request.POST['textfield8']
    Gender = request.POST['textfield9']
    CreatePassword = request.POST['textfield11']
    ConfirmPassword = request.POST['textfield12']
    Collegename = request.POST['textfield13']
    Photo = request.FILES['textfield10']


    dt=datetime.now().strftime('%Y%m%d-%H%M%S')+".jpg"
    fs=FileSystemStorage()
    fs.save(dt,Photo)
    path=fs.url(dt)


    if Login.objects.filter(username=Email).exists():
        return HttpResponse("<script>alert('email already existed');window.location='/myapp/event_register_get/'</script>")



    if CreatePassword==ConfirmPassword:


        l=Login()
        l.username=Email
        l.password=ConfirmPassword
        l.type='pending'
        l.save()
        e=Event_Coordinator()
        e.name=Name
        e.email=Email
        e.phone=PhoneNo
        e.dob=DOB
        e.gender=Gender
        e.place=Place
        e.post=Post
        e.pin=Pin
        e.district=District
        e.photo=path
        e.college_name=Collegename
        e.status='pending'
        e.LOGIN=l
        e.save()


        return HttpResponse("<script>alert(' succesfully registered');window.location='/myapp/login_get/'</script>")
    else:
        return HttpResponse("<script>alert(' password mismatched');window.location='/myapp/event_register_get/'</script>")

def event_view_profile_get(request):

    ev=Event_Coordinator.objects.get(LOGIN_id= request.session['lid'])
    return render(request, 'Event Coordinator/View profile.html',{'data':ev})

def event_view_profile_post(request):
    SEARCH = request.POST['textfield']
    stud=Student.objects.filter(name__icontains=SEARCH)


    return render(request,'Event Coordinator/View profile.html',{'data':stud})

# def event_edit_profile_post(request):
#     Name = request.POST['textfield']
#     Email = request.POST['textfield2']
#     PhoneNo = request.POST['textfield3']
#     Place = request.POST['textfield4']
#     Post = request.POST['textfield5']
#     Pin = request.POST['textfield6']
#     District = request.POST['textfield7']
#     DOB = request.POST['textfield8']
#     Gender = request.POST['textfield9']
#     Photo = request.POST['textfield10']
#     Collegename = request.POST['textfield13']
#
#
#     return HttpResponse("ok")
#
def event_update_profile_get(request):
    ev=Event_Coordinator.objects.get(LOGIN_id= request.session['lid'])

    return render(request,'Event Coordinator/Update Profile.html',{'data':ev})

def event_update_profile_post(request):
    Name = request.POST['textfield']
    Email = request.POST['textfield2']
    PhoneNo = request.POST['textfield3']
    Place = request.POST['textfield4']
    Post = request.POST['textfield5']
    Pin = request.POST['textfield6']
    District = request.POST['textfield7']
    DOB = request.POST['textfield8']
    Gender = request.POST['textfield9']
    Collagename = request.POST['textfield11']
    a=Event_Coordinator.objects.get(LOGIN_id= request.session['lid'])

    if 'textfield10' in request.FILES:
        Photo = request.FILES['textfield10']

        dt=datetime.now().strftime('%Y%m%d-%H%M%S')+".jpg"
        fs=FileSystemStorage()
        fs.save(dt,Photo)
        path=fs.url(dt)
        a.photo = path
        a.save()

    a.name=Name
    a.email= Email
    a.phone= PhoneNo
    a.place=Place
    a.post=Post
    a.pin=Pin
    a.district =District
    a.dob =DOB
    a.gender =Gender
    a.college_name = Collagename
    a.save()



    return HttpResponse("<script>alert('profile edited successfully');window.location='/myapp/event_view_profile_get/'</script>")

def delete_profile(request,id):
    Event_Coordinator.objects.get(id=id).delete()
    return HttpResponse("<script>alert('delete success');window.location='/myapp/delete_profile/'</script>")


def event_view_booking_get(request):
    data=Booking.objects.filter(status='pending',EVENT_DETAILS__EVENT_COORDINATOR__LOGIN=request.session['lid'])
    return render(request,'Event Coordinator/View booking accept or reject.html',{"data":data})

def event_view_booking_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']

    return HttpResponse("ok")


def approvebooking(request,id):
    data=Booking.objects.filter(id=id).update(status='approved')
    return HttpResponse("<script>alert(' Approve succesfully ');window.location='/myapp/event_view_booking_get/'</script>")

def rejectbooking(request,id):
    data=Booking.objects.filter(id=id).update(status='rejected')
    return HttpResponse("<script>alert(' rejected ');window.location='/myapp/event_view_booking_get/'</script>")


def event_accepted_booking_get(request):
    data=Booking.objects.filter(status='approved',EVENT_DETAILS__EVENT_COORDINATOR__LOGIN=request.session['lid'])
    return render(request,'Event Coordinator/View accepted booking.html',{'data':data})

def event_accepted_booking_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']

    return HttpResponse("ok")

def event_rejected_booking_get(request):
    data=Booking.objects.filter(status='rejected',EVENT_DETAILS__EVENT_COORDINATOR__LOGIN=request.session['lid'])
    return render(request,'Event Coordinator/View rejected booking.html',{"data":data})

def event_rejected_booking_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']

    return HttpResponse("ok")

def event_view_payment_get(request):
    data=Payment.objects.filter(BOOKING__EVENT_DETAILS__EVENT_COORDINATOR__LOGIN=request.session['lid'])
    return render(request,'Event Coordinator/View Payment.html',{'data':data})


def event_view_payment_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']
    data=Payment.objects.filter(date__range=[From,To],BOOKING__EVENT_DETAILS__EVENT_COORDINATOR__LOGIN=request.session['lid'])
    return render(request,'Event Coordinator/View Payment.html',{'data':data})

def event_generate_certificate_get(request):
    return render(request,'Event Coordinator/Generate Certificate.html')

def event_generate_certificate_post(request):
    StudentName = request.POST['textfield']
    CertificateNo = request.POST['textfield2']
    EventName = request.POST['textfield3']


    return HttpResponse("ok")


def event_view_feedback_get(request):
    data=Feedback.objects.filter(EVENT_DETAILS__EVENT_COORDINATOR__LOGIN_id=request.session['lid'])
    return render(request,'Event Coordinator/View Feedback.html',{"data":data})

def event_view_feedback_post(request):
    From = request.POST['textfield']
    To = request.POST['textfield2']

    data=Feedback.objects.filter(date__range=[From,To])
    return render(request,'Event Coordinator/View Feedback.html',{'data':data})



def Logout(request):
    request.session['lid']=''
    return HttpResponse("<script>alert('Logout');window.location='/myapp/login_get/'</script>")


# -------------------------------------FLUTTER-----------------------------------



def std_register(request):
    name=request.POST['name']
    email=request.POST['email']
    phone=request.POST['phone']
    dob=request.POST['dob']
    gender=request.POST['gender']
    place=request.POST['place']
    post=request.POST['post']
    pin=request.POST['pin']
    district=request.POST['district']
    college_name=request.POST['college_name']
    course=request.POST['course']
    department=request.POST['department']
    semester=request.POST['semester']
    photo=request.POST['photo']
    password=request.POST['password']
    confirm_password=request.POST['confirm_password']

    l=Login()
    l.username=email
    l.password=confirm_password
    l.type='student'
    l.save()

    from datetime import datetime
    date=datetime.now().strftime("%Y%m%d-%H%M%S")+".jpg"
    import base64
    a=base64.b64decode(photo)
    fh=open("C:\\Users\\user\\PycharmProjects\\unified_student\\media\\student\\"+date,"wb")
    path='/media/student/'+date

    fh.write(a)
    fh.close()


    a=Student()
    a.name=name
    a.email=email
    a.phone=phone
    a.dob=dob
    a.gender=gender
    a.place=place
    a.post=post
    a.pin=pin
    a.district=district
    a.college_name=college_name
    a.course=course
    a.department=department
    a.semester=semester
    a.photo=path
    a.LOGIN=l
    a.save()

    return JsonResponse({"status":"ok"})


def std_login(request):
    username=request.POST['username']
    password=request.POST['password']

    a=Login.objects.filter(username=username,password=password)
    if a.exists():
        a1 = Login.objects.get(username=username, password=password)
        lid=a1.id
        print(lid)
        if a1.type=='student':
            return JsonResponse({"status": "ok","lid":str(lid)})
        else:
            return JsonResponse({"status": "no"})
    else:
        return JsonResponse({"status": "no"})


def std_changepassword(request):
    CurrentPassword = request.POST['CurrentPassword']
    NewPassword = request.POST['NewPassword']
    ConfirmPassword = request.POST['ConfirmPassword']
    lid=request.POST['lid']

    a=Login.objects.filter(id=lid,password=CurrentPassword)
    if a.exists():
        Login.objects.get(id=lid,password=CurrentPassword)
        if NewPassword==ConfirmPassword:
            a1 = Login.objects.filter(id=lid).update(password=NewPassword)
            return JsonResponse({"status": "ok"})
        else:
            return JsonResponse({"status": "no"})
    else:
        return JsonResponse({"status": "no"})


def std_viewprofile(request):
    lid=request.POST["lid"]
    print(lid,"llllllllllllllllllllll")
    data=Student.objects.get(LOGIN_id=lid)
    print(data)
    return JsonResponse(

        {"status": "ok",
            'name':data.name,
            'email':data.email,
            'phone':data.phone,
            'dob':data.dob,
            'gender':data.gender,
            'place':data.place,
            'post':data.post,
            'pin':data.pin,
            'district':data.district,
            'college_name':data.college_name,
            'course':data.course,
            'department':data.department,
            'semester':data.semester,
            'photo':data.photo


        }

    )



def std_editprofile(request):
    name=request.POST['name']
    email=request.POST['email']
    phone=request.POST['phone']
    dob=request.POST['dob']
    gender=request.POST['gender']
    place=request.POST['place']
    post=request.POST['post']
    pin=request.POST['pin']
    district=request.POST['district']
    college_name=request.POST['college_name']
    course=request.POST['course']
    department=request.POST['department']
    semester=request.POST['semester']
    photo=request.POST['photo']
    id=request.POST['lid']

    a = Student.objects.get(LOGIN=id)


    if len(photo)>0:
        from datetime import datetime
        date = datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
        import base64
        a = base64.b64decode(photo)
        fh = open("C:\\Users\\user\\PycharmProjects\\unified_student\\media\\student\\" + date)

        fh.write(a)
        fh.close()
        a.photo = "/media/student/" + date
        a.save()

    a.name = name
    a.email = email
    a.phone = phone
    a.dob = dob
    a.gender = gender
    a.place = place
    a.post = post
    a.pin = pin
    a.district = district
    a.college_name = college_name
    a.course = course
    a.department = department
    a.semester = semester
    a.save()

    return JsonResponse({"status":"ok"})

def std_view_eventdetails(request):
    sea=request.POST['val']
    data=Event_details.objects.filter(event_name__icontains=sea)|Event_details.objects.filter(College_name__icontains=sea)
    l=[]
    for i in data:
        l.append({
            'id':i.id,
            'event_name':i.event_name,
            'date':i.date,
            'duration':i.duration,
            'venue':i.venue,
            'College_name':i.College_name,
            'poster':i.poster,
            'point':i.ACTIVITY.point,
            'amount':i.amount,

        })
    print(l)
    return JsonResponse({"status":"ok",'data':l})

def view_event_details(request):
    id=request.POST['id']
    a=Event_details.objects.get(id=id)
    return JsonResponse({"status":"ok",
                         'event_name': a.event_name,
                         'date': a.date,
                         'duration': a.duration,
                         'venue': a.venue,
                         'College_name': a.College_name,
                         'poster': a.poster,
                         'ACTIVITY': a.ACTIVITY.point,
                         'amount': a.amount,
                         'latitude': a.latitude,
                         'longitude': a.longitude,
                         'EVENT_COORDINATOR': a.EVENT_COORDINATOR.name

                         })

# def std_view_event_nearest_events(request):
#
#
#     data=Event_details.objects.all()
#     l=[]
#     for i in data:
#         l.append({
#             'id':i.id,
#             'event_name':i.event_name,
#             'date':i.date,
#             'duration':i.duration,
#             'venue':i.venue,
#             'College_name':i.College_name,
#             'poster':i.poster,
#             'point':i.point,
#             'latitude':i.latitude,
#             'longitude':i.longitude,
#
#         })
#     print(l)
#     return JsonResponse({"status":"ok",'data':l})
#
#
#




from django.http import JsonResponse
from math import radians, sin, cos, sqrt, atan2

def haversine(lat1, lon1, lat2, lon2):
    # Radius of the Earth in kilometers
    R = 6371.0

    # Convert latitude and longitude from degrees to radians
    lat1, lon1, lat2, lon2 = map(radians, [lat1, lon1, lat2, lon2])

    # Difference in coordinates
    dlat = lat2 - lat1
    dlon = lon2 - lon1

    # Haversine formula
    a = sin(dlat / 2)**2 + cos(lat1) * cos(lat2) * sin(dlon / 2)**2
    c = 2 * atan2(sqrt(a), sqrt(1 - a))

    # Distance in kilometers
    distance = R * c
    return distance

def view_event_nearest_events(request):
    lid=request.POST['lid']
    data = Location.objects.filter(LOGIN_id=lid).first()
    phone_lat = float(data.latitude)
    phone_lon = float(data.longitude)

    data = Event_details.objects.all()
    l = []

    for i in data:
        event_lat = i.latitude
        event_lon = i.longitude

        # Calculate the distance between the user and the event
        distance = haversine(float(phone_lat),float( phone_lon),float( event_lat), float(event_lon))

        # If the event is within 5km, add it to the list
        if distance <= 5:
            l.append({
                'id': i.id,
                'event_name': i.event_name,
                'date': i.date,
                'duration': i.duration,
                'venue': i.venue,
                'College_name': i.College_name,
                'poster': i.poster,
                'point': i.ACTIVITY.point,
                'amount':i.amount,
                'latitude': i.latitude,
                'longitude': i.longitude,
                'distance': distance  # Optional: include distance in the response
            })

    return JsonResponse({"status": "ok", 'data': l})

def std_bookevents(request):
    lid=request.POST['lid']
    eventdetails=request.POST['eid']
    if Booking.objects.filter(EVENT_DETAILS_id=eventdetails, STUDENT__LOGIN=lid).exists():
        return JsonResponse({"status": "no"})

    a=Booking()
    a.date=datetime.now()
    a.status='pending'
    a.STUDENT=Student.objects.get(LOGIN_id=lid)
    a.EVENT_DETAILS_id=eventdetails
    a.save()
    return JsonResponse({"status":"ok"})

def std_view_bookingstatus(request):
    lid=request.POST['lid']
    data = Booking.objects.filter(STUDENT__LOGIN_id=lid)
    l = []
    for i in data:
        l.append({
            'id': i.id,
            'eid': i.EVENT_DETAILS.id,
            'date': i.date,
            'statuss': i.status,
            'student': i.STUDENT.name,
            'amount':i.EVENT_DETAILS.amount,
            'eventdetails':i.EVENT_DETAILS.event_name,
        })
    return JsonResponse({"status": "ok", 'data': l})


# def std_make_payment(request):
#     lid=request.POST['lid']
#     bid=request.POST['bid']
#     date=datetime.now().today()
#     status='paid'
#     p=Payment()
#     p.date=date
#     p.status=status
#     p.STUDENT=Student.objects.get(LOGIN_id=lid)
#     p.BOOKING_id=bid
#     p.save()
#     b=Booking.objects.filter(id=bid).update(status='paid')
#
#     Eid=b.BOOKING.EVENT_DETAILS.id
#
#
#
#
#     t=Ticket()
#     t.date=datetime.now()
#     t.ticket_no=random.randint(0000,9999)
#     t.EVENT_DETAILS_id=Eid
#     t.STUDENT=Student.objects.get(LOGIN_id=lid)
#     t.save()
#
#
#
#
#
#
#
#     return JsonResponse({"status":"ok"})



def std_make_payment(request):
    try:
        lid = request.POST['lid']
        bid = request.POST['bid']
        date = datetime.now().today()
        status = 'paid'

        print(lid,bid,date,status)
        p = Payment()
        p.date = date
        p.status = status
        p.STUDENT = Student.objects.get(LOGIN_id=lid)
        p.BOOKING_id = bid
        p.save()
        booking = Booking.objects.get(id=bid)
        booking.status = 'paid'
        booking.save()
        Eid = booking.EVENT_DETAILS.id


        # if Ticket.objects.filter(STUENT__LOGIN_id=lid,EVENT_DETAILS_id=bid).exists():
        #     return JsonResponse({'status':'no'})

        if Ticket.objects.filter(EVENT_DETAILS_id=Eid).exists():
            tic=Ticket.objects.filter(EVENT_DETAILS_id=Eid).first()

            print(tic)
            t = Ticket()
            t.date = datetime.now()
            t.ticket_no = int(tic.ticket_no)+1
            t.EVENT_DETAILS_id = Eid
            t.STUDENT = Student.objects.get(LOGIN_id=lid)
            t.save()
            return JsonResponse({"status": "ok"})


        else:
            t = Ticket()
            t.date = datetime.now()
            t.ticket_no = random.randint(1000, 9999)
            t.EVENT_DETAILS_id = Eid
            t.STUDENT = Student.objects.get(LOGIN_id=lid)
            t.save()
            return JsonResponse({"status": "ok"})

    except Booking.DoesNotExist:
        return JsonResponse({"status": "error", "message": "Booking not found"})

    except Student.DoesNotExist:
        return JsonResponse({"status": "error", "message": "Student not found"})

    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})






def std_view_tickets(request):
    bid=request.POST['bid']
    # eid=request.POST['eid']
    data = Ticket.objects.filter(EVENT_DETAILS_id=bid)
    l = []
    for i in data:
        l.append({
            'id': i.id,
            'date': i.date,
            'ticket_no': i.ticket_no,
            'eventdetails':i.EVENT_DETAILS.event_name,
            'student':i.STUDENT.name,

        })
    print(l)

    return JsonResponse({"status":"ok",'data':l})

def std_view_activitypoint(request):
    lid=request.POST['lid']
    data = Activity_point.objects.filter(STUDENT__LOGIN_id=lid)
    l = []
    for i in data:
        l.append({
            'id': i.EVENT_DETAILS.id,
            'point': i.EVENT_DETAILS.ACTIVITY.point,
            'eventdetails':i.EVENT_DETAILS.event_name,
            'eventcoordinator':i.EVENT_COORDINATOR.name,
        })
    print(l,'lllllllllll')

    return JsonResponse({"status": "ok", 'data': l})


def std_send_feedback(request):
    feedback=request.POST['feedback']
    lid=request.POST['lid']
    cid=request.POST['cid']
    a=Feedback()
    a.date=datetime.now()
    a.feedback=feedback
    a.EVENT_DETAILS_id=cid
    a.STUDENT=Student.objects.get(LOGIN_id=lid)
    a.save()
    return JsonResponse({"status":"ok"})

def std_send_complaint(request):
    complaint=request.POST['complaint']
    lid=request.POST['lid']
    a=Complaint()
    a.date=datetime.now()
    a.complaint=complaint
    a.STUDENT=Student.objects.get(LOGIN_id=lid)
    a.status='pending'
    a.reply='pending'
    a.save()
    return JsonResponse({"status":"ok"})

def std_view_reply(request):
    lid=request.POST['lid']
    data = Complaint.objects.filter(STUDENT__LOGIN_id=lid)
    l = []
    for i in data:
        l.append({
            'id': i.id,
            'date': i.date,
            'reply': i.reply,
            'status': i.status,
            'complaint':i.complaint
        })
    return JsonResponse({"status": "ok", 'data': l})

def std_location(request):
    latitude=request.POST['latitude']
    longitude=request.POST['longitude']
    lid=request.POST['lid']

    if Location.objects.filter(LOGIN_id=lid).exists():
        Location.objects.filter(LOGIN_id=lid).update(longitude=longitude,latitude=latitude)

    a=Location()
    a.location=longitude
    a.latitude=latitude
    a.LOGIN_id=lid
    a.date=datetime.now()
    a.save()

    return JsonResponse({"status":"ok"})


def get_nearest_events(request):
    from django.db.models import FloatField, F, Value, Q
    from django.db.models.functions import Sqrt, Sin, Cos, Radians, ACos, Cast
    # current_latitude = 11.258753
    # current_longitude = 75.780411

    current_latitude = request.POST['lat']
    current_longitude = request.POST['lon']

    EARTH_RADIUS = 6371

    events = Event_details.objects.annotate(
        # Convert CharField latitude and longitude to FloatField
        latitude=Cast('lat', FloatField()),
        longitude=Cast('long', FloatField())
    ).annotate(
        distance=EARTH_RADIUS * ACos(
            Cos(Radians(Value(current_latitude))) * Cos(Radians(F('lati'))) *
            Cos(Radians(F('lon')) - Radians(Value(current_longitude))) +
            Sin(Radians(Value(current_latitude))) * Sin(Radians(F('lati')))
        )
    ).filter(
        distance__lte=10
    ).order_by('distance')

    l = []
    for i in events:


        l.append({
            'id': i.id,
            'event_name': i.event_name,
            'date': i.date,
            'duration': i.duration,
            'venue': i.venue,
            'College_name': i.College_name,
            'poster': i.poster,
            'point': i.point,
            'latitude': i.latitude,
            'longitude': i.longitude,
            'amount': i.amount,
            # 'distance': distance  # Optional: include distance in the response
        })

    return JsonResponse({"status": "ok", 'data': l})
































####################csert



#
# import os
# from datetime import datetime
# from django.http import HttpResponse
# from reportlab.pdfgen import canvas
# from reportlab.lib.pagesizes import letter
#
# def generate_certificate(request):
#     eid=request.POST['eid']
#     # Fetch student details from the database
#     p = Activity_point.objects.get(EVENT_DETAILS_id=eid)
#
#     student_name = p.STUDENT.name
#     student_course = p.STUDENT.course
#     student_dept = p.STUDENT.department
#     student_sem = p.STUDENT.semester
#     event_name = p.EVENT_DETAILS.event_name
#     duration = p.EVENT_DETAILS.duration
#     College_name = p.EVENT_DETAILS.College_name
#     score = p.point
#
#     # Define the filename and path
#     media_path = "C:\\Users\\user\\PycharmProjects\\unified_student\\media\\"
#     filename = os.path.join(media_path, f"certificate_{datetime.now().strftime('%Y%m%d_%H%M%S')}.pdf")
#
#     # Create PDF
#     c = canvas.Canvas(filename, pagesize=letter)
#
#     # Set background image
#     background_image = "C:\\Users\\user\\PycharmProjects\\unified_student\\media\\cert2.jpg"
#     c.drawImage(background_image, 0, 0, width=letter[0], height=letter[1])
#
#     # Add text content
#     c.setFont("Helvetica-Bold", 30)
#     c.drawCentredString(400, 700, f"Certificate of Participation For {event_name}")
#
#
#     c.setFont("Helvetica-Bold", 25)
#     c.drawCentredString(300, 650, "Event Duration {duration}","College name is {College_name}")
#
#
#     c.setFont("Helvetica", 16)
#     c.drawCentredString(300, 600, f"This is to certify that Participant Name {student_name},{student_course}, {student_dept}, {student_sem}")
#
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(300, 540, f"and activity point {score}.")
#
#     c.setFont("Helvetica", 12)
#     c.drawCentredString(300, 100, "Congratulations!")
#
#     # Save the certificate
#     c.save()
#     print(f"Certificate generated: {filename}")
#
#     # Serve the PDF
#     if os.path.exists(filename):
#         with open(filename, 'rb') as fh:
#             response = HttpResponse(fh.read(), content_type="application/pdf")
#             response['Content-Disposition'] = f'inline; filename={os.path.basename(filename)}'
#             return response
#
#     return JsonResponse({'status':'ok'})
#
#

















#
# import os
# from datetime import datetime
# from django.http import HttpResponse, JsonResponse
# from reportlab.pdfgen import canvas
# from reportlab.lib.pagesizes import letter
#
# def generate_certificate(request):
#     eid = request.POST.get('eid')
#
#     # Fetch student details from the database
#     try:
#         p = Activity_point.objects.get(EVENT_DETAILS_id=eid)
#     except Activity_point.DoesNotExist:
#         return JsonResponse({'status': 'error', 'message': 'Event not found'})
#
#     student_name = p.STUDENT.name
#     student_course = p.STUDENT.course
#     student_dept = p.STUDENT.department
#     student_sem = p.STUDENT.semester
#     event_name = p.EVENT_DETAILS.event_name
#     duration = p.EVENT_DETAILS.duration
#     college_name = p.EVENT_DETAILS.College_name
#     score = p.point
#
#     # Define the filename and path
#     media_path = "C:\\Users\\user\\PycharmProjects\\unified_student\\media\\"
#     filename = os.path.join(media_path, f"certificate_{datetime.now().strftime('%Y%m%d_%H%M%S')}.pdf")
#
#     # Create PDF
#     c = canvas.Canvas(filename, pagesize=letter)
#
#     # Set background image
#     background_image = "C:\\Users\\user\\PycharmProjects\\unified_student\\media\\cert2.jpg"
#     c.drawImage(background_image, 0, 0, width=letter[0], height=letter[1])
#
#     # Add text content
#     c.setFont("Helvetica-Bold", 30)
#     c.drawCentredString(300, 560, "Certificate of Participation")
#
#     c.setFont("Helvetica-Bold", 25)
#     c.drawCentredString(300, 520, f"For {event_name}")
#
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(300, 330, f"Event Duration: {duration}")
#
#     c.setFont("Helvetica", 15)
#     c.drawCentredString(300, 310, f"College: {college_name}")
#
#     c.setFont("Helvetica", 16)
#     c.drawCentredString(300, 490, "This is to certify that")
#
#     c.setFont("Helvetica-Bold", 18)
#     c.drawCentredString(300, 450, f"{student_name}")
#
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(300, 400, f"Department: {student_dept} | Course: {student_course} | Semester: {student_sem}")
#
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(300, 350, f"Activity Points Earned: {score}")
#
#     c.setFont("Helvetica-Bold", 16)
#     c.drawCentredString(300, 240, "Congratulations!")
#
#     # Add Signature and Seal
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(150, 50, "_____________________")
#     c.drawCentredString(150, 30, "Authorized Signature")
#
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(450, 50, "_____________________")
#     c.drawCentredString(450, 30, "Official Seal")
#
#     # Save the certificate
#     c.save()
#     print(f"Certificate generated: {filename}")
#
#     # Serve the PDF
#     if os.path.exists(filename):
#         with open(filename, 'rb') as fh:
#             response = HttpResponse(fh.read(), content_type="application/pdf")
#             response['Content-Disposition'] = f'inline; filename={os.path.basename(filename)}'
#             return response
#
#     return JsonResponse({'status': 'ok'})






# import os
# from datetime import datetime
# from django.http import HttpResponse, JsonResponse
# from reportlab.pdfgen import canvas
# from reportlab.lib.pagesizes import letter
# from django.core.files.storage import default_storage
# from django.core.files.base import ContentFile
# from .models import Certificate, Activity_point
#
# def generate_certificate(request):
#     eid = request.POST['eid']
#     lid = request.POST['lid']
#
#     # Fetch student details from the database
#     try:
#         p = Activity_point.objects.get(EVENT_DETAILS_id=eid)
#     except Activity_point.DoesNotExist:
#         return JsonResponse({'status': 'error', 'message': 'Event not found'})
#
#     student = p.STUDENT
#     event = p.EVENT_DETAILS
#
#     student_name = student.name
#     student_course = student.course
#     student_dept = student.department
#     student_sem = student.semester
#     event_name = event.event_name
#     duration = event.duration
#     college_name = event.College_name
#     score = p.point
#
#     # Define the filename and path
#     filename = f"certificate_{datetime.now().strftime('%Y%m%d_%H%M%S')}.pdf"
#     file_path = os.path.join("media/", filename)
#
#     # Create PDF
#     c = canvas.Canvas(file_path, pagesize=letter)
#     background_image = "C:\\Users\\user\\PycharmProjects\\unified_student\\media\\cert2.jpg"
#     c.drawImage(background_image, 0, 0, width=letter[0], height=letter[1])
#
#     # Add text content
#     c.setFont("Helvetica-Bold", 30)
#     c.drawCentredString(300, 560, "Certificate of Participation")
#     c.setFont("Helvetica-Bold", 25)
#     c.drawCentredString(300, 520, f"For {event_name}")
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(300, 330, f"Event Duration: {duration}")
#     c.setFont("Helvetica", 15)
#     c.drawCentredString(300, 310, f"College: {college_name}")
#     c.setFont("Helvetica", 16)
#     c.drawCentredString(300, 490, "This is to certify that")
#     c.setFont("Helvetica-Bold", 18)
#     c.drawCentredString(300, 450, f"{student_name}")
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(300, 400, f"Department: {student_dept} | Course: {student_course} | Semester: {student_sem}")
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(300, 350, f"Activity Points Earned: {score}")
#     c.setFont("Helvetica-Bold", 16)
#     c.drawCentredString(300, 240, "Congratulations!")
#
#     # Add Signature and Seal
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(150, 50, "_____________________")
#     c.drawCentredString(150, 30, "Authorized Signature")
#     c.drawCentredString(450, 50, "_____________________")
#     c.drawCentredString(450, 30, "Official Seal")
#
#     # Save the PDF
#     c.save()
#
#     # Save to Certificate table
#     certificate_entry = Certificate.objects.create(
#         date=datetime.now().date(),
#         certificate="/"+file_path,
#         STUDENT=Student.objects.get(LOGIN=lid),
#         EVENT_DETAILS=event
#     )
#
#     # Serve the PDF for download
#     if os.path.exists(file_path):
#         with open(file_path, 'rb') as fh:
#             response = HttpResponse(fh.read(), content_type="application/pdf")
#             response['Content-Disposition'] = f'inline; filename={filename}'
#             return response
#
#     return JsonResponse({'status': 'ok',"certi":"/"+file_path})




import os
from io import BytesIO
from datetime import datetime
from django.http import HttpResponse, JsonResponse
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from django.core.files.base import ContentFile
from django.core.files.storage import default_storage
from .models import Certificate, Activity_point, Student

# def generate_certificate(request):
#     eid = request.POST.get('eid')
#     lid = request.POST.get('lid')
#     print(eid)
#
#     # Fetch student and event details
#     try:
#         p = Activity_point.objects.filter(EVENT_DETAILS_id=eid,STUDENT__LOGIN=lid)
#         # p = Activity_point.objects.get(EVENT_DETAILS_id=eid,STUDENT__LOGIN=lid)
#     except Activity_point.DoesNotExist:
#         print("kkk")
#         return JsonResponse({'status': 'error', 'message': 'Event not found'})
#
#     student = p.STUDENT
#     event = p.EVENT_DETAILS
#
#     student_name = student.name
#     student_course = student.course
#     student_dept = student.department
#     student_sem = student.semester
#     event_name = event.event_name
#     duration = event.duration
#     college_name = event.College_name
#     score = event.ACTIVITY.point
#
#     var = datetime.now().strftime("%Y%m%dH%M%S") + ".pdf"
#     filename = "C:\\Users\\user\\PycharmProjects\\unified_student\\media\\" + var
#
#     print(filename)
#     path = '/media/' + var
#
#
#     # Generate the PDF in memory
#     buffer = BytesIO()
#     c = canvas.Canvas(filename, pagesize=letter)
#
#     # Add background image
#     background_image = "C:\\Users\\user\\PycharmProjects\\unified_student\\media\\cert2.jpg"
#     if os.path.exists(background_image):
#         c.drawImage(background_image, 0, 0, width=letter[0], height=letter[1])
#
#     # Add certificate text
#     c.setFont("Helvetica-Bold", 30)
#     c.drawCentredString(300, 560, "Certificate of Participation")
#     c.setFont("Helvetica-Bold", 25)
#     c.drawCentredString(300, 520, f"For {event_name}")
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(300, 330, f"Event Duration: {duration}")
#     c.setFont("Helvetica", 15)
#     c.drawCentredString(300, 310, f"College: {college_name}")
#     c.setFont("Helvetica", 16)
#     c.drawCentredString(300, 490, "This is to certify that")
#     c.setFont("Helvetica-Bold", 18)
#     c.drawCentredString(300, 450, f"{student_name}")
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(300, 400, f"Department: {student_dept} | Course: {student_course} | Semester: {student_sem}")
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(300, 350, f"Activity Points Earned: {score}")
#     c.setFont("Helvetica-Bold", 16)
#     c.drawCentredString(300, 240, "Congratulations!")
#
#     # Signature and Seal
#     c.setFont("Helvetica", 14)
#     c.drawCentredString(150, 50, "_____________________")
#     c.drawCentredString(150, 30, "Authorized Signature")
#     c.drawCentredString(450, 50, "_____________________")
#     c.drawCentredString(450, 30, "Official Seal")
#
#     # Save the PDF
#     c.save()
#     pdf_data = buffer.getvalue()
#     buffer.close()
#
#
#
#
#
#
#
#     # Save certificate record in DB
#     certificate_entry = Certificate.objects.create(
#         date=datetime.now().date(),
#         certificate=path,
#         STUDENT=Student.objects.get(LOGIN=lid),
#         EVENT_DETAILS=event
#     )
#
#     return JsonResponse({'status': "ok",'certi':path})
from django.http import JsonResponse
from datetime import datetime
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from io import BytesIO
import os

from .models import Activity_point, Student, Certificate

def generate_certificate(request):
    try:
        eid = request.POST.get('eid')
        lid = request.POST.get('lid')

        print("eid:", eid)
        print("lid:", lid)

        # Fetch the first matching Activity_point (safe if multiple exist)
        p = Activity_point.objects.filter(EVENT_DETAILS_id=eid, STUDENT__LOGIN=lid).first()
        if not p:
            return JsonResponse({'status': 'error', 'message': 'No matching activity point found'})

        student = p.STUDENT
        event = p.EVENT_DETAILS

        if not event.ACTIVITY:
            return JsonResponse({'status': 'error', 'message': 'No activity linked to event'})

        student_name = student.name
        student_course = student.course
        student_dept = student.department
        student_sem = student.semester
        event_name = event.event_name
        duration = event.duration
        college_name = event.College_name
        score = event.ACTIVITY.point

        var = datetime.now().strftime("%Y%m%d%H%M%S") + ".pdf"
        filename = "C:\\Users\\user\\PycharmProjects\\unified_student\\media\\" + var
        path = '/media/' + var

        # Generate the PDF
        buffer = BytesIO()
        c = canvas.Canvas(filename, pagesize=letter)

        # Add background if it exists
        background_image = "C:\\Users\\user\\PycharmProjects\\unified_student\\media\\cert2.jpg"
        if os.path.exists(background_image):
            c.drawImage(background_image, 0, 0, width=letter[0], height=letter[1])

        # Certificate text layout
        c.setFont("Helvetica-Bold", 30)
        c.drawCentredString(300, 560, "Certificate of Participation")
        c.setFont("Helvetica-Bold", 25)
        c.drawCentredString(300, 520, f"For {event_name}")
        c.setFont("Helvetica", 14)
        c.drawCentredString(300, 330, f"Event Duration: {duration}")
        c.setFont("Helvetica", 15)
        c.drawCentredString(300, 310, f"College: {college_name}")
        c.setFont("Helvetica", 16)
        c.drawCentredString(300, 490, "This is to certify that")
        c.setFont("Helvetica-Bold", 18)
        c.drawCentredString(300, 450, f"{student_name}")
        c.setFont("Helvetica", 14)
        c.drawCentredString(300, 400, f"Department: {student_dept} | Course: {student_course} | Semester: {student_sem}")
        c.setFont("Helvetica", 14)
        c.drawCentredString(300, 350, f"Activity Points Earned: {score}")
        c.setFont("Helvetica-Bold", 16)
        c.drawCentredString(300, 240, "Congratulations!")

        # Signature lines
        c.setFont("Helvetica", 14)
        c.drawCentredString(150, 50, "_____________________")
        c.drawCentredString(150, 30, "Authorized Signature")
        c.drawCentredString(450, 50, "_____________________")
        c.drawCentredString(450, 30, "Official Seal")

        # Save PDF to file
        c.save()
        buffer.close()

        # Save certificate record in DB
        Certificate.objects.create(
            date=datetime.now().date(),
            certificate=path,
            STUDENT=student,
            EVENT_DETAILS=event
        )

        return JsonResponse({'status': "ok", 'certi': path})

    except Exception as e:
        print("Exception occurred in generate_certificate:", str(e))
        return JsonResponse({'status': 'error', 'message': str(e)})








from django.http import JsonResponse
from .models import Certificate

def std_view_activitycertificate(request):
    aid = request.POST.get('aid')  # Activity Point ID
    lid = request.POST.get('lid')  # Login ID

    if not aid or not lid:
        return JsonResponse({"status": "error", "message": "Missing required parameters"})

    # Fetch certificates where EVENT_DETAILS matches the same event as the given activity point
    res = Certificate.objects.filter(
        EVENT_DETAILS_id=aid,  # Since EVENT_DETAILS is shared, filter directly
        STUDENT__LOGIN_id=lid
    )

    # Prepare response data
    data = [
        {
            'id': cert.id,
            'date': cert.date.strftime('%Y-%m-%d'),  # Format date properly
            'certificate': cert.certificate,  # Assuming this stores a file path or URL
            'eventname': cert.EVENT_DETAILS.event_name,
        }
        for cert in res
    ]

    return JsonResponse({"status": "ok", "data": data})






def notif(request):
    nid=request.POST['nid']
    d=Event_details.objects.filter(id__gt=nid)
    if d.exists():
        f=d[0]
        return JsonResponse({"status": "ok",'nid':str(f.id),'message':f.event_name})
    else:
        return JsonResponse({"status": "no"})


def viewnotification(request):
    from datetime import datetime
    date=datetime.now().today()
    d=Event_details.objects.filter(date__gte=date)
    l=[]
    for i in d:
        l.append({
            'id':i.id,
            'event':i.event_name,
            'college name':i.College_name,
            'date':i.date,

        })
    print(l)
    return JsonResponse({"status": "ok",'data':l})






def Totalactivity_point(request):
    lid=request.POST['lid']


    return JsonResponse({"status": "ok"})

# def Uploadactivity_point(request):
#     lid=request.POST['lid']
#     s_w_ktu1=request.POST['photo1']
#     s_w_ktu2=request.POST['photo2']
#     s_w_ni1=request.POST['photo3']
#     s_w_ni2=request.POST['photo4']
#     pp_ktu1=request.POST['photo5']
#     pp_ktu2=request.POST['photo6']
#     pp_ni1=request.POST['photo7']
#     pp_ni2=request.POST['photo8']
#     intern=request.POST['photo9']
#     sports1=request.POST['photo10']
#     sports2=request.POST['photo11']
#     sports3=request.POST['photo12']
#     sports4=request.POST['photo13']
#     sports5=request.POST['photo14']
#     sports6=request.POST['photo15']
#     sports7=request.POST['photo16']
#     return JsonResponse({})


def std_viewactivity_point(request):
    data=Activity.objects.all()
    l=[]
    for i in data:
        l.append({
            'id':i.id,
            'category':i.category,
            # 'level':i.level,
            # 'point':i.point,
        })
    print(l)
    return JsonResponse({'status':'ok','data':l})

def std_viewtotal_activity_point(request):
    lid=request.POST['lid']
    l=[]
    data=StdActivitypoint.objects.filter(STUDENT__LOGIN_id=lid)
    tot = 0

    for i in data:
        tot=int(tot)+int(i.marks)
        l.append({
            'id':i.id,
            'date':i.date,
            'file':i.file,
            'category':i.ACTIVITY.category,
            'marks':i.marks,
        })
    return JsonResponse({'status':'ok','data':l,'tot':tot})



def Uploadactivity_point(request):
    lid = request.POST['lid']
    file = request.POST['photo']
    from datetime import datetime
    date = datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
    import base64
    a = base64.b64decode(file)
    fh = open("C:\\Users\\user\\PycharmProjects\\unified_student\\media\\" + date, 'wb')
    fh.write(a)
    fh.close()

    cid = request.POST['cid']
    activity = Activity.objects.get(id=cid)
    cc = activity.category
    student = Student.objects.get(LOGIN_id=lid)

    # Internship: only one upload allowed
    if cc == "Internship":
        if StdActivitypoint.objects.filter(ACTIVITY_id=cid, STUDENT=student).exists():
            return JsonResponse({'status': 'no'})

    # Sports: multiple uploads allowed, total max 60 marks
    elif cc == "Sports":
        total_marks = StdActivitypoint.objects.filter(STUDENT=student, ACTIVITY__category="Sports").aggregate(Sum('marks'))['marks__sum'] or 0
        if total_marks >= 60:
            return JsonResponse({'status': 'max_reached'})

    # Poster Presentation and Seminar/Workshop: max 2 uploads per category
    elif cc in ["Poster presentation(KTU)", "Poster presentation(NIT/IIT)", "Seminar and Workshop(KTU)", "Seminar and Workshop(NIT/IIT)"]:
        count = StdActivitypoint.objects.filter(STUDENT=student, ACTIVITY__category=cc).count()
        if count >= 2:
            return JsonResponse({'status': 'limit_reached'})

    # Proceed to save
    mm = StdActivitypoint()
    mm.date = datetime.now().today()
    mm.file = '/media/' + date
    mm.STUDENT = student
    mm.ACTIVITY = activity

    if cc == "Seminar and Workshop(KTU)":
        mm.marks = 6
    elif cc == "Seminar and Workshop(NIT/IIT)":
        mm.marks = 15
    elif cc == "Poster presentation(KTU)":
        mm.marks = 4
    elif cc == "Poster presentation(NIT/IIT)":
        mm.marks = 10
    elif cc == "Internship":
        mm.marks = 20
    elif cc == "Sports":
        mm.marks = 8

    mm.save()
    return JsonResponse({'status': 'ok'})


# def Uploadactivity_point(request):
#     lid=request.POST['lid']
#     file = request.POST['photo']
#     from datetime import datetime
#     date = datetime.now().strftime("%Y%m%d-%H%M%S") + ".jpg"
#     import base64
#     a = base64.b64decode(file)
#     fh = open("C:\\Users\\user\\PycharmProjects\\unified_student\\media\\" + date,'wb')
#
#     fh.write(a)
#     fh.close()
#
#     cid=request.POST['cid']
#     cc=Activity.objects.get(id=cid).category
#
#     if StdActivitypoint.objects.filter(ACTIVITY_id=cid,STUDENT__LOGIN=lid).exists():
#         return JsonResponse({'status': 'no'})
#     else:
#
#         mm=StdActivitypoint()
#         mm.date=datetime.now().today()
#         mm.file='/media/'+date
#         mm.STUDENT=Student.objects.get(LOGIN_id=lid)
#         mm.ACTIVITY=Activity.objects.get(id=cid)
#         if cc=="Seminar and Workshop(KTU)":
#             mm.marks=6
#         elif cc=="Seminar and Workshop(NIT/IIT)":
#             mm.marks=15
#         elif cc=="Poster presentation(KTU)":
#             mm.marks=4
#         elif cc=="Poster presentation(NIT/IIT)":
#             mm.marks=10
#         elif cc=="Internship":
#             mm.marks=20
#         elif cc=="Sports":
#             mm.marks=8
#         mm.save()
#         return JsonResponse({'status':'ok'})





