# Imports the monkeyrunner modules used by this program
from com.android.monkeyrunner import MonkeyRunner as mr
from com.android.monkeyrunner import MonkeyDevice as md

# Setup Menus
missionMenu = [300, 40]
scoutMenu = [730, 40]

# Position of scouts
scoutPosition1 = (570, 300);
healPosition1 = (260, 340);

scoutPosition2 = (825, 300);
healPosition2 = (500, 340);

scoutPosition3 = (1000, 300);
healPosition3 = (750, 340);

# Position of slots
slot1 = (570, 550)

# Missions
missionInProgress = [220, 216]
missionTopRight = [1080, 180]
missionCollect = [800, 670]
badNeigh = [200, 260]
wretHive = [200, 315]
eyesMad  = [200, 450]
gWarfare = [200, 540]

# Buttons
startMission = [830, 670]

# Begin the program
print("Connecting...")
device = mr.waitForConnection()
print("Connection has beeen established")

# Setup Mission count
missionCount = 1;

# Begin the loop
while True:
    # Selection the 'Missions' tab
    device.touch(missionMenu[0], missionMenu[1], md.DOWN_AND_UP)
    mr.sleep(.25)

    # Select the Mission
    device.touch(eyesMad[0], eyesMad[1], md.DOWN_AND_UP)
    # device.touch(gWarfare[0], gWarfare[1], md.DOWN_AND_UP) 
    mr.sleep(.5)

    # Select Scout first slot
    device.touch(slot1[0], slot1[1], md.DOWN_AND_UP)
    mr.sleep(.25)

    # Select the first Scout
    device.touch(scoutPosition3[0], scoutPosition3[1], md.DOWN_AND_UP)
    mr.sleep(.5)

    # Select 'Start Mission' button 
    device.touch(startMission[0], startMission[1], md.DOWN_AND_UP)
    mr.sleep(.5)

    # Select the current running mission
    device.touch(missionInProgress[0], missionInProgress[1], md.DOWN_AND_UP)
    mr.sleep(.5)

    # Select top right to complete
    device.touch(missionTopRight[0], missionTopRight[1], md.DOWN_AND_UP)
    mr.sleep(3)
    device.touch(missionTopRight[0], missionTopRight[1], md.DOWN_AND_UP)
    mr.sleep(3)

    # Collect mission rewards
    device.touch(missionCollect[0], missionCollect[1], md.DOWN_AND_UP)
    mr.sleep(.5)

    # Select 'Scouts' tab
    device.touch(scoutMenu[0], scoutMenu[1], md.DOWN_AND_UP)
    mr.sleep(.5)

    # Heal the first scout
    device.touch(healPosition3[0], healPosition3[1], md.DOWN_AND_UP)
    mr.sleep(0)
    
    print("Mission Complete: " + str(missionCount))
    missionCount = missionCount + 1
