var faker = require('faker')
function generateDataQuestion () {
  faker.setLocale('en');
  var dataQuestion = []
  for (var id = 0; id < 5; id++) {
    var title = faker.vehicle.manufacturer()
    var description = faker.commerce.productDescription()
    var startDate = faker.date.past()
    var endDate = faker.date.future()
    var questions = [
      {
        type: "Welcome",
        title: "Please record your video in a quiet location with sufficient lighting, and ensure that your WiFi connection is active. After recording a video, you have the opportunity to review it and record it again if needed.",
      },
      {
        type: "VIDEO",
        title: "This is a Video Question",
      },
      {
        type: "TEXT",
        title: "This is a Text Question",
      },
      {
        type: "NUMERIC",
        title: "This is a Numeric Question",
      },
      {
        type: "SINGLE_CHOICE",
        title: "This is a single Choice question",
        options: ["choice 1", "choice 2", "choice 3", "choice 4"],
      },
      {
        type: "MULTIPLE_CHOICE",
        title: "This is a single Multiple question",
        options: ["option 1", "option 2", "option 3", "option 4"],
      },
      {
        type: "THANKYOU",
        title:
          "All finished? Please check your WiFi signal, and click on Submit Videos.\nWant to change a response? To return to the survey, click on the Back Arrow.\nWant to complete it later? Click on the Cancel. Your answers are saved so you can pick up where you left off.",
      },
      
    ]

    dataQuestion.push({
      "id": id,
      "title": title,
      "description": description,
      "startDate": startDate,
      "endDate": endDate,
      "questions": questions,

    })
  }
  return { "dataQuestion": dataQuestion }
}
module.exports = generateDataQuestion