library(tidyverse)
library(DBI)
library(odbc)

#create snowflake connection
myconn <- DBI::dbConnect(odbc::odbc(), driver="SnowflakeDSIIDriver", Server = "server.ID",
                         Driver = "SnowflakeDSIIDriver",
                         Role = "CA_VACCINE_ROLE", #this can be whatever role you want/have or be left blank
                         Warehouse = "COMPUTE_WH", #this can be whatever warehouse that you have access to or be left blank
                         uid="USER_ID", pwd='password')

#pull data #######change to grab all when ready
JJ_mix <- DBI::dbGetQuery(myconn, 
                               "SELECT *
                               FROM table
                               WHERE VAX_RECEIVED LIKE 'J&J%' AND HAS_ADDITIONAL_DOSE = '1'
                               ;"
)

mix_JJ <- DBI::dbGetQuery(myconn, 
                           "SELECT *
                           FROM tale
                           WHERE VAX_RECEIVED NOT LIKE 'J&J,%' AND HAS_ADDITIONAL_DOSE = '1' AND VAX_RECEIVED LIKE '%J&J%'
                           ;"
)
