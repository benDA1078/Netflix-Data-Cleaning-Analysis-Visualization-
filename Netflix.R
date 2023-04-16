# Final Building Frame
```{r}
  glimpse(Netflix)
  table(Netflix$type)
```
  ### Visualize the Show Type of the "Original" Dataset 
```{r}
    Type <- Netflix %>% 
      count(type) %>%
      ggplot() + geom_col(aes(x = type, y= n, fill = type)) + 
      labs(title = "Movie & TV Shows (Original)", subtitle = "Netflix Data", caption = "Data Source: Kaggle, *Shivam Bansal*") + theme_update()
```    
    
    ### Total amount of Movies & TV Shows available 
```{r}
      type_count <- count(Netflix,type)
      type_count$percen <- paste0(round((type_count$n/sum(type_count$n))*100,2),'%') 
      Pie1 <- plot_ly(type_count,
            labels= ~type,
            values= ~n,
            type='pie') %>% 
      layout(title = 'Netflix Content Type (Original)')
```  
    ### Mean of the Dataset (Time Duration)
``` {r}
      Netflix %>%
        filter(type == "Movie") %>%
       separate(duration, sep = ' ', into = 'Duration_in_Mins') %>%
        mutate(Duration_in_Mins = as.numeric(Duration_in_Mins))
      Netflix %>%
        filter(type == "Movie") %>% 
        mutate(Duration_in_Mins = parse_number(duration)) %>% 
        summarize(mean_duration = mean(Duration_in_Mins))
    ### Graphing the Mean
      Mean <- Netflix %>%
        filter(type == 'Movie') %>%
        mutate(Duration_in_Mins = parse_number(duration)) %>%
        ggplot() + geom_density(aes(x = Duration_in_Mins)) +
        labs(title = 'Distribution of Movie Duration (Original)',
             subtitle = 'in Minutes',
             caption = 'Data Source: Kaggle ') +
        theme_update()
```
      
    ### Distribution of Countries 
```{r}
      table(Netflix$country)
      #### Creating another data subset called "Country" for combining 2 plots into 1 graph
      Country <-Netflix %>%
        filter(!str_detect(country,',')) %>%
        group_by(country) %>%
        count() %>%
        arrange(desc(n)) %>%
        head(20) %>%
        ggplot() + geom_col(aes(y = reorder(country,n), x = n)) +
        geom_label(aes(y = reorder(country,n), x = n, label = n)) +
        labs(title = 'Approx. Number of Titles of each Country (Original)',
             subtitle = 'Top 20 Countries',
             caption = 'Data Source: Kaggle ') +
        theme_minimal()
      
      plot(country)
```
    
    
## Create another copy of "Netflix" for Data cleaning
```{r}
    Netflix2 <- Netflix 
    ### Removing all Missing Values (N/A)
      Netflix2 <- na.omit(Netflix2)
    ### Visualize the Netflix2 
      Type2 <- Netflix2 %>% 
        count(type) %>%
        ggplot() + geom_col(aes(x=type, y=n, fill = type)) + 
        labs(title = "Movie & TV Shows", subtitle = "Netflix Data", caption = "Data Source: Kaggle, *Shivam Bansal*") + theme_update()
```
      
    ### Movies & TV Shows Available 
```{r}
      type_count <- count(Netflix2,type)
      type_count$percen <- paste0(round((type_count$n/sum(type_count$n))*100,2),'%') 
      Pie2 <- plot_ly(type_count,
                      labels= ~type,
                      values= ~n,
                      type='pie') %>% 
        layout(title = 'Netflix Content Type')
```
      
    ### Mean of the Dataset (Time Duration) 
```{r}
      Netflix2 %>%
        filter(type == "Movie") %>%
        separate(duration, sep = ' ', into = 'Duration_in_Mins') %>%
        mutate(Duration_in_Mins = as.numeric(Duration_in_Mins))
      Netflix2 %>%
        filter(type == "Movie") %>% 
        mutate(Duration_in_Mins = parse_number(duration)) %>% 
        summarize(mean_duration = mean(Duration_in_Mins))
      
      Mean2 <- Netflix2 %>%
        filter(type == 'Movie') %>%
        mutate(Duration_in_Mins = parse_number(duration)) %>%
        ggplot() + geom_density(aes(x = Duration_in_Mins)) +
        labs(title = '(CLEAN) Distribution of Movie Duration',
             subtitle = 'in Minutes',
             caption = 'Data Source: Kaggle ') +
        theme_update()
```
      
   ### Distribution of Countries 
```{r}
        Country2 <- Netflix2 %>%
          filter(!str_detect(country,',')) %>%
          group_by(country) %>%
          count() %>%
          arrange(desc(n)) %>%
          head(20) %>%
          ggplot() + geom_col(aes(y = reorder(country,n), x = n)) +
          geom_label(aes(y = reorder(country,n), x = n, label = n)) +
          labs(title = 'Approx. Number of Titles of each Country',
               subtitle = 'Top 20 Countries',
              caption = 'Data Source: Kaggle ') +
          theme_minimal()
```

  # Comparing Netflix & Netlfix2 (being the cleaned data)
```{r}
      png("Movie & TV Shows", width = 1280, height = 1280)
      init <- par(no.readonly=TRUE)
      par(mfrow=c(1,2))
      grid.arrange(Type, Type2, ncol=2)
      dev.off()
      
      png("Total Movies & TV Shows available", width = 1280, height = 1280)
      
      dev.off()
      
      png("Netflix Content", width = 1280, height = 1280) 
      init <- par(no.readonly=TRUE)
      par(mfrow=c(1,2))
      
      dev.off() 
      
      png("Distribution of Countries")
      init <- par(no.readonly=TRUE)
      par(mfrow=c(1,2))
      grid.arrange(country, country2, ncol=2)
      dev.off()
```
