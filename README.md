# Sputnik-iOS
<img src="img/ic_satellite_1024.png" width="300" height="300">

Source code of [Спутник ГУАП](https://itunes.apple.com/ru/app/спутник-гуап/id1234040508?l=en&mt=8) app.
## About App
Official iOS app of [SUAI University](http://new.guap.ru) developed by [Sputnik SUAI](http://sputnik.guap.ru) team.
### News
University news are obtained from official [site](http://new.guap.ru/pubs). Only news of first page available.

<img src="img/news.png" width="300"> <img src="img/news_detail.png" width="300">
### Schedule
Both [semester](rasp.guap.ru) and [session](raspsess.guap.ru) are available. It's possible to obtain schedule of groups, teachers or auditories. User can set base entity which will be available offline. Calendar also included.

<img src="img/schedule_main.png" width="300"> <img src="img/schedule_calendar.png" width="300">
### Navigation
Navigation module allows to find auditory make routes between auditories of main building of university placed on Bolshaya Morskaya str., 67. Sources of navigation html **is not included** (i.e. navigation will not work).

<img src="img/nav.png" width="300"> <img src="img/nav_route.png" width="300">
### Reference information
Reference information module contains information about institutes, departments. In sources real reference information replaced by **test** data.

<img src="img/ref.png" width="300"> <img src="img/ref_cath.png" width="300"> <img src="img/ref_inst.png" width="300">
## How to install
1. Download repo;
2. Using terminal go to root folder and install CocoaPods dependencies:
```bash
pod install
```
3. Open Sputnik.xcworkspace;
4. Delete Navigation folder placed in Sputnik/Resources;
5. cmd + R.
