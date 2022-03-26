# MummaBrandyn_WearableProject

## Brandyn Mumma

## Link to repo
https://github.com/RoatchBrandyn-FS/MummaBrandyn_WearableProject/settings/access?guidance_task=

## Weekly Requirements - Alpha

1. The feature I was able to complete for this weeks requirements was the connection between the watch and phone. And to show it working, when clicking on the connect button in the watch, the connection view in the phone should change to a green and say "Device Connected"

2. Sadly, because of other assignments pushing my timeline behind, I wasn't able to get much more functionality into the projectv as wanted. I Also was getting stuck on setting up a page-based navigation in watch  after connecting to phone, and wasn' able to complete that correctly. If I have any more trouble with it I will try a new method to getting the player scores to show and work with the phone.

## Weekly Requirements - Gold

1. Finished the final two features. The feature of displaying both scores wasn't finhed in time. Changed to only displaying on the main device, but made it easier to tell which change is for which player when using the watch device.

2. Made a simple icon for the application for all required appIcons

3. Tried changing the App Titles for both devices, and somehow crashed the Watch App. Restored form GitHub and elected to leave name as is. Did come up with final name for the app: Tabletop Score Projector or Tabletop SP

## Devices used for testing
1. Phone: iPhone 12 Pro Max
2. Watch: Series 6 - 44mm
-> For the watch, I did most input testing with voice control because I couldn't find how to limit the keyboard otherwise

## Current Functionality
The phone will work on its own. When the device connects with watch, it will display up top whether the device successfully connected. If user needs help, the top left buutton will tell user the how to connect. The top right button will reset the scores and display the same alert as the start of the app. The inputs are specific to the views they are in. The action for changing values on either side are connected on the same action. All scores either add/subtract based on the value of the respective input, or alerts the user of the reason it didn't work. When using the watch, hitting connect won't enable the player buttons unless it connects to the phone app. BIG CHANGES ON THE WATCH: wasn't able to do the interface the way I wanted to origianlly, including showing the score correctly (more details in post mortem). However, once the watch is connected, the player buttons are enabled and the conenct button becomes disabled. When clicking on the player buttons, t should take you to the same detail interface but with specific information based on player clicked on. From there, you can input any string into the text field and either press the add or deduct buttons and send data to the phone. The watch won't check for letters/numbers, but when data is sent to the phone, it runs the same functions as the phone changes and will check and will change the score or alert he user on why it didn't change.
