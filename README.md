# Rabbid MultiTool Vita
Powerful toolbox for the PSVita. It only does everything!

<img src="Screenshots/2024-08-02-143643.png">

## Features
### Database Tools
* **Back up app.db**: Backs up the app database to use it in case of restoring your bubble layout.
* **Restore backed up app.db**: Self-explanatory, restores your previously backed up app database.
* **Update database**: Also self-explanatory, triggers a database update. Doing this wipes your custom themes from the database and you'll have to add them back using a custom themes manager. Official themes aren't affected and will stay.
* **Rebuild database**: Self-explanatory yet again, triggers a database rebuild. Doing so wipes your bubble layout. It can be restored by using the aforementioned backup/restore app database option.
* **Import Media**: Imports media to the database, meaning it can be accessed by using the system media apps.
### App Tools
Once clicked, a list will show with all the apps installed, system apps present in the app database and official (not Adrenaline bubbles) PSP/PS1 bubbles. You can add a custom icon and livearea images to an app in the specified folder. This is not possible with system apps yet.
### Account Tools
TBA
### Features coming in 0.10
#### Registry Tools
* Reset parental passcode: Resets the Parental Controls passcode, useful in cases of purchasing a Vita with a parental passcode & settings left and forgotten by the previous owner(s).
* Reset screen lock passcode: Resets the lockscreen passcode, allowing to go directly to the Livearea without typing a passcode.
* Disable Auto-AVLS: Disables the Auto-AVLS feature for AVLS-forced Vitas.
* Modify a registry key: You can modify a registry key from the system's registry to whatever you like/want.
#### Settings
* Show icons in app list: Enable/disable icon preview in the app list of **App Tools**. It's recommended to turn this off as having it on might cause lag/freezing issues and sometimes either a C stack overflow error or a GPU crash.
#### Other Additions
Auto-Updating is now a thing, you can now update directly within the app. This will affect versions 0.10 and onwards, as versions 0.09 or below need to be updated manually because these versions don't have auto-updating.
## Credits
* OneLua team for their Lua interpreter and their past apps.
