# QB VEHICLESHOP with Custom Finance Options and a Clean Interface 
**Important Note : No support will be provided on this resource if you use some CUSTOM FW or Renamed QBCore.**

One of my old works, completed now. Took idea from CRON (no extra resource required) to build auto deductions. Script is quite stable and optimised (compared to old ones). Also there were many Finance Scripts out there in the Community, but none of them seemed to work properly. This one has been tested by me, and it works flawlessly. 

<a href="https://discord.gg/jrNxkpVaJU" rel="some text">![Discord](https://discordapp.com/api/guilds/816584206838398997/widget.png?style=banner2)</a>

<img src = 'https://media.discordapp.net/attachments/833414724171202580/860788925991747584/unknown.png'>

## FEATURES
- All features of Normal QB-VEHICLESHOP
- Finance Added with Custom Installment Cost (Percentage system)
- Finances cut automatically every 24 hours (even if player is offline)
- Custom Downpayment Options, TEST DRIVE also available for cardealers.
- Replaced Native Text with some Colourful Text. 
- Can be easily used even if your server has existing player vehicles. 
- Greatly reduced Client MS (from around 0.1-0.2, brought down to below 0.06) 
- Player's cannot buy new cars until old finances are paid.

## SETUP 
- The Resource has a SQL Included. Execute the SQL and confirm the changes. 
- **THE CONFIG HAS A FIELD NAMED `Config.HouroftheDay` which should be something between 0-24 and sets at which hour, finances would be deducted from everyone's account (Daily In REAL TIME). Example : Setting it to 15 would cut finances at 3 PM Server Time Everyday!**
- Start the resource in resources.cfg
- Take the `cardealer` job to test all the features. 

## COMMANDS
- `/finance` for Players to Check how much Pending Finance do they Have.
- `/finance [amount]` pays 10000 against pending finances. 


## KNOWN ISSUES 
- Finance and Downpayment values are synced across all cars, thus multiple selling of vehicles might cause issues. 
- EDM might have some flaws in selling using ID (unsure) 
- TestDrive is still like WIP. I doubt it doesn't work. (Create a PR if you fix it)

## CREDITS
- Xion for providing the broken finance files making work a bit easy. 
- MonkeyWhisper and Ariz for reporting issues with Auto Deduction of finance. 
- Ariz for assisting in development on the part of Offline Player Finance Deduction. 

## LICENSE
<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License</a>.

