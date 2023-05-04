# MovieDataSet

This project was a final project for my regression class at Purdue university. We were tasked with finding a dataset, and then coming up with a few research questions that we thought were interesting. 

Some of the highlights I took from it was the data cleaning as well as one of the research questions I did. 

Data cleaning: 
- The data set that we came in with was a little messy 
- NA values in critical columns
- Bad naming scheme
- Regression needs all numerical columns, and we didn't have that

One of the columns that showed NA values was metascore. We considered dropping it from the dataset, but we thought we could draw interesting analysis
from keeping it. The approach I took here was checking the distribution of the data first and it looked something like this: <img width="1115" alt="Screen Shot 2023-05-04 at 9 18 24 AM" src="https://user-images.githubusercontent.com/47802441/236216343-ba9b3031-4f3d-41f1-ab4b-e2cefb0abf2b.png">
As you can see, the distribution is somewhat normal. So it was decided that we would continue to sample from a normal distribution using the none NA data to find mean and standard deviation. The distribution became more normal after this.

Another column that was troublesome was the revenue column, which showed how much revenue in millions a movie brought in. I took a similar approach here by checking 
the distribution first: <img width="1121" alt="Screen Shot 2023-05-04 at 9 20 46 AM" src="https://user-images.githubusercontent.com/47802441/236216920-cc0eeb29-754d-4be3-a21f-be4bdd2de190.png">
As you can see, the data is heavily right skew, so I decided to just randomly sample from the existing data to replace the missing, and check that the original distribution didn't deviate too much. 

Another task I completed in data cleaning was ensuring all the encoding was done correctly well as cuting down the number of genres that described each movie. 

Research Question: 

The research question that I decided to do was: Is the impact of rating on number votes the same for the top 3 genres of movies. Here is a break down of the variables I used: <img width="795" alt="Screen Shot 2023-05-04 at 9 34 28 AM" src="https://user-images.githubusercontent.com/47802441/236220994-6d799926-6167-4eef-8bdb-aa6f86bd0f92.png">

First I did some preliminary analysis on our full model. 
<img width="928" alt="Screen Shot 2023-05-04 at 9 35 12 AM" src="https://user-images.githubusercontent.com/47802441/236221210-3d876e6e-c23a-4909-a673-4ff1b7d1460f.png">
So, we are testing here to see if there is a significant difference between using the full model vs the reduced. The difference between the reduced and the full being that the full includes the interaction term between our genre and rating. Here is the summary of our model: 
<img width="454" alt="Screen Shot 2023-05-04 at 9 38 10 AM" src="https://user-images.githubusercontent.com/47802441/236222246-11a42059-ae4b-4e8b-bb98-053049c62ad1.png">
The only insight I took from this is that our R^2 is fairly low, and this means that our model is a relatively poor fit. This is something that we can explore later. 

Next I transitioned into the analysis of some of the issues with our model, and I found that we had a constant varience issue and decided to focus most of my energy on fixing that. Using WLS boostrapping, which is a method to fix non-constant varience in a model, I was able to bring make a huge difference. <img width="817" alt="Screen Shot 2023-05-04 at 9 41 47 AM" src="https://user-images.githubusercontent.com/47802441/236223490-f046e7af-2180-4f22-ad03-9997be665efc.png">
Our aim here is to make the residuals more constant and centered around zero after boostrapping, and in this case WLS worked like a charm. The picture on the left is before the boostrapping method was applied and the right is after. We can also see the improvement in the QQPlot. 
<img width="830" alt="Screen Shot 2023-05-04 at 9 43 20 AM" src="https://user-images.githubusercontent.com/47802441/236224223-a2972154-285a-409a-a7c2-8f908c566a0b.png">
Conclusion: 

In conclusion, it was found that the impact of rating on the number of votes a movie recieved was different for the top 3 genres. We had a p-value of less than .05, so we can reject HO in favor of our full model. I would also like to include that we had a RMSE of about 1.5 from k-folds cross-validation, so it is possible that our model has a decent amount of predictive power.


