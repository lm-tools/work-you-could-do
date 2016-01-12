class StartController < ApplicationController
  def select_soc_codes
    @keywords = [
      {
        "title": "Cook",
        "results": [
          {
            "title": "Cooks",
            "description": "Cooks prepare, season and cook food, often using pre-prepared 
            ingredients, in clubs, private households, fast food outlets, shops selling food 
            cooked on the premises and the catering departments and canteens of other establishments."
          },
          {
            "title": "Housekeepers and related occupations",
            "description": "Housekeepers and related workers perform domestic cleaning and other 
            housekeeping tasks within private households, hotels, schools, hostels 
            and other non-private households."
          },
        ]
      },
      {
        "title": "Drive",
        "results": [
          {
            "title": "Driving instructors",
            "description": "Driving instructors co-ordinate and undertake the instruction of 
            people learning to drive cars, motorcycles, buses and haulage vehicles."
          },
          {
            "title": "Taxi and cab drivers and chauffeurs",
            "description": "Taxi and cab drivers and chauffeurs drive motor cars for private individuals, 
            government departments and industrial and commercial organisations, 
            drive taxis for public hire, drive new cars to delivery points and drive motorcycles and other motor vehicles."
          }
        ]
      }
    ]
  end
end
