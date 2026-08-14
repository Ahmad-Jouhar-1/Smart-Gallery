class EndPoints {
  static String baseUrl = "http://192.168.1.2:8000";

  static void setBaseUrl(String newBaseUrl) {
    baseUrl = newBaseUrl;
  }

  static String departmentId(int departmentId) {
    return "/api/department/$departmentId";
  }

  static String canCancel(int appointmentId) {
    return "/api/appointments/$appointmentId/can_cancel";
  }

  static String appointmentId(int appointmentId) {
    return "/api/appointments/$appointmentId";
  }

  static String doctorProfile(int doctorId) {
    return "/api/doctors/$doctorId/profile";
  }

  static String prescriptionId(int appointmentId) {
    return "/api/prescription/$appointmentId";
  }

  static String offerId(int offerId) {
    return "/api/offer/$offerId";
  }

  static String doctorDepartmentId(int departmentId) {
    return "/api/doctors/department/$departmentId";
  }

  static String doctorId(int doctorId) {
    return "/api/days/doctor/$doctorId";
  }

  static String billId(int billId) {
    return "/api/user/bill/$billId";
  }

  static String read(int notificationId) {
    return "/api/notifications/$notificationId/read";
  }

  static String medicalReportId(int appointmentId) {
    return "/api/medical_report/appointment/$appointmentId";
  }

  /////send otp code to email/////
  static String sendEmailVerify() {
    return "/api/send-email";
  }

  /////submit otp code//////
  static String checkOTPcode() {
    return "/api/verify-email";
  }

  /////sign up//////
  static String signup() {
    return "/api/user_register";
  }

  //////login///////
  static String login() {
    return "/api/user_login";
  }

  //////send Email forget password////
  static String sendEmailForgetPassword() {
    return "/api/password/email";
  }

  /////submit otp forget password////
  static String checkOTPForgetPassword() {
    return "/api/password/code/check/email";
  }

  /////reset password///////
  static String resetPassword() {
    return "/api/password/reset/email";
  }

  ///////logout//////////////
  static String logout() {
    return "/api/user_logout";
  }

  ///////edit profile////////
  static String editProfile() {
    return "/api/user/profile";
  }

  //////edit email///////////
  static String editEmail() {
    return "/api/user/email";
  }

  ///////change password/////
  static String changePassword() {
    return "/api/user/password";
  }

  /////change image///////////
  static String changeImage() {
    return "/api/upload_image";
  }

  /////show info profile///////
  static String showInfoProfile() {
    return "/api/user/profile";
  }

  ////show vital signals//////
  static String showVitalSignals() {
    return "/api/vital_signs";
  }

  static String departments = "/api/departments";
  static String defaultDays = "/api/default_days";
  static String defaultTimes = "/api/default_times";
  static String appointments = "/api/appointments";
  static String patientAppointments = "/api/patient/appointments";
  static String availableSlotsByShift = "/api/availableSlotsByShift";
  static String top5 = "/api/top5";
  static String rate = "/api/doctors/rate";
  static String points = "/api/points";
  static String offers = "/api/offers";
  static String offerPrice = "/api/offer_price";
  static String notifications = "/api/notifications";
  static String bills = "/api/user/bills";
  static String refreshToken = "/api/refresh_token";
}

class ApiKey {
  static String accept = "Accept";
  static String authorization = "Authorization";
  static String acceptLanguage = "Accept-Language";
  static String errorMessage = "message";
  static String startId = "start_id";
  static String endId = "end_id";
  static String canCancel = "can_cancel";
  static String departmentId = "department_id";
  static String doctorId = "doctor_id";
  static String slotId = "slot_id";
  static String date = "date";
  static String requestTypeId = "request_type_id";
  static String withMedicalReport = "with_medical_report";
  static String pending = "pending";
  static String completed = "completed";
  static String data = "data";
  static String shift = "shift";
  static String slots = "slots";
  static String day = "day";
  static String timeId = "time_id";
  static String id = "id";
  static String status = "status";
  static String doctorName = "doctor_name";
  static String doctorImage = "doctor_image";
  static String department = "department";
  static String dateTime = "date_time";
  static String isAvailable = "isAvailable";
  static String name = "name";
  static String time = "time";
  static String treatments = "treatments";
  static String rate = "rate";
  static String specialty = "specialty";
  static String image = "image";
  static String speciality = "speciality";
  static String startTime = "start_time";
  static String endTime = "end_time";
  static String experience = "experience";
  static String bio = "bio";
  static String qualifications = "qualifications";
  static String medications = "medications";
  static String type = "type";
  static String dosage = "dosage";
  static String frequesncy = "frequency";
  static String duration = "duration";
  static String note = "note";
  static String labTests = "lab_tests";
  static String surgeries = "surgeries";
  static String advices = "advices";
  static String advice = "advice";
  static String isPrescriptionViewed = "is_prescription_viewed";
  static String appointmentId = "appointment_id";
  static String rating = "rating";
  static String points = "points";
  static String paymentMethod = "payment_method";
  static String offerId = "offer_id";
  static String reservation = "reservation";
  static String selectedService = "selected_service";
  static String price = "price";
  static String currency = "currency";
  static String morningDoctorsCount = "morning_Doctors_Count";
  static String afternoonDoctorsCount = "morning_Doctors_Count";
  static String afternoon = "afternoon";
  static String morning = "morning";
  static String unreadNotifications = "Unread Notifications";
  static String readNotifications = "Read Notifications";
  static String paid = "paid";
  static String unpaid = "unpaid";
  static String fcmToken = "fcm_token";
  static String keyword = "keyword";
  static String medicalReportUrl = "medical report url";
}
