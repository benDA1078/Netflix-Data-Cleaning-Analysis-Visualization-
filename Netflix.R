``` {r}
  glimpse(Netflix)
  table(Netflix$type)
```

```{r}
  png("Movie & TV Shows", width = 1280, height = 1280)
    Netflix %>% 
      count(type) %>%
      ggplot() + geom_col(aes(x = type, y= n, fill = type)) + 
      labs(title = "Movie & TV Shows", subtitle = "Netflix Data", caption = "Data Source: Kaggle, *Shivam Bansal*") + theme_update()
    dev.of()
```

```{r}
png("Total Movies & TV Shows available", width = 1280, height = 1280)
    Netflix %>%
      ggplot(aes(type, fill=type)) + 
      geom_bar() + 
      coord_flip() +
      geom_text(stat = "count", aes(label = ..count..),hjust=1.5) + 
      theme_update()
    dev.off()
```

```{r}

```

```{r}
Netflix2 <- Netflix
Netflix2 <- na.omit(Netflix2)
```

```{r}
Netflix2 %>%
  count(type) %>%
  ggplot() + geom_col(aes(x=type,y=n,fill=type)) + 
  labs(title = "Movies & TV Shows", subtitle = "Netflix Data", caption = "Data Source: Kaggle, *Shivam Bansal*") + 
  theme_update()
```
