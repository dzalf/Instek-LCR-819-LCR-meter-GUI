# Instek-LCR-819-LCR-meter-GUI
This is an alpha version of the GUI for data visualization and capture for the LCR-819

Due to the lack of an appropriate GUI for using the LCR I took the time to code this GUI in Matlab 2017b :heart:.  Some time ago I found that the only available GUI was compatible with Windows XP and it was VERY difficult to get it to work with Windows 10 or even Windows 7.

This GUI is useful to control and communicate with the Instek [LCR-819](https://www.csulb.edu/sites/default/files/groups/college-of-engineering/About/gwinstek_lcr_meter.pdf) (or [this](http://www.farnell.com/datasheets/1804014.pdf?_ga=2.140256308.620377038.1550777785-1665021690.1550777785)) LCR meter via RS-232. A USB to serial [converter](https://www.amazon.co.uk/dp/B0753HBT12/ref=asc_df_B0753HBT1258594860/?tag=googshopuk-21&creative=22146&creativeASIN=B0753HBT12&linkCode=df0&hvadid=309968313994&hvpos=1o3&hvnetw=g&hvrand=18098737753792326012&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9046639&hvtargid=pla-397003917010) (even based on the unpopular [FTDI](https://www.youtube.com/watch?v=eU66as4Bbds) :unamused:) is copletely compatible with this purpose. Set the BR to 38400 and **NEVER** change it, otherwise the LCR will go :crazy:

All the necessary libraries are pointed in the MainDataStructure.m file.

The GUI panel looks like this: :eyes:

![alt txt](https://github.com/dzalf/Instek-LCR-819-LCR-meter-GUI/blob/master/Rev03.png)

All the functionalities from the LCR have been implemented.

A list of the complete features fromthis GUI will be uploaded soon. 

In short: 

a. it can capture data at three different rates, 

b. all the permitted modes from the instrument are available and the circuit modes (serial and parallel), 

c. three test frequencies can be selected ( 1 kHz, 10 kHz and 100 kHz)

d. captured data is logged on an excel file upon saving wih an appropriate name. 

e. I implemented pagination of the saved data, namely, each capture is saved in a new HUGE cell therefore when saving only the latest is saved

Please test it using the deployed files and feel free to fork it to make all the changes and testing

**IMPORTANT NOTE**

The .exe file will download the Matlab runtime therefore you should expect around 1.5 GB used after installing. If you already have Matlab you don't officially need to install this HOWEVER it is appreciated if you can test the deployed file and tackle any issues.

**#TODO**

As usual, many improvements can be done including:

1. Thorough testing of the software stability
2. Beautify the interfase


Cheers :beer:


dzalf :sunglasses:
