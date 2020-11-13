

# Read one file

#
# Get one sample - helper functipon for 'get_lengde_from_file'
#

get_one_sample <- function(data, firstcolumn, sampleno){
  lengths_seconddigit <- as.numeric(data[19:28, firstcolumn])
  data_list <- vector("list", 8)  # max 4 columns  
  column <- firstcolumn + 1
  list_no <- 0
  continue <- TRUE
  while (continue & column <= 15){
    lengths_firstdigit <- as.numeric(data[18, column])
    check <- identical(as.numeric(dat[19:28, column]), as.numeric(0:9)) 
    if (!is.na(lengths_firstdigit)){
      list_no <- list_no + 1
      data_list[[list_no]] <- data.frame (Sampleno = sampleno, 
                                 Length = lengths_firstdigit + lengths_seconddigit, 
                                 Number = as.numeric(data[19:28, column]))
      column <- column + 1
    } else if (check){
        continue <- FALSE
    } else if (!check){
      column <- column + 1
    }
  }
  data_list[1:list_no] %>% bind_rows()
}


if (FALSE){
  
  # Test get_one_sample
  
  
  dat <- read_excel(
    "K:/Prosjekter/Sjøvann/JAMP/2018/opparbeiding biota/Blåskjell/10A2_Skallneset_2018.xlsx"
  ,
    col_names = paste0("Col", 1:15),
    range = "A1:O28",
    col_types = "text") %>% 
    as.data.frame()
  dat <- read_excel(
    "K:/Prosjekter/Sjøvann/JAMP/2015/Opparbeiding_biota/Blaaskjell/30A_Gressholmen.xlsx",
    col_names = paste0("Col", 1:15),
    range = "A1:O28",
    col_types = "text") %>% 
    as.data.frame()

  # debugonce(get_one_sample)
  df <- get_one_sample(dat, firstcolumn = 1, sampleno = 1)
  df <- get_one_sample(dat, firstcolumn = 5, sampleno = 2)
  df <- get_one_sample(dat, firstcolumn = 9, sampleno = 3)
  
}

get_lengde_from_file <- function(folder, filename, stationcode, year, trace = FALSE){
  if (trace)
    cat(folder, "/", filename, "\n")
  fn_full <- glue("{folder}/{filename}")
  dat <- read_excel(fn_full, 
                    col_names = paste0("Col", 1:15),
                    range = "A1:O28",
                    col_types = "text") %>% 
    as.data.frame()
  
  data_list <- vector("list", 4)
  sample_no <- 0
  
  # Go through each column and if we find a column that resembles a start of a smaple, we run 'get_one_sample' 
  for (column in 1:18){
    check <- identical(as.numeric(dat[19:28, column]), as.numeric(0:9)) 
    if (check){
      sample_no <- sample_no + 1
      data_list[[sample_no]] <- get_one_sample(
        data = dat, 
        firstcolumn =  column, 
        sampleno = sample_no)
    }
    
  }
  
  lengder <- data_list[1:sample_no] %>% bind_rows()
  
  lengder <- lengder %>%
    mutate(Number = case_when(
      is.na(Number) ~ 0,
      !is.na(Number) ~ Number
    ),
    Station = stationcode,
    Year = year
    )
  
  lengder
  
  
}

if (FALSE){
  
  
  # Test  
  # debugonce(get_lengde_from_file2)
  
  # Test with file with 3 columns per sample  
  df <- get_lengde_from_file(
    folder = "K:/Prosjekter/Sjøvann/JAMP/2018/opparbeiding biota/Blåskjell",
    filename = "10A2_Skallneset_2018.xlsx",
    stationcode = "10A2",
    year = 2018
  )
  
  # 2014
  df <- get_lengde_from_file(
    folder = "K:/Prosjekter/Sjøvann/JAMP/2014/opparbeiding/blaaskjell",
    filename = "10A2_skallneset.xlsx",
    stationcode = "10A2",
    year = 2018
  )

    
  # Test with file with 4 columns per sample  
  df <- get_lengde_from_file(
    folder = "K:/Prosjekter/Sjøvann/JAMP/2018/opparbeiding biota/Blåskjell",
    filename = "I714_Brevik kirke_2018.xlsx",
    stationcode = "I714",
    year = 2018
  )
  
  ggplot(df , aes(x = Length, y = Number, fill = as.factor(Sampleno))) +
    geom_col()
  
}


