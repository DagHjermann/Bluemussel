# Bluemussel

Reads blue mussel length for blue mussel collected in the Milkys (aka. JAMP/CEMP) project.    

* Typically, for each blue mussel station, 3 samples with 30-100 mussels are taken  
* The length of each mussel is measured  

Saved data are copied to `K:/Avdeling/214-Oseanografi/DHJ/Data/Contaminants/Marine/Milkys`  

### Sources of data  

The two sources of data are these:  

* For the period 1981-2013, the data are stored in an Access data base and are read using *script 02*  
    - For each sample, these data are structured as *mean, standard deviation, min and max length* per sample    
    - The 
* For the period 2014-2019, the data are stored in excel files on K: (see script) and are read using *script 01*    
    - For each sample, these data are structured as *number of blue mussels per millimeter* (e.g. 7 mussels were 37 mm)   

In other words, we have the raw data for 2014-2019 but not for 1981-2013.  


### Resulting data  

The returned data are stored as Excel files. Due to their different sources, they differ based on the period:  

* 1. Period 1981-2013: the data are stored as follows:  

    - Summarised (mean, SD, min, max) per sample: `Bluemussel lengths 1981-2013 summarised.xlsx` (one line per year * station x sample))  

* 2. Period 2014-2019: the data are stored as raw data (a below) plus two summarised formats (b and c):  

    a. Raw data: `Bluemussel lengths 2014-2019 raw.xlsx` (as explained above - one line per year * station x sample x millimeter) 
    b. Summarised (mean, SD, min, max) per sample: `Bluemussel lengths 2014-2019 summarised sample.xlsx` (one line per year * station x sample))  
    c. Summarised (mean, SD, min, max) per station: `Bluemussel lengths 2014-2019 summarised station.xlsx` (one line per year * station) 

    

### Joining periods    

*File 1 (1981-2013) can be joined with file 2b ('summarised per sample' 2013-2019 data)*. The following variable names correspond to each other (1981-2013 = first name, 2013-2019 = last name):   
```
- jmpst = Station  
- Station_name = Station_name  
- Lat_fixed = Lat   
- Long_fixed = Long  
- myear = Year  
- subno = Sampleno  
- lnmea, lnstd, lnmin, lnmax = Mean_length,	SD_length,	Min_length,	Max_length  	
- noinp = Sample_size      
```
  
If you want 'summarised per station' data, you need to first calculate weighted means and weighted standard deviations for the 1981-2013 data (see [here](https://math.stackexchange.com/q/320441) for a formula for weighted standard deviation). The result can then be combined with file 2c.       


### Variables  
  
Note: by 'nominal' position, we mean a position that is not changing from year to year, even if actual sampling may move slightly from year to year  

#### File 1, period 1981-2013     

```
"jmpst", "Station_name", "Lat_fixed", "Long_fixed",   # station codes (jmpst) and positions as 'defined' in 2019 (1)
"myear", "sdate", "stime",                            # year and date
"rlabo", "seqno",                                     # key columns in the original data
"subno",                                              # Sample number (usually 1-3) - corresponds to 'Sampleno' 2014-2019
"speci",                                              # species code (Mytilus edulis)
"latitude", "longitude", "latdg", "latmi", "latmf", "londg", "lonmi", "lonmf",  # position as recorded in the data (2) 
"inorb", "noinp",                                     # noimp = sample size (number of mussels in the sample)
"lnmin", "lnmax", "lnmea", "lnstd",                   # Length per mussel (min, max, mean and SD)
"wtmin", "wtmax", "wtmea", "wtstd",                   # Weight per mussel (lacking in most cases)
"shlwtx", "tiswtx", "qeorw",                          # Total weight of shell and tissue (usually lacking)
"cmnt1.x", "cmnt2.x", "cmnt3.x", "cmnt4.x", "cmnt5.x",   # Comments for sampling that year
"cmnt1.y", "cmnt2.y", "cmnt3.y", "cmnt4.y", "cmnt5.y")   # Sample-specific comments

(1) Lat_fixed and Long_fixed are fix from year to year, the 
(2) position variables: 
      latitude = latitude with decimals
      latdg, latmi, latmf = latitude given as whole degrees, minutes (1/60 degree) and the two first decimals of minutes (1/100 minute)
    Note: these positions may differ from one year to another (at least in principle)
```

#### Files 2a, 2b, 2c, period 2014-2019   

- For all files:  

   - Station (code)	 
   - Station_name	(as defined in 2019)   
   - Lat ('nominal' position)	 
   - Long	('nominal' position)    
   - Year	(sampling year)  

- For 2a:  
   - Sampleno	(sample within station, usually 1-3)    
   - Length (millimeters)	 
   - Number (number of blue mussels with the given length)  

- For 2b and 2c:  
   - Sampleno	(as above; obviously only given for 2b)   
   - Mean_length,	SD_length,	Min_length,	Max_length (mean, standard deviation, min, max)	  
   - Sample_size - number of blue mussels per sample (file 2b) or per station (file 2c)   
  

