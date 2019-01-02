var appName = "Sahi Pet";
var baseURL = "http://{your-ip}";
// Authentication
var urlRegister = "$baseURL/customer/register";
var urlLogin = "$baseURL/customer/login";
var urlCheckSession = "$baseURL/customer/check-session";
// Courier
var urlCourier = "$baseURL/courier";
var pathCourierRegister = "/register";
var pathCourierPetshop = "/petshop";
List<String> listEnabled = ["True", "False"];


// Product
var urlGrooming = "$baseURL/grooming";
var urlClinic = "$baseURL/clinic";
var urlHotel = "$baseURL/hotel";

// Order
var urlOrder = "$baseURL/transaction";