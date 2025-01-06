# AstraOS/RobertOS HOME

**Assets branch contains conversion script**

**This operating system was used for the Robert computer and is abandoned, please look at AdaOS instead: https://github.com/2048hertz/AdaOS**

CURRENTLY IN AN UNUSABLE STATE, IF DOWNLOADED AND SOMEHOW BUILT USING OUTDATED BUILD INSTRUCTIONS THEN PLEASE DO NOT EXPECT ANY UPDATES SINCE UPDATES WILL BE BUILT FOR THE STABLE VERSIONS OF ASTRAOS, OR DO NOT DOWNLOAD ANY UPDATES BECAUSE THEY WILL HAVE THE POSSIBILITY TO BREAK YOUR INSTALL.

An ARM64 Linux based operating system for the Robert Computer (Raspberry Pi handheld computer). Based off of Raspberry Pi OS

WORK IN PROGRESS - Currently AstraOS can only be built by the user

AstraOS is easy to build compared to other operating systems.
The asset branch contains bash and python scripts to build the OS.
There is a version up right now but it's not stable and well-tested. It will require some more work.

HOW TO BUILD (outdated, we recommend not to download this os before the iso for 0.1 alpha is released)
# THIS SECTION HAS YET TO BE UPDATED FOR THE NAME CHANGE FROM ROBERTOS > ASTRAOS

1) Install the "2024-03-15-raspios-bookworm-armhf.img.xz" version of Raspberry Pi OS
2) Do a basic set up, do not update or install anything.
3) Run in the terminal - wget https://github.com/2048hertz/RobertOS/releases/download/0.1/installer.sh
4) Configuration will be done for you!
5) You will boot into an installer where you will set up your user account, set your timezone, locale, etc.
6) There! In 5 steps you have successfully built RobertOS

OPTIONAL

The top and bottom panel are not automatically configured due to limitations with xfconf-query
Thus, you may change the configurations how they are dreamed to be by yourself.
Right click the application menu and click properties
Change the icon to logo.png in /usr/bin/RobertOS-assets/
Change the session menu from the username to a custom value which is exactly " Session Menu " with the spaces
Remove all seperators and add the reboot, hibernate, etc options
For the bottom panel, remove the seperator beside the show desktop plugin then add an application menu plugin and configure it like the top panel application menu but this time use the image file logofull.png instead of logo.png

CONGRATULATIONS, YOU HAVE BUILT ROBERTOS!


RobertOS হোম

একটি ARM64 লিনাক্স ভিত্তিক অপারেটিং সিস্টেম রবার্ট কম্পিউটার (রাসপবেরি পাই হ্যান্ডহেল্ড কম্পিউটার) জন্য। রাসপবেরি পাই ওএস থেকে ভিত্তি নেওয়া

কাজ চলছে - বর্তমানে RobertOS ব্যবহারকারীর দ্বারা মাত্র তৈরি করা যাবে

RobertOS অন্যান্য অপারেটিং সিস্টেম তুলনায় তৈরি করা সহজ। সম্পদ শাখাটির মধ্যে ওএস তৈরি করার জন্য ব্যাশ এবং পাইথন স্ক্রিপ্ট রয়েছে। বর্তমানে একটি সংস্থান আছে কিন্তু এটি স্থিতিশীল এবং ভাল পরীক্ষিত নয়। এটির প্রয়োজনে আরও কাজ করতে হবে।

কিভাবে তৈরি করবেন -

• রাসপবেরি পাই ওএস এর "2024-03-15-raspios-bookworm-armhf.img.xz" সংস্করণ ইনস্টল করুন

• একটি বেসিক সেটআপ করুন, কিছুই আপডেট বা ইনস্টল না করুন।

• টার্মিনালে রান করুন - wget https://github.com/2048hertz/RobertOS/releases/download/0.1/installer.sh

• কনফিগারেশনটি আপনার জন্য সম্পন্ন হবে!

• আপনি ইন্সটলারে বুট করবেন যেখানে আপনি আপনার ব্যবহারকারী অ্যাকাউন্ট, সময় অঞ্চল, লোকেল, ইত্যাদি সেট করবেন।

• আমারে! ৫ ধাপে আপনি সফলভাবে RobertOS তৈরি করেছেন

শীর্ষ এবং নীচের প্যানেল স্বয়ংক্রিয়ভাবে কনফিগার করা হয়নি কারণ xfconf-query এর সীমানা রয়েছে। এই কারণে, আপনি চেষ্টা করতে পারেন যে কিভাবে কনফিগারেশনগুলি আপনি চাইতে পারেন। অ্যাপ্লিকেশন মেনুতে ডান ক্লিক করুন এবং বৈশিষ্ট্যগুলি পরিবর্তন করুন আইকনটির পাথটি logo.png তে পরিবর্তন করুন /usr/bin/RobertOS-assets/ ব্যবহার করুন ব্যবহারকারীর নাম থেকে সেশন মেনুকে কাস্টম মান " সেশন মেনু " সহ স্থান দিন স্থানগুলি সমস্ত সেপারেটর অপসারণ করুন এবং পুনরায় বুট, হাইবারনেট ইত্যাদি বিকল্প যোগ করুন নিচের প্যানেলে, ডেস্কটপ প্লাগিনের পাশে সেপারেটর অপসারণ করুন এবং একটি অ্যাপ্লিকেশন মেনু প্লাগিন যোগ করুন এবং এটি শীর্ষ প্যানেল অ্যাপ্লিকেশন মেনুর মতো কনফিগার করুন তবে এবার ছবির ফাইল logofull.png ব্যবহার করুন logo.png এর পরিবর্তে।



