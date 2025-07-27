Config = {}

Config.Locations = {
    {
        coords = vector3(215.76, -810.12, 30.73),
        label = "Downtown Rental",
        targetIcon = "fa-solid fa-car",
        targetLabel = "Open Rental Menu",
        ped = {
            model = "a_m_y_business_01", -- Ped model
            heading = 157.0
        }
    },
    {
        coords = vector3(-1034.6, -2733.6, 20.17),
        label = "Airport Rental",
        targetIcon = "fa-solid fa-car",
        targetLabel = "Open Rental Menu",
        ped = {
            model = "a_m_m_business_01",
            heading = 60.0
        }
    },
    -- Add more locations as needed
}

Config.Vehicles = {
    {
        model = "sultan",
        name = "Sultan",
        price = 500,
        description = "A reliable 4-door sedan.",
        image = "images/sultan.png"
    },
    {
        model = "banshee",
        name = "Banshee",
        price = 1200,
        description = "A fast sports car.",
        image = "images/banshee.png"
    },
    -- Add more vehicles as needed
}

Config.MinRentalHours = 1
Config.MaxRentalHours = 6

Config.PaymentTypes = { "cash", "bank" }

Config.RentalPaperItem = "rental_paper"