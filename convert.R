library(dplyr)

options(stringsAsFactors = F)
Sys.setlocale("LC_TIME", "C") %>% invisible

filename <- "Treatment - 01_LP_S/HR data/20151027/Session1/0022D08B3EFF.csv"

data <- read.csv(filename, header = F, sep = " ")
ncols <- ncol(data)
data <- read.csv(filename, header = F, sep = " ", colClasses = replicate(ncols, "character"))

time <- data[1,]
starttime <- as.POSIXct(paste0(time[6],time[2],time[3],time[4]), format="%Y%b%d%T", tz = time[[5]])

HR <- data %>% 
  filter(V1 == "Notification") %>% 
  select(HR16 = V7) %>%
  mutate(time = starttime:(starttime + n() - 1)) %>%
  mutate(time = as.POSIXct(time, origin = "1970-01-01")) %>%
  mutate(HR = strtoi(HR16,16))

i <- 8
HF <- list()
while(i < ncols) {
  tmp <- data[,i:(i+1)]
  names(tmp) <- c("hex2", "hex1")
  tmp <- tmp %>% 
    mutate(time = starttime:(starttime + n() - 1)) %>%
    mutate(time = as.POSIXct(time, origin = "1970-01-01")) %>%
    filter(hex2 != "") %>%
    mutate(HF = strtoi(paste0(hex1, hex2), 16)) %>%
    mutate(i = i)
  HF[[length(HF) + 1]] <- tmp
  i <- i + 2
}

HF <- do.call(rbind, HF) %>% arrange(time, i)

