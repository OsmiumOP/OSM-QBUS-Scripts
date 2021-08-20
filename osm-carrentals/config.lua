-- ENTIRE SCRIPT MADE BY OSMIUM#0001 | DISCORD.IO/OSMFX 
-- This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA. 

CRConfig = {}

CRConfig.RefreshCars = 5 -- MINUTES AFTER WHICH EMPTY CAR SLOTS GET REFILLED

CRConfig.DriveTime = 30 -- MINUTES AFTER PERSON WILL BE CHARGED AGAIN 

CRConfig.NonPayment = 3 -- IN CASE OF NON-PAYMENT(LOW CASH/BANK) CAR WILL BE DELETED IN THESE MINUTES!

-- RENTING CAR POSITIONS

CRConfig.RentingPositions = {
    -- PILLBOX

    [1] = {
        coords = {
            x = 278.58197021484, y = -592.37957763672, z = 42.261516571045, h = 67.754776000977 
        },
        vehicle = "neon",
        buying = false,
        rentcost = 6000,
    }, 
    [2] = {
        coords = {
            x = 281.46957397461, y = -585.10882568359, z = 42.294975280762, h = 68.783508300781 
        },
        vehicle = "neon",
        buying = false,
        rentcost = 3000,
    },
    [3] = {
        coords = {
            x = 284.20724487305, y = -578.91467285156, z = 42.218921661377, h = 67.055213928223 
        },
        vehicle = "neon",
        buying = false,
        rentcost = 8000,
    }, 
    [4] = {
        coords = {
            x = 282.85913085938, y = -581.95855712891, z = 42.26879119873, h = 68.766624450684
        },
        vehicle = "neon",
        buying = false,
        rentcost = 8000,
    },  
    [5] = {
        coords = {
            x = 280.3024597168, y = -588.45440673828, z = 42.297096252441, h = 68.79224395752
        },
        vehicle = "neon",
        buying = false,
        rentcost = 7000,
    },  
    
    -- GARAGE NEAR MOTELS

    [6] = {
        coords = {
            x = 301.01171875, y = -330.37561035156, z = 43.919872283936, h = 74.321479797363
        },
        vehicle = "autarch",
        buying = false,
        rentcost = 5000,
    },  
}

-- LARGE BLUE TEXT SPOTS and RENTAL LOCATIONS

CRConfig.RentalSpots = {
    [1] = {
        coords = {
            x = 280.91973876953, y = -586.38342285156, z = 43.303909301758, h = 75.361427307129 
        },
    }, 
    [2] = {
        coords = {
            x = 301.01171875, y = -330.37561035156, z = 44.919872283936, h = 74.321479797363
        },
    }, 
}

-- CHARGES CUSTOMER EXTRA IF CAR BODY IS DAMAGED

CRConfig.DamageCharges = {
    enable = true, -- ENABLE / DISABLE FEATURE
    charges = 800, -- FOR DAMAGED BODY
    appreciation = 500, -- REWARD FOR GOOD CAR CONDITION
}

-- TEXT COLOURS

CRConfig.PrimaryColor = {r = 51, g = 136, b = 255, a = 255} -- Use RGB color picker
CRConfig.SecondaryColor = {r = 33, g = 244, b = 218, a = 255} -- Use RGB color picker	

CRConfig.Release = '1.0.0'
