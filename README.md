# data_analysis_portfolio
Portfolio project on Data Analysis (SQL, Python, ML, Tableau)

## Project is based on the ecommerce data provided by Olist:
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?resource=download

## In the project you can find several folders:
1. sql_queries -- here you can find sql_queries, mostly related to data preparation
2. notebooks -- Jupyter notebooks containing the whole process
3. data -- csv tables, downloaded from Kaggle
4. tableau -- Tableau visualization of results

## Project description

### The first goal of the project was to discover the data and get some insights (see "Data analysis.ipynb" for details). 
Here we discovered that the current estimation of the order delivery time made by Olist is very inaccurate, can lead to bad customers' reviews.

### The second goal was to improve this prediction using some standart ML algorithms ("ML. Linear & Boosting.ipynb", "ML. Neural Networks.ipynb")
For data preparation and feature extraction/analysis see "Dataset preparation.ipynb", "Feature Analysis.ipynb"
The best model performance was achieved by Neural Network with the following structure:
keras.Sequential([
    layers.Dense(256, input_shape=(X_train.shape[1],)),
    layers.LeakyReLU(alpha=0.1),
    layers.BatchNormalization(),
    layers.Dropout(0.3),

    layers.Dense(128),
    layers.LeakyReLU(alpha=0.1),
    layers.BatchNormalization(),
    layers.Dropout(0.3),

    layers.Dense(64),
    layers.LeakyReLU(alpha=0.1),
    layers.BatchNormalization(),
    layers.Dropout(0.2),

    layers.Dense(32),
    layers.LeakyReLU(alpha=0.1),
    layers.BatchNormalization(),

    layers.Dense(1)  # Outer layer
])

Final metrics (MAE, RMSE calculated in days):
MAE: 4.3880
MSE: 44.3887
RMSE: 6.6625
R² Score (log space): 0.4369

### Final analysis of the results can be found in "Score analysis.ipynb" and in "tableau" folder. 
The main conclusion is that even though we didn't manage to increase accuracy on the problematic set (where bad customers' reviews and long baseline delays took place), overall accuracy increased significantly (for 3-days window our model is ~2 times more accurate than the baseline). Howewer, one could use mean value of baseline and our NN score to better address the problem of bad reviews.
