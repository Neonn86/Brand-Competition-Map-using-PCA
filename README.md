# Brand Competition Map using PCA in R
## Objective:
The goal is to map the competitive lanscape of the car market. So that we can learn:

• What car brands are similar?

• What can a certain brand do to improve customer preferences.

## Data Source:
The data documents:

• Car brands;

• Ratings from customers about each attributes e.g. 'Economical', 'Sporty' (range from 1-10);

• Overall preference for each brand

## Structure
• Use PCA to reduce data dimension.

The number of features are far more than the data observations, it's impossible to fit the regression based on that. So we use PCA to reduce dimension.

• Choose the most important factors.

Only remain the factors that can explain the most variance of the data. As a result, we choose 4 out of 17 factors as our final factors.

• Map the brand competition landscape.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/98130185/158703182-3685e3e2-6a32-4de4-ab33-8c3288dccbb6.png">

Take 2 out of the 4 important factors as an example, we name these 2 factor based on their inner feature composition, plot the competition situation based on these two features.

The iso-preference line indicates that all the brands on this line shares the same overall preference.
The ideal vector indicates the improvement direction that companies can adopt to improve their customer recognition.

## Recommendations:
