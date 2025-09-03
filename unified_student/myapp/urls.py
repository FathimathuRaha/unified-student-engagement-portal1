from django.urls import path
from myapp import views

urlpatterns = [
    path('login_get/',views.login_get),
    path('login_post/',views.login_post),

    # ---------------------Admin--------------

    path('admin_home/',views.admin_home),

    path('changepassword_get/',views.changepassword_get),
    path('changepassword_post/',views.changepassword_post),

    path('add_activity_get/',views.add_activity_get),
    path('add_activity_post/',views.add_activity_post),

    path('view_activity_get/',views.view_activity_get),
    path('view_activity_post/',views.view_activity_post),



    path('delete_activity/<id>',views.delete_activity),

    path('add_ticket_get/',views.add_ticket_get),
    path('add_ticket_post/',views.add_ticket_post),

    path('view_ticket_get/',views.view_ticket_get),
    path('view_ticket_post/',views.view_ticket_post),

    path('edit_ticket_get/<id>',views.edit_ticket_get),
    path('edit_ticket_post/',views.edit_ticket_post),

    path('delete_ticket/<id>', views.delete_ticket),

    path('add_eventdetails_report_get/', views.add_eventdetails_report_get),
    path('add_eventdetails_report_post/', views.add_eventdetails_report_post),

    path('view_eventdetails_report_get/', views.view_eventdetails_report_get),
    path('view_eventdetails_report_post/', views.view_eventdetails_report_post),

    path('edit_eventdetails_report_get/', views.edit_eventdetails_report_get),
    path('edit_eventdetails_report_post/', views.edit_eventdetails_report_post),

    path('delete_eventdetails_report/<id>', views.delete_eventdetails_report),

    path('view_coordinator_get/', views.view_coordinator_get),
    path('view_coordinator_post/', views.view_coordinator_post),

    path('approve_coordinator/<id>',views.approve_coordinator),
    path('reject_coordinator/<id>',views.reject_coordinator),


    path('view_approvedcoordinator_get/', views.view_approvedcoordinator_get),
    path('view_approvedcoordinator_post/', views.view_approvedcoordinator_post),

    path('view_rejectedcoordinator_get/', views.view_rejectedcoordinator_get),
    path('view_rejectedcoordinator_post/', views.view_rejectedcoordinator_post),

    path('view_complaint_get/', views.view_complaint_get),
    path('view_complaint_post/', views.view_complaint_post),

    path('view_sendreply_get/<id>', views.view_sendreply_get),
    path('view_sendreply_post/', views.view_sendreply_post),

    path('view_events_get/', views.view_events_get),
    path('view_events_post/', views.view_events_post),


    path('view_feedback_get/', views.view_feedback_get),
    path('view_feedback_post/', views.view_feedback_post),

    path('view_notification_get/', views.view_notification_get),
    path('view_notification_post/', views.view_notification_post),

    path('view_issuedcertificate_get/', views.view_issuedcertificate_get),
    path('view_issuedcertificate_post/', views.view_issuedcertificate_post),

    path('view_payment_get/', views.view_payment_get),
    path('view_payment_post/', views.view_payment_post),

    path('view_student_get/', views.view_student_get),
    path('view_student_post/', views.view_student_post),

    # -------------------event coordiator---------------------


    path('coordinator_home/', views.coordinator_home),

    path('event_change_password_get/', views.event_change_password_get),
    path('event_change_password_post/', views.event_change_password_post),

    path('co_view_student_get/<id>', views.co_view_student_get),
    path('co_view_student_post/', views.co_view_student_post),



    path('event_add_event_get/', views.event_add_event_get),
    path('event_add_event_post/', views.event_add_event_post),

    path('event_edit_event_get/<id>', views.event_edit_event_get),
    path('event_edit_event_post/', views.event_edit_event_post),

    path('event_view_event_get/', views.event_view_event_get),
    path('event_view_event_post/', views.event_view_event_post),

    path('delete_event/<id>', views.delete_event),

    path('markattend/', views.markattend),

    path('event_register_get/', views.event_register_get),
    path('event_register_post/', views.event_register_post),

    path('event_view_profile_get/', views.event_view_profile_get),
    path('event_view_profile_post/', views.event_view_profile_post),

    path('event_update_profile_get/', views.event_update_profile_get),
    path('event_update_profile_post/', views.event_update_profile_post),

    path('delete_profile/<id>', views.delete_profile),

    path('event_view_booking_get/', views.event_view_booking_get),
    path('event_view_booking_post/', views.event_view_booking_post),

    path('approvebooking/<id>', views.approvebooking),
    path('rejectbooking/<id>', views.rejectbooking),

    path('event_accepted_booking_get/', views.event_accepted_booking_get),
    path('event_accepted_booking_post/', views.event_accepted_booking_post),

    path('event_rejected_booking_get/', views.event_rejected_booking_get),
    path('event_rejected_booking_post/', views.event_rejected_booking_post),

    path('event_view_payment_get/', views.event_view_payment_get),
    path('event_view_payment_post/', views.event_view_payment_post),

    path('event_generate_certificate_get/', views.event_generate_certificate_get),
    path('event_generate_certificate_post/', views.event_generate_certificate_post),

    path('event_view_feedback_get/', views.event_view_feedback_get),
    path('event_view_feedback_post/', views.event_view_feedback_post),

    path('add_activitypoint_get/', views.add_activitypoint_get),
    path('add_activitypoint_post/', views.add_activitypoint_post),

    path('view_activitypoint_get/', views.view_activitypoint_get),
    path('view_activitypoint_post/', views.view_activitypoint_post),

    path('delete_activitypoint/<id>', views.delete_activitypoint),

    path('Logout/', views.Logout),

# --------------------FLUTTER--------------------------

   path('std_register/',views.std_register),

   path('std_login/',views.std_login),

   path('std_changepassword/',views.std_changepassword),

   path('std_viewprofile/',views.std_viewprofile),

   path('std_editprofile/',views.std_editprofile),

   path('std_view_eventdetails/',views.std_view_eventdetails),

   path('view_event_details/',views.view_event_details),

   # path('std_view_event_nearest_events/',views.std_view_event_nearest_events),

   path('std_bookevents/',views.std_bookevents),

   path('std_view_bookingstatus/',views.std_view_bookingstatus),

   path('std_make_payment/',views.std_make_payment),

   path('std_view_tickets/',views.std_view_tickets),

   path('std_view_activitypoint/',views.std_view_activitypoint),

   path('std_send_feedback/',views.std_send_feedback),

   path('std_send_complaint/',views.std_send_complaint),

   path('std_view_reply/',views.std_view_reply),

   path('generate_certificate/',views.generate_certificate),

   path('std_view_activitycertificate/',views.std_view_activitycertificate),

   path('get_nearest_events/',views.get_nearest_events),

   path('std_location/',views.std_location),

   path('view_event_nearest_events/',views.view_event_nearest_events),


   path('viewnotification/',views.viewnotification),

   path('Totalactivity_point/',views.Totalactivity_point),
   path('std_viewactivity_point/',views.std_viewactivity_point),
   path('std_viewtotal_activity_point/',views.std_viewtotal_activity_point),
   path('Uploadactivity_point/',views.Uploadactivity_point),

   path('notif/',views.notif),




]
