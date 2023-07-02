# MovieDataSet

This project was the final project for my regression class at Purdue University. We were tasked with finding a dataset, and then coming up with a few research questions that we thought were interesting. 

Some of the highlights I took from it were the data cleaning as well as one of the research questions I did. 

Data cleaning: 
- The data set that we came in with was a little messy 
- NA values in critical columns
- Bad naming scheme
- Regression needs all numerical columns, and we didn't have that

One of the columns that showed NA values was Metascore. We considered dropping it from the dataset, but we thought we could draw interesting analysis
from keeping it. The approach I took here was checking the distribution of the data first and it looked something like this: <img width="1115" alt="Screen Shot 2023-05-04 at 9 18 24 AM" src="https://user-images.githubusercontent.com/47802441/236216343-ba9b3031-4f3d-41f1-ab4b-e2cefb0abf2b.png">
As you can see, the distribution is somewhat normal. So it was decided that we would continue to sample from a normal distribution using the none NA data to find the mean and standard deviation. The distribution became more normal after this.

Another column that was troublesome was the revenue column, which showed how much revenue in millions a movie brought in. I took a similar approach here by checking 
the distribution first: <img width="1121" alt="Screen Shot 2023-05-04 at 9 20 46 AM" src="https://user-images.githubusercontent.com/47802441/236216920-cc0eeb29-754d-4be3-a21f-be4bdd2de190.png">
As you can see, the data is heavily right skew, so I decided to just randomly sample from the existing data to replace the missing and check that the original distribution didn't deviate too much. 

Another task I completed in data cleaning was ensuring all the encoding was done correctly well as cutting down the number of genres that described each movie. 

Research Question: 

The research question that I decided to do was: Is the impact of rating on the number of votes the same for the top 3 genres of movies? Here is a breakdown of the variables I used: <img width="795" alt="Screen Shot 2023-05-04 at 9 34 28 AM" src="https://user-images.githubusercontent.com/47802441/236220994-6d799926-6167-4eef-8bdb-aa6f86bd0f92.png">

First I did some preliminary analysis on our full model. 
<img width="928" alt="Screen Shot 2023-05-04 at 9 35 12 AM" src="https://user-images.githubusercontent.com/47802441/236221210-3d876e6e-c23a-4909-a673-4ff1b7d1460f.png">
So, we are testing here to see if there is a significant difference between using the full model vs the reduced one. The difference between the reduced and the full is that the full includes the interaction term between our genre and rating. Here is the summary of our model: 
<img width="454" alt="Screen Shot 2023-05-04 at 9 38 10 AM" src="https://user-images.githubusercontent.com/47802441/236222246-11a42059-ae4b-4e8b-bb98-053049c62ad1.png">
The only insight I took from this is that our R^2 is fairly low, and this means that our model is a relatively poor fit. This is something that we can explore later. 

Next, I transitioned into the analysis of some of the issues with our model, and I found that we had a constant variance issue and decided to focus most of my energy on fixing that. Using WLS bootstrapping, which is a method to fix non-constant variance in a model, I was able to bring make a huge difference. <img width="817" alt="Screen Shot 2023-05-04 at 9 41 47 AM" src="https://user-images.githubusercontent.com/47802441/236223490-f046e7af-2180-4f22-ad03-9997be665efc.png">
Our aim here is to make the residuals more constant and centered around zero after bootstrapping, and in this case, WLS worked like a charm. The picture on the left is before the bootstrapping method was applied and the right is after. We can also see an improvement in the QQPlot. 
<img width="830" alt="Screen Shot 2023-05-04 at 9 43 20 AM" src="https://user-images.githubusercontent.com/47802441/236224223-a2972154-285a-409a-a7c2-8f908c566a0b.png">
Conclusion: 

In conclusion, it was found that the impact of rating on the number of votes a movie received was different for the top 3 genres. We had a p-value of less than .05, so we can reject HO in favor of our full model. I would also like to include that we had an RMSE of about 1.5 from k-folds cross-validation, so it is possible that our model has a decent amount of predictive power.


K-Fold cross-validation was also performed on this question. The value of the RMSE was around 1.5 meaning that the prediction power of the model is relatively high given new data. 

Overall, this project was a great experience for me. We were provided little guidance for this project, and we pretty much had to build our models from the ground up. The team aspect of this project was also a challenge. I find that given more time, the more college students take advantage. We took up to the deadline to turn this project in and at times lacked chemistry as a team. This was a practice of perseverance for all of us, and we had to learn to work as a team and find ways we could contribute our unique skills. 

For more of a more detailed look into the whole project, including aspects I personally didn't do, please take a look at our research paper. 
STAT51200_Group_2_Final_Report.pdf


