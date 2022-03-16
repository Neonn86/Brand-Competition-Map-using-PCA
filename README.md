# Brand Competition Map using PCA in R
## Objective:
The goal is to map the competitive lanscape of the car market. So that we can learn:

(1) What car brands are similar?

(2) What can a certain brand do to improve customer preferences.

## Data Source:
The data documents:

(1) Car brands;

(2) Ratings from customers about each attributes e.g. 'Economical', 'Sporty' (range from 1-10);

(3) Overall preference for each brand

## Structure
(1) Use PCA to reduce data dimension.

The number of features are far more than the data observations, it's impossible to fit the regression based on that. So we use PCA to reduce dimension.

(2) Choose the most important factors.

Only remain the factors that can explain the most variance of the data. As a result, we choose 4 out of 17 factors as our final factors. (Eigenvalues > 1)

<img width="468" alt="image" src="https://user-images.githubusercontent.com/98130185/158704878-6767fb8d-f029-4fe1-a0a7-f87cd013ae5e.png">

(3) Map the brand competition landscape.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/98130185/158704355-eee3cc7f-28c5-4a1a-8ee3-8affe0e046da.png">

Take 2 out of the 4 important factors as an example, we name these 2 factor based on their inner feature composition, plot the competition situation based on these two features.

The iso-preference line indicates that all the brands on this line shares the same overall preference.

The ideal vector indicates the improvement direction that companies can adopt to improve their customer recognition.

(4) Use Bootstrap to gain the 95% confidence interval of ideal vector's angles.

## Conclusions:
(1) In the Good Engineer & Economic level, the car brands can be categrized into 4 groups. The brands in the same group indicate the similar ratings from customers perspective.

(2)Infiniti, along with BMW, is the highest preferred brand in the Z1-Z3 space. If Infiniti needs to pull closer to BMW, then it needs to improve along the angle and direction of the ideal vector, i.e. they need to continue focusing on making well-engineered (quiet and well built) and also well-designed (attractive) cars which will add to the popularity (prestige and success) of their brand.

