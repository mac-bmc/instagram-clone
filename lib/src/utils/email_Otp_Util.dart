Map<String,dynamic> getNetworkBody(String sendToMail,String otp)
{
  return {
    "ishtml": false,
    "sendto": sendToMail,
    "name": "Insta_clone",
    "replyTo": "",
    "title": "Email otp verificatin",
    "body": "Please enter OTP: ${otp}"
  };
}