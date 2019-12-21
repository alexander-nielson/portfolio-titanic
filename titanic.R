library(titanic)
library(tidyverse)
library(naniar)
library(UpSetR)

#wrangling
titan_data<-as_tibble(titanic_train)
titan_data

#esnure correct the data types

titan_data <- titan_data %>% mutate(
    passid = PassengerId,
    survived = factor(ifelse(Survived==0,"no","yes")),
    pclass = factor(Pclass),
    name = Name,
    sex = factor(Sex),
    age = Age,
    num_sibsp = SibSp,
    num_parch = Parch,
    ticket = Ticket,
    fare = Fare,
    cabin = Cabin
)

titan_data <- titan_data %>% select(
    passid,
    survived,
    pclass,
    name,
    sex,
    age,
    num_sibsp,
    num_parch,
    ticket,
    fare,
    cabin
)

# Now we need to create some new variables of interest.
#
# First, I want to create one which can recognize names. I will first find the
# passenger title, then one for last name, and the one for first name

titan_data<-titan_data %>% tidyr::extract(
    name,
    c("title"),
    '(,.*\\..)',
    remove = FALSE
)
titan_data$title <- titan_data$title %>%  str_replace_all("[, ]", "")

titan_data<-titan_data %>% tidyr::extract(
    name,
    c("lname"),
    '(.*, )',
    remove = FALSE
)
titan_data$lname<- titan_data$lname %>%  str_replace_all("[, ]", "")

titan_data<-titan_data %>% tidyr::extract(
    name,
    c("fname"),
    '(\\..*)',
    remove = FALSE
)
titan_data$fname<- titan_data$fname %>%  str_replace_all("[. ]", "")



#Wrangle family size



#wrangle deck



#wrangle fare




#first lets visualize the missing data
vis_miss(titan_data)


#EDA


#EDA of title
ggplot(data = titan_data,
       mapping = aes(x = title, fill = survived)) +
    geom_bar(position = "identity")


ggplot(data = titan_data,
       mapping = aes(x = pclass, fill = survived)) +
    geom_bar(position = "identity")


