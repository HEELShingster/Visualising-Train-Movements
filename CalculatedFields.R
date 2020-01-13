//A combination of all created calculated fields used in Tableau

//Displays format into a better readable form to the user
IF [Event Type] == 'DEPARTURE' THEN
'Actual Departure Time'
ELSEIF [Event Type] == 'ARRIVAL' THEN
'Actual Arrival Time'
END

//Calculates and displays time to the next location
IF [Next Report Run Time] == '' AND [Nlcdesc (Stanoxmapping1)] == 'Destination Reached' THEN
'Destination Reached'
ELSEIF [Next Report Run Time] == '' THEN
'N/A'
ELSE
[Next Report Run Time] + ' minutes'
END

//Displays current station name
IF REGEXP_MATCH([Station Name], "[A-Z][a-z]") THEN
[Station Name]
ELSE
'N/A'
END

//Calculates whether the train has variance to planned timetable
IF [Variation Status] == 'EARLY' THEN
STR([Timetable Variation]) + ' minutes early'
ELSEIF [Variation Status] == 'LATE' THEN
STR([Timetable Variation]) + ' minutes late'
ELSEIF [Variation Status] == 'ON TIME' THEN
'On Time'
ELSEIF [Variation Status] == 'OFF ROUTE' THEN
'Not in Timetable/Schedule'
END

//Displays the relevant TOC logo when clicked in the sidebar
CASE [Train Operating Company] WHEN 'c2c' THEN
'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToCkzacZm25NUPRyPyuIDsRK5jLIbjxgcuwu-Tgz7LChTEk5O7'
WHEN 'Caledonian Sleeper' THEN
'https://www.railwaygazette.com/uploads/pics/tn_gb-caledoniansleeper-logo-tracks.jpg'
WHEN 'Chiltern Railway' THEN
//'https://media.licdn.com/dms/image/C4D0BAQHCpsMWR292tA/company-logo_200_200/0?e=2159024400&v=beta&t=4tAYKnFiZDSrXz-Lbqp_NohJBv_zpoXu3JC3tFTFf4Q'
//'http://seekvectorlogo.com/wp-content/uploads/2018/04/chiltern-railways-vector-logo-small.png'
'https://www.silverrailtech.com/wp-content/uploads/2018/05/untitled-design-28-2.png'
WHEN 'CrossCountry' THEN
//'http://wordpress.fifedirect.org.uk/cyclefife/wp-content/uploads/sites/27/2017/06/crosscountry-1.jpg'
//'https://leicester.camra.org.uk/attachments/Image/Cross-Country-logo_1.png?template=generic'
'http://seekvectorlogo.com/wp-content/uploads/2018/04/crosscountry-vector-logo.png'
WHEN 'Devon and Cornwall Railways' THEN
'https://irp-cdn.multiscreensite.com/e983be39/dms3rep/multi/Large+Grey+Logo+copy.png'
WHEN 'East Midlands Trains' THEN
//'https://www.m360.co.uk/wp-content/uploads/2017/03/emt-headerx2-1380x541.png'
'http://cricket.derbyshireccc.com/wp-content/uploads/2015/05/east-midlands-trains-logo-4340-565593_478x359.jpg'
WHEN 'Eurostar' THEN
'https://pageflows.com/media/logos/eurostar.jpg'
WHEN 'GB Railfreight' THEN
'https://www.logolynx.com/images/logolynx/7a/7a47d65dc38f23b5ae68d24ab590d865.png'
WHEN 'Govia Thameslink Railway (Thameslink, Southern and Great Northern)' THEN
'https://i.guim.co.uk/img/media/b27d15542b2ad6e53e474ea3121160407927234e/0_188_3508_2105/master/3508.jpg?width=300&quality=85&auto=format&fit=max&s=fc909404bee8be2181eab0da524c2526'
WHEN 'Grand Central' THEN
'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeeMS_tXbJmVAvYzzelVrvpe49Zma0fPdFqRe7M_MKTyyfMJc5'
WHEN 'Great Western Railway' THEN
//'https://2.bp.blogspot.com/-UWKNqoT0nqo/XLM13GbsLYI/AAAAAAAAIyE/eWB2i4x6gDoqgdH1Vn_246ToVfUuAI7QwCLcBGAs/s1600/_BSP7733.jpg'
//'http://customerservices.reviews/wp-content/uploads/2018/05/GWR_Logo.jpg'
'https://www.meetsouthwest.co.uk/wp-content/uploads/2018/12/GWR.png'
WHEN 'Greater Anglia' THEN
'https://www.railpro.co.uk/wp-content/uploads/Greater-Anglia-Logo-1.jpg'
WHEN 'Heathrow Express' THEN
'https://www.assesstech.com/wp-content/uploads/2017/02/Logo-HEX.png'
WHEN 'Hull Trains' THEN
'https://www.railpro.co.uk/wp-content/uploads/HullTrains-640.jpg'
WHEN 'London North Eastern Railway (LNER)' THEN
'https://economyclassandbeyond.boardingarea.com/wp-content/uploads/2018/05/LNERailway-800x483.png'
WHEN 'London Overground' THEN 
//'https://s3-eu-west-1.amazonaws.com/grm-assets/15997/9cx55o3_400x400.jpg'
//'https://assets.change.org/photos/1/eo/ze/vgEoZeBhLqSjjTO-800x450-noPad.jpg?1509261218'
'http://www.unseensteam.co.uk/sites/default/files/styles/large/public/London_Overground_logo.svg__0.jpg?itok=AjbkDCgb'
WHEN 'LUL Bakerloo Line' THEN
'https://micaarchitects.com/img/cGZyR3pMWnUrdHVTZnNJeUhIMXBQQT09/594-bakerloo-line-mica-logo.jpg'
WHEN 'LUL District Line (Richmond Branch)' THEN 
//'https://pbs.twimg.com/profile_images/738736607587618816/PMRH5wti_400x400.jpg'
'https://i.ebayimg.com/images/g/xBgAAOSwf9ta-5fh/s-l300.jpg'
WHEN 'LUL District Line (Wimbledon Branch)' THEN
'https://www.sorryfortheinconvenience.co.uk/assets/img/banner-district-line.png?v=4'
WHEN 'Merseyrail' THEN
//'http://www.socialvalueuk.org/app/uploads/2019/01/Merseytravel-Logo-CB.jpg'
'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8prSKUkOhlxIeyjSbdZfEOGUF-FV9bm7D3XZkZCigJSbPAPNq'
WHEN 'Network Rail (On-Track Machines)' THEN
'http://www.keolis.co.uk/sites/default/files/images/news/bror_logo_master_small.jpg'
//'https://pbs.twimg.com/media/DfuEz3xX0AAZBV7.jpg'
WHEN 'Nexus (Tyne & Wear Metro)' THEN
//'http://www.ngi.org.uk/wp-content/uploads/2016/08/db-regio.jpg'
//'https://is1-ssl.mzstatic.com/image/thumb/Purple71/v4/33/18/99/3318996d-00ad-2ce8-3155-f2b5eb4ba459/pr_source.png/1200x630wa.png'
//'https://is1-ssl.mzstatic.com/image/thumb/Purple71/v4/33/18/99/3318996d-00ad-2ce8-3155-f2b5eb4ba459/pr_source.png/1200x630wa.png'
'https://28d9s823661hsg59v20uwuya-wpengine.netdna-ssl.com/wp-content/uploads/2018/05/metro.png'
WHEN 'North Yorkshire Moors Railway' THEN
'https://pbs.twimg.com/profile_images/1063026404839866368/50IFatin_400x400.jpg'
WHEN 'Northern Rail' THEN
//'http://www.bwdconnect.org.uk/wp-content/uploads/2016/11/new-northern-logo.png'
'https://www.moneysavingexpert.com/content/dam/mse/deals/northernlogo.png'
WHEN 'ScotRail' THEN
//'http://www.railtechnologymagazine.com/write/MediaUploads/class_386_scotrail_hitachi_electric.jpg'
//'https://storage.railmagazine.com/website/1/root/20180221-193715_w268.jpg'
//'http://graemedey.info/wp-content/uploads/2018/03/scotrail-logo.JPG.gallery.jpg'
'http://www.carena.org.uk/wp-content/uploads/2017/03/scotrail-logo.jpg'
WHEN 'South Western Railway' THEN
'https://pbs.twimg.com/profile_images/1013755062399717376/tkxXje-H_400x400.jpg'
WHEN 'Southeastern' THEN
//'https://honey.co.uk/wp-content/uploads/2017/05/southeastern-logo-rev.jpg'
//'https://backend.someone.digital/wp-content/uploads/2017/12/Southeastern_Logo.jpg'
//'https://www.moneysavingexpert.com/content/dam/mse/deals/Southeastern2016.jpg'
'https://cdn.londonandpartners.com/asset/southeastern-southeastern-71c800b993c7b0610ff18fed991da84d.jpg'
//'https://honey.co.uk/wp-content/uploads/2017/05/southeastern-logo-rev.jpg'
//'https://creative-heads.co.uk/wp-content/uploads/2015/07/SE.png'
//'https://i1.wp.com/metro.co.uk/wp-content/uploads/2016/10/ad_221494243.jpg?quality=90&strip=all&zoom=1&resize=644%2C428&ssl=1'
WHEN 'TfL Rail' THEN
'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/TFL_Rail_roundel.svg/1200px-TFL_Rail_roundel.svg.png'
WHEN 'TransPennine Express' THEN
'http://jobs.railwayoperators.co.uk/wp-content/uploads/2015/02/Transpennie-Express-Logo_Core_RGB.jpg'
WHEN 'Transport for Wales' THEN
'https://www.railpro.co.uk/wp-content/uploads/TRANSPORT-FOR-WALES-LOGO-1.jpg'
WHEN 'Virgin Trains' THEN 
'https://yt3.ggpht.com/a/AGF-l7829KhtzaQevFKxRa43kPUWNtjlI8-4Ec_E-A=s900-mo-c-c0xffffffff-rj-k-no'
WHEN 'West Coast Railway Co.' THEN 
//'https://upload.wikimedia.org/wikipedia/en/thumb/7/7e/West_coast_railways_logo.svg/1200px-West_coast_railways_logo.svg.png'
'https://farm4.staticflickr.com/3798/9341648709_6dcb434512_b.jpg'
WHEN 'West Midlands Trains' THEN
//'https://www.railbusinessdaily.com/wp-content/uploads/2018/09/wkqnwkbcxeh4ny9kkftx.jpg'
//'http://resources.mynewsdesk.com/image/upload/t_next_gen_logo_limit_x2_png/wkqnwkbcxeh4ny9kkftx.png'
//'http://seekvectorlogo.com/wp-content/uploads/2018/04/west-midlands-trains-vector-logo-small.png'
'https://railguard.co.uk/file/4a3f25ed3a0889a3071008eddf31a300.png'
END

