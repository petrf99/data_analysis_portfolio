# Data Analysis Portfolio
Portfolio project on Data Analysis (SQL, Python, ML, Tableau)

## **Project Overview**
This project is based on **ecommerce data** provided by Olist:  
🔗 [Olist Brazilian E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?resource=download)

## **Project Structure**
The repository consists of the following folders:
1. **`sql_queries/`** – SQL queries, mainly for data preparation.
2. **`notebooks/`** – Jupyter notebooks with the full analysis process.
3. **`data/`** – CSV files downloaded from Kaggle.
4. **`tableau/`** – Tableau visualizations of the results.

---

## **Project Description**

### **1️⃣ Data Exploration & Insights**
The first goal of the project was to explore the dataset and extract insights. See **"Data analysis.ipynb"** for details.  
We found that Olist's current **order delivery time estimation is highly inaccurate**, which can negatively impact customer reviews.

### **2️⃣ Improving Delivery Time Prediction (ML Models)**
To improve the delivery time prediction, we applied standard **Machine Learning algorithms**. See:
- **Dataset preparation & feature analysis** → `Dataset preparation.ipynb`, `Feature Analysis.ipynb`
- **ML Models** → `ML. Linear & Boosting.ipynb`, `ML. Neural Networks.ipynb`

#### **Best Model Performance: Neural Network**
The highest accuracy was achieved using a **Neural Network** with the following architecture:

```python
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

    layers.Dense(1)  # Output layer
])
```

#### **Final Metrics (in days):**
```
MAE: 4.3880  
MSE: 44.3887  
RMSE: 6.6625  
R² Score (log space): 0.4369  
```

### **3️⃣ Final Analysis & Conclusions**
Final results and insights are documented in:
- **`Score analysis.ipynb`** (Jupyter Notebook)
- **`tableau/`** (Tableau visualizations)

#### **Key Findings:**
✅ The model significantly improved overall prediction accuracy.  
✅ For a **3-day prediction window**, our model is **~2× more accurate than the baseline**.  
⚠️ However, **it did not improve accuracy** for problematic cases where **bad reviews and long delays** occurred.  

📌 **Potential Improvement:** Combining the **baseline estimate and our NN predictions** could help better mitigate negative customer experiences.

---

### **Next Steps**
- Experiment with **more advanced ML models** (e.g., Transformers, LSTMs).
- Investigate **customer review sentiment analysis** for further insights.
- Optimize the **business impact** of predictions (e.g., adjusting delivery estimates dynamically).

