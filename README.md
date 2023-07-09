# Analysis of the state and evolution of telecommunication in Argentina


## Project Structure

The repository is structured as follows:

- [`raw_data`](/raw_data.zip): The raw data used in this project was taken directly from the governmental API, but if there is network problemas in the API server, there is a back-up in the file `raw_data.zip` which is in the root of this repository.
- [`processed_data/`](processed_data/): Contains the transformed and manipulated datasets in CSV format.
- [`notebooks/`](notebooks/): Includes Python notebooks for data cleaning, EDA and visualization. There is also a python script that import the data from the API directly.
- [`img/`](img/): Includes Python figures for data visualization and images used around the repository.

## Procedures




# Tech Summary
- [Pandas](https://pandas.pydata.org/docs/), [NumPy](https://numpy.org/doc/), [ast](https://docs.python.org/3/library/ast.html) are the libraries and modules used to clean the raw dataset.
- [Matplotlib](https://matplotlib.org/stable/index.html), [Seaborn](https://seaborn.pydata.org/), [WordCloud](https://pypi.org/project/wordcloud/) are the libraries used for visualization.
- [Visual Studio Code](https://code.visualstudio.com/) is the code editor used for this project. Data Wrangler extension was also helpful.