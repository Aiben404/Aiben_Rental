# 🚗 Vehicle Rental System

A modern FiveM resource that provides a sleek and user-friendly vehicle rental system using [ox_lib](https://github.com/overextended/ox_lib) and [ox_target](https://github.com/overextended/ox_target).

## ✨ Features

- 🎯 **Multiple Interaction Methods** - Support for both ox_target and TextUI
- 🚙 **Flexible Vehicle System** - Easily add/remove vehicles with custom pricing
- 📍 **Multiple Locations** - Configure multiple rental locations across the map
- 🖼️ **Vehicle Images** - Visual vehicle selection with custom images
- 💳 **Payment Options** - Support for both cash and bank payments
- 📄 **Rental Documentation** - Receipt system with metadata (vehicle, plate, renter, expiration)
- ⏰ **Time-based Rentals** - Configurable minimum and maximum rental durations
- 🔄 **Vehicle Recovery** - Built-in command to recover lost rental vehicles
- 🌍 **Multi-language Support** - Easy localization system
- 🔒 **Server-side Security** - All critical operations handled server-side

## 📋 Requirements

- **FiveM Server** (Latest recommended)
- **ESX Framework** (Default, can be adapted for other frameworks)
- **[ox_lib](https://github.com/overextended/ox_lib)** - Required for UI components
- **[ox_target](https://github.com/overextended/ox_target)** - Required for interaction system

## 🚀 Installation

1. **Download the resource:**
   ```bash
   # Clone the repository
   git clone https://github.com/Aiben404/Aiben_Rental.git
   
   # Or download and extract the ZIP file
   ```

2. **Ensure dependencies are installed:**
   - Make sure `ox_lib` and `ox_target` are installed and started
   - Verify ESX framework is properly configured

3. **Add to server.cfg:**
   ```cfg
   ensure ox_lib
   ensure ox_target
   ensure rental
   ```

4. **Restart your server**

## ⚙️ Configuration

### Basic Configuration (`config.lua`)

#### Rental Locations
```lua
Config.Locations = {
    {
        coords = vector3(215.76, -810.12, 30.73),
        label = "Downtown Rental",
        targetIcon = "fa-solid fa-car",
        targetLabel = "Open Rental Menu",
        ped = {
            model = "a_m_y_business_01",
            heading = 157.0
        }
    }
}
```

#### Available Vehicles
```lua
Config.Vehicles = {
    {
        model = "sultan",
        name = "Sultan",
        price = 500,
        description = "A reliable 4-door sedan.",
        image = "images/sultan.png"
    }
}
```

#### Rental Settings
```lua
Config.MinRentalHours = 1
Config.MaxRentalHours = 6
Config.PaymentTypes = { "cash", "bank" }
Config.RentalPaperItem = "rental_paper"
```

### Localization (`locales/en.lua`)

Customize all text messages:
```lua
Locales = {
    ['open_menu'] = "Press ~INPUT_CONTEXT~ to rent a vehicle.",
    ['not_enough_money'] = "You don't have enough money.",
    ['rental_success'] = "You have rented a vehicle for %s hours.",
    -- Add more translations as needed
}
```

## 🎮 Usage

### For Players

1. **Visit a rental location** marked on the map
2. **Interact with the rental agent** using ox_target or TextUI
3. **Select your desired vehicle** from the available options
4. **Choose rental duration** (1-6 hours by default)
5. **Select payment method** (cash or bank)
6. **Receive rental documentation** with all details
7. **Use `/recovervehicle`** if you lose your rental

### For Server Administrators

#### Adding New Vehicles
1. Add vehicle images to the `images/` folder
2. Update `Config.Vehicles` in `config.lua`:
   ```lua
   {
       model = "adder",
       name = "Adder",
       price = 2000,
       description = "A high-performance supercar.",
       image = "images/adder.png"
   }
   ```

#### Adding New Locations
1. Update `Config.Locations` in `config.lua`:
   ```lua
   {
       coords = vector3(x, y, z),
       label = "Location Name",
       targetIcon = "fa-solid fa-car",
       targetLabel = "Open Rental Menu",
       ped = {
           model = "ped_model",
           heading = 0.0
       }
   }
   ```

## 📜 Commands

| Command | Description | Usage |
|---------|-------------|-------|
| `/recovervehicle` | Recover your currently rented vehicle | `/recovervehicle` |

## 🔧 Customization

### Adding Vehicle Images
1. Place vehicle images in the `images/` folder
2. Use PNG format for best compatibility
3. Reference the image in your vehicle configuration

### Modifying Rental Times
Edit these values in `config.lua`:
```lua
Config.MinRentalHours = 1  -- Minimum rental time
Config.MaxRentalHours = 6   -- Maximum rental time
```

### Changing Payment Methods
Modify the payment types in `config.lua`:
```lua
Config.PaymentTypes = { "cash", "bank", "crypto" }  -- Add your payment methods
```

## 🛠️ Troubleshooting

### Common Issues

**Q: Menu doesn't open when interacting**
- A: Ensure ox_lib and ox_target are properly installed and started
- A: Check that the resource is started in your server.cfg

**Q: Vehicles don't spawn**
- A: Verify vehicle models exist in your server
- A: Check coordinates for spawn points

**Q: Payment doesn't work**
- A: Ensure ESX is properly configured
- A: Check that the payment methods are supported by your ESX version

**Q: Images don't display**
- A: Verify images are in the `images/` folder
- A: Check file paths in vehicle configuration

## 📁 File Structure

```
rental/
├── client.lua          # Client-side logic
├── server.lua          # Server-side logic
├── config.lua          # Configuration file
├── fxmanifest.lua      # Resource manifest
├── README.md           # This file
├── images/             # Vehicle images
│   ├── sultan.png
│   └── banshee.png
└── locales/            # Localization files
    └── en.lua
```

## 🤝 Support

- **Discord:** `_aiben404`
- **GitHub Issues:** [Create an issue](https://github.com/Aiben404/Aiben_Rental/issues)
- **Documentation:** Check this README for configuration help

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Credits

- **[ox_lib](https://github.com/overextended/ox_lib)** by overextended
- **[ox_target](https://github.com/overextended/ox_target)** by overextended
- **ESX Framework** by ESX-Devs

---

**Made with ❤️ by Aiben**