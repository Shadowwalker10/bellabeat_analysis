{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "d3145de2",
   "metadata": {
    "papermill": {
     "duration": 0.020186,
     "end_time": "2023-07-13T02:39:53.643248",
     "exception": false,
     "start_time": "2023-07-13T02:39:53.623062",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Reading Each Available Dataset"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "ed63b04d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:39:53.685102Z",
     "iopub.status.busy": "2023-07-13T02:39:53.683186Z",
     "iopub.status.idle": "2023-07-13T02:40:55.080811Z",
     "shell.execute_reply": "2023-07-13T02:40:55.079194Z"
    },
    "papermill": {
     "duration": 61.421884,
     "end_time": "2023-07-13T02:40:55.083742",
     "exception": false,
     "start_time": "2023-07-13T02:39:53.661858",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Installing package into ‘/usr/local/lib/R/site-library’\n",
      "(as ‘lib’ is unspecified)\n",
      "\n",
      "Installing package into ‘/usr/local/lib/R/site-library’\n",
      "(as ‘lib’ is unspecified)\n",
      "\n",
      "Warning message in install.packages(\"magrittr\"):\n",
      "“installation of package ‘magrittr’ had non-zero exit status”\n",
      "Installing package into ‘/usr/local/lib/R/site-library’\n",
      "(as ‘lib’ is unspecified)\n",
      "\n",
      "Installing package into ‘/usr/local/lib/R/site-library’\n",
      "(as ‘lib’ is unspecified)\n",
      "\n"
     ]
    }
   ],
   "source": [
    "install.packages(\"missForest\")\n",
    "install.packages(\"magrittr\")\n",
    "install.packages(\"mice\")\n",
    "install.packages(\"gplots\")\n",
    "options(max.print = 1000)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "28e1762c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:40:55.150408Z",
     "iopub.status.busy": "2023-07-13T02:40:55.127253Z",
     "iopub.status.idle": "2023-07-13T02:40:56.976455Z",
     "shell.execute_reply": "2023-07-13T02:40:56.974900Z"
    },
    "papermill": {
     "duration": 1.872883,
     "end_time": "2023-07-13T02:40:56.978922",
     "exception": false,
     "start_time": "2023-07-13T02:40:55.106039",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\n",
      "Attaching package: ‘dplyr’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:stats’:\n",
      "\n",
      "    filter, lag\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:base’:\n",
      "\n",
      "    intersect, setdiff, setequal, union\n",
      "\n",
      "\n",
      "\n",
      "Attaching package: ‘mice’\n",
      "\n",
      "\n",
      "The following object is masked from ‘package:stats’:\n",
      "\n",
      "    filter\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:base’:\n",
      "\n",
      "    cbind, rbind\n",
      "\n",
      "\n",
      "\n",
      "Attaching package: ‘gplots’\n",
      "\n",
      "\n",
      "The following object is masked from ‘package:stats’:\n",
      "\n",
      "    lowess\n",
      "\n",
      "\n",
      "\n",
      "Attaching package: ‘lubridate’\n",
      "\n",
      "\n",
      "The following object is masked from ‘package:cowplot’:\n",
      "\n",
      "    stamp\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:base’:\n",
      "\n",
      "    date, intersect, setdiff, union\n",
      "\n",
      "\n",
      "\n",
      "Attaching package: ‘magrittr’\n",
      "\n",
      "\n",
      "The following object is masked from ‘package:tidyr’:\n",
      "\n",
      "    extract\n",
      "\n",
      "\n"
     ]
    }
   ],
   "source": [
    "library(cowplot)\n",
    "library(dplyr)\n",
    "library(mice)\n",
    "library(gplots)\n",
    "library(tidyr)\n",
    "library(lubridate)\n",
    "library(ggplot2)\n",
    "library(magrittr)\n",
    "library(missForest)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "f00c178c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:40:57.022707Z",
     "iopub.status.busy": "2023-07-13T02:40:57.021028Z",
     "iopub.status.idle": "2023-07-13T02:40:57.081573Z",
     "shell.execute_reply": "2023-07-13T02:40:57.080116Z"
    },
    "papermill": {
     "duration": 0.08485,
     "end_time": "2023-07-13T02:40:57.083988",
     "exception": false,
     "start_time": "2023-07-13T02:40:56.999138",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 15</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDate</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>FairlyActiveMinutes</th><th scope=col>LightlyActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>25</td><td>13</td><td>328</td><td> 728</td><td>1985</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/13/2016</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>21</td><td>19</td><td>217</td><td> 776</td><td>1797</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/14/2016</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>30</td><td>11</td><td>181</td><td>1218</td><td>1776</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/15/2016</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>29</td><td>34</td><td>209</td><td> 726</td><td>1745</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/16/2016</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>36</td><td>10</td><td>221</td><td> 773</td><td>1863</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/17/2016</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>38</td><td>20</td><td>164</td><td> 539</td><td>1728</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 15\n",
       "\\begin{tabular}{r|lllllllllllllll}\n",
       "  & Id & ActivityDate & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & FairlyActiveMinutes & LightlyActiveMinutes & SedentaryMinutes & Calories\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <int> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & 25 & 13 & 328 &  728 & 1985\\\\\n",
       "\t2 & 1503960366 & 4/13/2016 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & 21 & 19 & 217 &  776 & 1797\\\\\n",
       "\t3 & 1503960366 & 4/14/2016 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & 30 & 11 & 181 & 1218 & 1776\\\\\n",
       "\t4 & 1503960366 & 4/15/2016 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & 29 & 34 & 209 &  726 & 1745\\\\\n",
       "\t5 & 1503960366 & 4/16/2016 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & 36 & 10 & 221 &  773 & 1863\\\\\n",
       "\t6 & 1503960366 & 4/17/2016 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & 38 & 20 & 164 &  539 & 1728\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 15\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDate &lt;chr&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | VeryActiveMinutes &lt;int&gt; | FairlyActiveMinutes &lt;int&gt; | LightlyActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | 25 | 13 | 328 |  728 | 1985 |\n",
       "| 2 | 1503960366 | 4/13/2016 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | 21 | 19 | 217 |  776 | 1797 |\n",
       "| 3 | 1503960366 | 4/14/2016 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | 30 | 11 | 181 | 1218 | 1776 |\n",
       "| 4 | 1503960366 | 4/15/2016 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | 29 | 34 | 209 |  726 | 1745 |\n",
       "| 5 | 1503960366 | 4/16/2016 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | 36 | 10 | 221 |  773 | 1863 |\n",
       "| 6 | 1503960366 | 4/17/2016 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | 38 | 20 | 164 |  539 | 1728 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDate TotalSteps TotalDistance TrackerDistance\n",
       "1 1503960366 4/12/2016    13162      8.50          8.50           \n",
       "2 1503960366 4/13/2016    10735      6.97          6.97           \n",
       "3 1503960366 4/14/2016    10460      6.74          6.74           \n",
       "4 1503960366 4/15/2016     9762      6.28          6.28           \n",
       "5 1503960366 4/16/2016    12669      8.16          8.16           \n",
       "6 1503960366 4/17/2016     9705      6.48          6.48           \n",
       "  LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance\n",
       "1 0                        1.88               0.55                    \n",
       "2 0                        1.57               0.69                    \n",
       "3 0                        2.44               0.40                    \n",
       "4 0                        2.14               1.26                    \n",
       "5 0                        2.71               0.41                    \n",
       "6 0                        3.19               0.78                    \n",
       "  LightActiveDistance SedentaryActiveDistance VeryActiveMinutes\n",
       "1 6.06                0                       25               \n",
       "2 4.71                0                       21               \n",
       "3 3.91                0                       30               \n",
       "4 2.83                0                       29               \n",
       "5 5.04                0                       36               \n",
       "6 2.51                0                       38               \n",
       "  FairlyActiveMinutes LightlyActiveMinutes SedentaryMinutes Calories\n",
       "1 13                  328                   728             1985    \n",
       "2 19                  217                   776             1797    \n",
       "3 11                  181                  1218             1776    \n",
       "4 34                  209                   726             1745    \n",
       "5 10                  221                   773             1863    \n",
       "6 20                  164                   539             1728    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>940</li><li>15</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 940\n",
       "\\item 15\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 940\n",
       "2. 15\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 940  15"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "activity_merged <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv\")\n",
    "head(activity_merged)\n",
    "dim(activity_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "1c8512de",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:40:57.131824Z",
     "iopub.status.busy": "2023-07-13T02:40:57.130399Z",
     "iopub.status.idle": "2023-07-13T02:40:57.164258Z",
     "shell.execute_reply": "2023-07-13T02:40:57.162703Z"
    },
    "papermill": {
     "duration": 0.060709,
     "end_time": "2023-07-13T02:40:57.166820",
     "exception": false,
     "start_time": "2023-07-13T02:40:57.106111",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 15</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDate</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>FairlyActiveMinutes</th><th scope=col>LightlyActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>25</td><td>13</td><td>328</td><td> 728</td><td>1985</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/13/2016</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>21</td><td>19</td><td>217</td><td> 776</td><td>1797</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/14/2016</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>30</td><td>11</td><td>181</td><td>1218</td><td>1776</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/15/2016</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>29</td><td>34</td><td>209</td><td> 726</td><td>1745</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/16/2016</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>36</td><td>10</td><td>221</td><td> 773</td><td>1863</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/17/2016</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>38</td><td>20</td><td>164</td><td> 539</td><td>1728</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 15\n",
       "\\begin{tabular}{r|lllllllllllllll}\n",
       "  & Id & ActivityDate & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & FairlyActiveMinutes & LightlyActiveMinutes & SedentaryMinutes & Calories\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <int> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & 25 & 13 & 328 &  728 & 1985\\\\\n",
       "\t2 & 1503960366 & 04/13/2016 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & 21 & 19 & 217 &  776 & 1797\\\\\n",
       "\t3 & 1503960366 & 04/14/2016 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & 30 & 11 & 181 & 1218 & 1776\\\\\n",
       "\t4 & 1503960366 & 04/15/2016 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & 29 & 34 & 209 &  726 & 1745\\\\\n",
       "\t5 & 1503960366 & 04/16/2016 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & 36 & 10 & 221 &  773 & 1863\\\\\n",
       "\t6 & 1503960366 & 04/17/2016 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & 38 & 20 & 164 &  539 & 1728\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 15\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDate &lt;chr&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | VeryActiveMinutes &lt;int&gt; | FairlyActiveMinutes &lt;int&gt; | LightlyActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | 25 | 13 | 328 |  728 | 1985 |\n",
       "| 2 | 1503960366 | 04/13/2016 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | 21 | 19 | 217 |  776 | 1797 |\n",
       "| 3 | 1503960366 | 04/14/2016 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | 30 | 11 | 181 | 1218 | 1776 |\n",
       "| 4 | 1503960366 | 04/15/2016 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | 29 | 34 | 209 |  726 | 1745 |\n",
       "| 5 | 1503960366 | 04/16/2016 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | 36 | 10 | 221 |  773 | 1863 |\n",
       "| 6 | 1503960366 | 04/17/2016 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | 38 | 20 | 164 |  539 | 1728 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDate TotalSteps TotalDistance TrackerDistance\n",
       "1 1503960366 04/12/2016   13162      8.50          8.50           \n",
       "2 1503960366 04/13/2016   10735      6.97          6.97           \n",
       "3 1503960366 04/14/2016   10460      6.74          6.74           \n",
       "4 1503960366 04/15/2016    9762      6.28          6.28           \n",
       "5 1503960366 04/16/2016   12669      8.16          8.16           \n",
       "6 1503960366 04/17/2016    9705      6.48          6.48           \n",
       "  LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance\n",
       "1 0                        1.88               0.55                    \n",
       "2 0                        1.57               0.69                    \n",
       "3 0                        2.44               0.40                    \n",
       "4 0                        2.14               1.26                    \n",
       "5 0                        2.71               0.41                    \n",
       "6 0                        3.19               0.78                    \n",
       "  LightActiveDistance SedentaryActiveDistance VeryActiveMinutes\n",
       "1 6.06                0                       25               \n",
       "2 4.71                0                       21               \n",
       "3 3.91                0                       30               \n",
       "4 2.83                0                       29               \n",
       "5 5.04                0                       36               \n",
       "6 2.51                0                       38               \n",
       "  FairlyActiveMinutes LightlyActiveMinutes SedentaryMinutes Calories\n",
       "1 13                  328                   728             1985    \n",
       "2 19                  217                   776             1797    \n",
       "3 11                  181                  1218             1776    \n",
       "4 34                  209                   726             1745    \n",
       "5 10                  221                   773             1863    \n",
       "6 20                  164                   539             1728    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "activity_merged$ActivityDate <- as.Date(activity_merged$ActivityDate, \n",
    "                                        format = \"%m/%d/%Y\")\n",
    "activity_merged$ActivityDate <- format(activity_merged$ActivityDate,\n",
    "                                      \"%m/%d/%Y\")\n",
    "head(activity_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "7708c301",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:40:57.213361Z",
     "iopub.status.busy": "2023-07-13T02:40:57.212020Z",
     "iopub.status.idle": "2023-07-13T02:40:57.226158Z",
     "shell.execute_reply": "2023-07-13T02:40:57.224730Z"
    },
    "papermill": {
     "duration": 0.039828,
     "end_time": "2023-07-13T02:40:57.227890",
     "exception": false,
     "start_time": "2023-07-13T02:40:57.188062",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sum(is.na(activity_merged))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "9d81cc91",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:40:57.276084Z",
     "iopub.status.busy": "2023-07-13T02:40:57.274737Z",
     "iopub.status.idle": "2023-07-13T02:40:57.288357Z",
     "shell.execute_reply": "2023-07-13T02:40:57.286808Z"
    },
    "papermill": {
     "duration": 0.039574,
     "end_time": "2023-07-13T02:40:57.290344",
     "exception": false,
     "start_time": "2023-07-13T02:40:57.250770",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "##Renaming the activitydate column to activityday\n",
    "colnames(activity_merged)[2] <- \"ActivityDay\"\n",
    "act_colnames <- names(activity_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "3fc01295",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:40:57.336653Z",
     "iopub.status.busy": "2023-07-13T02:40:57.335256Z",
     "iopub.status.idle": "2023-07-13T02:40:57.347620Z",
     "shell.execute_reply": "2023-07-13T02:40:57.346064Z"
    },
    "papermill": {
     "duration": 0.037102,
     "end_time": "2023-07-13T02:40:57.349507",
     "exception": false,
     "start_time": "2023-07-13T02:40:57.312405",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "##Comapring the similarity of columns in a df with parent dataframe\n",
    "comparecolumns <- function(parent_df,\n",
    "                          df,file_name){\n",
    "    common_cols <- length(intersect(colnames(parent_df), colnames(df)))\n",
    "    if(dim(df)[2]!=common_cols){\n",
    "        cat(file_name,\"didn't match with activity_merged by: \",abs(dim(df)[2]-common_cols), \"columns\\n\")\n",
    "        #return(abs(dim(df)[2]-common_cols))\n",
    "    }\n",
    "}"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "77b33f3c",
   "metadata": {
    "papermill": {
     "duration": 0.02106,
     "end_time": "2023-07-13T02:40:57.391330",
     "exception": false,
     "start_time": "2023-07-13T02:40:57.370270",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "300f7fab",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:40:57.436677Z",
     "iopub.status.busy": "2023-07-13T02:40:57.435315Z",
     "iopub.status.idle": "2023-07-13T02:41:16.698742Z",
     "shell.execute_reply": "2023-07-13T02:41:16.696950Z"
    },
    "papermill": {
     "duration": 19.288973,
     "end_time": "2023-07-13T02:41:16.701606",
     "exception": false,
     "start_time": "2023-07-13T02:40:57.412633",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "dailySteps_merged.csv didn't match with activity_merged by:  1 columns\n",
      "heartrate_seconds_merged.csv didn't match with activity_merged by:  2 columns\n",
      "hourlyCalories_merged.csv didn't match with activity_merged by:  1 columns\n",
      "hourlyIntensities_merged.csv didn't match with activity_merged by:  3 columns\n",
      "hourlySteps_merged.csv didn't match with activity_merged by:  2 columns\n",
      "minuteCaloriesNarrow_merged.csv didn't match with activity_merged by:  1 columns\n",
      "minuteCaloriesWide_merged.csv didn't match with activity_merged by:  61 columns\n",
      "minuteIntensitiesNarrow_merged.csv didn't match with activity_merged by:  2 columns\n",
      "minuteIntensitiesWide_merged.csv didn't match with activity_merged by:  61 columns\n",
      "minuteMETsNarrow_merged.csv didn't match with activity_merged by:  2 columns\n",
      "minuteSleep_merged.csv didn't match with activity_merged by:  3 columns\n",
      "minuteStepsNarrow_merged.csv didn't match with activity_merged by:  2 columns\n",
      "minuteStepsWide_merged.csv didn't match with activity_merged by:  61 columns\n",
      "sleepDay_merged.csv didn't match with activity_merged by:  4 columns\n",
      "weightLogInfo_merged.csv didn't match with activity_merged by:  7 columns\n"
     ]
    }
   ],
   "source": [
    "root_folder <- \"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16\"\n",
    "file_names <- list.files(root_folder)\n",
    "parent_df <- activity_merged\n",
    "for (file in file_names){\n",
    "    if (file!=\"dailyActivity_merged.csv\"){\n",
    "        file_path <- file.path(root_folder, file)\n",
    "        df <- read.csv(file_path)\n",
    "        comparecolumns(parent_df, df, file)\n",
    "        }\n",
    "}"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8bd1fe04",
   "metadata": {
    "papermill": {
     "duration": 0.0227,
     "end_time": "2023-07-13T02:41:16.780499",
     "exception": false,
     "start_time": "2023-07-13T02:41:16.757799",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Data Preparation"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "43d2ac1e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:16.826380Z",
     "iopub.status.busy": "2023-07-13T02:41:16.825115Z",
     "iopub.status.idle": "2023-07-13T02:41:16.835860Z",
     "shell.execute_reply": "2023-07-13T02:41:16.834501Z"
    },
    "papermill": {
     "duration": 0.035243,
     "end_time": "2023-07-13T02:41:16.837467",
     "exception": false,
     "start_time": "2023-07-13T02:41:16.802224",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "## Similarity of Id in ActivityMerged and dataframe\n",
    "diff_find <- function(parent_df, df){\n",
    "    difference = setdiff(parent_df$Id, df$Id)\n",
    "    cat(\"The total number of dissimilar Ids: \", length(difference),\"\\n\")\n",
    "    print(difference)\n",
    "}"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "cacc9ed7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:16.883882Z",
     "iopub.status.busy": "2023-07-13T02:41:16.882225Z",
     "iopub.status.idle": "2023-07-13T02:41:16.912477Z",
     "shell.execute_reply": "2023-07-13T02:41:16.911031Z"
    },
    "papermill": {
     "duration": 0.055841,
     "end_time": "2023-07-13T02:41:16.914422",
     "exception": false,
     "start_time": "2023-07-13T02:41:16.858581",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>StepTotal</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016</td><td>13162</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/13/2016</td><td>10735</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/14/2016</td><td>10460</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/15/2016</td><td> 9762</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/16/2016</td><td>12669</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/17/2016</td><td> 9705</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & ActivityDay & StepTotal\\\\\n",
       "  & <dbl> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 & 13162\\\\\n",
       "\t2 & 1503960366 & 4/13/2016 & 10735\\\\\n",
       "\t3 & 1503960366 & 4/14/2016 & 10460\\\\\n",
       "\t4 & 1503960366 & 4/15/2016 &  9762\\\\\n",
       "\t5 & 1503960366 & 4/16/2016 & 12669\\\\\n",
       "\t6 & 1503960366 & 4/17/2016 &  9705\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | StepTotal &lt;int&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 | 13162 |\n",
       "| 2 | 1503960366 | 4/13/2016 | 10735 |\n",
       "| 3 | 1503960366 | 4/14/2016 | 10460 |\n",
       "| 4 | 1503960366 | 4/15/2016 |  9762 |\n",
       "| 5 | 1503960366 | 4/16/2016 | 12669 |\n",
       "| 6 | 1503960366 | 4/17/2016 |  9705 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay StepTotal\n",
       "1 1503960366 4/12/2016   13162    \n",
       "2 1503960366 4/13/2016   10735    \n",
       "3 1503960366 4/14/2016   10460    \n",
       "4 1503960366 4/15/2016    9762    \n",
       "5 1503960366 4/16/2016   12669    \n",
       "6 1503960366 4/17/2016    9705    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "##Checking dailysteps data\n",
    "dailysteps <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/dailySteps_merged.csv\")\n",
    "head(dailysteps)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8589ff4c",
   "metadata": {
    "papermill": {
     "duration": 0.021397,
     "end_time": "2023-07-13T02:41:16.957383",
     "exception": false,
     "start_time": "2023-07-13T02:41:16.935986",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Activity Merged refers StepTotal in dailysteps as TotalSteps"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "be4e3d54",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:17.002619Z",
     "iopub.status.busy": "2023-07-13T02:41:17.001233Z",
     "iopub.status.idle": "2023-07-13T02:41:17.022559Z",
     "shell.execute_reply": "2023-07-13T02:41:17.021153Z"
    },
    "papermill": {
     "duration": 0.046311,
     "end_time": "2023-07-13T02:41:17.024880",
     "exception": false,
     "start_time": "2023-07-13T02:41:16.978569",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>TotalSteps</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016</td><td>13162</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/13/2016</td><td>10735</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/14/2016</td><td>10460</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/15/2016</td><td> 9762</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/16/2016</td><td>12669</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/17/2016</td><td> 9705</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & ActivityDay & TotalSteps\\\\\n",
       "  & <dbl> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 & 13162\\\\\n",
       "\t2 & 1503960366 & 4/13/2016 & 10735\\\\\n",
       "\t3 & 1503960366 & 4/14/2016 & 10460\\\\\n",
       "\t4 & 1503960366 & 4/15/2016 &  9762\\\\\n",
       "\t5 & 1503960366 & 4/16/2016 & 12669\\\\\n",
       "\t6 & 1503960366 & 4/17/2016 &  9705\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | TotalSteps &lt;int&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 | 13162 |\n",
       "| 2 | 1503960366 | 4/13/2016 | 10735 |\n",
       "| 3 | 1503960366 | 4/14/2016 | 10460 |\n",
       "| 4 | 1503960366 | 4/15/2016 |  9762 |\n",
       "| 5 | 1503960366 | 4/16/2016 | 12669 |\n",
       "| 6 | 1503960366 | 4/17/2016 |  9705 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay TotalSteps\n",
       "1 1503960366 4/12/2016   13162     \n",
       "2 1503960366 4/13/2016   10735     \n",
       "3 1503960366 4/14/2016   10460     \n",
       "4 1503960366 4/15/2016    9762     \n",
       "5 1503960366 4/16/2016   12669     \n",
       "6 1503960366 4/17/2016    9705     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "colnames(dailysteps)[3]<- \"TotalSteps\"\n",
    "head(dailysteps)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "3e18148a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:17.070359Z",
     "iopub.status.busy": "2023-07-13T02:41:17.069001Z",
     "iopub.status.idle": "2023-07-13T02:41:17.081921Z",
     "shell.execute_reply": "2023-07-13T02:41:17.080400Z"
    },
    "papermill": {
     "duration": 0.03761,
     "end_time": "2023-07-13T02:41:17.083687",
     "exception": false,
     "start_time": "2023-07-13T02:41:17.046077",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "The total number of dissimilar Ids:  0 \n",
      "numeric(0)\n"
     ]
    }
   ],
   "source": [
    "diff_find(activity_merged,dailysteps)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "896cf24d",
   "metadata": {
    "papermill": {
     "duration": 0.0217,
     "end_time": "2023-07-13T02:41:17.127265",
     "exception": false,
     "start_time": "2023-07-13T02:41:17.105565",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Checking Heart Rate File"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "54c6a66d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:17.173172Z",
     "iopub.status.busy": "2023-07-13T02:41:17.171897Z",
     "iopub.status.idle": "2023-07-13T02:41:21.667089Z",
     "shell.execute_reply": "2023-07-13T02:41:21.665675Z"
    },
    "papermill": {
     "duration": 4.520668,
     "end_time": "2023-07-13T02:41:21.669335",
     "exception": false,
     "start_time": "2023-07-13T02:41:17.148667",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>Time</th><th scope=col>Value</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>2022484408</td><td>4/12/2016 7:21:00 AM</td><td> 97</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>2022484408</td><td>4/12/2016 7:21:05 AM</td><td>102</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>2022484408</td><td>4/12/2016 7:21:10 AM</td><td>105</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>2022484408</td><td>4/12/2016 7:21:20 AM</td><td>103</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>2022484408</td><td>4/12/2016 7:21:25 AM</td><td>101</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>2022484408</td><td>4/12/2016 7:22:05 AM</td><td> 95</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & Time & Value\\\\\n",
       "  & <dbl> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 2022484408 & 4/12/2016 7:21:00 AM &  97\\\\\n",
       "\t2 & 2022484408 & 4/12/2016 7:21:05 AM & 102\\\\\n",
       "\t3 & 2022484408 & 4/12/2016 7:21:10 AM & 105\\\\\n",
       "\t4 & 2022484408 & 4/12/2016 7:21:20 AM & 103\\\\\n",
       "\t5 & 2022484408 & 4/12/2016 7:21:25 AM & 101\\\\\n",
       "\t6 & 2022484408 & 4/12/2016 7:22:05 AM &  95\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | Time &lt;chr&gt; | Value &lt;int&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 2022484408 | 4/12/2016 7:21:00 AM |  97 |\n",
       "| 2 | 2022484408 | 4/12/2016 7:21:05 AM | 102 |\n",
       "| 3 | 2022484408 | 4/12/2016 7:21:10 AM | 105 |\n",
       "| 4 | 2022484408 | 4/12/2016 7:21:20 AM | 103 |\n",
       "| 5 | 2022484408 | 4/12/2016 7:21:25 AM | 101 |\n",
       "| 6 | 2022484408 | 4/12/2016 7:22:05 AM |  95 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         Time                 Value\n",
       "1 2022484408 4/12/2016 7:21:00 AM  97  \n",
       "2 2022484408 4/12/2016 7:21:05 AM 102  \n",
       "3 2022484408 4/12/2016 7:21:10 AM 105  \n",
       "4 2022484408 4/12/2016 7:21:20 AM 103  \n",
       "5 2022484408 4/12/2016 7:21:25 AM 101  \n",
       "6 2022484408 4/12/2016 7:22:05 AM  95  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "heartrate_seconds <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/heartrate_seconds_merged.csv\")\n",
    "head(heartrate_seconds)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "487c8a15",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:21.716315Z",
     "iopub.status.busy": "2023-07-13T02:41:21.714906Z",
     "iopub.status.idle": "2023-07-13T02:41:23.967698Z",
     "shell.execute_reply": "2023-07-13T02:41:23.966349Z"
    },
    "papermill": {
     "duration": 2.278104,
     "end_time": "2023-07-13T02:41:23.969643",
     "exception": false,
     "start_time": "2023-07-13T02:41:21.691539",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "FALSE"
      ],
      "text/latex": [
       "FALSE"
      ],
      "text/markdown": [
       "FALSE"
      ],
      "text/plain": [
       "[1] FALSE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "TRUE"
      ],
      "text/latex": [
       "TRUE"
      ],
      "text/markdown": [
       "TRUE"
      ],
      "text/plain": [
       "[1] TRUE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "\"1503960366\" %in% heartrate_seconds$Id\n",
    "\"1503960366\" %in% activity_merged$Id"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "4895ef11",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:24.017299Z",
     "iopub.status.busy": "2023-07-13T02:41:24.015943Z",
     "iopub.status.idle": "2023-07-13T02:41:24.546164Z",
     "shell.execute_reply": "2023-07-13T02:41:24.544684Z"
    },
    "papermill": {
     "duration": 0.556134,
     "end_time": "2023-07-13T02:41:24.548103",
     "exception": false,
     "start_time": "2023-07-13T02:41:23.991969",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "The total number of dissimilar Ids:  19 \n",
      " [1] 1503960366 1624580081 1644430081 1844505072 1927972279 2320127002\n",
      " [7] 2873212765 3372868164 3977333714 4057192912 4319703577 4445114986\n",
      "[13] 4702921684 6290855005 7086361926 8053475328 8253242879 8378563200\n",
      "[19] 8583815059\n"
     ]
    }
   ],
   "source": [
    "## finding how many id's dont match in the two dataframes\n",
    "diff_find(activity_merged, heartrate_seconds)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "a9de5976",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:24.597689Z",
     "iopub.status.busy": "2023-07-13T02:41:24.596407Z",
     "iopub.status.idle": "2023-07-13T02:41:27.118627Z",
     "shell.execute_reply": "2023-07-13T02:41:27.116560Z"
    },
    "papermill": {
     "duration": 2.549377,
     "end_time": "2023-07-13T02:41:27.121172",
     "exception": false,
     "start_time": "2023-07-13T02:41:24.571795",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>Time</th><th scope=col>Value</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>2022484408</td><td>04/12/2016</td><td> 97</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>2022484408</td><td>04/12/2016</td><td>102</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>2022484408</td><td>04/12/2016</td><td>105</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>2022484408</td><td>04/12/2016</td><td>103</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>2022484408</td><td>04/12/2016</td><td>101</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>2022484408</td><td>04/12/2016</td><td> 95</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & Time & Value\\\\\n",
       "  & <dbl> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 2022484408 & 04/12/2016 &  97\\\\\n",
       "\t2 & 2022484408 & 04/12/2016 & 102\\\\\n",
       "\t3 & 2022484408 & 04/12/2016 & 105\\\\\n",
       "\t4 & 2022484408 & 04/12/2016 & 103\\\\\n",
       "\t5 & 2022484408 & 04/12/2016 & 101\\\\\n",
       "\t6 & 2022484408 & 04/12/2016 &  95\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | Time &lt;chr&gt; | Value &lt;int&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 2022484408 | 04/12/2016 |  97 |\n",
       "| 2 | 2022484408 | 04/12/2016 | 102 |\n",
       "| 3 | 2022484408 | 04/12/2016 | 105 |\n",
       "| 4 | 2022484408 | 04/12/2016 | 103 |\n",
       "| 5 | 2022484408 | 04/12/2016 | 101 |\n",
       "| 6 | 2022484408 | 04/12/2016 |  95 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         Time       Value\n",
       "1 2022484408 04/12/2016  97  \n",
       "2 2022484408 04/12/2016 102  \n",
       "3 2022484408 04/12/2016 105  \n",
       "4 2022484408 04/12/2016 103  \n",
       "5 2022484408 04/12/2016 101  \n",
       "6 2022484408 04/12/2016  95  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "heartrate_seconds$Time <- as.Date(heartrate_seconds$Time, \n",
    "                                  format = \"%m/%d/%Y\")\n",
    "\n",
    "heartrate_seconds$Time <- format(heartrate_seconds$Time, \"%m/%d/%Y\")\n",
    "head(heartrate_seconds)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "64ef3f57",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:27.169477Z",
     "iopub.status.busy": "2023-07-13T02:41:27.168162Z",
     "iopub.status.idle": "2023-07-13T02:41:27.196922Z",
     "shell.execute_reply": "2023-07-13T02:41:27.195271Z"
    },
    "papermill": {
     "duration": 0.055199,
     "end_time": "2023-07-13T02:41:27.199077",
     "exception": false,
     "start_time": "2023-07-13T02:41:27.143878",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "There are 0 null values in heartrate data."
     ]
    }
   ],
   "source": [
    "cat(\"There are\",sum(is.na(heartrate_seconds)),\"null values in heartrate data.\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "cdc81e94",
   "metadata": {
    "papermill": {
     "duration": 0.02212,
     "end_time": "2023-07-13T02:41:27.243440",
     "exception": false,
     "start_time": "2023-07-13T02:41:27.221320",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Check for Outliers"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "036143cb",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:27.290452Z",
     "iopub.status.busy": "2023-07-13T02:41:27.289315Z",
     "iopub.status.idle": "2023-07-13T02:41:31.459083Z",
     "shell.execute_reply": "2023-07-13T02:41:31.456736Z"
    },
    "papermill": {
     "duration": 4.196408,
     "end_time": "2023-07-13T02:41:31.461782",
     "exception": false,
     "start_time": "2023-07-13T02:41:27.265374",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nO3deZzVdb348e+ZM8ywyiCTiYgaSIhiat2baZq31IcUM1SmWViGpdR1a/NqV80U\nuaVmYWr88ueS+bt2xeWyFEVqhVzNFg1zCVxyXxA3hm1glnN+f4yhKd/v/SDD+X798Hz+0ePM\neUO8+ef44rudUrVaTQAAeOury3sBAAB6h7ADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIhEfd4L9IKurq6VK1fmvQWwZRk0aFBdXd3atWvXrVuX9y7AlmXIkCFpoxjCrlqtdnd3\n570FsGUplUp1dXVJkvj8AYrDqVgAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgI\nOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBI\nCDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIO4A3\n4/777//2t7+9du3avBcBeFWpWq3mvcOm6uzsbGtry3sLYEtxzDHHPPXUU69958QTT5wwYUJe\n+wBbmubm5rSRI3YAG+FTn/rU66ouSZKLL77497//fS77ALyWsAPYCMuXL9/g+2effXaNNwF4\nI2EHECqj3iK4rAWIgLADCPXkk0+mjUqlUi03AdggYQcQap999kkbOWIHFIGwAwj1hS98IW3k\niB1QBMIOINTChQvTRsIOKAJhBxBq0aJFaSOnYoEiEHYAoUaMGJH3CgBZhB1AqEMPPTRtNGDA\ngFpuArBBwg4g1KpVq9JGu+66ay03Adig+tr8MdWul2dddukvf/eXF9fWDRsxeuJnv3TIXtsm\nSZIklQXXzvjZwj8/ubK8y7j3Tj7x6JH916+UMQLIwbPPPps2Wrp0aS03AdigGh2xu+nbJ19z\n63MTjz7pvHNO/dCodTPOOn72k6uSJHnkxjOmz7zjfYce+62vHDXwb78+/auXVv7+WzJGALlo\naGjY4PulUqmxsbHGywC8US3Crnvdkz+664X9v3lm64f2Gb3Luz5x/LcPbirPnnFfUu34/szF\noz499fCD9tntPft/+fwTVj/7q2ueXp0kSdYIICfbb7/9Bt+vVqvCDiiCWpzc7F772I7veMdH\n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\nt3c//uLDd17+3dMO2Kn7movOmrDvLkN23OuYU87drCsCABAiNOzW23rUe75w8n/M+93il/72\n28n777Diibuv+O6/b47NAADYKKHfFbtepfPlW+feOHPmzBvn/PaFju668qB9Jxy2OTYDAGCj\nhIZdtXvl7fP+e+bMmTfMunlpe1ep1Gf3Az528qRJnz6idYet+mzWFQEACPG/hF21suaPv5o9\nc+bM6//7l0+t7EySZKd3H3zapEmTPv3J3bbrX5MNAQAIkhV2px572PU3/PzR5euSJBk6eu8T\nvjpp0qRJ+4xprtVuAABshKywO//yG/tvu+tRX/n0pEmTDvnnkTXbCQCANyEr7K67ZdHHPrSn\n75YAAHhLyAq7ww/cs2Z7AACwiTb6OXYAABSTsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiER9jf+8q/71c32n/uhTb+v39zcqC66d8bOFf35yZXmXce+dfOLR\nI/vXB4wAAHi9Wh6xqz70P5fPemZ5V7W6/q1Hbjxj+sw73nfosd/6ylED//br0796aSVgBADA\nG9XoGNiyOy489eLbXlzV8Q/vVju+P3PxqE9fcPhBo5Ik2fn80uFHnX/N05M/O3xA1ggAgA2p\n0RG7pt0OP33quRecd+pr31zXtvCJtd0HHzy858fGpv32Gthw14Kl2SMAADaoRkfsGrYavvNW\nSXdH39e+2bH6niRJdu3fZ/07Y/vXz7+nLTkya9RjypQpDz/8cM/rcePG/eAHP9jMfwOAf1Aq\nlZIkKZfLQ4cOzXsXYAvS3d2dMc3zdoTKutVJkgytf/WoYXOfcteqtdmjHmvWrFmxYsX61z2f\nsAC15/MHqKXsz5w8w66uoV+SJC93VQaWyz3vvNjZXW5qyB71OOKII1566aZHjXsAAA2pSURB\n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\nrkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(heartrate_seconds, aes(x = \"\", y = Value))+geom_boxplot()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "273b2856",
   "metadata": {
    "papermill": {
     "duration": 0.022204,
     "end_time": "2023-07-13T02:41:31.506469",
     "exception": false,
     "start_time": "2023-07-13T02:41:31.484265",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "There a huge number of outlier present. So, we are going to calculate median instedd of mean."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "b38743b1",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:31.554261Z",
     "iopub.status.busy": "2023-07-13T02:41:31.552973Z",
     "iopub.status.idle": "2023-07-13T02:41:31.734988Z",
     "shell.execute_reply": "2023-07-13T02:41:31.733109Z"
    },
    "papermill": {
     "duration": 0.208452,
     "end_time": "2023-07-13T02:41:31.737198",
     "exception": false,
     "start_time": "2023-07-13T02:41:31.528746",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'Id'. You can override using the `.groups`\n",
      "argument.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Id</th><th scope=col>Time</th><th scope=col>Median_Value</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>2022484408</td><td>04/12/2016</td><td>72</td></tr>\n",
       "\t<tr><td>2022484408</td><td>04/13/2016</td><td>76</td></tr>\n",
       "\t<tr><td>2022484408</td><td>04/14/2016</td><td>70</td></tr>\n",
       "\t<tr><td>2022484408</td><td>04/15/2016</td><td>76</td></tr>\n",
       "\t<tr><td>2022484408</td><td>04/16/2016</td><td>71</td></tr>\n",
       "\t<tr><td>2022484408</td><td>04/17/2016</td><td>80</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 6 × 3\n",
       "\\begin{tabular}{lll}\n",
       " Id & Time & Median\\_Value\\\\\n",
       " <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 2022484408 & 04/12/2016 & 72\\\\\n",
       "\t 2022484408 & 04/13/2016 & 76\\\\\n",
       "\t 2022484408 & 04/14/2016 & 70\\\\\n",
       "\t 2022484408 & 04/15/2016 & 76\\\\\n",
       "\t 2022484408 & 04/16/2016 & 71\\\\\n",
       "\t 2022484408 & 04/17/2016 & 80\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 6 × 3\n",
       "\n",
       "| Id &lt;dbl&gt; | Time &lt;chr&gt; | Median_Value &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 2022484408 | 04/12/2016 | 72 |\n",
       "| 2022484408 | 04/13/2016 | 76 |\n",
       "| 2022484408 | 04/14/2016 | 70 |\n",
       "| 2022484408 | 04/15/2016 | 76 |\n",
       "| 2022484408 | 04/16/2016 | 71 |\n",
       "| 2022484408 | 04/17/2016 | 80 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         Time       Median_Value\n",
       "1 2022484408 04/12/2016 72          \n",
       "2 2022484408 04/13/2016 76          \n",
       "3 2022484408 04/14/2016 70          \n",
       "4 2022484408 04/15/2016 76          \n",
       "5 2022484408 04/16/2016 71          \n",
       "6 2022484408 04/17/2016 80          "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#### Finding average heart rate for each id\n",
    "average_heart_rate <- heartrate_seconds%>%\n",
    "group_by(Id,Time)%>%\n",
    "summarise(Median_Value = median(Value))\n",
    "head(average_heart_rate)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "4b333a25",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:31.785348Z",
     "iopub.status.busy": "2023-07-13T02:41:31.784069Z",
     "iopub.status.idle": "2023-07-13T02:41:31.798898Z",
     "shell.execute_reply": "2023-07-13T02:41:31.797203Z"
    },
    "papermill": {
     "duration": 0.041403,
     "end_time": "2023-07-13T02:41:31.800986",
     "exception": false,
     "start_time": "2023-07-13T02:41:31.759583",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sum(is.na(average_heart_rate))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "49fb50d5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:31.850424Z",
     "iopub.status.busy": "2023-07-13T02:41:31.849018Z",
     "iopub.status.idle": "2023-07-13T02:41:31.861126Z",
     "shell.execute_reply": "2023-07-13T02:41:31.859722Z"
    },
    "papermill": {
     "duration": 0.040099,
     "end_time": "2023-07-13T02:41:31.863472",
     "exception": false,
     "start_time": "2023-07-13T02:41:31.823373",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "colnames(average_heart_rate)[2] <- \"ActivityDay\""
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "id": "edf90904",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:31.913443Z",
     "iopub.status.busy": "2023-07-13T02:41:31.912065Z",
     "iopub.status.idle": "2023-07-13T02:41:31.929182Z",
     "shell.execute_reply": "2023-07-13T02:41:31.927928Z"
    },
    "papermill": {
     "duration": 0.044954,
     "end_time": "2023-07-13T02:41:31.931037",
     "exception": false,
     "start_time": "2023-07-13T02:41:31.886083",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>940</li><li>15</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 940\n",
       "\\item 15\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 940\n",
       "2. 15\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 940  15"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>334</li><li>3</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 334\n",
       "\\item 3\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 334\n",
       "2. 3\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 334   3"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "dim(activity_merged)\n",
    "dim(average_heart_rate)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "id": "63c2321c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:31.981631Z",
     "iopub.status.busy": "2023-07-13T02:41:31.980152Z",
     "iopub.status.idle": "2023-07-13T02:41:32.019573Z",
     "shell.execute_reply": "2023-07-13T02:41:32.018126Z"
    },
    "papermill": {
     "duration": 0.067385,
     "end_time": "2023-07-13T02:41:32.021489",
     "exception": false,
     "start_time": "2023-07-13T02:41:31.954104",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 16</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>FairlyActiveMinutes</th><th scope=col>LightlyActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Value</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>25</td><td>13</td><td>328</td><td> 728</td><td>1985</td><td>NA</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/13/2016</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>21</td><td>19</td><td>217</td><td> 776</td><td>1797</td><td>NA</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/14/2016</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>30</td><td>11</td><td>181</td><td>1218</td><td>1776</td><td>NA</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/15/2016</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>29</td><td>34</td><td>209</td><td> 726</td><td>1745</td><td>NA</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/16/2016</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>36</td><td>10</td><td>221</td><td> 773</td><td>1863</td><td>NA</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/17/2016</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>38</td><td>20</td><td>164</td><td> 539</td><td>1728</td><td>NA</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 16\n",
       "\\begin{tabular}{r|llllllllllllllll}\n",
       "  & Id & ActivityDay & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & FairlyActiveMinutes & LightlyActiveMinutes & SedentaryMinutes & Calories & Median\\_Value\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <int> & <int> & <int> & <int> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & 25 & 13 & 328 &  728 & 1985 & NA\\\\\n",
       "\t2 & 1503960366 & 04/13/2016 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & 21 & 19 & 217 &  776 & 1797 & NA\\\\\n",
       "\t3 & 1503960366 & 04/14/2016 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & 30 & 11 & 181 & 1218 & 1776 & NA\\\\\n",
       "\t4 & 1503960366 & 04/15/2016 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & 29 & 34 & 209 &  726 & 1745 & NA\\\\\n",
       "\t5 & 1503960366 & 04/16/2016 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & 36 & 10 & 221 &  773 & 1863 & NA\\\\\n",
       "\t6 & 1503960366 & 04/17/2016 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & 38 & 20 & 164 &  539 & 1728 & NA\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 16\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | VeryActiveMinutes &lt;int&gt; | FairlyActiveMinutes &lt;int&gt; | LightlyActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | Median_Value &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | 25 | 13 | 328 |  728 | 1985 | NA |\n",
       "| 2 | 1503960366 | 04/13/2016 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | 21 | 19 | 217 |  776 | 1797 | NA |\n",
       "| 3 | 1503960366 | 04/14/2016 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | 30 | 11 | 181 | 1218 | 1776 | NA |\n",
       "| 4 | 1503960366 | 04/15/2016 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | 29 | 34 | 209 |  726 | 1745 | NA |\n",
       "| 5 | 1503960366 | 04/16/2016 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | 36 | 10 | 221 |  773 | 1863 | NA |\n",
       "| 6 | 1503960366 | 04/17/2016 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | 38 | 20 | 164 |  539 | 1728 | NA |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay TotalSteps TotalDistance TrackerDistance\n",
       "1 1503960366 04/12/2016  13162      8.50          8.50           \n",
       "2 1503960366 04/13/2016  10735      6.97          6.97           \n",
       "3 1503960366 04/14/2016  10460      6.74          6.74           \n",
       "4 1503960366 04/15/2016   9762      6.28          6.28           \n",
       "5 1503960366 04/16/2016  12669      8.16          8.16           \n",
       "6 1503960366 04/17/2016   9705      6.48          6.48           \n",
       "  LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance\n",
       "1 0                        1.88               0.55                    \n",
       "2 0                        1.57               0.69                    \n",
       "3 0                        2.44               0.40                    \n",
       "4 0                        2.14               1.26                    \n",
       "5 0                        2.71               0.41                    \n",
       "6 0                        3.19               0.78                    \n",
       "  LightActiveDistance SedentaryActiveDistance VeryActiveMinutes\n",
       "1 6.06                0                       25               \n",
       "2 4.71                0                       21               \n",
       "3 3.91                0                       30               \n",
       "4 2.83                0                       29               \n",
       "5 5.04                0                       36               \n",
       "6 2.51                0                       38               \n",
       "  FairlyActiveMinutes LightlyActiveMinutes SedentaryMinutes Calories\n",
       "1 13                  328                   728             1985    \n",
       "2 19                  217                   776             1797    \n",
       "3 11                  181                  1218             1776    \n",
       "4 34                  209                   726             1745    \n",
       "5 10                  221                   773             1863    \n",
       "6 20                  164                   539             1728    \n",
       "  Median_Value\n",
       "1 NA          \n",
       "2 NA          \n",
       "3 NA          \n",
       "4 NA          \n",
       "5 NA          \n",
       "6 NA          "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>940</li><li>16</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 940\n",
       "\\item 16\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 940\n",
       "2. 16\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 940  16"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "new_activity_merged <- merge(activity_merged, average_heart_rate, by = c(\"Id\",\"ActivityDay\"), all = TRUE)\n",
    "head(new_activity_merged)\n",
    "dim(new_activity_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "id": "513d3271",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:32.074177Z",
     "iopub.status.busy": "2023-07-13T02:41:32.072731Z",
     "iopub.status.idle": "2023-07-13T02:41:32.086723Z",
     "shell.execute_reply": "2023-07-13T02:41:32.085307Z"
    },
    "papermill": {
     "duration": 0.042703,
     "end_time": "2023-07-13T02:41:32.089181",
     "exception": false,
     "start_time": "2023-07-13T02:41:32.046478",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "606"
      ],
      "text/latex": [
       "606"
      ],
      "text/markdown": [
       "606"
      ],
      "text/plain": [
       "[1] 606"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sum(is.na(new_activity_merged))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "b5fbdd5f",
   "metadata": {
    "papermill": {
     "duration": 0.02433,
     "end_time": "2023-07-13T02:41:32.138323",
     "exception": false,
     "start_time": "2023-07-13T02:41:32.113993",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Checking Hourly Calories File"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "id": "ebebd09f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:32.189671Z",
     "iopub.status.busy": "2023-07-13T02:41:32.188324Z",
     "iopub.status.idle": "2023-07-13T02:41:32.239860Z",
     "shell.execute_reply": "2023-07-13T02:41:32.237683Z"
    },
    "papermill": {
     "duration": 0.080388,
     "end_time": "2023-07-13T02:41:32.242696",
     "exception": false,
     "start_time": "2023-07-13T02:41:32.162308",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityHour</th><th scope=col>Calories</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016 12:00:00 AM</td><td>81</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/12/2016 1:00:00 AM </td><td>61</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/12/2016 2:00:00 AM </td><td>59</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/12/2016 3:00:00 AM </td><td>47</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/12/2016 4:00:00 AM </td><td>48</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/12/2016 5:00:00 AM </td><td>48</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & ActivityHour & Calories\\\\\n",
       "  & <dbl> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 12:00:00 AM & 81\\\\\n",
       "\t2 & 1503960366 & 4/12/2016 1:00:00 AM  & 61\\\\\n",
       "\t3 & 1503960366 & 4/12/2016 2:00:00 AM  & 59\\\\\n",
       "\t4 & 1503960366 & 4/12/2016 3:00:00 AM  & 47\\\\\n",
       "\t5 & 1503960366 & 4/12/2016 4:00:00 AM  & 48\\\\\n",
       "\t6 & 1503960366 & 4/12/2016 5:00:00 AM  & 48\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityHour &lt;chr&gt; | Calories &lt;int&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 12:00:00 AM | 81 |\n",
       "| 2 | 1503960366 | 4/12/2016 1:00:00 AM  | 61 |\n",
       "| 3 | 1503960366 | 4/12/2016 2:00:00 AM  | 59 |\n",
       "| 4 | 1503960366 | 4/12/2016 3:00:00 AM  | 47 |\n",
       "| 5 | 1503960366 | 4/12/2016 4:00:00 AM  | 48 |\n",
       "| 6 | 1503960366 | 4/12/2016 5:00:00 AM  | 48 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityHour          Calories\n",
       "1 1503960366 4/12/2016 12:00:00 AM 81      \n",
       "2 1503960366 4/12/2016 1:00:00 AM  61      \n",
       "3 1503960366 4/12/2016 2:00:00 AM  59      \n",
       "4 1503960366 4/12/2016 3:00:00 AM  47      \n",
       "5 1503960366 4/12/2016 4:00:00 AM  48      \n",
       "6 1503960366 4/12/2016 5:00:00 AM  48      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "hourly_calories <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/hourlyCalories_merged.csv\")\n",
    "head(hourly_calories)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 26,
   "id": "683b869b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:32.295985Z",
     "iopub.status.busy": "2023-07-13T02:41:32.294702Z",
     "iopub.status.idle": "2023-07-13T02:41:32.310018Z",
     "shell.execute_reply": "2023-07-13T02:41:32.308249Z"
    },
    "papermill": {
     "duration": 0.043438,
     "end_time": "2023-07-13T02:41:32.312051",
     "exception": false,
     "start_time": "2023-07-13T02:41:32.268613",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "The total number of dissimilar Ids:  0 \n",
      "numeric(0)\n"
     ]
    }
   ],
   "source": [
    "diff_find(activity_merged, hourly_calories)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 27,
   "id": "ea806ec8",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:32.364257Z",
     "iopub.status.busy": "2023-07-13T02:41:32.362889Z",
     "iopub.status.idle": "2023-07-13T02:41:32.397941Z",
     "shell.execute_reply": "2023-07-13T02:41:32.396666Z"
    },
    "papermill": {
     "duration": 0.063119,
     "end_time": "2023-07-13T02:41:32.399848",
     "exception": false,
     "start_time": "2023-07-13T02:41:32.336729",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityHour</th><th scope=col>Calories</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>81</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/12/2016</td><td>61</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/12/2016</td><td>59</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/12/2016</td><td>47</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/12/2016</td><td>48</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/12/2016</td><td>48</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & ActivityHour & Calories\\\\\n",
       "  & <dbl> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 81\\\\\n",
       "\t2 & 1503960366 & 04/12/2016 & 61\\\\\n",
       "\t3 & 1503960366 & 04/12/2016 & 59\\\\\n",
       "\t4 & 1503960366 & 04/12/2016 & 47\\\\\n",
       "\t5 & 1503960366 & 04/12/2016 & 48\\\\\n",
       "\t6 & 1503960366 & 04/12/2016 & 48\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityHour &lt;chr&gt; | Calories &lt;int&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 81 |\n",
       "| 2 | 1503960366 | 04/12/2016 | 61 |\n",
       "| 3 | 1503960366 | 04/12/2016 | 59 |\n",
       "| 4 | 1503960366 | 04/12/2016 | 47 |\n",
       "| 5 | 1503960366 | 04/12/2016 | 48 |\n",
       "| 6 | 1503960366 | 04/12/2016 | 48 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityHour Calories\n",
       "1 1503960366 04/12/2016   81      \n",
       "2 1503960366 04/12/2016   61      \n",
       "3 1503960366 04/12/2016   59      \n",
       "4 1503960366 04/12/2016   47      \n",
       "5 1503960366 04/12/2016   48      \n",
       "6 1503960366 04/12/2016   48      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "hourly_calories$ActivityHour <- as.Date(hourly_calories$ActivityHour, format = \"%m/%d/%Y\")\n",
    "hourly_calories$ActivityHour <- format(hourly_calories$ActivityHour, \"%m/%d/%Y\")\n",
    "head(hourly_calories)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 28,
   "id": "ba93ccd2",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:32.452038Z",
     "iopub.status.busy": "2023-07-13T02:41:32.450542Z",
     "iopub.status.idle": "2023-07-13T02:41:32.718537Z",
     "shell.execute_reply": "2023-07-13T02:41:32.717159Z"
    },
    "papermill": {
     "duration": 0.29645,
     "end_time": "2023-07-13T02:41:32.720448",
     "exception": false,
     "start_time": "2023-07-13T02:41:32.423998",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\ntKBpyMgjzz9jl97vnDy0oufDi7dfcsUtr5xwzrmnNnTdM/eqiz/TeePcc1xgBGJUXl5uKTug\nlBWj2HV3LL3mibX7f/M7R+7SEATBjtN2W/H4cb+++qljvjVz9aIN9dP32WefXfr+TLbz8lue\n2f7j3/nIQdsHQbDDZeFHTrrsxmUnnzi+tgiBAXKy3AlQ4opxCay7/eXJ2257+HbD3jwQzhhe\nlW7aGATBgg0dDTPqu9s2rFzdtPkzyR3Nj7za3n3wweN7vqyqnzWjrvKJh1YWIS1APm7FAiWu\nGFfsKofv973v7df7ZXrj4uuWb5x8yk5BEMzfmM4+OuejVy5OZ7PltaMO+cT5Zx25exAEnZsW\nBkEwvaai96d2rim/b2FzcPwbX1533XUrV77R88aNG/exj32sCL8IMMgVvmJXV1dXtCTAoFX4\nRFTs1xFe+eu9c75/XXq7wy4+dEJ357KNZRVTGvf59o1frc+2/O+91/3Xjy6p2vGGk6fVZzo2\nBUEwsvytC4qNFWVdG9t7v3zwwQcXL17c83nPPfc8+eSTi/t7AINRWVlZgWl1dXXRkgCDVnd3\nd4Fp8Ypd5/ol110557fz1+3/4U994xPvrw7DoGz8rbfe+ua8ar/jvvDsfU88+OOnTv7OrFTl\nkCAI1ndl6t48jb6e7i6rr+z9r2277ba990QmTZrU1dVVtF8EGLQKn0+diIAiyGQyBf7ILFKx\na3nlD5/7/A/Kdjvssh+dtFNj3j9qZ4wZ8sC6NUEQVNTuFgSPLGnrmlj1RvTn2rqGz6rv/c6v\nfe1rvZ/T6XRTU9NWyw7whsILFDsRAcXR2NiYb1SMlyeymdZvXHh11b/OvvrSMzdvdU3PXnXa\n6ees7Oy9VZx5eHlr/fSpQRBU1x84rrLsd4+u7hmkNy14vKXzXQdtU4S0APnU1NTEHQGgkGJc\nsWtdfeOi1vQpu9U88de/vvUPD9lh952OG9l69oVfnnvuJ95fH7Y9cf/PH9k09NLTpwZBEISV\nn//wtH+//ssPjP3CLg3p31z13Zqx/3rSBA8mA3GypRhQ4sIinKdWPnrxmZc92efgsIn/8fOr\nZnasf/on19z42N+eay8but2Oux5z6pl7T3qzvWW777/he7fc//jr7eH2e+x/9mfP2KE2dw1N\np9PNzc1b9VcACILguOOOK3C2ue+++4oZBhi0CtyKLUax29oUO6A4PvnJT65atSrfVLEDiiPm\n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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "ggplot(hourly_calories, aes(x = \"\", y = Calories))+geom_boxplot()"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d96e1b65",
   "metadata": {
    "papermill": {
     "duration": 0.02433,
     "end_time": "2023-07-13T02:41:32.769099",
     "exception": false,
     "start_time": "2023-07-13T02:41:32.744769",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "There are a lot of outliers, so considering mean calories is not a safe option. Thus considering median."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 29,
   "id": "4d8fd395",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:32.821245Z",
     "iopub.status.busy": "2023-07-13T02:41:32.819842Z",
     "iopub.status.idle": "2023-07-13T02:41:32.915889Z",
     "shell.execute_reply": "2023-07-13T02:41:32.914602Z"
    },
    "papermill": {
     "duration": 0.12422,
     "end_time": "2023-07-13T02:41:32.917909",
     "exception": false,
     "start_time": "2023-07-13T02:41:32.793689",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'Id'. You can override using the `.groups`\n",
      "argument.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Id</th><th scope=col>ActivityHour</th><th scope=col>Median_Hourly_Calorie</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>1503960366</td><td>04/12/2016</td><td>76.0</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/13/2016</td><td>71.5</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/14/2016</td><td>62.5</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/15/2016</td><td>59.5</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/16/2016</td><td>63.5</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/17/2016</td><td>53.5</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 6 × 3\n",
       "\\begin{tabular}{lll}\n",
       " Id & ActivityHour & Median\\_Hourly\\_Calorie\\\\\n",
       " <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 1503960366 & 04/12/2016 & 76.0\\\\\n",
       "\t 1503960366 & 04/13/2016 & 71.5\\\\\n",
       "\t 1503960366 & 04/14/2016 & 62.5\\\\\n",
       "\t 1503960366 & 04/15/2016 & 59.5\\\\\n",
       "\t 1503960366 & 04/16/2016 & 63.5\\\\\n",
       "\t 1503960366 & 04/17/2016 & 53.5\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 6 × 3\n",
       "\n",
       "| Id &lt;dbl&gt; | ActivityHour &lt;chr&gt; | Median_Hourly_Calorie &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 1503960366 | 04/12/2016 | 76.0 |\n",
       "| 1503960366 | 04/13/2016 | 71.5 |\n",
       "| 1503960366 | 04/14/2016 | 62.5 |\n",
       "| 1503960366 | 04/15/2016 | 59.5 |\n",
       "| 1503960366 | 04/16/2016 | 63.5 |\n",
       "| 1503960366 | 04/17/2016 | 53.5 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityHour Median_Hourly_Calorie\n",
       "1 1503960366 04/12/2016   76.0                 \n",
       "2 1503960366 04/13/2016   71.5                 \n",
       "3 1503960366 04/14/2016   62.5                 \n",
       "4 1503960366 04/15/2016   59.5                 \n",
       "5 1503960366 04/16/2016   63.5                 \n",
       "6 1503960366 04/17/2016   53.5                 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "average_hourly_calories <- hourly_calories%>%\n",
    "group_by(Id,ActivityHour)%>%\n",
    "summarise(Median_Hourly_Calorie = median(Calories))\n",
    "\n",
    "head(average_hourly_calories)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 30,
   "id": "230fc926",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:32.970966Z",
     "iopub.status.busy": "2023-07-13T02:41:32.969624Z",
     "iopub.status.idle": "2023-07-13T02:41:33.009653Z",
     "shell.execute_reply": "2023-07-13T02:41:33.008353Z"
    },
    "papermill": {
     "duration": 0.068765,
     "end_time": "2023-07-13T02:41:33.011547",
     "exception": false,
     "start_time": "2023-07-13T02:41:32.942782",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 17</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>FairlyActiveMinutes</th><th scope=col>LightlyActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Value</th><th scope=col>Median_Hourly_Calorie</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>25</td><td>13</td><td>328</td><td> 728</td><td>1985</td><td>NA</td><td>76.0</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/13/2016</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>21</td><td>19</td><td>217</td><td> 776</td><td>1797</td><td>NA</td><td>71.5</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/14/2016</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>30</td><td>11</td><td>181</td><td>1218</td><td>1776</td><td>NA</td><td>62.5</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/15/2016</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>29</td><td>34</td><td>209</td><td> 726</td><td>1745</td><td>NA</td><td>59.5</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/16/2016</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>36</td><td>10</td><td>221</td><td> 773</td><td>1863</td><td>NA</td><td>63.5</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/17/2016</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>38</td><td>20</td><td>164</td><td> 539</td><td>1728</td><td>NA</td><td>53.5</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 17\n",
       "\\begin{tabular}{r|lllllllllllllllll}\n",
       "  & Id & ActivityDay & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & FairlyActiveMinutes & LightlyActiveMinutes & SedentaryMinutes & Calories & Median\\_Value & Median\\_Hourly\\_Calorie\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <int> & <int> & <int> & <int> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & 25 & 13 & 328 &  728 & 1985 & NA & 76.0\\\\\n",
       "\t2 & 1503960366 & 04/13/2016 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & 21 & 19 & 217 &  776 & 1797 & NA & 71.5\\\\\n",
       "\t3 & 1503960366 & 04/14/2016 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & 30 & 11 & 181 & 1218 & 1776 & NA & 62.5\\\\\n",
       "\t4 & 1503960366 & 04/15/2016 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & 29 & 34 & 209 &  726 & 1745 & NA & 59.5\\\\\n",
       "\t5 & 1503960366 & 04/16/2016 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & 36 & 10 & 221 &  773 & 1863 & NA & 63.5\\\\\n",
       "\t6 & 1503960366 & 04/17/2016 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & 38 & 20 & 164 &  539 & 1728 & NA & 53.5\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 17\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | VeryActiveMinutes &lt;int&gt; | FairlyActiveMinutes &lt;int&gt; | LightlyActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | Median_Value &lt;dbl&gt; | Median_Hourly_Calorie &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | 25 | 13 | 328 |  728 | 1985 | NA | 76.0 |\n",
       "| 2 | 1503960366 | 04/13/2016 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | 21 | 19 | 217 |  776 | 1797 | NA | 71.5 |\n",
       "| 3 | 1503960366 | 04/14/2016 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | 30 | 11 | 181 | 1218 | 1776 | NA | 62.5 |\n",
       "| 4 | 1503960366 | 04/15/2016 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | 29 | 34 | 209 |  726 | 1745 | NA | 59.5 |\n",
       "| 5 | 1503960366 | 04/16/2016 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | 36 | 10 | 221 |  773 | 1863 | NA | 63.5 |\n",
       "| 6 | 1503960366 | 04/17/2016 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | 38 | 20 | 164 |  539 | 1728 | NA | 53.5 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay TotalSteps TotalDistance TrackerDistance\n",
       "1 1503960366 04/12/2016  13162      8.50          8.50           \n",
       "2 1503960366 04/13/2016  10735      6.97          6.97           \n",
       "3 1503960366 04/14/2016  10460      6.74          6.74           \n",
       "4 1503960366 04/15/2016   9762      6.28          6.28           \n",
       "5 1503960366 04/16/2016  12669      8.16          8.16           \n",
       "6 1503960366 04/17/2016   9705      6.48          6.48           \n",
       "  LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance\n",
       "1 0                        1.88               0.55                    \n",
       "2 0                        1.57               0.69                    \n",
       "3 0                        2.44               0.40                    \n",
       "4 0                        2.14               1.26                    \n",
       "5 0                        2.71               0.41                    \n",
       "6 0                        3.19               0.78                    \n",
       "  LightActiveDistance SedentaryActiveDistance VeryActiveMinutes\n",
       "1 6.06                0                       25               \n",
       "2 4.71                0                       21               \n",
       "3 3.91                0                       30               \n",
       "4 2.83                0                       29               \n",
       "5 5.04                0                       36               \n",
       "6 2.51                0                       38               \n",
       "  FairlyActiveMinutes LightlyActiveMinutes SedentaryMinutes Calories\n",
       "1 13                  328                   728             1985    \n",
       "2 19                  217                   776             1797    \n",
       "3 11                  181                  1218             1776    \n",
       "4 34                  209                   726             1745    \n",
       "5 10                  221                   773             1863    \n",
       "6 20                  164                   539             1728    \n",
       "  Median_Value Median_Hourly_Calorie\n",
       "1 NA           76.0                 \n",
       "2 NA           71.5                 \n",
       "3 NA           62.5                 \n",
       "4 NA           59.5                 \n",
       "5 NA           63.5                 \n",
       "6 NA           53.5                 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>940</li><li>17</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 940\n",
       "\\item 17\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 940\n",
       "2. 17\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 940  17"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "colnames(average_hourly_calories)[2] <- \"ActivityDay\"\n",
    "new_activity_merged <- merge(new_activity_merged, \n",
    "                             average_hourly_calories, \n",
    "                             by = c(\"Id\", \"ActivityDay\"), all = TRUE)\n",
    "head(new_activity_merged)\n",
    "dim(new_activity_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 31,
   "id": "1b6cf9b6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:33.064951Z",
     "iopub.status.busy": "2023-07-13T02:41:33.063695Z",
     "iopub.status.idle": "2023-07-13T02:41:33.077791Z",
     "shell.execute_reply": "2023-07-13T02:41:33.076247Z"
    },
    "papermill": {
     "duration": 0.043144,
     "end_time": "2023-07-13T02:41:33.079878",
     "exception": false,
     "start_time": "2023-07-13T02:41:33.036734",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "612"
      ],
      "text/latex": [
       "612"
      ],
      "text/markdown": [
       "612"
      ],
      "text/plain": [
       "[1] 612"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sum(is.na(new_activity_merged))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "2f5dd914",
   "metadata": {
    "papermill": {
     "duration": 0.024954,
     "end_time": "2023-07-13T02:41:33.130495",
     "exception": false,
     "start_time": "2023-07-13T02:41:33.105541",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Checking Hourly Intensity File"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 32,
   "id": "2f032f20",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:33.185243Z",
     "iopub.status.busy": "2023-07-13T02:41:33.183981Z",
     "iopub.status.idle": "2023-07-13T02:41:33.238342Z",
     "shell.execute_reply": "2023-07-13T02:41:33.236914Z"
    },
    "papermill": {
     "duration": 0.083617,
     "end_time": "2023-07-13T02:41:33.240383",
     "exception": false,
     "start_time": "2023-07-13T02:41:33.156766",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityHour</th><th scope=col>TotalIntensity</th><th scope=col>AverageIntensity</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016 12:00:00 AM</td><td>20</td><td>0.333333</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/12/2016 1:00:00 AM </td><td> 8</td><td>0.133333</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/12/2016 2:00:00 AM </td><td> 7</td><td>0.116667</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/12/2016 3:00:00 AM </td><td> 0</td><td>0.000000</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/12/2016 4:00:00 AM </td><td> 0</td><td>0.000000</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/12/2016 5:00:00 AM </td><td> 0</td><td>0.000000</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 4\n",
       "\\begin{tabular}{r|llll}\n",
       "  & Id & ActivityHour & TotalIntensity & AverageIntensity\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 12:00:00 AM & 20 & 0.333333\\\\\n",
       "\t2 & 1503960366 & 4/12/2016 1:00:00 AM  &  8 & 0.133333\\\\\n",
       "\t3 & 1503960366 & 4/12/2016 2:00:00 AM  &  7 & 0.116667\\\\\n",
       "\t4 & 1503960366 & 4/12/2016 3:00:00 AM  &  0 & 0.000000\\\\\n",
       "\t5 & 1503960366 & 4/12/2016 4:00:00 AM  &  0 & 0.000000\\\\\n",
       "\t6 & 1503960366 & 4/12/2016 5:00:00 AM  &  0 & 0.000000\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 4\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityHour &lt;chr&gt; | TotalIntensity &lt;int&gt; | AverageIntensity &lt;dbl&gt; |\n",
       "|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 12:00:00 AM | 20 | 0.333333 |\n",
       "| 2 | 1503960366 | 4/12/2016 1:00:00 AM  |  8 | 0.133333 |\n",
       "| 3 | 1503960366 | 4/12/2016 2:00:00 AM  |  7 | 0.116667 |\n",
       "| 4 | 1503960366 | 4/12/2016 3:00:00 AM  |  0 | 0.000000 |\n",
       "| 5 | 1503960366 | 4/12/2016 4:00:00 AM  |  0 | 0.000000 |\n",
       "| 6 | 1503960366 | 4/12/2016 5:00:00 AM  |  0 | 0.000000 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityHour          TotalIntensity AverageIntensity\n",
       "1 1503960366 4/12/2016 12:00:00 AM 20             0.333333        \n",
       "2 1503960366 4/12/2016 1:00:00 AM   8             0.133333        \n",
       "3 1503960366 4/12/2016 2:00:00 AM   7             0.116667        \n",
       "4 1503960366 4/12/2016 3:00:00 AM   0             0.000000        \n",
       "5 1503960366 4/12/2016 4:00:00 AM   0             0.000000        \n",
       "6 1503960366 4/12/2016 5:00:00 AM   0             0.000000        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "hourly_intensity <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/hourlyIntensities_merged.csv\")\n",
    "head(hourly_intensity)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 33,
   "id": "28d651e8",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:33.294618Z",
     "iopub.status.busy": "2023-07-13T02:41:33.293138Z",
     "iopub.status.idle": "2023-07-13T02:41:33.330314Z",
     "shell.execute_reply": "2023-07-13T02:41:33.328953Z"
    },
    "papermill": {
     "duration": 0.066934,
     "end_time": "2023-07-13T02:41:33.332324",
     "exception": false,
     "start_time": "2023-07-13T02:41:33.265390",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityHour</th><th scope=col>TotalIntensity</th><th scope=col>AverageIntensity</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>20</td><td>0.333333</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/12/2016</td><td> 8</td><td>0.133333</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/12/2016</td><td> 7</td><td>0.116667</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/12/2016</td><td> 0</td><td>0.000000</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/12/2016</td><td> 0</td><td>0.000000</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/12/2016</td><td> 0</td><td>0.000000</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 4\n",
       "\\begin{tabular}{r|llll}\n",
       "  & Id & ActivityHour & TotalIntensity & AverageIntensity\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 20 & 0.333333\\\\\n",
       "\t2 & 1503960366 & 04/12/2016 &  8 & 0.133333\\\\\n",
       "\t3 & 1503960366 & 04/12/2016 &  7 & 0.116667\\\\\n",
       "\t4 & 1503960366 & 04/12/2016 &  0 & 0.000000\\\\\n",
       "\t5 & 1503960366 & 04/12/2016 &  0 & 0.000000\\\\\n",
       "\t6 & 1503960366 & 04/12/2016 &  0 & 0.000000\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 4\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityHour &lt;chr&gt; | TotalIntensity &lt;int&gt; | AverageIntensity &lt;dbl&gt; |\n",
       "|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 20 | 0.333333 |\n",
       "| 2 | 1503960366 | 04/12/2016 |  8 | 0.133333 |\n",
       "| 3 | 1503960366 | 04/12/2016 |  7 | 0.116667 |\n",
       "| 4 | 1503960366 | 04/12/2016 |  0 | 0.000000 |\n",
       "| 5 | 1503960366 | 04/12/2016 |  0 | 0.000000 |\n",
       "| 6 | 1503960366 | 04/12/2016 |  0 | 0.000000 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityHour TotalIntensity AverageIntensity\n",
       "1 1503960366 04/12/2016   20             0.333333        \n",
       "2 1503960366 04/12/2016    8             0.133333        \n",
       "3 1503960366 04/12/2016    7             0.116667        \n",
       "4 1503960366 04/12/2016    0             0.000000        \n",
       "5 1503960366 04/12/2016    0             0.000000        \n",
       "6 1503960366 04/12/2016    0             0.000000        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "hourly_intensity$ActivityHour <- as.Date(hourly_intensity$ActivityHour, format = \"%m/%d/%Y\")\n",
    "hourly_intensity$ActivityHour <- format(hourly_intensity$ActivityHour, \"%m/%d/%Y\")\n",
    "head(hourly_intensity)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 34,
   "id": "4f5cc0aa",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:33.387399Z",
     "iopub.status.busy": "2023-07-13T02:41:33.385962Z",
     "iopub.status.idle": "2023-07-13T02:41:33.536476Z",
     "shell.execute_reply": "2023-07-13T02:41:33.535002Z"
    },
    "papermill": {
     "duration": 0.179897,
     "end_time": "2023-07-13T02:41:33.538607",
     "exception": false,
     "start_time": "2023-07-13T02:41:33.358710",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nr72am5ubm5v32muvIUOGJI9NJBsAoArcYwcVSV4I+/zzz8+aNWvUqFFHHHFECOGxxx77zne+\nM2zYsPIGAKgCHTuoSHJ33erVq7/1rW8tXbr0jjvuuOOOO/70pz9961vfSsadvOntdwCwNejY\nQUWiKAohNDQ0XHzxxS+//PKHPvShEMIjjzxyxx13NDY29vT0JBsAoAoEO6hIU1NTsVj85Cc/\nuWbNml//+te33nprCKFQKEydOnXo0KG//OUvm5qasq4RgHoh2EFFhg8fvmTJkltuueXRRx8d\nN27cvHnzQgi77bbbggULJk+enGzIukYA6oVgBxXZcccdly1b1tPTc8ABB/Tt27e5uTmE0NXV\n1dbWFkJoamraaaedsq4RgHrh4QmoyF577dXT09O/f/8QQltb2/r169evX5+kuv79+3d3d0+Y\nMCHrGgGoF4IdVOSEE04IIbz++usDBgyYOHHinnvuOWHChIkTJw4YMOD1118vbwCAKnAUCxV5\n9tlnk8Vuu+125JFHJo9KdHd3l0qlJ554ItmQ3GwHAFubYAcVufzyy0MI+++//+OPP54kubKJ\nEyc+9thjl19++amnnppRdQDUF8EOKvLKK69EUfT444+PGDFiv/32CyFEURTH8eOPP/7YY49F\nUfTKK69kXSMA9UKwg4p0d3fHcbz33nvff//9K1eunDVrVghhypQpw4cPnzJlynPPPdfd3Z11\njQDUC8EOKtLQ0BBCmDp16i677LJu3bry9SFDhpx44onPPfdcsgEAqkCwg4r079//9ddfv/TS\nS0MIY8aMSU5jn3jiiaVLlyYXk0koAFAFgh1UZNCgQa+++moIYfLkyffff39y8NrU1DR16tRH\nH3002ZBxiQDUDcEOKvLaa6+FEAqFwqOPPtqnT5/eXxUKhVKptGbNmoxKA6DuGFAMFWlvbw8h\n9OvXL4QQRVFysVAolC8mb6EAgCoQ7KAipVIphLBp06azzz67VCrFcRzHcbFYPPvsszdt2lTe\nAABV4CgWKpI051paWs4777wrrriiWCyGEBoaGtauXdva2trR0ZFsAIAqEOygIq2trW1tbYMH\nD165cuUWt9MNGjSoo6OjtbU1q9oAqDd6CVCR7bffPoSwcuXKE044YdWqVS+88MKLL764atWq\nE044YeXKlSGEYcOGZV0jAPVCxw4qUj5pve6666677ro3big/UQEAW5uOHVQkuanuLXh4AoCq\n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\nABTxvxjOEduiQPsgAAAAAElFTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "boxplot(hourly_intensity[,c(\"TotalIntensity\", \"AverageIntensity\")])"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "7357c315",
   "metadata": {
    "papermill": {
     "duration": 0.025724,
     "end_time": "2023-07-13T02:41:33.590457",
     "exception": false,
     "start_time": "2023-07-13T02:41:33.564733",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "The boxplot shows a lot of outliers present in the Total Intensity Column and there are some outliers in the AverageIntensity Column As Well"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 35,
   "id": "124a8abf",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:33.645715Z",
     "iopub.status.busy": "2023-07-13T02:41:33.644267Z",
     "iopub.status.idle": "2023-07-13T02:41:33.658510Z",
     "shell.execute_reply": "2023-07-13T02:41:33.657151Z"
    },
    "papermill": {
     "duration": 0.044191,
     "end_time": "2023-07-13T02:41:33.660829",
     "exception": false,
     "start_time": "2023-07-13T02:41:33.616638",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sum(is.na(hourly_intensity))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 36,
   "id": "1351b30b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:33.718304Z",
     "iopub.status.busy": "2023-07-13T02:41:33.716988Z",
     "iopub.status.idle": "2023-07-13T02:41:33.728949Z",
     "shell.execute_reply": "2023-07-13T02:41:33.727576Z"
    },
    "papermill": {
     "duration": 0.044341,
     "end_time": "2023-07-13T02:41:33.732204",
     "exception": false,
     "start_time": "2023-07-13T02:41:33.687863",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "colnames(hourly_intensity)[2] <- \"ActivityDay\""
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 37,
   "id": "dec1c2e1",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:33.788233Z",
     "iopub.status.busy": "2023-07-13T02:41:33.786814Z",
     "iopub.status.idle": "2023-07-13T02:41:33.800300Z",
     "shell.execute_reply": "2023-07-13T02:41:33.798684Z"
    },
    "papermill": {
     "duration": 0.043964,
     "end_time": "2023-07-13T02:41:33.802499",
     "exception": false,
     "start_time": "2023-07-13T02:41:33.758535",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "The total number of dissimilar Ids:  0 \n",
      "numeric(0)\n"
     ]
    }
   ],
   "source": [
    "diff_find(new_activity_merged, hourly_intensity)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 38,
   "id": "0c63a91c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:33.863196Z",
     "iopub.status.busy": "2023-07-13T02:41:33.861804Z",
     "iopub.status.idle": "2023-07-13T02:41:33.953933Z",
     "shell.execute_reply": "2023-07-13T02:41:33.952637Z"
    },
    "papermill": {
     "duration": 0.125261,
     "end_time": "2023-07-13T02:41:33.956165",
     "exception": false,
     "start_time": "2023-07-13T02:41:33.830904",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'Id'. You can override using the `.groups`\n",
      "argument.\n"
     ]
    }
   ],
   "source": [
    "average_hourly_intensity <- hourly_intensity%>%\n",
    "group_by(Id,ActivityDay)%>%\n",
    "summarise(MedTotalIntensity = median(TotalIntensity),\n",
    "         MedAverageIntensity = median(AverageIntensity))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 39,
   "id": "33ec5e4e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:34.014215Z",
     "iopub.status.busy": "2023-07-13T02:41:34.012857Z",
     "iopub.status.idle": "2023-07-13T02:41:34.038513Z",
     "shell.execute_reply": "2023-07-13T02:41:34.037132Z"
    },
    "papermill": {
     "duration": 0.05727,
     "end_time": "2023-07-13T02:41:34.040953",
     "exception": false,
     "start_time": "2023-07-13T02:41:33.983683",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 6 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>MedTotalIntensity</th><th scope=col>MedAverageIntensity</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>1503960366</td><td>04/12/2016</td><td>13.0</td><td>0.2166670</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/13/2016</td><td>11.5</td><td>0.1916665</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/14/2016</td><td> 6.0</td><td>0.1000000</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/15/2016</td><td> 6.5</td><td>0.1083335</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/16/2016</td><td> 9.5</td><td>0.1583335</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/17/2016</td><td> 1.5</td><td>0.0250000</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 6 × 4\n",
       "\\begin{tabular}{llll}\n",
       " Id & ActivityDay & MedTotalIntensity & MedAverageIntensity\\\\\n",
       " <dbl> & <chr> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 1503960366 & 04/12/2016 & 13.0 & 0.2166670\\\\\n",
       "\t 1503960366 & 04/13/2016 & 11.5 & 0.1916665\\\\\n",
       "\t 1503960366 & 04/14/2016 &  6.0 & 0.1000000\\\\\n",
       "\t 1503960366 & 04/15/2016 &  6.5 & 0.1083335\\\\\n",
       "\t 1503960366 & 04/16/2016 &  9.5 & 0.1583335\\\\\n",
       "\t 1503960366 & 04/17/2016 &  1.5 & 0.0250000\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 6 × 4\n",
       "\n",
       "| Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | MedTotalIntensity &lt;dbl&gt; | MedAverageIntensity &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| 1503960366 | 04/12/2016 | 13.0 | 0.2166670 |\n",
       "| 1503960366 | 04/13/2016 | 11.5 | 0.1916665 |\n",
       "| 1503960366 | 04/14/2016 |  6.0 | 0.1000000 |\n",
       "| 1503960366 | 04/15/2016 |  6.5 | 0.1083335 |\n",
       "| 1503960366 | 04/16/2016 |  9.5 | 0.1583335 |\n",
       "| 1503960366 | 04/17/2016 |  1.5 | 0.0250000 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay MedTotalIntensity MedAverageIntensity\n",
       "1 1503960366 04/12/2016  13.0              0.2166670          \n",
       "2 1503960366 04/13/2016  11.5              0.1916665          \n",
       "3 1503960366 04/14/2016   6.0              0.1000000          \n",
       "4 1503960366 04/15/2016   6.5              0.1083335          \n",
       "5 1503960366 04/16/2016   9.5              0.1583335          \n",
       "6 1503960366 04/17/2016   1.5              0.0250000          "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(average_hourly_intensity)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 40,
   "id": "21835cc7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:34.097110Z",
     "iopub.status.busy": "2023-07-13T02:41:34.095807Z",
     "iopub.status.idle": "2023-07-13T02:41:34.137487Z",
     "shell.execute_reply": "2023-07-13T02:41:34.136085Z"
    },
    "papermill": {
     "duration": 0.072224,
     "end_time": "2023-07-13T02:41:34.139774",
     "exception": false,
     "start_time": "2023-07-13T02:41:34.067550",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 19</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>FairlyActiveMinutes</th><th scope=col>LightlyActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Value</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedAverageIntensity</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>25</td><td>13</td><td>328</td><td> 728</td><td>1985</td><td>NA</td><td>76.0</td><td>13.0</td><td>0.2166670</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/13/2016</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>21</td><td>19</td><td>217</td><td> 776</td><td>1797</td><td>NA</td><td>71.5</td><td>11.5</td><td>0.1916665</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/14/2016</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>30</td><td>11</td><td>181</td><td>1218</td><td>1776</td><td>NA</td><td>62.5</td><td> 6.0</td><td>0.1000000</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/15/2016</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>29</td><td>34</td><td>209</td><td> 726</td><td>1745</td><td>NA</td><td>59.5</td><td> 6.5</td><td>0.1083335</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/16/2016</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>36</td><td>10</td><td>221</td><td> 773</td><td>1863</td><td>NA</td><td>63.5</td><td> 9.5</td><td>0.1583335</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/17/2016</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>38</td><td>20</td><td>164</td><td> 539</td><td>1728</td><td>NA</td><td>53.5</td><td> 1.5</td><td>0.0250000</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 19\n",
       "\\begin{tabular}{r|lllllllllllllllllll}\n",
       "  & Id & ActivityDay & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & FairlyActiveMinutes & LightlyActiveMinutes & SedentaryMinutes & Calories & Median\\_Value & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedAverageIntensity\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <int> & <int> & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & 25 & 13 & 328 &  728 & 1985 & NA & 76.0 & 13.0 & 0.2166670\\\\\n",
       "\t2 & 1503960366 & 04/13/2016 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & 21 & 19 & 217 &  776 & 1797 & NA & 71.5 & 11.5 & 0.1916665\\\\\n",
       "\t3 & 1503960366 & 04/14/2016 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & 30 & 11 & 181 & 1218 & 1776 & NA & 62.5 &  6.0 & 0.1000000\\\\\n",
       "\t4 & 1503960366 & 04/15/2016 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & 29 & 34 & 209 &  726 & 1745 & NA & 59.5 &  6.5 & 0.1083335\\\\\n",
       "\t5 & 1503960366 & 04/16/2016 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & 36 & 10 & 221 &  773 & 1863 & NA & 63.5 &  9.5 & 0.1583335\\\\\n",
       "\t6 & 1503960366 & 04/17/2016 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & 38 & 20 & 164 &  539 & 1728 & NA & 53.5 &  1.5 & 0.0250000\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 19\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | VeryActiveMinutes &lt;int&gt; | FairlyActiveMinutes &lt;int&gt; | LightlyActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | Median_Value &lt;dbl&gt; | Median_Hourly_Calorie &lt;dbl&gt; | MedTotalIntensity &lt;dbl&gt; | MedAverageIntensity &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | 25 | 13 | 328 |  728 | 1985 | NA | 76.0 | 13.0 | 0.2166670 |\n",
       "| 2 | 1503960366 | 04/13/2016 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | 21 | 19 | 217 |  776 | 1797 | NA | 71.5 | 11.5 | 0.1916665 |\n",
       "| 3 | 1503960366 | 04/14/2016 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | 30 | 11 | 181 | 1218 | 1776 | NA | 62.5 |  6.0 | 0.1000000 |\n",
       "| 4 | 1503960366 | 04/15/2016 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | 29 | 34 | 209 |  726 | 1745 | NA | 59.5 |  6.5 | 0.1083335 |\n",
       "| 5 | 1503960366 | 04/16/2016 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | 36 | 10 | 221 |  773 | 1863 | NA | 63.5 |  9.5 | 0.1583335 |\n",
       "| 6 | 1503960366 | 04/17/2016 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | 38 | 20 | 164 |  539 | 1728 | NA | 53.5 |  1.5 | 0.0250000 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay TotalSteps TotalDistance TrackerDistance\n",
       "1 1503960366 04/12/2016  13162      8.50          8.50           \n",
       "2 1503960366 04/13/2016  10735      6.97          6.97           \n",
       "3 1503960366 04/14/2016  10460      6.74          6.74           \n",
       "4 1503960366 04/15/2016   9762      6.28          6.28           \n",
       "5 1503960366 04/16/2016  12669      8.16          8.16           \n",
       "6 1503960366 04/17/2016   9705      6.48          6.48           \n",
       "  LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance\n",
       "1 0                        1.88               0.55                    \n",
       "2 0                        1.57               0.69                    \n",
       "3 0                        2.44               0.40                    \n",
       "4 0                        2.14               1.26                    \n",
       "5 0                        2.71               0.41                    \n",
       "6 0                        3.19               0.78                    \n",
       "  LightActiveDistance SedentaryActiveDistance VeryActiveMinutes\n",
       "1 6.06                0                       25               \n",
       "2 4.71                0                       21               \n",
       "3 3.91                0                       30               \n",
       "4 2.83                0                       29               \n",
       "5 5.04                0                       36               \n",
       "6 2.51                0                       38               \n",
       "  FairlyActiveMinutes LightlyActiveMinutes SedentaryMinutes Calories\n",
       "1 13                  328                   728             1985    \n",
       "2 19                  217                   776             1797    \n",
       "3 11                  181                  1218             1776    \n",
       "4 34                  209                   726             1745    \n",
       "5 10                  221                   773             1863    \n",
       "6 20                  164                   539             1728    \n",
       "  Median_Value Median_Hourly_Calorie MedTotalIntensity MedAverageIntensity\n",
       "1 NA           76.0                  13.0              0.2166670          \n",
       "2 NA           71.5                  11.5              0.1916665          \n",
       "3 NA           62.5                   6.0              0.1000000          \n",
       "4 NA           59.5                   6.5              0.1083335          \n",
       "5 NA           63.5                   9.5              0.1583335          \n",
       "6 NA           53.5                   1.5              0.0250000          "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>940</li><li>19</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 940\n",
       "\\item 19\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 940\n",
       "2. 19\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 940  19"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "new_activity_merged <- merge(new_activity_merged, average_hourly_intensity,\n",
    "                            by = c(\"Id\", \"ActivityDay\"), all = TRUE)\n",
    "head(new_activity_merged)\n",
    "dim(new_activity_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 41,
   "id": "8d9cea6e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:34.197325Z",
     "iopub.status.busy": "2023-07-13T02:41:34.195915Z",
     "iopub.status.idle": "2023-07-13T02:41:34.209806Z",
     "shell.execute_reply": "2023-07-13T02:41:34.208478Z"
    },
    "papermill": {
     "duration": 0.045145,
     "end_time": "2023-07-13T02:41:34.212024",
     "exception": false,
     "start_time": "2023-07-13T02:41:34.166879",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "624"
      ],
      "text/latex": [
       "624"
      ],
      "text/markdown": [
       "624"
      ],
      "text/plain": [
       "[1] 624"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sum(is.na(new_activity_merged))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "9c635403",
   "metadata": {
    "papermill": {
     "duration": 0.027781,
     "end_time": "2023-07-13T02:41:34.266791",
     "exception": false,
     "start_time": "2023-07-13T02:41:34.239010",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Checking HourlySteps File"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 42,
   "id": "35b3c7b8",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:34.324456Z",
     "iopub.status.busy": "2023-07-13T02:41:34.323155Z",
     "iopub.status.idle": "2023-07-13T02:41:34.398172Z",
     "shell.execute_reply": "2023-07-13T02:41:34.396663Z"
    },
    "papermill": {
     "duration": 0.107851,
     "end_time": "2023-07-13T02:41:34.401600",
     "exception": false,
     "start_time": "2023-07-13T02:41:34.293749",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "hourly_steps <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/hourlySteps_merged.csv\")\n",
    "activity_col <- hourly_steps%>%\n",
    "select(matches(\"ActivityH|ActivityM|ActivityD|Day\"))\n",
    "\n",
    "hourly_steps <- hourly_steps%>%\n",
    "select(-matches(\"ActivityH|ActivityM|ActivityD|Day\"))\n",
    "\n",
    "\n",
    "\n",
    "activity_col <- activity_col%>%\n",
    "mutate(ActivityDay = as.Date(activity_col$ActivityHour, format = \"%m/%d/%Y\"))%>%\n",
    "select(matches(\"ActivityDay\"))\n",
    "\n",
    "\n",
    "hourly_steps <- cbind(hourly_steps, Series = activity_col)\n",
    "\n",
    "hourly_steps$ActivityDay <- format(hourly_steps$ActivityDay, \"%m/%d/%Y\")\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 43,
   "id": "8ff3a0b3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:34.459784Z",
     "iopub.status.busy": "2023-07-13T02:41:34.458069Z",
     "iopub.status.idle": "2023-07-13T02:41:34.502406Z",
     "shell.execute_reply": "2023-07-13T02:41:34.500912Z"
    },
    "papermill": {
     "duration": 0.075819,
     "end_time": "2023-07-13T02:41:34.504784",
     "exception": false,
     "start_time": "2023-07-13T02:41:34.428965",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>StepTotal</th><th scope=col>ActivityDay</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>373</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>160</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>151</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>  0</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>  0</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>  0</td><td>04/12/2016</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & StepTotal & ActivityDay\\\\\n",
       "  & <dbl> & <int> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 373 & 04/12/2016\\\\\n",
       "\t2 & 1503960366 & 160 & 04/12/2016\\\\\n",
       "\t3 & 1503960366 & 151 & 04/12/2016\\\\\n",
       "\t4 & 1503960366 &   0 & 04/12/2016\\\\\n",
       "\t5 & 1503960366 &   0 & 04/12/2016\\\\\n",
       "\t6 & 1503960366 &   0 & 04/12/2016\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | StepTotal &lt;int&gt; | ActivityDay &lt;chr&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 1503960366 | 373 | 04/12/2016 |\n",
       "| 2 | 1503960366 | 160 | 04/12/2016 |\n",
       "| 3 | 1503960366 | 151 | 04/12/2016 |\n",
       "| 4 | 1503960366 |   0 | 04/12/2016 |\n",
       "| 5 | 1503960366 |   0 | 04/12/2016 |\n",
       "| 6 | 1503960366 |   0 | 04/12/2016 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         StepTotal ActivityDay\n",
       "1 1503960366 373       04/12/2016 \n",
       "2 1503960366 160       04/12/2016 \n",
       "3 1503960366 151       04/12/2016 \n",
       "4 1503960366   0       04/12/2016 \n",
       "5 1503960366   0       04/12/2016 \n",
       "6 1503960366   0       04/12/2016 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>22099</li><li>3</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 22099\n",
       "\\item 3\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 22099\n",
       "2. 3\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 22099     3"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "The total number of dissimilar Ids:  0 \n",
      "numeric(0)\n"
     ]
    }
   ],
   "source": [
    "head(hourly_steps)\n",
    "dim(hourly_steps)\n",
    "diff_find(new_activity_merged, hourly_steps)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 44,
   "id": "f16e5d20",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:34.561668Z",
     "iopub.status.busy": "2023-07-13T02:41:34.560498Z",
     "iopub.status.idle": "2023-07-13T02:41:34.681976Z",
     "shell.execute_reply": "2023-07-13T02:41:34.680113Z"
    },
    "papermill": {
     "duration": 0.152532,
     "end_time": "2023-07-13T02:41:34.684331",
     "exception": false,
     "start_time": "2023-07-13T02:41:34.531799",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nVNLeAADAJPDlCQCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQd\nAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLAD\nAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYA\nAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4A\nIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEA\nBCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCA\nIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQ\nhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACC\nEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQ\nwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC\n2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEH8\nDygMwSW7sKoTAAAAAElFTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "boxplot(hourly_steps[,c(\"StepTotal\")])"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "5eda346f",
   "metadata": {
    "papermill": {
     "duration": 0.027441,
     "end_time": "2023-07-13T02:41:34.739007",
     "exception": false,
     "start_time": "2023-07-13T02:41:34.711566",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "The number of outliers in StepTotal column in pretty high"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 45,
   "id": "a23fe414",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:34.796209Z",
     "iopub.status.busy": "2023-07-13T02:41:34.795063Z",
     "iopub.status.idle": "2023-07-13T02:41:34.872207Z",
     "shell.execute_reply": "2023-07-13T02:41:34.870938Z"
    },
    "papermill": {
     "duration": 0.108254,
     "end_time": "2023-07-13T02:41:34.874316",
     "exception": false,
     "start_time": "2023-07-13T02:41:34.766062",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'Id'. You can override using the `.groups`\n",
      "argument.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>MedianHourlySteps</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>1503960366</td><td>04/12/2016</td><td>341.0</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/13/2016</td><td>285.0</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/14/2016</td><td> 69.5</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/15/2016</td><td> 80.0</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/16/2016</td><td>123.5</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/17/2016</td><td> 10.5</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 6 × 3\n",
       "\\begin{tabular}{lll}\n",
       " Id & ActivityDay & MedianHourlySteps\\\\\n",
       " <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 1503960366 & 04/12/2016 & 341.0\\\\\n",
       "\t 1503960366 & 04/13/2016 & 285.0\\\\\n",
       "\t 1503960366 & 04/14/2016 &  69.5\\\\\n",
       "\t 1503960366 & 04/15/2016 &  80.0\\\\\n",
       "\t 1503960366 & 04/16/2016 & 123.5\\\\\n",
       "\t 1503960366 & 04/17/2016 &  10.5\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 6 × 3\n",
       "\n",
       "| Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | MedianHourlySteps &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 1503960366 | 04/12/2016 | 341.0 |\n",
       "| 1503960366 | 04/13/2016 | 285.0 |\n",
       "| 1503960366 | 04/14/2016 |  69.5 |\n",
       "| 1503960366 | 04/15/2016 |  80.0 |\n",
       "| 1503960366 | 04/16/2016 | 123.5 |\n",
       "| 1503960366 | 04/17/2016 |  10.5 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay MedianHourlySteps\n",
       "1 1503960366 04/12/2016  341.0            \n",
       "2 1503960366 04/13/2016  285.0            \n",
       "3 1503960366 04/14/2016   69.5            \n",
       "4 1503960366 04/15/2016   80.0            \n",
       "5 1503960366 04/16/2016  123.5            \n",
       "6 1503960366 04/17/2016   10.5            "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "avg_hourly_steps <- hourly_steps%>%\n",
    "group_by(Id, ActivityDay)%>%\n",
    "summarise(MedianHourlySteps = median(StepTotal))\n",
    "head(avg_hourly_steps)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 46,
   "id": "f7294862",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:34.932603Z",
     "iopub.status.busy": "2023-07-13T02:41:34.931210Z",
     "iopub.status.idle": "2023-07-13T02:41:34.972150Z",
     "shell.execute_reply": "2023-07-13T02:41:34.970752Z"
    },
    "papermill": {
     "duration": 0.072046,
     "end_time": "2023-07-13T02:41:34.974087",
     "exception": false,
     "start_time": "2023-07-13T02:41:34.902041",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 20</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>FairlyActiveMinutes</th><th scope=col>LightlyActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Value</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedAverageIntensity</th><th scope=col>MedianHourlySteps</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>25</td><td>13</td><td>328</td><td> 728</td><td>1985</td><td>NA</td><td>76.0</td><td>13.0</td><td>0.2166670</td><td>341.0</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/13/2016</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>21</td><td>19</td><td>217</td><td> 776</td><td>1797</td><td>NA</td><td>71.5</td><td>11.5</td><td>0.1916665</td><td>285.0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/14/2016</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>30</td><td>11</td><td>181</td><td>1218</td><td>1776</td><td>NA</td><td>62.5</td><td> 6.0</td><td>0.1000000</td><td> 69.5</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/15/2016</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>29</td><td>34</td><td>209</td><td> 726</td><td>1745</td><td>NA</td><td>59.5</td><td> 6.5</td><td>0.1083335</td><td> 80.0</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/16/2016</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>36</td><td>10</td><td>221</td><td> 773</td><td>1863</td><td>NA</td><td>63.5</td><td> 9.5</td><td>0.1583335</td><td>123.5</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/17/2016</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>38</td><td>20</td><td>164</td><td> 539</td><td>1728</td><td>NA</td><td>53.5</td><td> 1.5</td><td>0.0250000</td><td> 10.5</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 20\n",
       "\\begin{tabular}{r|llllllllllllllllllll}\n",
       "  & Id & ActivityDay & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & FairlyActiveMinutes & LightlyActiveMinutes & SedentaryMinutes & Calories & Median\\_Value & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedAverageIntensity & MedianHourlySteps\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <int> & <int> & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & 25 & 13 & 328 &  728 & 1985 & NA & 76.0 & 13.0 & 0.2166670 & 341.0\\\\\n",
       "\t2 & 1503960366 & 04/13/2016 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & 21 & 19 & 217 &  776 & 1797 & NA & 71.5 & 11.5 & 0.1916665 & 285.0\\\\\n",
       "\t3 & 1503960366 & 04/14/2016 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & 30 & 11 & 181 & 1218 & 1776 & NA & 62.5 &  6.0 & 0.1000000 &  69.5\\\\\n",
       "\t4 & 1503960366 & 04/15/2016 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & 29 & 34 & 209 &  726 & 1745 & NA & 59.5 &  6.5 & 0.1083335 &  80.0\\\\\n",
       "\t5 & 1503960366 & 04/16/2016 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & 36 & 10 & 221 &  773 & 1863 & NA & 63.5 &  9.5 & 0.1583335 & 123.5\\\\\n",
       "\t6 & 1503960366 & 04/17/2016 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & 38 & 20 & 164 &  539 & 1728 & NA & 53.5 &  1.5 & 0.0250000 &  10.5\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 20\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | VeryActiveMinutes &lt;int&gt; | FairlyActiveMinutes &lt;int&gt; | LightlyActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | Median_Value &lt;dbl&gt; | Median_Hourly_Calorie &lt;dbl&gt; | MedTotalIntensity &lt;dbl&gt; | MedAverageIntensity &lt;dbl&gt; | MedianHourlySteps &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | 25 | 13 | 328 |  728 | 1985 | NA | 76.0 | 13.0 | 0.2166670 | 341.0 |\n",
       "| 2 | 1503960366 | 04/13/2016 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | 21 | 19 | 217 |  776 | 1797 | NA | 71.5 | 11.5 | 0.1916665 | 285.0 |\n",
       "| 3 | 1503960366 | 04/14/2016 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | 30 | 11 | 181 | 1218 | 1776 | NA | 62.5 |  6.0 | 0.1000000 |  69.5 |\n",
       "| 4 | 1503960366 | 04/15/2016 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | 29 | 34 | 209 |  726 | 1745 | NA | 59.5 |  6.5 | 0.1083335 |  80.0 |\n",
       "| 5 | 1503960366 | 04/16/2016 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | 36 | 10 | 221 |  773 | 1863 | NA | 63.5 |  9.5 | 0.1583335 | 123.5 |\n",
       "| 6 | 1503960366 | 04/17/2016 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | 38 | 20 | 164 |  539 | 1728 | NA | 53.5 |  1.5 | 0.0250000 |  10.5 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay TotalSteps TotalDistance TrackerDistance\n",
       "1 1503960366 04/12/2016  13162      8.50          8.50           \n",
       "2 1503960366 04/13/2016  10735      6.97          6.97           \n",
       "3 1503960366 04/14/2016  10460      6.74          6.74           \n",
       "4 1503960366 04/15/2016   9762      6.28          6.28           \n",
       "5 1503960366 04/16/2016  12669      8.16          8.16           \n",
       "6 1503960366 04/17/2016   9705      6.48          6.48           \n",
       "  LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance\n",
       "1 0                        1.88               0.55                    \n",
       "2 0                        1.57               0.69                    \n",
       "3 0                        2.44               0.40                    \n",
       "4 0                        2.14               1.26                    \n",
       "5 0                        2.71               0.41                    \n",
       "6 0                        3.19               0.78                    \n",
       "  LightActiveDistance SedentaryActiveDistance VeryActiveMinutes\n",
       "1 6.06                0                       25               \n",
       "2 4.71                0                       21               \n",
       "3 3.91                0                       30               \n",
       "4 2.83                0                       29               \n",
       "5 5.04                0                       36               \n",
       "6 2.51                0                       38               \n",
       "  FairlyActiveMinutes LightlyActiveMinutes SedentaryMinutes Calories\n",
       "1 13                  328                   728             1985    \n",
       "2 19                  217                   776             1797    \n",
       "3 11                  181                  1218             1776    \n",
       "4 34                  209                   726             1745    \n",
       "5 10                  221                   773             1863    \n",
       "6 20                  164                   539             1728    \n",
       "  Median_Value Median_Hourly_Calorie MedTotalIntensity MedAverageIntensity\n",
       "1 NA           76.0                  13.0              0.2166670          \n",
       "2 NA           71.5                  11.5              0.1916665          \n",
       "3 NA           62.5                   6.0              0.1000000          \n",
       "4 NA           59.5                   6.5              0.1083335          \n",
       "5 NA           63.5                   9.5              0.1583335          \n",
       "6 NA           53.5                   1.5              0.0250000          \n",
       "  MedianHourlySteps\n",
       "1 341.0            \n",
       "2 285.0            \n",
       "3  69.5            \n",
       "4  80.0            \n",
       "5 123.5            \n",
       "6  10.5            "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>940</li><li>20</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 940\n",
       "\\item 20\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 940\n",
       "2. 20\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 940  20"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "## Merging with activity\n",
    "new_activity_merged <- merge(new_activity_merged, avg_hourly_steps,\n",
    "                            by = c(\"Id\", \"ActivityDay\"), all = TRUE)\n",
    "head(new_activity_merged)\n",
    "dim(new_activity_merged)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "7f44580b",
   "metadata": {
    "papermill": {
     "duration": 0.028014,
     "end_time": "2023-07-13T02:41:35.030517",
     "exception": false,
     "start_time": "2023-07-13T02:41:35.002503",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Checking MinutesCalories Narrow File"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 47,
   "id": "0e46dd6c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:35.088904Z",
     "iopub.status.busy": "2023-07-13T02:41:35.087593Z",
     "iopub.status.idle": "2023-07-13T02:41:37.823141Z",
     "shell.execute_reply": "2023-07-13T02:41:37.821782Z"
    },
    "papermill": {
     "duration": 2.767222,
     "end_time": "2023-07-13T02:41:37.825170",
     "exception": false,
     "start_time": "2023-07-13T02:41:35.057948",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityMinute</th><th scope=col>Calories</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016 12:00:00 AM</td><td>0.7865</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/12/2016 12:01:00 AM</td><td>0.7865</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/12/2016 12:02:00 AM</td><td>0.7865</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/12/2016 12:03:00 AM</td><td>0.7865</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/12/2016 12:04:00 AM</td><td>0.7865</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/12/2016 12:05:00 AM</td><td>0.9438</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & ActivityMinute & Calories\\\\\n",
       "  & <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 12:00:00 AM & 0.7865\\\\\n",
       "\t2 & 1503960366 & 4/12/2016 12:01:00 AM & 0.7865\\\\\n",
       "\t3 & 1503960366 & 4/12/2016 12:02:00 AM & 0.7865\\\\\n",
       "\t4 & 1503960366 & 4/12/2016 12:03:00 AM & 0.7865\\\\\n",
       "\t5 & 1503960366 & 4/12/2016 12:04:00 AM & 0.7865\\\\\n",
       "\t6 & 1503960366 & 4/12/2016 12:05:00 AM & 0.9438\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityMinute &lt;chr&gt; | Calories &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 12:00:00 AM | 0.7865 |\n",
       "| 2 | 1503960366 | 4/12/2016 12:01:00 AM | 0.7865 |\n",
       "| 3 | 1503960366 | 4/12/2016 12:02:00 AM | 0.7865 |\n",
       "| 4 | 1503960366 | 4/12/2016 12:03:00 AM | 0.7865 |\n",
       "| 5 | 1503960366 | 4/12/2016 12:04:00 AM | 0.7865 |\n",
       "| 6 | 1503960366 | 4/12/2016 12:05:00 AM | 0.9438 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityMinute        Calories\n",
       "1 1503960366 4/12/2016 12:00:00 AM 0.7865  \n",
       "2 1503960366 4/12/2016 12:01:00 AM 0.7865  \n",
       "3 1503960366 4/12/2016 12:02:00 AM 0.7865  \n",
       "4 1503960366 4/12/2016 12:03:00 AM 0.7865  \n",
       "5 1503960366 4/12/2016 12:04:00 AM 0.7865  \n",
       "6 1503960366 4/12/2016 12:05:00 AM 0.9438  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>Calories</th><th scope=col>ActivityDay</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>0.7865</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>0.7865</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>0.7865</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>0.7865</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>0.7865</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>0.9438</td><td>04/12/2016</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & Calories & ActivityDay\\\\\n",
       "  & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 0.7865 & 04/12/2016\\\\\n",
       "\t2 & 1503960366 & 0.7865 & 04/12/2016\\\\\n",
       "\t3 & 1503960366 & 0.7865 & 04/12/2016\\\\\n",
       "\t4 & 1503960366 & 0.7865 & 04/12/2016\\\\\n",
       "\t5 & 1503960366 & 0.7865 & 04/12/2016\\\\\n",
       "\t6 & 1503960366 & 0.9438 & 04/12/2016\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | Calories &lt;dbl&gt; | ActivityDay &lt;chr&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 1503960366 | 0.7865 | 04/12/2016 |\n",
       "| 2 | 1503960366 | 0.7865 | 04/12/2016 |\n",
       "| 3 | 1503960366 | 0.7865 | 04/12/2016 |\n",
       "| 4 | 1503960366 | 0.7865 | 04/12/2016 |\n",
       "| 5 | 1503960366 | 0.7865 | 04/12/2016 |\n",
       "| 6 | 1503960366 | 0.9438 | 04/12/2016 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         Calories ActivityDay\n",
       "1 1503960366 0.7865   04/12/2016 \n",
       "2 1503960366 0.7865   04/12/2016 \n",
       "3 1503960366 0.7865   04/12/2016 \n",
       "4 1503960366 0.7865   04/12/2016 \n",
       "5 1503960366 0.7865   04/12/2016 \n",
       "6 1503960366 0.9438   04/12/2016 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "min_cal_nrr <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/minuteCaloriesNarrow_merged.csv\")\n",
    "head(min_cal_nrr)\n",
    "activity_col <- min_cal_nrr%>%\n",
    "select(matches(\"ActivityH|ActivityM|ActivityD|Day\"))\n",
    "\n",
    "\n",
    "min_cal_nrr <- min_cal_nrr%>%\n",
    "select(-matches(\"ActivityH|ActivityM|ActivityD|Day\"))\n",
    "\n",
    "\n",
    "\n",
    "activity_col <- activity_col%>%\n",
    "mutate(ActivityDay = as.Date(activity_col$ActivityMinute, format = \"%m/%d/%Y\"))%>%\n",
    "select(matches(\"ActivityDay\"))\n",
    "\n",
    "\n",
    "\n",
    "min_cal_nrr <- cbind(min_cal_nrr, Series = activity_col)\n",
    "\n",
    "min_cal_nrr$ActivityDay <- format(min_cal_nrr$ActivityDay, \"%m/%d/%Y\")\n",
    "head(min_cal_nrr)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 48,
   "id": "a035462b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:37.887251Z",
     "iopub.status.busy": "2023-07-13T02:41:37.885907Z",
     "iopub.status.idle": "2023-07-13T02:41:43.129961Z",
     "shell.execute_reply": "2023-07-13T02:41:43.128604Z"
    },
    "papermill": {
     "duration": 5.277984,
     "end_time": "2023-07-13T02:41:43.131965",
     "exception": false,
     "start_time": "2023-07-13T02:41:37.853981",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nq2fPA+5atamVPwLwYd1+++3bH7zxxhs7fglA6wop7IpK9vzlc4vuum78MYf3r1u7cn39+xfn\niop3v37Gy/f+cNx+2VXLan3YDvgkTZgwYfuDV1xxRccvAWhdIYVdkiRFxXucf9Wt/++5l9es\ne/cbPTp/4LVMp3Ou/L9/X7Xh9Vfmz368KqWBQCiZTCb5nyebbH28+RkoTScA5IlCeo5d+2R7\n9xvYu9/AtGcAETQ2Nja33Q4bznPsgLxSYFfsADrYgQce+BFeAkiFsANozcKFC5cuXbrN5bpM\nJrN06dKFCxemtQpgh+K9FQvwCevbt6+3XIGCIOwA2mXjxo1PPvlkkiRDhw71dGIgP3krFqAN\nDz/8cJcuXXbddddRo0aNGjVq11137dKly+9+97u0dwFsS9gBtObKK688/fTTN2zYkM1m99xz\nzz333DObzW7YsOHUU0+98sor014H8AHCDqBFixcvvv7665MkGTNmTH19/erVq1evXl1fXz9m\nzJgkSa6//vrFixenvRHgfcIOoEWnn356kiRf+tKXpk6duvXxqVOnHnPMMUmSnHHGGeksA9gR\nYQfQokWLFiVJ8uCDD27/0kMPPZQkiSeeAHlF2AG0qL6+PpPJ9OjRY/uXevTokclk6ut9OTWQ\nR4QdQIuavxN2h7b/DlmAdPmfJIAWde/ePUmSa665ZvuXfvCDHzSfAJAnhB1AiyZOnJgkyQ9/\n+MNtPku3cOHCprtlm04AyBO+eQKgRePHj//JT36ydOnSgw8++HOf+1zTPbAPPfTQ3/72t1wu\nd8ABB4wfPz7tjQDvE3YAramurv7iF7/4l7/85fnnn3/++eebjx955JHPPvtsisMAtuetWIA2\nPPvss8uWLTvjjDMOOOCAfv36nXHGGcuWLVN1QB5yxQ6gbfvtt98On2YHkFdcsQMACELYAQAE\n4a1YgHapq6t79dVXkyTZd999O3XqlPYcgB1wxQ6gDdXV1aNHj+7WrVv//v379+/frVu30aNH\nL126NO1dANtyxQ6gNX/+85+//OUvv/vuu8cee+zRRx+dJMm8efPuu+++Rx99tKqqasiQIWkP\nBHifsANo0fr1608//fQkSWbNmjV06NDm408++eRpp532L//yL6+88kqXLl3SGwjwAd6KBWjR\n3Xff/eabb95+++1bV12SJEOHDr3tttvefPPNu+++O61tANsTdgAtmjVrVufOnc8888ztXzrr\nrLM6d+78xBNPdPwqgJYIO4AWrVq1qlevXqWlpdu/VFpa2qtXr1WrVnX8KoCWCDuAFu22227r\n1q3b4Uu5XG7t2rW77bZbB08CaIWwA2jRkUceuWbNmnnz5m3/0tNPP/32229/4Qtf6PhVAC0R\ndgAtOv/880tKSi688MK1a9cmSZLL5XK5XJIka9euvfDCC0tKSs4///y0NwK8T9gBtGjAgAGT\nJk2aP3/+fvvt16NHj2w2m81me/Tosd9++82fP//6668fMGBA2hsB3ifsAFozatSo7t27b9iw\n4c0332y6Yvfmm29u2LChe/fuo0aNSnsdwAd4QDFAizZv3jxixIgNGzbccccdffv2XbRoUZIk\nBx544LJly7797W9/5StfefHFF3d4zyxAKoQdQIvuvffexYsX/+d//udFF12UJMnJJ5/c/FJN\nTc3ll19+7733fvOb30xvIMAHeCsWoEW///3vS0tLx40bt/1L48aNKy0traqq6vhVAC0RdgAt\nev311/v06VNRUbH9SxUVFX369Hnttdc6fhVAS4QdQIvKy8vfe++9ll7dtGlTeXl5R+4BaJ2w\nA2jRwIEDV65c+fLLL2//0ssvv7xq1aqBAwd2/CqAlgg7gBaNGTMmk8lMmDChrq5u6+N1dXUT\nJkzIZDJjxoxJaxvA9oQdQIsGDx58ySWXPPHEE0OGDPntb3+7evXq1atXP/LII0OGDHniiSfG\njx8/ePDgtDcCvM/jTgBaM3ny5N122+1HP/rRaaed1nywU6dOEydOvPbaa1McBrA9YQfQmmw2\nO2nSpAsvvPCRRx5ZuHBhJpM58MADTzvttN69e6c9DWBbwg6gbb17977kkkvSXgHQBp+xAwAI\nQtgBAAQh7ADasHz58rKyssxWysrKli9fnvYugG0JO4DWXHXVVX379t28efPWBzdv3ty3b193\nxQL5xs0TAC1at27dpEmTmn6eOHFi586dkyR57733rr/++iRJrrnmmksvvbRr165pTgTYirAD\naFGvXr2afqioqGiKueZfN27c2HRCK18mC9DBhB1Ai2pqapp+2LhxY79+/Y466qgkSZ5++unF\nixdvcwJAPhB2AG3IZrMzZsw45ZRTmo9UVVWNHDmyoaEhxVUA23PzBEAbJk6cuHXVJUlyyimn\nfP/7309rD0BLhB1AG1599dUkSW677bbjjz/++OOPv+2225Ikee2119LeBbAtb8UCtCiTyeRy\n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\nACCI/w+xos/JtuadPQAAAABJRU5ErkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "boxplot(min_cal_nrr[,c(\"Calories\")])"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "c8932c2a",
   "metadata": {
    "papermill": {
     "duration": 0.030206,
     "end_time": "2023-07-13T02:41:43.191678",
     "exception": false,
     "start_time": "2023-07-13T02:41:43.161472",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "High Number of Outliers\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 49,
   "id": "45b60dde",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:43.252840Z",
     "iopub.status.busy": "2023-07-13T02:41:43.251616Z",
     "iopub.status.idle": "2023-07-13T02:41:43.379009Z",
     "shell.execute_reply": "2023-07-13T02:41:43.377621Z"
    },
    "papermill": {
     "duration": 0.160422,
     "end_time": "2023-07-13T02:41:43.381064",
     "exception": false,
     "start_time": "2023-07-13T02:41:43.220642",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'Id'. You can override using the `.groups`\n",
      "argument.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>MedianMinCalories</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>1503960366</td><td>04/12/2016</td><td>0.9438</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/13/2016</td><td>0.7865</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/14/2016</td><td>0.9438</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/15/2016</td><td>0.7865</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/16/2016</td><td>0.7865</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/17/2016</td><td>0.7865</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 6 × 3\n",
       "\\begin{tabular}{lll}\n",
       " Id & ActivityDay & MedianMinCalories\\\\\n",
       " <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 1503960366 & 04/12/2016 & 0.9438\\\\\n",
       "\t 1503960366 & 04/13/2016 & 0.7865\\\\\n",
       "\t 1503960366 & 04/14/2016 & 0.9438\\\\\n",
       "\t 1503960366 & 04/15/2016 & 0.7865\\\\\n",
       "\t 1503960366 & 04/16/2016 & 0.7865\\\\\n",
       "\t 1503960366 & 04/17/2016 & 0.7865\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 6 × 3\n",
       "\n",
       "| Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | MedianMinCalories &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 1503960366 | 04/12/2016 | 0.9438 |\n",
       "| 1503960366 | 04/13/2016 | 0.7865 |\n",
       "| 1503960366 | 04/14/2016 | 0.9438 |\n",
       "| 1503960366 | 04/15/2016 | 0.7865 |\n",
       "| 1503960366 | 04/16/2016 | 0.7865 |\n",
       "| 1503960366 | 04/17/2016 | 0.7865 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay MedianMinCalories\n",
       "1 1503960366 04/12/2016  0.9438           \n",
       "2 1503960366 04/13/2016  0.7865           \n",
       "3 1503960366 04/14/2016  0.9438           \n",
       "4 1503960366 04/15/2016  0.7865           \n",
       "5 1503960366 04/16/2016  0.7865           \n",
       "6 1503960366 04/17/2016  0.7865           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "avg_min_cal <- min_cal_nrr%>%\n",
    "group_by(Id, ActivityDay)%>%\n",
    "summarise(MedianMinCalories = median(Calories))\n",
    "head(avg_min_cal)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 50,
   "id": "210b922e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:43.443903Z",
     "iopub.status.busy": "2023-07-13T02:41:43.442573Z",
     "iopub.status.idle": "2023-07-13T02:41:43.455067Z",
     "shell.execute_reply": "2023-07-13T02:41:43.453642Z"
    },
    "papermill": {
     "duration": 0.046068,
     "end_time": "2023-07-13T02:41:43.456901",
     "exception": false,
     "start_time": "2023-07-13T02:41:43.410833",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "The total number of dissimilar Ids:  0 \n",
      "numeric(0)\n"
     ]
    }
   ],
   "source": [
    "diff_find(new_activity_merged, avg_min_cal)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 51,
   "id": "c6a22fcd",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:43.519711Z",
     "iopub.status.busy": "2023-07-13T02:41:43.518498Z",
     "iopub.status.idle": "2023-07-13T02:41:43.554602Z",
     "shell.execute_reply": "2023-07-13T02:41:43.553260Z"
    },
    "papermill": {
     "duration": 0.069573,
     "end_time": "2023-07-13T02:41:43.556409",
     "exception": false,
     "start_time": "2023-07-13T02:41:43.486836",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 21</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>⋯</th><th scope=col>FairlyActiveMinutes</th><th scope=col>LightlyActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Value</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedAverageIntensity</th><th scope=col>MedianHourlySteps</th><th scope=col>MedianMinCalories</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>⋯</td><td>13</td><td>328</td><td> 728</td><td>1985</td><td>NA</td><td>76.0</td><td>13.0</td><td>0.2166670</td><td>341.0</td><td>0.9438</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/13/2016</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>⋯</td><td>19</td><td>217</td><td> 776</td><td>1797</td><td>NA</td><td>71.5</td><td>11.5</td><td>0.1916665</td><td>285.0</td><td>0.7865</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/14/2016</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>⋯</td><td>11</td><td>181</td><td>1218</td><td>1776</td><td>NA</td><td>62.5</td><td> 6.0</td><td>0.1000000</td><td> 69.5</td><td>0.9438</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/15/2016</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>⋯</td><td>34</td><td>209</td><td> 726</td><td>1745</td><td>NA</td><td>59.5</td><td> 6.5</td><td>0.1083335</td><td> 80.0</td><td>0.7865</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/16/2016</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>⋯</td><td>10</td><td>221</td><td> 773</td><td>1863</td><td>NA</td><td>63.5</td><td> 9.5</td><td>0.1583335</td><td>123.5</td><td>0.7865</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/17/2016</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>⋯</td><td>20</td><td>164</td><td> 539</td><td>1728</td><td>NA</td><td>53.5</td><td> 1.5</td><td>0.0250000</td><td> 10.5</td><td>0.7865</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 21\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & Id & ActivityDay & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & ⋯ & FairlyActiveMinutes & LightlyActiveMinutes & SedentaryMinutes & Calories & Median\\_Value & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedAverageIntensity & MedianHourlySteps & MedianMinCalories\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <int> & <int> & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & ⋯ & 13 & 328 &  728 & 1985 & NA & 76.0 & 13.0 & 0.2166670 & 341.0 & 0.9438\\\\\n",
       "\t2 & 1503960366 & 04/13/2016 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & ⋯ & 19 & 217 &  776 & 1797 & NA & 71.5 & 11.5 & 0.1916665 & 285.0 & 0.7865\\\\\n",
       "\t3 & 1503960366 & 04/14/2016 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & ⋯ & 11 & 181 & 1218 & 1776 & NA & 62.5 &  6.0 & 0.1000000 &  69.5 & 0.9438\\\\\n",
       "\t4 & 1503960366 & 04/15/2016 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & ⋯ & 34 & 209 &  726 & 1745 & NA & 59.5 &  6.5 & 0.1083335 &  80.0 & 0.7865\\\\\n",
       "\t5 & 1503960366 & 04/16/2016 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & ⋯ & 10 & 221 &  773 & 1863 & NA & 63.5 &  9.5 & 0.1583335 & 123.5 & 0.7865\\\\\n",
       "\t6 & 1503960366 & 04/17/2016 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & ⋯ & 20 & 164 &  539 & 1728 & NA & 53.5 &  1.5 & 0.0250000 &  10.5 & 0.7865\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 21\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | ⋯ ⋯ | FairlyActiveMinutes &lt;int&gt; | LightlyActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | Median_Value &lt;dbl&gt; | Median_Hourly_Calorie &lt;dbl&gt; | MedTotalIntensity &lt;dbl&gt; | MedAverageIntensity &lt;dbl&gt; | MedianHourlySteps &lt;dbl&gt; | MedianMinCalories &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | ⋯ | 13 | 328 |  728 | 1985 | NA | 76.0 | 13.0 | 0.2166670 | 341.0 | 0.9438 |\n",
       "| 2 | 1503960366 | 04/13/2016 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | ⋯ | 19 | 217 |  776 | 1797 | NA | 71.5 | 11.5 | 0.1916665 | 285.0 | 0.7865 |\n",
       "| 3 | 1503960366 | 04/14/2016 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | ⋯ | 11 | 181 | 1218 | 1776 | NA | 62.5 |  6.0 | 0.1000000 |  69.5 | 0.9438 |\n",
       "| 4 | 1503960366 | 04/15/2016 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | ⋯ | 34 | 209 |  726 | 1745 | NA | 59.5 |  6.5 | 0.1083335 |  80.0 | 0.7865 |\n",
       "| 5 | 1503960366 | 04/16/2016 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | ⋯ | 10 | 221 |  773 | 1863 | NA | 63.5 |  9.5 | 0.1583335 | 123.5 | 0.7865 |\n",
       "| 6 | 1503960366 | 04/17/2016 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | ⋯ | 20 | 164 |  539 | 1728 | NA | 53.5 |  1.5 | 0.0250000 |  10.5 | 0.7865 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay TotalSteps TotalDistance TrackerDistance\n",
       "1 1503960366 04/12/2016  13162      8.50          8.50           \n",
       "2 1503960366 04/13/2016  10735      6.97          6.97           \n",
       "3 1503960366 04/14/2016  10460      6.74          6.74           \n",
       "4 1503960366 04/15/2016   9762      6.28          6.28           \n",
       "5 1503960366 04/16/2016  12669      8.16          8.16           \n",
       "6 1503960366 04/17/2016   9705      6.48          6.48           \n",
       "  LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance\n",
       "1 0                        1.88               0.55                    \n",
       "2 0                        1.57               0.69                    \n",
       "3 0                        2.44               0.40                    \n",
       "4 0                        2.14               1.26                    \n",
       "5 0                        2.71               0.41                    \n",
       "6 0                        3.19               0.78                    \n",
       "  LightActiveDistance SedentaryActiveDistance ⋯ FairlyActiveMinutes\n",
       "1 6.06                0                       ⋯ 13                 \n",
       "2 4.71                0                       ⋯ 19                 \n",
       "3 3.91                0                       ⋯ 11                 \n",
       "4 2.83                0                       ⋯ 34                 \n",
       "5 5.04                0                       ⋯ 10                 \n",
       "6 2.51                0                       ⋯ 20                 \n",
       "  LightlyActiveMinutes SedentaryMinutes Calories Median_Value\n",
       "1 328                   728             1985     NA          \n",
       "2 217                   776             1797     NA          \n",
       "3 181                  1218             1776     NA          \n",
       "4 209                   726             1745     NA          \n",
       "5 221                   773             1863     NA          \n",
       "6 164                   539             1728     NA          \n",
       "  Median_Hourly_Calorie MedTotalIntensity MedAverageIntensity MedianHourlySteps\n",
       "1 76.0                  13.0              0.2166670           341.0            \n",
       "2 71.5                  11.5              0.1916665           285.0            \n",
       "3 62.5                   6.0              0.1000000            69.5            \n",
       "4 59.5                   6.5              0.1083335            80.0            \n",
       "5 63.5                   9.5              0.1583335           123.5            \n",
       "6 53.5                   1.5              0.0250000            10.5            \n",
       "  MedianMinCalories\n",
       "1 0.9438           \n",
       "2 0.7865           \n",
       "3 0.9438           \n",
       "4 0.7865           \n",
       "5 0.7865           \n",
       "6 0.7865           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "## Merging with activity\n",
    "new_activity_merged <- merge(new_activity_merged, avg_min_cal,\n",
    "                            by = c(\"Id\", \"ActivityDay\"), all = TRUE)\n",
    "head(new_activity_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 52,
   "id": "d65bbe29",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:43.619514Z",
     "iopub.status.busy": "2023-07-13T02:41:43.618127Z",
     "iopub.status.idle": "2023-07-13T02:41:43.632466Z",
     "shell.execute_reply": "2023-07-13T02:41:43.630960Z"
    },
    "papermill": {
     "duration": 0.048142,
     "end_time": "2023-07-13T02:41:43.634355",
     "exception": false,
     "start_time": "2023-07-13T02:41:43.586213",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>940</li><li>21</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 940\n",
       "\\item 21\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 940\n",
       "2. 21\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 940  21"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "dim(new_activity_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 53,
   "id": "49da4036",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:43.698266Z",
     "iopub.status.busy": "2023-07-13T02:41:43.696865Z",
     "iopub.status.idle": "2023-07-13T02:41:43.710951Z",
     "shell.execute_reply": "2023-07-13T02:41:43.709624Z"
    },
    "papermill": {
     "duration": 0.048319,
     "end_time": "2023-07-13T02:41:43.712964",
     "exception": false,
     "start_time": "2023-07-13T02:41:43.664645",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "636"
      ],
      "text/latex": [
       "636"
      ],
      "text/markdown": [
       "636"
      ],
      "text/plain": [
       "[1] 636"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sum(is.na(new_activity_merged))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "5ff9369b",
   "metadata": {
    "papermill": {
     "duration": 0.029883,
     "end_time": "2023-07-13T02:41:43.772526",
     "exception": false,
     "start_time": "2023-07-13T02:41:43.742643",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Checking MinutesCalories Wide File"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 54,
   "id": "028f343d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:43.835128Z",
     "iopub.status.busy": "2023-07-13T02:41:43.833635Z",
     "iopub.status.idle": "2023-07-13T02:41:44.522708Z",
     "shell.execute_reply": "2023-07-13T02:41:44.521358Z"
    },
    "papermill": {
     "duration": 0.722166,
     "end_time": "2023-07-13T02:41:44.524396",
     "exception": false,
     "start_time": "2023-07-13T02:41:43.802230",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 62</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityHour</th><th scope=col>Calories00</th><th scope=col>Calories01</th><th scope=col>Calories02</th><th scope=col>Calories03</th><th scope=col>Calories04</th><th scope=col>Calories05</th><th scope=col>Calories06</th><th scope=col>Calories07</th><th scope=col>⋯</th><th scope=col>Calories50</th><th scope=col>Calories51</th><th scope=col>Calories52</th><th scope=col>Calories53</th><th scope=col>Calories54</th><th scope=col>Calories55</th><th scope=col>Calories56</th><th scope=col>Calories57</th><th scope=col>Calories58</th><th scope=col>Calories59</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/13/2016 12:00:00 AM</td><td>1.8876</td><td>2.2022</td><td>0.9438</td><td>0.9438</td><td>0.9438</td><td>2.0449</td><td>0.9438</td><td>2.2022</td><td>⋯</td><td>0.9438</td><td>2.0449</td><td>2.0449</td><td>0.9438</td><td>2.3595</td><td>1.8876</td><td>0.9438</td><td>0.9438</td><td>0.9438</td><td>0.9438</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/13/2016 1:00:00 AM </td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.9438</td><td>0.9438</td><td>0.9438</td><td>0.7865</td><td>⋯</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/13/2016 2:00:00 AM </td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>⋯</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/13/2016 3:00:00 AM </td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>⋯</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/13/2016 4:00:00 AM </td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>⋯</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/13/2016 5:00:00 AM </td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>⋯</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td><td>0.7865</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 62\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & Id & ActivityHour & Calories00 & Calories01 & Calories02 & Calories03 & Calories04 & Calories05 & Calories06 & Calories07 & ⋯ & Calories50 & Calories51 & Calories52 & Calories53 & Calories54 & Calories55 & Calories56 & Calories57 & Calories58 & Calories59\\\\\n",
       "  & <dbl> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/13/2016 12:00:00 AM & 1.8876 & 2.2022 & 0.9438 & 0.9438 & 0.9438 & 2.0449 & 0.9438 & 2.2022 & ⋯ & 0.9438 & 2.0449 & 2.0449 & 0.9438 & 2.3595 & 1.8876 & 0.9438 & 0.9438 & 0.9438 & 0.9438\\\\\n",
       "\t2 & 1503960366 & 4/13/2016 1:00:00 AM  & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.9438 & 0.9438 & 0.9438 & 0.7865 & ⋯ & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865\\\\\n",
       "\t3 & 1503960366 & 4/13/2016 2:00:00 AM  & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & ⋯ & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865\\\\\n",
       "\t4 & 1503960366 & 4/13/2016 3:00:00 AM  & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & ⋯ & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865\\\\\n",
       "\t5 & 1503960366 & 4/13/2016 4:00:00 AM  & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & ⋯ & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865\\\\\n",
       "\t6 & 1503960366 & 4/13/2016 5:00:00 AM  & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & ⋯ & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865 & 0.7865\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 62\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityHour &lt;chr&gt; | Calories00 &lt;dbl&gt; | Calories01 &lt;dbl&gt; | Calories02 &lt;dbl&gt; | Calories03 &lt;dbl&gt; | Calories04 &lt;dbl&gt; | Calories05 &lt;dbl&gt; | Calories06 &lt;dbl&gt; | Calories07 &lt;dbl&gt; | ⋯ ⋯ | Calories50 &lt;dbl&gt; | Calories51 &lt;dbl&gt; | Calories52 &lt;dbl&gt; | Calories53 &lt;dbl&gt; | Calories54 &lt;dbl&gt; | Calories55 &lt;dbl&gt; | Calories56 &lt;dbl&gt; | Calories57 &lt;dbl&gt; | Calories58 &lt;dbl&gt; | Calories59 &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/13/2016 12:00:00 AM | 1.8876 | 2.2022 | 0.9438 | 0.9438 | 0.9438 | 2.0449 | 0.9438 | 2.2022 | ⋯ | 0.9438 | 2.0449 | 2.0449 | 0.9438 | 2.3595 | 1.8876 | 0.9438 | 0.9438 | 0.9438 | 0.9438 |\n",
       "| 2 | 1503960366 | 4/13/2016 1:00:00 AM  | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.9438 | 0.9438 | 0.9438 | 0.7865 | ⋯ | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 |\n",
       "| 3 | 1503960366 | 4/13/2016 2:00:00 AM  | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | ⋯ | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 |\n",
       "| 4 | 1503960366 | 4/13/2016 3:00:00 AM  | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | ⋯ | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 |\n",
       "| 5 | 1503960366 | 4/13/2016 4:00:00 AM  | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | ⋯ | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 |\n",
       "| 6 | 1503960366 | 4/13/2016 5:00:00 AM  | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | ⋯ | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 | 0.7865 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityHour          Calories00 Calories01 Calories02 Calories03\n",
       "1 1503960366 4/13/2016 12:00:00 AM 1.8876     2.2022     0.9438     0.9438    \n",
       "2 1503960366 4/13/2016 1:00:00 AM  0.7865     0.7865     0.7865     0.7865    \n",
       "3 1503960366 4/13/2016 2:00:00 AM  0.7865     0.7865     0.7865     0.7865    \n",
       "4 1503960366 4/13/2016 3:00:00 AM  0.7865     0.7865     0.7865     0.7865    \n",
       "5 1503960366 4/13/2016 4:00:00 AM  0.7865     0.7865     0.7865     0.7865    \n",
       "6 1503960366 4/13/2016 5:00:00 AM  0.7865     0.7865     0.7865     0.7865    \n",
       "  Calories04 Calories05 Calories06 Calories07 ⋯ Calories50 Calories51\n",
       "1 0.9438     2.0449     0.9438     2.2022     ⋯ 0.9438     2.0449    \n",
       "2 0.9438     0.9438     0.9438     0.7865     ⋯ 0.7865     0.7865    \n",
       "3 0.7865     0.7865     0.7865     0.7865     ⋯ 0.7865     0.7865    \n",
       "4 0.7865     0.7865     0.7865     0.7865     ⋯ 0.7865     0.7865    \n",
       "5 0.7865     0.7865     0.7865     0.7865     ⋯ 0.7865     0.7865    \n",
       "6 0.7865     0.7865     0.7865     0.7865     ⋯ 0.7865     0.7865    \n",
       "  Calories52 Calories53 Calories54 Calories55 Calories56 Calories57 Calories58\n",
       "1 2.0449     0.9438     2.3595     1.8876     0.9438     0.9438     0.9438    \n",
       "2 0.7865     0.7865     0.7865     0.7865     0.7865     0.7865     0.7865    \n",
       "3 0.7865     0.7865     0.7865     0.7865     0.7865     0.7865     0.7865    \n",
       "4 0.7865     0.7865     0.7865     0.7865     0.7865     0.7865     0.7865    \n",
       "5 0.7865     0.7865     0.7865     0.7865     0.7865     0.7865     0.7865    \n",
       "6 0.7865     0.7865     0.7865     0.7865     0.7865     0.7865     0.7865    \n",
       "  Calories59\n",
       "1 0.9438    \n",
       "2 0.7865    \n",
       "3 0.7865    \n",
       "4 0.7865    \n",
       "5 0.7865    \n",
       "6 0.7865    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "min_cal_wide <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/minuteCaloriesWide_merged.csv\")\n",
    "head(min_cal_wide)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "23af0165",
   "metadata": {
    "papermill": {
     "duration": 0.030062,
     "end_time": "2023-07-13T02:41:44.585074",
     "exception": false,
     "start_time": "2023-07-13T02:41:44.555012",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "The wide file is also minute wise recording of the calories spend. So, we can consider just minutecaloriesnarrow's data as it's also minute wise recording of calories spent."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "81da3829",
   "metadata": {
    "papermill": {
     "duration": 0.029264,
     "end_time": "2023-07-13T02:41:44.644041",
     "exception": false,
     "start_time": "2023-07-13T02:41:44.614777",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Checking MinuteIntensities Narrow"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 55,
   "id": "2905504d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:44.706840Z",
     "iopub.status.busy": "2023-07-13T02:41:44.705531Z",
     "iopub.status.idle": "2023-07-13T02:41:46.924148Z",
     "shell.execute_reply": "2023-07-13T02:41:46.922760Z"
    },
    "papermill": {
     "duration": 2.252251,
     "end_time": "2023-07-13T02:41:46.926141",
     "exception": false,
     "start_time": "2023-07-13T02:41:44.673890",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityMinute</th><th scope=col>Intensity</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016 12:00:00 AM</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/12/2016 12:01:00 AM</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/12/2016 12:02:00 AM</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/12/2016 12:03:00 AM</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/12/2016 12:04:00 AM</td><td>0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/12/2016 12:05:00 AM</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & ActivityMinute & Intensity\\\\\n",
       "  & <dbl> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 12:00:00 AM & 0\\\\\n",
       "\t2 & 1503960366 & 4/12/2016 12:01:00 AM & 0\\\\\n",
       "\t3 & 1503960366 & 4/12/2016 12:02:00 AM & 0\\\\\n",
       "\t4 & 1503960366 & 4/12/2016 12:03:00 AM & 0\\\\\n",
       "\t5 & 1503960366 & 4/12/2016 12:04:00 AM & 0\\\\\n",
       "\t6 & 1503960366 & 4/12/2016 12:05:00 AM & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityMinute &lt;chr&gt; | Intensity &lt;int&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 12:00:00 AM | 0 |\n",
       "| 2 | 1503960366 | 4/12/2016 12:01:00 AM | 0 |\n",
       "| 3 | 1503960366 | 4/12/2016 12:02:00 AM | 0 |\n",
       "| 4 | 1503960366 | 4/12/2016 12:03:00 AM | 0 |\n",
       "| 5 | 1503960366 | 4/12/2016 12:04:00 AM | 0 |\n",
       "| 6 | 1503960366 | 4/12/2016 12:05:00 AM | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityMinute        Intensity\n",
       "1 1503960366 4/12/2016 12:00:00 AM 0        \n",
       "2 1503960366 4/12/2016 12:01:00 AM 0        \n",
       "3 1503960366 4/12/2016 12:02:00 AM 0        \n",
       "4 1503960366 4/12/2016 12:03:00 AM 0        \n",
       "5 1503960366 4/12/2016 12:04:00 AM 0        \n",
       "6 1503960366 4/12/2016 12:05:00 AM 0        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 1</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>ActivityMinute</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>4/12/2016 12:00:00 AM</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>4/12/2016 12:01:00 AM</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>4/12/2016 12:02:00 AM</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>4/12/2016 12:03:00 AM</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>4/12/2016 12:04:00 AM</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>4/12/2016 12:05:00 AM</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 1\n",
       "\\begin{tabular}{r|l}\n",
       "  & ActivityMinute\\\\\n",
       "  & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 4/12/2016 12:00:00 AM\\\\\n",
       "\t2 & 4/12/2016 12:01:00 AM\\\\\n",
       "\t3 & 4/12/2016 12:02:00 AM\\\\\n",
       "\t4 & 4/12/2016 12:03:00 AM\\\\\n",
       "\t5 & 4/12/2016 12:04:00 AM\\\\\n",
       "\t6 & 4/12/2016 12:05:00 AM\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 1\n",
       "\n",
       "| <!--/--> | ActivityMinute &lt;chr&gt; |\n",
       "|---|---|\n",
       "| 1 | 4/12/2016 12:00:00 AM |\n",
       "| 2 | 4/12/2016 12:01:00 AM |\n",
       "| 3 | 4/12/2016 12:02:00 AM |\n",
       "| 4 | 4/12/2016 12:03:00 AM |\n",
       "| 5 | 4/12/2016 12:04:00 AM |\n",
       "| 6 | 4/12/2016 12:05:00 AM |\n",
       "\n"
      ],
      "text/plain": [
       "  ActivityMinute       \n",
       "1 4/12/2016 12:00:00 AM\n",
       "2 4/12/2016 12:01:00 AM\n",
       "3 4/12/2016 12:02:00 AM\n",
       "4 4/12/2016 12:03:00 AM\n",
       "5 4/12/2016 12:04:00 AM\n",
       "6 4/12/2016 12:05:00 AM"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>Intensity</th><th scope=col>ActivityDay</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>0</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>0</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>0</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>0</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>0</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>0</td><td>04/12/2016</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & Intensity & ActivityDay\\\\\n",
       "  & <dbl> & <int> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 0 & 04/12/2016\\\\\n",
       "\t2 & 1503960366 & 0 & 04/12/2016\\\\\n",
       "\t3 & 1503960366 & 0 & 04/12/2016\\\\\n",
       "\t4 & 1503960366 & 0 & 04/12/2016\\\\\n",
       "\t5 & 1503960366 & 0 & 04/12/2016\\\\\n",
       "\t6 & 1503960366 & 0 & 04/12/2016\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | Intensity &lt;int&gt; | ActivityDay &lt;chr&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 1503960366 | 0 | 04/12/2016 |\n",
       "| 2 | 1503960366 | 0 | 04/12/2016 |\n",
       "| 3 | 1503960366 | 0 | 04/12/2016 |\n",
       "| 4 | 1503960366 | 0 | 04/12/2016 |\n",
       "| 5 | 1503960366 | 0 | 04/12/2016 |\n",
       "| 6 | 1503960366 | 0 | 04/12/2016 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         Intensity ActivityDay\n",
       "1 1503960366 0         04/12/2016 \n",
       "2 1503960366 0         04/12/2016 \n",
       "3 1503960366 0         04/12/2016 \n",
       "4 1503960366 0         04/12/2016 \n",
       "5 1503960366 0         04/12/2016 \n",
       "6 1503960366 0         04/12/2016 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "min_int_nrr <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/minuteIntensitiesNarrow_merged.csv\")\n",
    "head(min_int_nrr)\n",
    "activity_col <- min_int_nrr%>%\n",
    "select(matches(\"ActivityH|ActivityM|ActivityD|Day\"))\n",
    "\n",
    "head(activity_col)\n",
    "\n",
    "\n",
    "min_int_nrr <- min_int_nrr%>%\n",
    "select(-matches(\"ActivityH|ActivityM|ActivityD|Day\"))\n",
    "\n",
    "\n",
    "\n",
    "activity_col <- activity_col%>%\n",
    "mutate(ActivityDay = as.Date(activity_col$ActivityMinute, format = \"%m/%d/%Y\"))%>%\n",
    "select(matches(\"ActivityDay\"))\n",
    "\n",
    "\n",
    "\n",
    "min_int_nrr <- cbind(min_int_nrr, Series = activity_col)\n",
    "\n",
    "min_int_nrr$ActivityDay <- format(min_int_nrr$ActivityDay, \"%m/%d/%Y\")\n",
    "head(min_int_nrr)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 56,
   "id": "c0fb723c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:46.990408Z",
     "iopub.status.busy": "2023-07-13T02:41:46.989002Z",
     "iopub.status.idle": "2023-07-13T02:41:52.013227Z",
     "shell.execute_reply": "2023-07-13T02:41:52.011970Z"
    },
    "papermill": {
     "duration": 5.058844,
     "end_time": "2023-07-13T02:41:52.015672",
     "exception": false,
     "start_time": "2023-07-13T02:41:46.956828",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nO3dfZjVdb3v/+9ac8fIcBgE5VYUiQRlY4U2mDebsRStA9LvuO1nhjc79tZLEyrr\nVxdqoNtMa1dHTTyWZoqh6VGLY6N1UVD8VKz4mSYGwsBE6Qw7kRuBuV2zfn+MEQHiXN7Md75v\nHo+/mu/61PX6i+vZd63vWrlisZgAAJB9+bQHAADwzhB2AABBCDsAgCCEHQBAEMIOACAIYQcA\nEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAA\nghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBA\nEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAI\nQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABB\nCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAI\nYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh\n7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCE\nHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISw\nAwAIQtgBAARRmvaADNi6devdd9/d3Nyc9hAAoFeorKy84IIL+vfvn/aQPQm7N/fDH/5w9uzZ\naa8AAHqR0tLSSy+9NO0VexJ2b669vT1JkjvvvPPYY49NewsAkLJnn33205/+dFce9DbCrruO\nOuqoiRMnpr0CAEhZS0tL2hPekIcnAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQRFa/7mRz\n4/rVq9dsfHXbjp0tpX369h84ZMzYcUcOrU57FwBAajIWdsXC1ge+fc3Ndy58ctXGvV8dMnbS\nJ2fOvnr2J6pLcz2/DQAgXVkKu0LbSxcdf+yC5zaVlB1cc+q0CeNGDx1UXVFR2tHauuWVpj+t\nWfnksqe/9YVz71n46LNP3TOs3LvMAMCBJUth99QVZyx4btNJn7npvhsuHdF3H8s72zbdd+Nl\nM+YuPO3ymStvn9zjAwEA0pSl21pzFqypGnrJsltm7bPqkiTJlw887+r7b6sZXH//VT28DQAg\ndVkKuz/saK8aOfVNj0085dD2nSt7YA8AQK+SpbA7a2Dl5lU3NLV17u9QZ/P3H2joM2BKT40C\nAOgtshR2V944pXXrsvGTzrn3Zyt2FIp7vlxsfWHZIzNPG3dbw7bJc+emMRAAIE1ZenhizAUP\nfu+3p188/+EZZzxUUt7/yDGjhx1SXVFRVmhr3fpK47o19a+2dORyudpLb1102bi0xwKh9OvX\nb8eOHbv+7Nu372uvvZbiHoB9ylLYJUl+5ncWnznjx7fedV/dkuWr/vjMmpWv37fL5StGjD7m\ntNop586cddbxw9NdCQSTz+eLxX94l2D79u35fL6zc7+fDAHocdkKuyRJkuE106+vmX59khQ7\nmrdseW1Hc1t55UH9qgdU+lJi4F2wq+pyuVwul0uSpPg32g7obbIXdrvkSisHDKockPYMILCS\nkpKuquvTp09zc/Ou65WVlS0tLcVisaSkpFAopDcQ4B9k6eEJgB7WdUMun8/vXnVJkjQ3N+fz\n+V0HAHqJDN+x26e2bU8cftTZSZI0NjZ253yhUKirq2tpadnPmWeeeSZJkvb29ndkIZA5+7wn\nVygUut6ZBeg9ooVdsdjW1NTU/fNLliyZNm1ad04uXLhw8uTJb3EWAMC7L1rYlVcdt3z58u6f\nr62tXbRo0f7v2M2fP3/p0qUjRox42+uATBo4cOCmTZv2uFhdXZ3KGID9iBZ2uZJ+NTU13T9f\nUlIydeqb/ExZXV1dkiRdn6cBDii5XK5YLG7evHnvl7Zt29Z1oMdHAbyhEGFXbFvx/y5raNzS\nf9h7TvzQhMq8f2eBd0bXw7B7f7PJru9A6dOnT3rrAPaUsbtQr637xWc+MWX0yKHDjjjq45f+\nR1NbZ+vmp08bc+hxp3zk7E+cfdrJ7zvksA9+Z+lLac8Egti5c2fX3fpisZjbTVfV5fP5nTt3\npr0R4O+ydMeu+a+PTzhmakNLRy5fWX3Qqz++7Su/Xd1vTuvXf7Fu+z//y4UnjB3ctOr/W/jQ\n4tmnTxiy4c9nDzko7b1ABIVCoaysrKOjY4/rpaWlHpYHepss3bFbdN6/N7R0XPitRdtad7z6\nWvNTCy5/6Zefm/Vk08fv/v3SB+762rU33PXAzxuW3VRS2Pz5C+rSHgvE0d7eXiwWDz/88NLS\n0tLS0sMPP7xYLKo6oBfKUth9/amN1aPn3vW5qVWluSTJT/rUzeccclCufMR9nxq/68zQD13+\ntSOr/2v5f6a4EwipoaGhvb29vb29oaEh7S0A+5alsPtjc3v/cSfvfmX6wMqyqg+U/+PDEhOO\n7Ne+Y2WPLgMA6AWy9Bm7sZVl61b+Okk+vOvKB7909bzNh+1x7IWG10or39Oz0wAA0pelO3Zf\nOuHQbQ3/cdn3n9j1lQOjL5z9/3zu/9r9zCsrvvfltVsOHj+75+cBAKQrS2E3beEd76ksnf/p\nk/qPGHv6//3TPV594btfv/jcKaNqLmnL9b1+wcdTWQgAkKIshV3loCm/f/EXV8w4c1DrSyue\n+a89Xn3u21//7v0/LxtVc+vPV170nv6pLAQASFGWPmOXJMlBw0/+z3tO/s8k6Wzv3OOlE//n\ngicGv/eE9432uxMAwIEpY2G3S75sz3uNh005c8/HKAAADiRZeisWAID9EHYAAEEIOwCAIIQd\nAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLAD\nAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYA\nAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4A\nIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEA\nBCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCA\nIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIErTHvB2dbZt/OWjjz+3\n9qXOiuqx7z/xjJOPLc2lvQkAIA1ZCrva2trKQR+ve3DWritrHrn+oxdds3Zr264rA48+/Y4H\nfzT96Oo0BgIApClLYbd06dKqYeN3/bl1zfz3/cvVzcWyKedffurE8cP6Jc8//dj8Oxadc/wJ\ni1/+/Sn9K1KcCgDQ87IUdnv44TnzmjuLcx9/ce7pI1+/dNG/f+78bw4/6YsX/uvidQ99LNV1\nAAA9LcMPT3xz9eZ+h13596pLkiRJBn/oimtH9X958VfTWgUAkJYMh90r7Z1Vh5+49/Xjjqhq\n3/F8z+8BAEhXhsPu/CF9t294au/ry9ZuK6s6tuf3AACkK2Nh1/Jq3YUXz77uG7fc/8hjp14+\n6bUN133l53/e/cDqh+dct2HbkJO/lNZCAIC0ZOnhiQ9OOGrtunV3f/fm3S9+bfrka3fWJ0mS\nFDvO/9gJCx9fUVIx/PYffCSdiQAA6clS2D397KokSbZs3FC/dm19ff3a+vr6+vr1G7b97fXC\ngsd+N2DMKTf96OEpA/ukuBMAIBVZCrsu1YNHThw8cuKJp+75Qq7syT+snzT+CD88AQAcmLIX\ndm8sf8L4I9LeAACQmkhh91YUCoW6urqWlpb9nGloaEiSpLOzs4c2AQC8JdHCrm3bE4cfdXaS\nJI2Njd05v2TJkmnTpnXn5Pr169/WMgCAd1m0sCsW25qamrp/vra2dtGiRfu/Yzd//vylS5eO\nGjXqba8DAHgXRQu78qrjli9f3v3zJSUlU6dO3f+Zurq6JEny+Yx95x8AcKCJFna5kn41NTVp\nrwAASEH2wq5t64blT/7muRf/OvQ9x3z0zJMr83t+vcnKnzz4++1t5513XirzAADSkrGwW/7d\nWdMvn7+xrdD1Z9XhNbf9pO5Txx68+5mffPbfrmzYKuwAgANNlsLuv34z78RLvpOUVM/47KWT\nxg7Z8Luf3XpX3YUfPLp87dpzDqtKex0AQMqyFHZ3nn9zku9797P1nzp6QJIkycWfmfWpm977\n4c//2ykXT62/d+/3ZAEADihZetLztobXBo6/6fWqS5IkSYb98+xfXHPCtoaF/+OO1SkOAwDo\nDbIUdtsLnX0OOWyPix/88k/PGFS5+LPTXtjZkcoqAIBeIkthd2p1n7+u+Pr2QnH3i7mS/nc/\nOqfQsvaMs28pvtF/EwDgAJClsPvyzLEtmxdPPHfe8y/v2P36oTVX/e+Z4/782OdPmn371oK6\nAwAOUFkKuw9c+9i5Ew5+8cFrJ4zoP2zUex/Z1LzrpbPmL5vz30c/efMlQ4a8546mHfv5HwEA\niCpLYZcvO/TeFavvuPbyk97/3rbNjVs7/n5zLl968FcXvXDPf1x8REnT+hYftgMADkRZCrsk\nSfKlgz599c2/XvHCK1teu3DwQf/wWq58xlX/649N2/7y4rNLfl6X0kAAgNRk6Xvsuqdk+JgJ\nw8dMSHsGAEBPy9gdOwAA3oiwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcA\nEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAA\nghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBA\nEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAI\nQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABB\nCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAI\nYQcAEISwAwAIojTtAW/R5sb1q1ev2fjqth07W0r79O0/cMiYseOOHFqd9i4AgNRkLOyKha0P\nfPuam+9c+OSqjXu/OmTspE/OnH317E9Ul+Z6fhsAQLqyFHaFtpcuOv7YBc9tKik7uObUaRPG\njR46qLqiorSjtXXLK01/WrPyyWVPf+sL596z8NFnn7pnWLl3mQGAA0uWwu6pK85Y8Nymkz5z\n0303XDqi7z6Wd7Ztuu/Gy2bMXXja5TNX3j65xwcCAKQpS7e15ixYUzX0kmW3zNpn1SVJki8f\neN7V999WM7j+/qt6eBsAQOqyFHZ/2NFeNXLqmx6beMqh7TtX9sAeAIBeJUthd9bAys2rbmhq\n69zfoc7m7z/Q0GfAlJ4aBQDQW2Qp7K68cUrr1mXjJ51z789W7CgU93y52PrCskdmnjbutoZt\nk+fOTWMgAECasvTwxJgLHvzeb0+/eP7DM854qKS8/5FjRg87pLqioqzQ1rr1lcZ1a+pfbenI\n5XK1l9666LJxaY8FQpk8efKyZcuKxWKSJLlc7uSTT166dGnaowD2lKWwS5L8zO8sPnPGj2+9\n6766JctX/fGZNStfv2+Xy1eMGH3MabVTzp0566zjh6e7Eggmn893JV2XYrH4q1/9Kp/Pd3bu\n95MhAD0uW2GXJEkyvGb69TXTr0+SYkfzli2v7WhuK688qF/1gEpfSgy8C3avulwulyRJ15/F\nYlHbAb1N9sJul1xp5YBBlQPSngEEVlpa2pVxpaWl7e3tu66XlZV1dHQUi8XS0tKOjo70BgL8\ngyw9PAHQwwqFQpIkuVxu96pLkqS9vb3r7l3XAYBeIsN37PapbdsThx91dpIkjY2N3TlfKBTq\n6upaWlr2c6ahoSFJEm+4wAHrlFNO2efFX/3qVz0/BmA/ooVdsdjW1NTU/fNLliyZNm1ad06u\nX7/+rY4Csm2fD8AuXbq066YdQO8RLezKq45bvnx598/X1tYuWrRo/3fs5s+fv3Tp0lGjRr3t\ndUAmHXHEEV137ve4mMIUgP2KFna5kn41NTXdP19SUjJ16pv8TFldXV2SJPm8zyPCASeXyxWL\nxQ0bNuz9UtdFN+2AXiV7Yde2dcPyJ3/z3It/HfqeYz565smV+T3/VV35kwd/v73tvPPOS2Ue\nEElZWVlbW1uxWCwpKdn9OYmSkpKup2XLysrSWwewp4yF3fLvzpp++fyNba//81p1eM1tP6n7\n1LEH737mJ5/9tysbtgo74O1rbW3t+h67zs7OXC63+/fYJUmSy+VaW1tTHQjwD7IUdv/1m3kn\nXvKdpKR6xmcvnTR2yIbf/ezWu+ou/ODR5WvXnnNYVdrrgJg6OztLSkq6novf/fcn8vm87zoB\nepsshd2d59+c5Pve/Wz9p44ekCRJcvFnZn3qpvd++PP/dsrFU+vv3fs9WYB3RFfAVVRUdH0X\ncWlpqRt1QO+UpQcCbmt4beD4m16vuiRJkmTYP8/+xTUnbGtY+D/uWJ3iMOBA0NraWigUCoWC\nqgN6rSyF3fZCZ59DDtvj4ge//NMzBlUu/uy0F3b6VR8A4ICWpbA7tbrPX1d8fXuhuPvFXEn/\nux+dU2hZe8bZtxTf6L8JAHAAyFLYfXnm2JbNiyeeO+/5l3fsfv3Qmqv+98xxf37s8yfNvn1r\nQd0BAAeoLIXdB6597NwJB7/44LUTRvQfNuq9j2xq3vXSWfOXzfnvo5+8+ZIhQ95zR9OO/fyP\nAABElaWwy5cdeu+K1Xdce/lJ739v2+bGrR27fe9A6cFfXfTCPf9x8RElTetbfNgOADgQZSns\nkiTJlw769NU3/3rFC69see3CwQf9w2u58hlX/a8/Nm37y4vPLvl5XUoDAQBSk6XvseuekuFj\nJgwfMyHtGQAAPS1jd+wAAHgjwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQd\nAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLAD\nAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYA\nAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4A\nIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEA\nBCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCA\nIIQdAEAQwg4AIAhhBwAQRGnaA96uzraNv3z08efWvtRZUT32/SeecfKxpbm0NwEApCFLYVdb\nW1s56ON1D87adWXNI9d/9KJr1m5t23Vl4NGn3/Hgj6YfXZ3GQACANGUp7JYuXVo1bPyuP7eu\nmf++f7m6uVg25fzLT504fli/5PmnH5t/x6Jzjj9h8cu/P6V/RYpTAQB6XpbCbg8/PGdec2dx\n7uMvzj195OuXLvr3z53/zeEnffHCf1287qGPpboOAKCnZfjhiW+u3tzvsCv/XnVJkiTJ4A9d\nce2o/i8v/mpaqwAA0pLhsHulvbPq8BP3vn7cEVXtO57v+T0AAOnKcNidP6Tv9g1P7X192dpt\nZVXH9vweAIB0ZSzsWl6tu/Di2dd945b7H3ns1Msnvbbhuq/8/M+7H1j98JzrNmwbcvKX0loI\nAJCWLD088cEJR61dt+7u7968+8WvTZ987c76JEmSYsf5Hzth4eMrSiqG3/6Dj6QzEQAgPVkK\nu6efXZUkyZaNG+rXrq2vr19bX19fX79+w7a/vV5Y8NjvBow55aYfPTxlYJ8UdwIApCJLYdel\nevDIiYNHTjzx1D1fyJU9+Yf1k8Yf4YcnAIADU/bC7o3lTxh/RNobAABSk7GHJwAAeCOR7tgl\nSZK0bXvi8KPOTpKksbGxO+cLhUJdXV1LS8t+zjQ0NCRJ0tnZ+U4MBAB4t0QLu2Kxrampqfvn\nlyxZMm3atO6cXL9+/VsdBQDQE6KFXXnVccuXL+/++dra2kWLFu3/jt38+fOXLl06atSot70O\nAOBdFC3sciX9ampqun++pKRk6tSp+z9TV1eXJEk+7/OIAECvJlYAAIIQdgAAQQg7AIAgsvQZ\nuy1NjTsK3f3OkeHDh7+rYwAAepsshd0X3//eO5q2d/NwsVh8V8cAAPQ2WQq76xY/dtQPbv3K\nt3/UXCgO+KfJJx5elfYiAIBeJEthN/iYk77wjZNqD1533JzfjLvstv9z8di0FwEA9CLZe3ji\nny77ZtoTAAB6o+yFXfl/O+kDI4b071OS9hAAgN4lS2/F7rLiz41pTwAA6HWyd8cOAIB9EnYA\nAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4A\nIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEA\nBCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCA\nIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQ\nhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACC\nEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQ\nwg4AIIjStAe8RZsb169evWbjq9t27Gwp7dO3/8AhY8aOO3Joddq7AABSk7GwKxa2PvDta26+\nc+GTqzbu/eqQsZM+OXP21bM/UV2a6/ltAADpylLYFdpeuuj4Yxc8t6mk7OCaU6dNGDd66KDq\niorSjtbWLa80/WnNyieXPf2tL5x7z8JHn33qnmHl3mUGAA4sWQq7p644Y8Fzm076zE333XDp\niL77WN7Ztum+Gy+bMXfhaZfPXHn75B4fCACQpizd1pqzYE3V0EuW3TJrn1WXJEm+fOB5V99/\nW83g+vuv6uFtAACpy1LY/WFHe9XIqW96bOIph7bvXNkDewAAepUshd1ZAys3r7qhqa1zf4c6\nm7//QEOfAVN6ahQAQG+RpbC78sYprVuXjZ90zr0/W7GjUNzz5WLrC8semXnauNsatk2eOzeN\ngUBk5eXlJSUlJSUl5eXlaW8B2LcsPTwx5oIHv/fb0y+e//CMMx4qKe9/5JjRww6prqgoK7S1\nbn2lcd2a+ldbOnK5XO2lty66bFzaY4E4SkpKOjv//l5BZ2dnLpfL5/OFQiHFVQB7y1LYJUl+\n5ncWnznjx7fedV/dkuWr/vjMmpWv37fL5StGjD7mtNop586cddbxw9NdCUSSz+eLxb/9U5PL\nJUnS9WdnZ2c+n989+ABSl62wS5IkGV4z/fqa6dcnSbGjecuW13Y0t5VXHtSvekClLyUG3mnl\n5eVdGbfH/bmue3jFYrG8vLytrS29gQD/IHtht0uutHLAoMoBac8AAuvo6EiSJJfL7fGua6FQ\n6LqT13UAoJfIcNjtU9u2Jw4/6uwkSRobG7tzvlAo1NXVtbS07OdMQ0NDkiTecIEDUNftupEj\nR+790siRI//0pz/tepcWoDeIFnbFYltTU1P3zy9ZsmTatGndObl+/fq3OgrItq7/d7f3xa6P\n3AH0HtHCrrzquOXLl3f/fG1t7aJFi/Z/x27+/PlLly4dNWrU214HZNLkyZOXLl2698UUpgDs\nV7Swy5X0q6mp6f75kpKSqVPf5Ncs6urqkiTJ57P0nX/AO+jXv/51Ny8CpEusALyh0tLSJEmK\nxWJZWdnu18vKyro+Xdd1AKCX8E8SwBtqb2/f9fRrLpfb/XvskiTJ5XLt7e2pDgT4B+7YAexP\n1+9MdP3nYrG4e9V5WB7obYQdwJvo7OycO3duPp/vummXz+fnzp2r6oBeKEtvxW5patxR6O6/\npMOH+2Ex4B0zb968efPmpb0C4E1kKey++P733tG0vZuHfWsoAHCgyVLYXbf4saN+cOtXvv2j\n5kJxwD9NPvHwqrQXAQD0IlkKu8HHnPSFb5xUe/C64+b8Ztxlt/2fi8emvQgAoBfJ3sMT/3TZ\nN9OeAADQG2Uv7Mr/20kfGDGkf5+StIcAAPQuWXordpcVf25MewIAQK+TvTt2AADsk7ADAAhC\n2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEI\nOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhh\nBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHs\nAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQd\nAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLAD\nAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2KrPJd8AAA1eSURB\nVAEABCHsAACCKE17wNvV2bbxl48+/tzalzorqse+/8QzTj62NJf2JgCANGQp7GpraysHfbzu\nwVm7rqx55PqPXnTN2q1tu64MPPr0Ox780fSjq9MYCACQpiyF3dKlS6uGjd/159Y189/3L1c3\nF8umnH/5qRPHD+uXPP/0Y/PvWHTO8Scsfvn3p/SvSHEqAEDPy1LY7eGH58xr7izOffzFuaeP\nfP3SRf/+ufO/OfykL174r4vXPfSxVNcBAPS0DD888c3Vm/sdduXfqy5JkiQZ/KErrh3V/+XF\nX01rFQBAWjIcdq+0d1YdfuLe1487oqp9x/M9vwcAIF0ZDrvzh/TdvuGpva8vW7utrOrYnt8D\nAJCujIVdy6t1F148+7pv3HL/I4+devmk1zZc95Wf/3n3A6sfnnPdhm1DTv5SWgsBANKSpYcn\nPjjhqLXr1t393Zt3v/i16ZOv3VmfJElS7Dj/YycsfHxFScXw23/wkXQmAgCkJ0th9/Szq5Ik\n2bJxQ/3atfX19Wvr6+vr69dv2Pa31wsLHvvdgDGn3PSjh6cM7JPiTgCAVGQp7LpUDx45cfDI\niSeeuucLubIn/7B+0vgj/PAEAHBgyl7YvbH8CeOPSHsDAEBqMvbwBAAAbyTSHbskSZK2bU8c\nftTZSZI0NjZ253yhUKirq2tpadnPmYaGhiRJOjs734mBAADvlmhhVyy2NTU1df/8kiVLpk2b\n1p2T69evf6ujAAB6QrSwK686bvny5d0/X1tbu2jRov3fsZs/f/7SpUtHjRr1ttcBALyLooVd\nrqRfTU1N98+XlJRMnTp1/2fq6uqSJMnnfR4RAOjVshp2mxvXr169ZuOr23bsbCnt07f/wCFj\nxo47cmh12rsAAFKTsbArFrY+8O1rbr5z4ZOrNu796pCxkz45c/bVsz9RXerL7ACAA06Wwq7Q\n9tJFxx+74LlNJWUH15w6bcK40UMHVVdUlHa0tm55pelPa1Y+uezpb33h3HsWPvrsU/cMK/fO\nKQBwYMlS2D11xRkLntt00mduuu+GS0f03cfyzrZN99142Yy5C0+7fObK2yf3+EAAgDRl6bbW\nnAVrqoZesuyWWfusuiRJ8uUDz7v6/ttqBtfff1UPbwMASF2Wwu4PO9qrRr7JE6xJkkw85dD2\nnSt7YA8AQK+SpbA7a2Dl5lU3NLXt9xcgOpu//0BDnwFTemoUAEBvkaWwu/LGKa1bl42fdM69\nP1uxo1Dc8+Vi6wvLHpl52rjbGrZNnjs3jYEAAGnK0sMTYy548Hu/Pf3i+Q/POOOhkvL+R44Z\nPeyQ6oqKskJb69ZXGtetqX+1pSOXy9Veeuuiy8alPRYAoKdlKeySJD/zO4vPnPHjW++6r27J\n8lV/fGbNytfv2+XyFSNGH3Na7ZRzZ8466/jh6a4EAEhFtsIuSZJkeM3062umX58kxY7mLVte\n29HcVl55UL/qAZW+lBgAOLBlL+x2yZVWDhhUOSDtGQAAvUSWHp4AAGA/hB0AQBDCDgAgCGEH\nABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewA\nAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0A\nQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMA\nCELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAA\nQQg7AIAghB0AQBDCDgAgCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAg\nCGEHABCEsAMACELYAQAEIewAAIIQdgAAQQg7AIAghB0AQBDCDgAgiNK0B7xFmxvXr169ZuOr\n23bsbCnt07f/wCFjxo47cmh12rsAAFKTsbArFrY+8O1rbr5z4ZOrNu796pCxkz45c/bVsz9R\nXZrr+W0AAOnKUtgV2l666PhjFzy3qaTs4JpTp00YN3rooOqKitKO1tYtrzT9ac3KJ5c9/a0v\nnHvPwkeffeqeYeXeZQYADixZCrunrjhjwXObTvrMTffdcOmIvvtY3tm26b4bL5sxd+Fpl89c\nefvkHh8IAJCmLN3WmrNgTdXQS5bdMmufVZckSb584HlX339bzeD6+6/q4W0AAKnLUtj9YUd7\n1cipb3ps4imHtu9c2QN7AAB6lSyF3VkDKzevuqGprXN/hzqbv/9AQ58BU3pqFABAb5GlsLvy\nximtW5eNn3TOvT9bsaNQ3PPlYusLyx6Zedq42xq2TZ47N42BAABpytLDE2MuePB7vz394vkP\nzzjjoZLy/keOGT3skOqKirJCW+vWVxrXral/taUjl8vVXnrrosvGpT0WAKCnZSnskiQ/8zuL\nz5zx41vvuq9uyfJVf3xmzcrX79vl8hUjRh9zWu2Uc2fOOuv44emuBABIRbbCLkmSZHjN9Otr\npl+fJMWO5i1bXtvR3FZeeVC/6gGVvpQYADiwZS/sdsmVVg4YVDkg7RnQw+bNm3fNNdekvQJS\nMHfu3Hnz5qW9Anq1DIfdPrVte+Lwo85OkqSxsbE75wuFQl1dXUtLy37ONDQ0JEnS2bnfp3Gh\nR2zfvn3z5s1pr4B0bN68efv27VVVVWkPgd4rWtgVi21NTU3dP79kyZJp06Z15+Rf/vKXtzoK\n3jFnnXXWL3/5y7RXQDpuvvnm559//he/+EXaQ6D3ihZ25VXHLV++vPvna2trFy1atP87dj/9\n6U/vvvvuT37yk297Hbxdc+bMaW1tfeKJJ9IeAik48cQT58yZk/YK6NWihV2upF9NTU33z5eU\nlEyd+ia/ZvHyyy/ffffdZWVlb28avAM+/OEPL1u2TNhxYPrIRz7y4Q9/OO0V0KtFCzsIb968\neT4/DsA+ZTXsNjeuX716zcZXt+3Y2VLap2//gUPGjB135NDqtHcBAKQmY2FXLGx94NvX3Hzn\nwidXbdz71SFjJ31y5uyrZ3+i2nfaAQAHniyFXaHtpYuOP3bBc5tKyg6uOXXahHGjhw6qrqgo\n7Wht3fJK05/WrHxy2dPf+sK59yx89Nmn7hlWnqWfwQUAePuyFHZPXXHGguc2nfSZm+674dIR\nffexvLNt0303XjZj7sLTLp+58vbJPT4QACBNWbqtNWfBmqqhlyy7ZdY+qy5Jknz5wPOuvv+2\nmsH191/Vw9sAAFKXpbD7w472qpFv8tUkSZJMPOXQ9p0re2APAECvkqWwO2tg5eZVNzS17fen\nvTqbv/9AQ58BU3pqFABAb5GlsLvyximtW5eNn3TOvT9bsaNQ3PPlYusLyx6Zedq42xq2TZ47\nN42BAABpytLDE2MuePB7vz394vkPzzjjoZLy/keOGT3skOqKirJCW+vWVxrXral/taUjl8vV\nXnrrosvGpT0WAKCnZSnskiQ/8zuLz5zx41vvuq9uyfJVf3xmzcrX79vl8hUjRh9zWu2Uc2fO\nOuv44emuBABIRbbCLkmSZHjN9Otrpl+fJMWO5i1bXtvR3FZeeVC/6gGVvpQYADiwZS/sdsmV\nVg4YVDkg7RkAAL1Elh6eAABgP4QdAEAQwg4AIAhhBwAQhLADAAhC2AEABJHhrzvpYatXr+7T\np0/aKwCAlK1evTrtCW9I2L25srKyJEk+/elPpz0EAOgtuvKgtxF2b+68887r6Ohobm5OewgA\n0CtUVlaed955aa/Yh1yxWEx7AwAA7wAPTwAABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhh\nBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHs\nAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQd\nAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLAD\nAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYA\nAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4A\nIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEA\nBCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCA\nIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQ\nhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACC\nEHYAAEEIOwCAIIQdAEAQwg4AIAhhBwAQhLADAAhC2AEABCHsAACCEHYAAEEIOwCAIIQdAEAQ\nwg4AIAhhBwAQhLADAAji/wcYYXlCL5QBzQAAAABJRU5ErkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "boxplot(min_int_nrr[,c(\"Intensity\")])"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "1ffaa11f",
   "metadata": {
    "papermill": {
     "duration": 0.031247,
     "end_time": "2023-07-13T02:41:52.078666",
     "exception": false,
     "start_time": "2023-07-13T02:41:52.047419",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "There are not many Outliers. So using average instead of Median"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 57,
   "id": "88bc678f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:52.143698Z",
     "iopub.status.busy": "2023-07-13T02:41:52.142365Z",
     "iopub.status.idle": "2023-07-13T02:41:52.220213Z",
     "shell.execute_reply": "2023-07-13T02:41:52.218984Z"
    },
    "papermill": {
     "duration": 0.112345,
     "end_time": "2023-07-13T02:41:52.222032",
     "exception": false,
     "start_time": "2023-07-13T02:41:52.109687",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'Id'. You can override using the `.groups`\n",
      "argument.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>MedianMinCalories</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>1503960366</td><td>04/12/2016</td><td>0.9438</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/13/2016</td><td>0.7865</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/14/2016</td><td>0.9438</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/15/2016</td><td>0.7865</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/16/2016</td><td>0.7865</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/17/2016</td><td>0.7865</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 6 × 3\n",
       "\\begin{tabular}{lll}\n",
       " Id & ActivityDay & MedianMinCalories\\\\\n",
       " <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 1503960366 & 04/12/2016 & 0.9438\\\\\n",
       "\t 1503960366 & 04/13/2016 & 0.7865\\\\\n",
       "\t 1503960366 & 04/14/2016 & 0.9438\\\\\n",
       "\t 1503960366 & 04/15/2016 & 0.7865\\\\\n",
       "\t 1503960366 & 04/16/2016 & 0.7865\\\\\n",
       "\t 1503960366 & 04/17/2016 & 0.7865\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 6 × 3\n",
       "\n",
       "| Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | MedianMinCalories &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 1503960366 | 04/12/2016 | 0.9438 |\n",
       "| 1503960366 | 04/13/2016 | 0.7865 |\n",
       "| 1503960366 | 04/14/2016 | 0.9438 |\n",
       "| 1503960366 | 04/15/2016 | 0.7865 |\n",
       "| 1503960366 | 04/16/2016 | 0.7865 |\n",
       "| 1503960366 | 04/17/2016 | 0.7865 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay MedianMinCalories\n",
       "1 1503960366 04/12/2016  0.9438           \n",
       "2 1503960366 04/13/2016  0.7865           \n",
       "3 1503960366 04/14/2016  0.9438           \n",
       "4 1503960366 04/15/2016  0.7865           \n",
       "5 1503960366 04/16/2016  0.7865           \n",
       "6 1503960366 04/17/2016  0.7865           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "avg_min_int <- min_int_nrr%>%\n",
    "group_by(Id, ActivityDay)%>%\n",
    "summarise(AvgMinIntensity = mean(Intensity))\n",
    "head(avg_min_cal)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 58,
   "id": "6c52f681",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:52.288611Z",
     "iopub.status.busy": "2023-07-13T02:41:52.287115Z",
     "iopub.status.idle": "2023-07-13T02:41:52.300816Z",
     "shell.execute_reply": "2023-07-13T02:41:52.299122Z"
    },
    "papermill": {
     "duration": 0.048765,
     "end_time": "2023-07-13T02:41:52.302710",
     "exception": false,
     "start_time": "2023-07-13T02:41:52.253945",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "The total number of dissimilar Ids:  0 \n",
      "numeric(0)\n"
     ]
    }
   ],
   "source": [
    "diff_find(new_activity_merged, avg_min_int)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 59,
   "id": "8cf4eca1",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:52.368153Z",
     "iopub.status.busy": "2023-07-13T02:41:52.366874Z",
     "iopub.status.idle": "2023-07-13T02:41:52.409981Z",
     "shell.execute_reply": "2023-07-13T02:41:52.408671Z"
    },
    "papermill": {
     "duration": 0.077717,
     "end_time": "2023-07-13T02:41:52.412158",
     "exception": false,
     "start_time": "2023-07-13T02:41:52.334441",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 22</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>⋯</th><th scope=col>LightlyActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Value</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedAverageIntensity</th><th scope=col>MedianHourlySteps</th><th scope=col>MedianMinCalories</th><th scope=col>AvgMinIntensity</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>⋯</td><td>328</td><td> 728</td><td>1985</td><td>NA</td><td>76.0</td><td>13.0</td><td>0.2166670</td><td>341.0</td><td>0.9438</td><td>0.2979167</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/13/2016</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>⋯</td><td>217</td><td> 776</td><td>1797</td><td>NA</td><td>71.5</td><td>11.5</td><td>0.1916665</td><td>285.0</td><td>0.7865</td><td>0.2208333</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/14/2016</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>⋯</td><td>181</td><td>1218</td><td>1776</td><td>NA</td><td>62.5</td><td> 6.0</td><td>0.1000000</td><td> 69.5</td><td>0.9438</td><td>0.2034722</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/15/2016</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>⋯</td><td>209</td><td> 726</td><td>1745</td><td>NA</td><td>59.5</td><td> 6.5</td><td>0.1083335</td><td> 80.0</td><td>0.7865</td><td>0.2527778</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/16/2016</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>⋯</td><td>221</td><td> 773</td><td>1863</td><td>NA</td><td>63.5</td><td> 9.5</td><td>0.1583335</td><td>123.5</td><td>0.7865</td><td>0.2423611</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/17/2016</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>⋯</td><td>164</td><td> 539</td><td>1728</td><td>NA</td><td>53.5</td><td> 1.5</td><td>0.0250000</td><td> 10.5</td><td>0.7865</td><td>0.2208333</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 22\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & Id & ActivityDay & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & ⋯ & LightlyActiveMinutes & SedentaryMinutes & Calories & Median\\_Value & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedAverageIntensity & MedianHourlySteps & MedianMinCalories & AvgMinIntensity\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <int> & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & ⋯ & 328 &  728 & 1985 & NA & 76.0 & 13.0 & 0.2166670 & 341.0 & 0.9438 & 0.2979167\\\\\n",
       "\t2 & 1503960366 & 04/13/2016 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & ⋯ & 217 &  776 & 1797 & NA & 71.5 & 11.5 & 0.1916665 & 285.0 & 0.7865 & 0.2208333\\\\\n",
       "\t3 & 1503960366 & 04/14/2016 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & ⋯ & 181 & 1218 & 1776 & NA & 62.5 &  6.0 & 0.1000000 &  69.5 & 0.9438 & 0.2034722\\\\\n",
       "\t4 & 1503960366 & 04/15/2016 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & ⋯ & 209 &  726 & 1745 & NA & 59.5 &  6.5 & 0.1083335 &  80.0 & 0.7865 & 0.2527778\\\\\n",
       "\t5 & 1503960366 & 04/16/2016 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & ⋯ & 221 &  773 & 1863 & NA & 63.5 &  9.5 & 0.1583335 & 123.5 & 0.7865 & 0.2423611\\\\\n",
       "\t6 & 1503960366 & 04/17/2016 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & ⋯ & 164 &  539 & 1728 & NA & 53.5 &  1.5 & 0.0250000 &  10.5 & 0.7865 & 0.2208333\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 22\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | ⋯ ⋯ | LightlyActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | Median_Value &lt;dbl&gt; | Median_Hourly_Calorie &lt;dbl&gt; | MedTotalIntensity &lt;dbl&gt; | MedAverageIntensity &lt;dbl&gt; | MedianHourlySteps &lt;dbl&gt; | MedianMinCalories &lt;dbl&gt; | AvgMinIntensity &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | ⋯ | 328 |  728 | 1985 | NA | 76.0 | 13.0 | 0.2166670 | 341.0 | 0.9438 | 0.2979167 |\n",
       "| 2 | 1503960366 | 04/13/2016 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | ⋯ | 217 |  776 | 1797 | NA | 71.5 | 11.5 | 0.1916665 | 285.0 | 0.7865 | 0.2208333 |\n",
       "| 3 | 1503960366 | 04/14/2016 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | ⋯ | 181 | 1218 | 1776 | NA | 62.5 |  6.0 | 0.1000000 |  69.5 | 0.9438 | 0.2034722 |\n",
       "| 4 | 1503960366 | 04/15/2016 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | ⋯ | 209 |  726 | 1745 | NA | 59.5 |  6.5 | 0.1083335 |  80.0 | 0.7865 | 0.2527778 |\n",
       "| 5 | 1503960366 | 04/16/2016 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | ⋯ | 221 |  773 | 1863 | NA | 63.5 |  9.5 | 0.1583335 | 123.5 | 0.7865 | 0.2423611 |\n",
       "| 6 | 1503960366 | 04/17/2016 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | ⋯ | 164 |  539 | 1728 | NA | 53.5 |  1.5 | 0.0250000 |  10.5 | 0.7865 | 0.2208333 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay TotalSteps TotalDistance TrackerDistance\n",
       "1 1503960366 04/12/2016  13162      8.50          8.50           \n",
       "2 1503960366 04/13/2016  10735      6.97          6.97           \n",
       "3 1503960366 04/14/2016  10460      6.74          6.74           \n",
       "4 1503960366 04/15/2016   9762      6.28          6.28           \n",
       "5 1503960366 04/16/2016  12669      8.16          8.16           \n",
       "6 1503960366 04/17/2016   9705      6.48          6.48           \n",
       "  LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance\n",
       "1 0                        1.88               0.55                    \n",
       "2 0                        1.57               0.69                    \n",
       "3 0                        2.44               0.40                    \n",
       "4 0                        2.14               1.26                    \n",
       "5 0                        2.71               0.41                    \n",
       "6 0                        3.19               0.78                    \n",
       "  LightActiveDistance SedentaryActiveDistance ⋯ LightlyActiveMinutes\n",
       "1 6.06                0                       ⋯ 328                 \n",
       "2 4.71                0                       ⋯ 217                 \n",
       "3 3.91                0                       ⋯ 181                 \n",
       "4 2.83                0                       ⋯ 209                 \n",
       "5 5.04                0                       ⋯ 221                 \n",
       "6 2.51                0                       ⋯ 164                 \n",
       "  SedentaryMinutes Calories Median_Value Median_Hourly_Calorie\n",
       "1  728             1985     NA           76.0                 \n",
       "2  776             1797     NA           71.5                 \n",
       "3 1218             1776     NA           62.5                 \n",
       "4  726             1745     NA           59.5                 \n",
       "5  773             1863     NA           63.5                 \n",
       "6  539             1728     NA           53.5                 \n",
       "  MedTotalIntensity MedAverageIntensity MedianHourlySteps MedianMinCalories\n",
       "1 13.0              0.2166670           341.0             0.9438           \n",
       "2 11.5              0.1916665           285.0             0.7865           \n",
       "3  6.0              0.1000000            69.5             0.9438           \n",
       "4  6.5              0.1083335            80.0             0.7865           \n",
       "5  9.5              0.1583335           123.5             0.7865           \n",
       "6  1.5              0.0250000            10.5             0.7865           \n",
       "  AvgMinIntensity\n",
       "1 0.2979167      \n",
       "2 0.2208333      \n",
       "3 0.2034722      \n",
       "4 0.2527778      \n",
       "5 0.2423611      \n",
       "6 0.2208333      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>940</li><li>22</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 940\n",
       "\\item 22\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 940\n",
       "2. 22\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 940  22"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "## Merging with activity\n",
    "new_activity_merged <- merge(new_activity_merged, avg_min_int,\n",
    "                            by = c(\"Id\", \"ActivityDay\"), all = TRUE)\n",
    "head(new_activity_merged)\n",
    "dim(new_activity_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 60,
   "id": "ec39542c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:52.479697Z",
     "iopub.status.busy": "2023-07-13T02:41:52.478418Z",
     "iopub.status.idle": "2023-07-13T02:41:52.492160Z",
     "shell.execute_reply": "2023-07-13T02:41:52.490830Z"
    },
    "papermill": {
     "duration": 0.049783,
     "end_time": "2023-07-13T02:41:52.494624",
     "exception": false,
     "start_time": "2023-07-13T02:41:52.444841",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "642"
      ],
      "text/latex": [
       "642"
      ],
      "text/markdown": [
       "642"
      ],
      "text/plain": [
       "[1] 642"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sum(is.na(new_activity_merged))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "10f2d6de",
   "metadata": {
    "papermill": {
     "duration": 0.031815,
     "end_time": "2023-07-13T02:41:52.558049",
     "exception": false,
     "start_time": "2023-07-13T02:41:52.526234",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Checking MinutesMETs Narrow"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "005cc705",
   "metadata": {
    "papermill": {
     "duration": 0.033037,
     "end_time": "2023-07-13T02:41:52.622603",
     "exception": false,
     "start_time": "2023-07-13T02:41:52.589566",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**Metabolic Equivalent**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 61,
   "id": "a199d14d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:52.690395Z",
     "iopub.status.busy": "2023-07-13T02:41:52.688909Z",
     "iopub.status.idle": "2023-07-13T02:41:54.958730Z",
     "shell.execute_reply": "2023-07-13T02:41:54.957422Z"
    },
    "papermill": {
     "duration": 2.305802,
     "end_time": "2023-07-13T02:41:54.961037",
     "exception": false,
     "start_time": "2023-07-13T02:41:52.655235",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityMinute</th><th scope=col>METs</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016 12:00:00 AM</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/12/2016 12:01:00 AM</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/12/2016 12:02:00 AM</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/12/2016 12:03:00 AM</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/12/2016 12:04:00 AM</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/12/2016 12:05:00 AM</td><td>12</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & ActivityMinute & METs\\\\\n",
       "  & <dbl> & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 12:00:00 AM & 10\\\\\n",
       "\t2 & 1503960366 & 4/12/2016 12:01:00 AM & 10\\\\\n",
       "\t3 & 1503960366 & 4/12/2016 12:02:00 AM & 10\\\\\n",
       "\t4 & 1503960366 & 4/12/2016 12:03:00 AM & 10\\\\\n",
       "\t5 & 1503960366 & 4/12/2016 12:04:00 AM & 10\\\\\n",
       "\t6 & 1503960366 & 4/12/2016 12:05:00 AM & 12\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityMinute &lt;chr&gt; | METs &lt;int&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 12:00:00 AM | 10 |\n",
       "| 2 | 1503960366 | 4/12/2016 12:01:00 AM | 10 |\n",
       "| 3 | 1503960366 | 4/12/2016 12:02:00 AM | 10 |\n",
       "| 4 | 1503960366 | 4/12/2016 12:03:00 AM | 10 |\n",
       "| 5 | 1503960366 | 4/12/2016 12:04:00 AM | 10 |\n",
       "| 6 | 1503960366 | 4/12/2016 12:05:00 AM | 12 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityMinute        METs\n",
       "1 1503960366 4/12/2016 12:00:00 AM 10  \n",
       "2 1503960366 4/12/2016 12:01:00 AM 10  \n",
       "3 1503960366 4/12/2016 12:02:00 AM 10  \n",
       "4 1503960366 4/12/2016 12:03:00 AM 10  \n",
       "5 1503960366 4/12/2016 12:04:00 AM 10  \n",
       "6 1503960366 4/12/2016 12:05:00 AM 12  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 1</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>ActivityMinute</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>4/12/2016 12:00:00 AM</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>4/12/2016 12:01:00 AM</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>4/12/2016 12:02:00 AM</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>4/12/2016 12:03:00 AM</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>4/12/2016 12:04:00 AM</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>4/12/2016 12:05:00 AM</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 1\n",
       "\\begin{tabular}{r|l}\n",
       "  & ActivityMinute\\\\\n",
       "  & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 4/12/2016 12:00:00 AM\\\\\n",
       "\t2 & 4/12/2016 12:01:00 AM\\\\\n",
       "\t3 & 4/12/2016 12:02:00 AM\\\\\n",
       "\t4 & 4/12/2016 12:03:00 AM\\\\\n",
       "\t5 & 4/12/2016 12:04:00 AM\\\\\n",
       "\t6 & 4/12/2016 12:05:00 AM\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 1\n",
       "\n",
       "| <!--/--> | ActivityMinute &lt;chr&gt; |\n",
       "|---|---|\n",
       "| 1 | 4/12/2016 12:00:00 AM |\n",
       "| 2 | 4/12/2016 12:01:00 AM |\n",
       "| 3 | 4/12/2016 12:02:00 AM |\n",
       "| 4 | 4/12/2016 12:03:00 AM |\n",
       "| 5 | 4/12/2016 12:04:00 AM |\n",
       "| 6 | 4/12/2016 12:05:00 AM |\n",
       "\n"
      ],
      "text/plain": [
       "  ActivityMinute       \n",
       "1 4/12/2016 12:00:00 AM\n",
       "2 4/12/2016 12:01:00 AM\n",
       "3 4/12/2016 12:02:00 AM\n",
       "4 4/12/2016 12:03:00 AM\n",
       "5 4/12/2016 12:04:00 AM\n",
       "6 4/12/2016 12:05:00 AM"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>METs</th><th scope=col>ActivityDay</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>10</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>10</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>10</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>10</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>10</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>12</td><td>04/12/2016</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 3\n",
       "\\begin{tabular}{r|lll}\n",
       "  & Id & METs & ActivityDay\\\\\n",
       "  & <dbl> & <int> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 10 & 04/12/2016\\\\\n",
       "\t2 & 1503960366 & 10 & 04/12/2016\\\\\n",
       "\t3 & 1503960366 & 10 & 04/12/2016\\\\\n",
       "\t4 & 1503960366 & 10 & 04/12/2016\\\\\n",
       "\t5 & 1503960366 & 10 & 04/12/2016\\\\\n",
       "\t6 & 1503960366 & 12 & 04/12/2016\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 3\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | METs &lt;int&gt; | ActivityDay &lt;chr&gt; |\n",
       "|---|---|---|---|\n",
       "| 1 | 1503960366 | 10 | 04/12/2016 |\n",
       "| 2 | 1503960366 | 10 | 04/12/2016 |\n",
       "| 3 | 1503960366 | 10 | 04/12/2016 |\n",
       "| 4 | 1503960366 | 10 | 04/12/2016 |\n",
       "| 5 | 1503960366 | 10 | 04/12/2016 |\n",
       "| 6 | 1503960366 | 12 | 04/12/2016 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         METs ActivityDay\n",
       "1 1503960366 10   04/12/2016 \n",
       "2 1503960366 10   04/12/2016 \n",
       "3 1503960366 10   04/12/2016 \n",
       "4 1503960366 10   04/12/2016 \n",
       "5 1503960366 10   04/12/2016 \n",
       "6 1503960366 12   04/12/2016 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "min_met_nrr <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/minuteMETsNarrow_merged.csv\")\n",
    "head(min_met_nrr)\n",
    "activity_col <- min_met_nrr%>%\n",
    "select(matches(\"ActivityH|ActivityM|ActivityD|Day\"))\n",
    "\n",
    "head(activity_col)\n",
    "\n",
    "\n",
    "min_met_nrr <- min_met_nrr%>%\n",
    "select(-matches(\"ActivityH|ActivityM|ActivityD|Day\"))\n",
    "\n",
    "\n",
    "\n",
    "activity_col <- activity_col%>%\n",
    "mutate(ActivityDay = as.Date(activity_col$ActivityMinute, format = \"%m/%d/%Y\"))%>%\n",
    "select(matches(\"ActivityDay\"))\n",
    "\n",
    "\n",
    "\n",
    "min_met_nrr <- cbind(min_met_nrr, Series = activity_col)\n",
    "\n",
    "min_met_nrr$ActivityDay <- format(min_met_nrr$ActivityDay, \"%m/%d/%Y\")\n",
    "head(min_met_nrr)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 62,
   "id": "77c598e9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:41:55.030215Z",
     "iopub.status.busy": "2023-07-13T02:41:55.028905Z",
     "iopub.status.idle": "2023-07-13T02:42:01.125166Z",
     "shell.execute_reply": "2023-07-13T02:42:01.123115Z"
    },
    "papermill": {
     "duration": 6.133852,
     "end_time": "2023-07-13T02:42:01.127990",
     "exception": false,
     "start_time": "2023-07-13T02:41:54.994138",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nO3daZRdVZ3w4XPqVipVmQcgEwYBA4QptjQzIkkDiUMILFvGZghEsAHJsoH1IrQG\nbUijoIBIEERiiIQhDHakgyI0YFgJqCwbNDQhZEIIQcYEkpruvef9UHZRpIZztLHOwPN8Creu\nWf8Prlq/7H3O3mEURQEAAPlXk/YAAAB8MIQdAEBBCDsAgIIQdgAABSHsAAAKQtgBABSEsAMA\nKAhhBwBQEMIOAKAghB0AQEEIOwCAghB2AAAFIewAAApC2AEAFISwAwAoCGEHAFAQwg4AoCCE\nHQBAQQg7AICCEHYAAAUh7AAACkLYAQAUhLADACgIYQcAUBDCDgCgIIQdAEBBCDsAgIIQdgAA\nBSHsAAAKQtgBABSEsAMAKAhhBwBQEMIOAKAghB0AQEEIOwCAghB2AAAFIewAAApC2AEAFISw\nAwAoCGEHAFAQwg4AoCCEHQBAQQg7AICCEHYAAAUh7AAACkLYAQAUhLADACgIYQcAUBDCDgCg\nIIQdAEBBCDsAgIIQdgAABSHsAAAKQtgBABSEsAMAKAhhBwBQEMIOAKAghB0AQEEIOwCAghB2\nAAAFIewAAApC2AEAFISwAwAoCGEHAFAQwg4AoCCEHQBAQQg7AICCEHYAAAUh7AAACkLYAQAU\nhLADACgIYQcAUBDCDgCgIIQdAEBBCDsAgIIQdgAABSHsAAAKQtgBABSEsAMAKAhhBwBQEMIO\nAKAghB0AQEEIOwCAghB2AAAFIewAAApC2AEAFISwAwAoCGEHAFAQwg4AoCCEHQBAQQg7AICC\nEHYAAAUh7AAACkLYAQAUhLADACgIYQcAUBC1aQ+QAxs3bpw3b15jY2PagwAAmdDQ0HDqqacO\nHjw47UG2Juzi3XbbbTNnzkx7CgAgQ2pra88+++y0p9iasIvX2toaBMGPfvSjCRMmpD0LAJCy\np59++owzzmjLg6wRdkntuuuu++yzT9pTAAApa2pqSnuEbnl5AgCgIIQdAEBBCDsAgIIQdgAA\nBSHsAAAKQtgBABSEsAMAKAhhBwBQEMIOAKAghB0AQEEIOwCAghB2AAAFIewAAApC2AEAFERt\n2gMA5MCWLVseeuihFStWBEGw6667Hn744f369Ut7KICtCTuAGDfeeOMll1zyxhtvtH8yfPjw\n2bNnn3nmmSlOBdCZrViAnlx++eVf+tKXBg4ceO211z755JNPPvnktddeO2DAgLPOOmv27Nlp\nTwfwPlbsALq1fPnySy+9dJ999nn44YcHDx7c9uF+++136qmnTpo0adasWdOmTdtjjz3SHRKg\nnRU7gG7dcsst5XJ5zpw57VXXZvDgwXPmzCmXy3Pnzk1rNoDOhB1At5566qltt912v/326/yj\n/ffff5tttvntb3/b+1MBdEfYAXRr06ZNW63VdTRkyJB33nmnN+cB6JmwA+jWqFGj1q9f39zc\n3PlHTU1NL7/88qhRo3p/KoDuCDuAbh1xxBFbtmxZsGBB5x8tWLCgsbHx8MMP7/2pALoj7AC6\ndcYZZ4waNeq88877xS9+0fHzX/ziFzNnzhw1atQZZ5yR1mwAnTnuBKBbAwcOvO+++6ZMmTJl\nypQDDzzwwAMPDMNw6dKly5YtGzJkyE9/+tOBAwemPSPAe4QdQE/233////7v//7GN75x9913\nL1u2LAiCQYMGTZ8+/dJLLx07dmza0wG8j7ADiLHDDjvccsstN9100/r164MgGD16dG2tX55A\nFvndBJBIbW2tJTog47w8AQBQEHldsXvrlTUrVqx89c1Nm7c01db3Hzx85Ljdxu80akjacwEF\nVC6X77jjjjvvvHPFihVBEOy6667HHXfc8ccfb0MWyJqc/VaKKhvvuvob3/vRgqXPvdr5pyN3\nO+DEGTO/NvO4IbVh788GFNKf/vSnadOmPfHEE3V1dePHjw+C4MEHH7z//vuvv/76RYsWbbvt\ntmkPCPCePIVdpeXl6ftOmP/MG6U+w/afdNTe43cetc2Qvn1ry83Nb7++Yd3K5UuXPPndC064\ndcH9Ty+7dXSdXWbg/6parR599NFPPPHEhRdeeMkll7RdL7Zx48bLL7/8qquumjZt2uOPP15T\n47cNkBV5Crtl50+Z/8wbh5x77e1XnL19/y4mr7a8cfu3zjl51oIjvjxj+Y2H9fqAQNEsXLhw\n2bJlF1xwwbe//e32DwcPHvztb3+7Wq1+5zvfufvuu4899tgUJwToKE//0Lx4/soBo7605Lrz\nuqy6IAhq6oaf9LU7bth/xKo7/rWXZwMK6b777qutrb3ooos6/+iiiy4qlUr33Xdf708F0J08\nhd3vN7cOGDs19mv7HLpd65blvTAPUHirV6/efvvthw8f3vlH22yzzUc+8pHVq1f3/lQA3clT\n2E0b3vDWc1dsaKn29KVq4y13ra0fOrm3hgKKrFQqVavd/s6pVCqlUqk35wHoWZ7C7pJvTW7e\nuGTPA479yS+e2lyJtv5x1PzskvtmHDH+hrWbDps1K40BgaLZdddd//jHP7700kudf9T2+a67\n7tr7UwF0J08vT4w7deEPf3PkWXPuPXnKPaW6wTuN23n0tkP69u1TaWne+Porq1euerOpHIbh\nxLOvX3TO+LSHBYrg+OOPnzdv3kUXXTR//vwwfN85Sl/96lejKDruuOPSmg2gszyFXRDUzPj+\nQ58++afXz7198SNPPPc/v1u5/M/rdmFN3+133uOIiZNPmHHetH3HpDslUBhTpkw5+uijb7vt\ntubm5ksvvXSPPfYIgmD58uWXXnrp3Xfffcwxx0yZMiXtGQHek6+wC4IgGLP/0bP3P3p2EETl\nxrfffmdzY0tdQ7+BQ4Y2OJQY+Bv4yU9+cvrpp99111133333oEGDgiDYtGlTEATHHnvs3Llz\n054O4H3yF3btwtqGods0DG559b/u/9kzL7xc7Ttkt787eMonJwg84APUv3//O++8c+bMmXfe\needzzz0XhuFuu+127LHHHnTQQWmPBrC1PIXdxIkTG7Y5ZvHC89o/WXnf7M9M/8YLG1vaPxm+\n+5E3L7zz6N1dGgt8kA466CAlB2RfnsLu0UcfHTB6z/b/3Lhyzse/8LXGqM/kU748aZ89Rw8M\n/vDkA3NuXnTsvgc+tP6/Dx3cN8VRAQB6X57Cbiu3HXtpYzWa9fPnZx059s8fTT/zK6d8Z8wh\nF552+kOr7/lsqtMBRbNhw4bnn38+CIJddtll5MiRaY8D0IUch913Vrw18COXvFd1QRAEwYiD\nzv/mjpd986HLgyBR2FUqlcWLFzc1NfXwnd/97ndBELS2tv5fpgXy6ze/+c2FF1742GOPtX/y\nqU996sorr9x3331TnAqgsxyH3eut1QE7HNz587//6IDWdX9I+Jc88sgjRx11VJJvLliw4LDD\nDks+HlAM//Ef//GFL3yhpqbmxBNPPPDAA4MgWLZs2T333HPwwQfffffdCX+BAPSOHIfdKSP7\n3/risiDY+hCpJS9s6jNgQsK/ZOLEiYsWLep5xW7OnDmPPvro9ttv/1cOCuTWq6++esoppwwf\nPvzBBx/ca6+92j4899xzL7rooiOPPPLkk09+/vnnR4wYke6QAO1yFnZNby4+7ayaj33sYx/7\n2McmffmA6y+67OsPzvjmkR9p/8KKey++7MVNO3zu/yX8C0ul0tSpU3v+zuLFi4MgqKnJ0/Vr\nwAfihz/84aZNm2699db2qmuz11573XDDDcccc8zNN998ySWXpDUewFbyFHb77b3rC6tXz7vp\nex0//PejD/vmllVBEARR+ZTPHrjg50+V+o658ceHpzMiUCy/+tWvBg4c+NnPdvHM7uc+97mB\nAwf+6le/EnZAduQp7J58+rkgCN5+9cVVL7ywatWqF1atWrVq1ZoXN/3vzyvzH/jt0HGHXnvn\nvZOH16c4J1AYr7/++siRI2tru/hVWVtbO3LkyNdee633pwLoTp7Crs2QEWP3GTF2n4Mnbf2D\nsM/S3685YM+PungC+KAMHTp0zZo11Wq188MY1Wr1tddeGzt2bJf/Q4BUFOm5sZoDVR3wgTr4\n4IPffvvthx9+uPOPHnroobffftt1FECmFCnsAD5gM2bMaGhoOOuss9atW9fx83Xr1v3zP/9z\nv379ZsyYkdZsAJ3lbysWoNeMHTv2hhtumD59+t5773366ae3rc8tXbr0lltueeedd+bNm2cr\nFsgUYQfQk1NPPXXkyJH/8i//cs0111xzzTVtH+6+++5XX331kUceme5sAFvJU9i9veGVzZVq\nwi+PGTPmbzoM8OFRX1/f0NDQ8ZOGhob6em/fA5mTp7C78O92uXnDuwm/HEXR33QY4EPijjvu\n+Kd/+qf6+vozzzyz/Uqx2267bdKkSbfddttxxx2X9oAA78lT2F320AO7/vj6r199Z2MlGrrX\nYQfvMCDtiYCCe/nll2fMmDF69OiHH3543LhxbR+edtppF1xwwT/8wz+cccYZhxxyiP0BIDvy\nFHYj9jjkgisPmThs9d9f/Ovx59zws7N2S3sioOBuvvnmzZs333XXXe1V12bcuHE/+MEPPvvZ\nz958882zZs1KazyAreTvuJO9zvlO2iMAHxZLliwZPHjw5MmTO/9o8uTJgwYNevzxx3t/KoDu\n5C/s6gYd8ontRw6uL6U9CFB8b7755nbbbVcqdfELp1QqjRgx4o033uj9qQC6k6et2HZP/fGV\ntEcAPhSGDRu2evXqSqXSue0qlcqrr766ww47pDIYQJfyt2IH0Gs++clPbty48aabbtppp51q\namrCMAzDsKamZqeddrrppps2bdp0yCGHpD0jwHuEHUC3vvjFL9bX15999tlr1qyJoqi+vr6+\n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\ne7W0tKQ9BaSjtbV1woQJaU8BmSbsIE9uv/32WbNmpT0FpOPrX//6bbfdlvYUkGnCDgCgILw8\nATlz6aWXXnrppWlPAUAWWbEDACgIYQcAUBDCDgCgIIQdAEBBCDuApLZs2bJly5a0pwDolrAD\niPHaa69deOGFY8eO7d+/f//+/ceOHXvhhRe+/vrrac8FsDVhB9CTP/zhDxMmTLjqqqsaGhpO\nOeWUU045paGh4aqrrpowYcLy5cvTng7gfZxjB9CtxsbGqVOnvvnmmz/5yU9OPPHEMAyDIIii\naMGCBWecccbUqVOXL1/e0NCQ9pgAf2bFDqBbP/7xj9euXXvVVVeddNJJbVUXBEEYhieddNKV\nV165Zs2aH//4x6kOCPA+wg6gWw888EB9ff3pp5/e+UdnnHFGfX39z3/+896fCqA7wg6gWy+/\n/PKYMWP69evX+Uf9+vUbM2bMyy+/3PtTAXRH2AF0q3///ps3b+7up++++26XzQeQFmEH0K0J\nEyZs2LDhmWee6fyjZ5555tVXX/34xz/e+1MBdEfYAXRr+vTpNTU15557blNTU8fPm5qazj33\n3JqamtNOOy2l0QC6IOwAuvWJT3zi/PPPX7JkyX777bdgwYI1a9asXbt2wYIF++6775IlSy64\n4IJPfOITac8I8B7n2AH05IorrhgyZMhll1120kkntX/Y0NBw+eWXf/WrX01xMIDOhB1AT2pq\nai6++OIvfvGL999/f9tVE3vsscfnPve5bbfdNu3RALYm7ADibbvtttOnT097CoAYnrEDACgI\nYQcAUBDCDgCgIIQdAEBBCDsAgIIQdgAABSHsAAAKQtgBABSEsANIZPXq1WeeeeaZZ565evXq\ntGcB6Fpeb55465U1K1asfPXNTZu3NNXW9x88fOS43cbvNGpI2nMBBXT66afPnTu3/T9/+MMf\nBkEwffr0W265Jb2hALqQs7CLKhvvuvob3/vRgqXPvdr5pyN3O+DEGTO/NvO4IbVh788GFNIe\ne+zx7LPPtv05DMMgCKIoCoJg7ty5v/71r//whz+kORzA++Up7CotL0/fd8L8Z94o9Rm2/6Sj\n9h6/86hthvTtW1tubn779Q3rVi5fuuTJ715wwq0L7n962a2j6+wyA/9Xd999d1vVfeQjH3nx\nxRfbPx87duwf//jH5cuX33333f/4j/+Y3oAA75OnsFt2/pT5z7xxyLnX3n7F2dv372Lyassb\nt3/rnJNnLTjiyzOW33hYrw8IFM0JJ5wQBEG/fv06Vl0QBC+++GK/fv0aGxtPOOEEYQdkR57C\n7uL5KweM+tKS687r7gs1dcNP+tod7y5+bOYd/xrc+HiSv7NSqSxevLipqamH76xduzYIgmq1\n+hfOC+ReuVwOguCJJ57o/KMnn3xy7733bvsCQEbkKex+v7l1wG5TY7+2z6Hbtf52ecK/85FH\nHjnqqKOSfPOll15K+HcCBbPXXnsl/BAgXXkKu2nDG+547ooNLVNG9vD8XLXxlrvW1g/9dMK/\nc+LEiYsWLep5xe4///M/582bd+KJJ/5F0wIA9LI8hd0l35o877R79zzg2Gv+/avHHP6J/qX3\nv/oaNT/7+OLvXvqVH63d9Jnvz0r4d5ZKpalTY1YB169fP2/evD59+vx1YwP5FYZhFEUTJkx4\n+umnt/pR24pd23uyABmRp7Abd+rCH/7myLPm3HvylHtKdYN3Grfz6G2H9O3bp9LSvPH1V1av\nXPVmUzkMw4lnX7/onPFpDwsUwZQpUx544IFnnnlm/vz5J598cvvn8+fPbzvoZMqUKelNB7C1\nPIVdENTM+P5Dnz75p9fPvX3xI0889z+/W7k8avtBWNN3+533OGLi5BNmnDdt3zHpTgkUxuLF\ni2trayuVyimnnHL66afvtttuQRA899xzbe9MlEqlxYsXpz0jwHvyFXZBEARj9j969v5Hzw6C\nqNz49tvvbG5sqWvoN3DI0AaHEgN/A+VyuaGhoampqVwudzyOuL6+vrGxMcXBADrL8Sm+YW3D\n0G222/4j22+3zTBVB/ztNDY2Ll26dMSIEbW1tbW1tSNGjFi6dKmqAzIofyt2AL3vwAMP3LBh\nQ9pTAMTI8YodAAAdCTsAgIIQdgAABSHsAAAKQtgBABSEsAMAKAhhBwBQEMIOAKAghB0AQEEI\nOwCAghB2AAAFIewAAApC2AEAFISwAwAoiNq0B8iNFStW1NfXpz0FAJCyFStWpD1Ct4RdvD59\n+gRBcMYZZ6Q9CACQFW15kDXCLt5JJ51ULpcbGxvTHgQAyISGhoaTTjop7Sm6EEZRlPYMAAB8\nALw8AQBQEMIOAKAghB0AQEEIOwCAghB2AAAFIewAAApC2AEAFISwAwAoCGEHAFAQwg4AoCCE\nHQBAQQg7AICCEHYAAAUh7AAACkLYAQAUhLADACgIYQcAUBDCDgCgIIQdAEBBCDsAgIIQdgAA\nBSHsAAAKQtgBABSEsAMAKAhhBwBQEMIOAKAghB0AQEEIOwCAghB2AAAFIewAAApC2AEAFISw\nAwAoCGEHAFAQwg4AoCCEHQBAQQg7AICCEHYAAAUh7AAACkLYAQAUhLADACgIYQcAUBDCDgCg\nIIQdAEBBCDsAgIIQdgAABSHsAAAKQtgBABSEsAMAKAhhBwBQEMIOAKAghB0AQEEIOwCAghB2\nAAAFIewAAApC2AEAFISwAwAoCGEHAFAQwg4AoCCEHQBAQQg7AICCEHYAAAUh7AAACkLYAQAU\nhLADACgIYQcAUBDCDgCgIIQdAEBBCDsAgIIQdgAABSHsAAAKQtgBABSEsAMAKAhhBwBQEMIO\nAKAghB0AQEEIOwCAghB2AAAFIewAAApC2AEAFISwAwAoCGEHAFAQwg4AoCCEHQBAQQg7AICC\nEHYAAAUh7AAACkLYAQAUhLADACgIYQcAUBDCDgCgIIQdAEBBCDsAgIIQdgAABSHsAAAKQtgB\nABSEsAMAKAhhBwBQEMIOAKAghB0AQEEIOwCAghB2AAAFIewAAApC2AEAFISwAwAoCGEHAFAQ\nwg4AoCCEHQBAQQg7AICCEHYAAAUh7AAACkLYAQAUhLADACgIYQcAUBDCDgCgIIQdAEBBCDsA\ngIIQdgAABSHsAAAKQtgBABSEsAMAKIj/D18+alfZ/xUYAAAAAElFTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "boxplot(min_met_nrr[,c(\"METs\")])"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "43e7c367",
   "metadata": {
    "papermill": {
     "duration": 0.032356,
     "end_time": "2023-07-13T02:42:01.192873",
     "exception": false,
     "start_time": "2023-07-13T02:42:01.160517",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**A lot of outliers**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 63,
   "id": "e2c65967",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:01.262775Z",
     "iopub.status.busy": "2023-07-13T02:42:01.261473Z",
     "iopub.status.idle": "2023-07-13T02:42:01.393357Z",
     "shell.execute_reply": "2023-07-13T02:42:01.391599Z"
    },
    "papermill": {
     "duration": 0.170717,
     "end_time": "2023-07-13T02:42:01.395734",
     "exception": false,
     "start_time": "2023-07-13T02:42:01.225017",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[22m`summarise()` has grouped output by 'Id'. You can override using the `.groups`\n",
      "argument.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 6 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>AvgMinMet</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>1503960366</td><td>04/12/2016</td><td>12</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/13/2016</td><td>10</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/14/2016</td><td>12</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/15/2016</td><td>10</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/16/2016</td><td>10</td></tr>\n",
       "\t<tr><td>1503960366</td><td>04/17/2016</td><td>10</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 6 × 3\n",
       "\\begin{tabular}{lll}\n",
       " Id & ActivityDay & AvgMinMet\\\\\n",
       " <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 1503960366 & 04/12/2016 & 12\\\\\n",
       "\t 1503960366 & 04/13/2016 & 10\\\\\n",
       "\t 1503960366 & 04/14/2016 & 12\\\\\n",
       "\t 1503960366 & 04/15/2016 & 10\\\\\n",
       "\t 1503960366 & 04/16/2016 & 10\\\\\n",
       "\t 1503960366 & 04/17/2016 & 10\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 6 × 3\n",
       "\n",
       "| Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | AvgMinMet &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 1503960366 | 04/12/2016 | 12 |\n",
       "| 1503960366 | 04/13/2016 | 10 |\n",
       "| 1503960366 | 04/14/2016 | 12 |\n",
       "| 1503960366 | 04/15/2016 | 10 |\n",
       "| 1503960366 | 04/16/2016 | 10 |\n",
       "| 1503960366 | 04/17/2016 | 10 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay AvgMinMet\n",
       "1 1503960366 04/12/2016  12       \n",
       "2 1503960366 04/13/2016  10       \n",
       "3 1503960366 04/14/2016  12       \n",
       "4 1503960366 04/15/2016  10       \n",
       "5 1503960366 04/16/2016  10       \n",
       "6 1503960366 04/17/2016  10       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "avg_min_met <- min_met_nrr%>%\n",
    "group_by(Id, ActivityDay)%>%\n",
    "summarise(AvgMinMet = median(METs))\n",
    "head(avg_min_met)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 64,
   "id": "06d98477",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:01.463225Z",
     "iopub.status.busy": "2023-07-13T02:42:01.462001Z",
     "iopub.status.idle": "2023-07-13T02:42:01.475635Z",
     "shell.execute_reply": "2023-07-13T02:42:01.473895Z"
    },
    "papermill": {
     "duration": 0.051077,
     "end_time": "2023-07-13T02:42:01.478767",
     "exception": false,
     "start_time": "2023-07-13T02:42:01.427690",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "The total number of dissimilar Ids:  0 \n",
      "numeric(0)\n"
     ]
    }
   ],
   "source": [
    "diff_find(new_activity_merged, avg_min_met)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 65,
   "id": "c9a9c336",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:01.547827Z",
     "iopub.status.busy": "2023-07-13T02:42:01.546575Z",
     "iopub.status.idle": "2023-07-13T02:42:01.597229Z",
     "shell.execute_reply": "2023-07-13T02:42:01.595688Z"
    },
    "papermill": {
     "duration": 0.087944,
     "end_time": "2023-07-13T02:42:01.599745",
     "exception": false,
     "start_time": "2023-07-13T02:42:01.511801",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 23</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>⋯</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Value</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedAverageIntensity</th><th scope=col>MedianHourlySteps</th><th scope=col>MedianMinCalories</th><th scope=col>AvgMinIntensity</th><th scope=col>AvgMinMet</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>⋯</td><td> 728</td><td>1985</td><td>NA</td><td>76.0</td><td>13.0</td><td>0.2166670</td><td>341.0</td><td>0.9438</td><td>0.2979167</td><td>12</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/13/2016</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>⋯</td><td> 776</td><td>1797</td><td>NA</td><td>71.5</td><td>11.5</td><td>0.1916665</td><td>285.0</td><td>0.7865</td><td>0.2208333</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/14/2016</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>⋯</td><td>1218</td><td>1776</td><td>NA</td><td>62.5</td><td> 6.0</td><td>0.1000000</td><td> 69.5</td><td>0.9438</td><td>0.2034722</td><td>12</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/15/2016</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>⋯</td><td> 726</td><td>1745</td><td>NA</td><td>59.5</td><td> 6.5</td><td>0.1083335</td><td> 80.0</td><td>0.7865</td><td>0.2527778</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/16/2016</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>⋯</td><td> 773</td><td>1863</td><td>NA</td><td>63.5</td><td> 9.5</td><td>0.1583335</td><td>123.5</td><td>0.7865</td><td>0.2423611</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/17/2016</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>⋯</td><td> 539</td><td>1728</td><td>NA</td><td>53.5</td><td> 1.5</td><td>0.0250000</td><td> 10.5</td><td>0.7865</td><td>0.2208333</td><td>10</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 23\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & Id & ActivityDay & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & ⋯ & SedentaryMinutes & Calories & Median\\_Value & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedAverageIntensity & MedianHourlySteps & MedianMinCalories & AvgMinIntensity & AvgMinMet\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & ⋯ &  728 & 1985 & NA & 76.0 & 13.0 & 0.2166670 & 341.0 & 0.9438 & 0.2979167 & 12\\\\\n",
       "\t2 & 1503960366 & 04/13/2016 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & ⋯ &  776 & 1797 & NA & 71.5 & 11.5 & 0.1916665 & 285.0 & 0.7865 & 0.2208333 & 10\\\\\n",
       "\t3 & 1503960366 & 04/14/2016 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & ⋯ & 1218 & 1776 & NA & 62.5 &  6.0 & 0.1000000 &  69.5 & 0.9438 & 0.2034722 & 12\\\\\n",
       "\t4 & 1503960366 & 04/15/2016 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & ⋯ &  726 & 1745 & NA & 59.5 &  6.5 & 0.1083335 &  80.0 & 0.7865 & 0.2527778 & 10\\\\\n",
       "\t5 & 1503960366 & 04/16/2016 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & ⋯ &  773 & 1863 & NA & 63.5 &  9.5 & 0.1583335 & 123.5 & 0.7865 & 0.2423611 & 10\\\\\n",
       "\t6 & 1503960366 & 04/17/2016 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & ⋯ &  539 & 1728 & NA & 53.5 &  1.5 & 0.0250000 &  10.5 & 0.7865 & 0.2208333 & 10\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 23\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | ⋯ ⋯ | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | Median_Value &lt;dbl&gt; | Median_Hourly_Calorie &lt;dbl&gt; | MedTotalIntensity &lt;dbl&gt; | MedAverageIntensity &lt;dbl&gt; | MedianHourlySteps &lt;dbl&gt; | MedianMinCalories &lt;dbl&gt; | AvgMinIntensity &lt;dbl&gt; | AvgMinMet &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | ⋯ |  728 | 1985 | NA | 76.0 | 13.0 | 0.2166670 | 341.0 | 0.9438 | 0.2979167 | 12 |\n",
       "| 2 | 1503960366 | 04/13/2016 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | ⋯ |  776 | 1797 | NA | 71.5 | 11.5 | 0.1916665 | 285.0 | 0.7865 | 0.2208333 | 10 |\n",
       "| 3 | 1503960366 | 04/14/2016 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | ⋯ | 1218 | 1776 | NA | 62.5 |  6.0 | 0.1000000 |  69.5 | 0.9438 | 0.2034722 | 12 |\n",
       "| 4 | 1503960366 | 04/15/2016 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | ⋯ |  726 | 1745 | NA | 59.5 |  6.5 | 0.1083335 |  80.0 | 0.7865 | 0.2527778 | 10 |\n",
       "| 5 | 1503960366 | 04/16/2016 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | ⋯ |  773 | 1863 | NA | 63.5 |  9.5 | 0.1583335 | 123.5 | 0.7865 | 0.2423611 | 10 |\n",
       "| 6 | 1503960366 | 04/17/2016 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | ⋯ |  539 | 1728 | NA | 53.5 |  1.5 | 0.0250000 |  10.5 | 0.7865 | 0.2208333 | 10 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay TotalSteps TotalDistance TrackerDistance\n",
       "1 1503960366 04/12/2016  13162      8.50          8.50           \n",
       "2 1503960366 04/13/2016  10735      6.97          6.97           \n",
       "3 1503960366 04/14/2016  10460      6.74          6.74           \n",
       "4 1503960366 04/15/2016   9762      6.28          6.28           \n",
       "5 1503960366 04/16/2016  12669      8.16          8.16           \n",
       "6 1503960366 04/17/2016   9705      6.48          6.48           \n",
       "  LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance\n",
       "1 0                        1.88               0.55                    \n",
       "2 0                        1.57               0.69                    \n",
       "3 0                        2.44               0.40                    \n",
       "4 0                        2.14               1.26                    \n",
       "5 0                        2.71               0.41                    \n",
       "6 0                        3.19               0.78                    \n",
       "  LightActiveDistance SedentaryActiveDistance ⋯ SedentaryMinutes Calories\n",
       "1 6.06                0                       ⋯  728             1985    \n",
       "2 4.71                0                       ⋯  776             1797    \n",
       "3 3.91                0                       ⋯ 1218             1776    \n",
       "4 2.83                0                       ⋯  726             1745    \n",
       "5 5.04                0                       ⋯  773             1863    \n",
       "6 2.51                0                       ⋯  539             1728    \n",
       "  Median_Value Median_Hourly_Calorie MedTotalIntensity MedAverageIntensity\n",
       "1 NA           76.0                  13.0              0.2166670          \n",
       "2 NA           71.5                  11.5              0.1916665          \n",
       "3 NA           62.5                   6.0              0.1000000          \n",
       "4 NA           59.5                   6.5              0.1083335          \n",
       "5 NA           63.5                   9.5              0.1583335          \n",
       "6 NA           53.5                   1.5              0.0250000          \n",
       "  MedianHourlySteps MedianMinCalories AvgMinIntensity AvgMinMet\n",
       "1 341.0             0.9438            0.2979167       12       \n",
       "2 285.0             0.7865            0.2208333       10       \n",
       "3  69.5             0.9438            0.2034722       12       \n",
       "4  80.0             0.7865            0.2527778       10       \n",
       "5 123.5             0.7865            0.2423611       10       \n",
       "6  10.5             0.7865            0.2208333       10       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>940</li><li>23</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 940\n",
       "\\item 23\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 940\n",
       "2. 23\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 940  23"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "648"
      ],
      "text/latex": [
       "648"
      ],
      "text/markdown": [
       "648"
      ],
      "text/plain": [
       "[1] 648"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "## Merging with activity\n",
    "new_activity_merged <- merge(new_activity_merged, avg_min_met,\n",
    "                            by = c(\"Id\", \"ActivityDay\"), all = TRUE)\n",
    "head(new_activity_merged)\n",
    "dim(new_activity_merged)\n",
    "sum(is.na(new_activity_merged))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "365bca20",
   "metadata": {
    "papermill": {
     "duration": 0.033269,
     "end_time": "2023-07-13T02:42:01.666464",
     "exception": false,
     "start_time": "2023-07-13T02:42:01.633195",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Checking Minute Sleep Merged "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 66,
   "id": "e83dabda",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:01.738389Z",
     "iopub.status.busy": "2023-07-13T02:42:01.737012Z",
     "iopub.status.idle": "2023-07-13T02:42:01.780894Z",
     "shell.execute_reply": "2023-07-13T02:42:01.778775Z"
    },
    "papermill": {
     "duration": 0.083615,
     "end_time": "2023-07-13T02:42:01.783006",
     "exception": false,
     "start_time": "2023-07-13T02:42:01.699391",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 5</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>SleepDay</th><th scope=col>TotalSleepRecords</th><th scope=col>TotalMinutesAsleep</th><th scope=col>TotalTimeInBed</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>4/12/2016 12:00:00 AM</td><td>1</td><td>327</td><td>346</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>4/13/2016 12:00:00 AM</td><td>2</td><td>384</td><td>407</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>4/15/2016 12:00:00 AM</td><td>1</td><td>412</td><td>442</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>4/16/2016 12:00:00 AM</td><td>2</td><td>340</td><td>367</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>4/17/2016 12:00:00 AM</td><td>1</td><td>700</td><td>712</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>4/19/2016 12:00:00 AM</td><td>1</td><td>304</td><td>320</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 5\n",
       "\\begin{tabular}{r|lllll}\n",
       "  & Id & SleepDay & TotalSleepRecords & TotalMinutesAsleep & TotalTimeInBed\\\\\n",
       "  & <dbl> & <chr> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 4/12/2016 12:00:00 AM & 1 & 327 & 346\\\\\n",
       "\t2 & 1503960366 & 4/13/2016 12:00:00 AM & 2 & 384 & 407\\\\\n",
       "\t3 & 1503960366 & 4/15/2016 12:00:00 AM & 1 & 412 & 442\\\\\n",
       "\t4 & 1503960366 & 4/16/2016 12:00:00 AM & 2 & 340 & 367\\\\\n",
       "\t5 & 1503960366 & 4/17/2016 12:00:00 AM & 1 & 700 & 712\\\\\n",
       "\t6 & 1503960366 & 4/19/2016 12:00:00 AM & 1 & 304 & 320\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 5\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | SleepDay &lt;chr&gt; | TotalSleepRecords &lt;int&gt; | TotalMinutesAsleep &lt;int&gt; | TotalTimeInBed &lt;int&gt; |\n",
       "|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 4/12/2016 12:00:00 AM | 1 | 327 | 346 |\n",
       "| 2 | 1503960366 | 4/13/2016 12:00:00 AM | 2 | 384 | 407 |\n",
       "| 3 | 1503960366 | 4/15/2016 12:00:00 AM | 1 | 412 | 442 |\n",
       "| 4 | 1503960366 | 4/16/2016 12:00:00 AM | 2 | 340 | 367 |\n",
       "| 5 | 1503960366 | 4/17/2016 12:00:00 AM | 1 | 700 | 712 |\n",
       "| 6 | 1503960366 | 4/19/2016 12:00:00 AM | 1 | 304 | 320 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         SleepDay              TotalSleepRecords TotalMinutesAsleep\n",
       "1 1503960366 4/12/2016 12:00:00 AM 1                 327               \n",
       "2 1503960366 4/13/2016 12:00:00 AM 2                 384               \n",
       "3 1503960366 4/15/2016 12:00:00 AM 1                 412               \n",
       "4 1503960366 4/16/2016 12:00:00 AM 2                 340               \n",
       "5 1503960366 4/17/2016 12:00:00 AM 1                 700               \n",
       "6 1503960366 4/19/2016 12:00:00 AM 1                 304               \n",
       "  TotalTimeInBed\n",
       "1 346           \n",
       "2 407           \n",
       "3 442           \n",
       "4 367           \n",
       "5 712           \n",
       "6 320           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "min_slp_merged <- read.csv(\"/kaggle/input/fitbit/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv\")\n",
    "head(min_slp_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 67,
   "id": "f2945c07",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:01.860577Z",
     "iopub.status.busy": "2023-07-13T02:42:01.858882Z",
     "iopub.status.idle": "2023-07-13T02:42:01.892226Z",
     "shell.execute_reply": "2023-07-13T02:42:01.890057Z"
    },
    "papermill": {
     "duration": 0.075217,
     "end_time": "2023-07-13T02:42:01.894941",
     "exception": false,
     "start_time": "2023-07-13T02:42:01.819724",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows: 940\n",
      "Columns: 23\n",
      "$ Id                       \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1503960366, 1503960366, 1503960366, 150396036…\n",
      "$ ActivityDay              \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m \"04/12/2016\", \"04/13/2016\", \"04/14/2016\", \"04…\n",
      "$ TotalSteps               \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 13162, 10735, 10460, 9762, 12669, 9705, 13019…\n",
      "$ TotalDistance            \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 8.50, 6.97, 6.74, 6.28, 8.16, 6.48, 8.59, 9.8…\n",
      "$ TrackerDistance          \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 8.50, 6.97, 6.74, 6.28, 8.16, 6.48, 8.59, 9.8…\n",
      "$ LoggedActivitiesDistance \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …\n",
      "$ VeryActiveDistance       \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 1.88, 1.57, 2.44, 2.14, 2.71, 3.19, 3.25, 3.5…\n",
      "$ ModeratelyActiveDistance \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 0.55, 0.69, 0.40, 1.26, 0.41, 0.78, 0.64, 1.3…\n",
      "$ LightActiveDistance      \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 6.06, 4.71, 3.91, 2.83, 5.04, 2.51, 4.71, 5.0…\n",
      "$ SedentaryActiveDistance  \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …\n",
      "$ VeryActiveMinutes        \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 25, 21, 30, 29, 36, 38, 42, 50, 28, 19, 66, 4…\n",
      "$ FairlyActiveMinutes      \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 13, 19, 11, 34, 10, 20, 16, 31, 12, 8, 27, 21…\n",
      "$ LightlyActiveMinutes     \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 328, 217, 181, 209, 221, 164, 233, 264, 205, …\n",
      "$ SedentaryMinutes         \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 728, 776, 1218, 726, 773, 539, 1149, 775, 818…\n",
      "$ Calories                 \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m 1985, 1797, 1776, 1745, 1863, 1728, 1921, 203…\n",
      "$ Median_Value             \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…\n",
      "$ Median_Hourly_Calorie    \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 76.0, 71.5, 62.5, 59.5, 63.5, 53.5, 71.5, 75.…\n",
      "$ MedTotalIntensity        \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 13.0, 11.5, 6.0, 6.5, 9.5, 1.5, 12.5, 13.0, 7…\n",
      "$ MedAverageIntensity      \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 0.2166670, 0.1916665, 0.1000000, 0.1083335, 0…\n",
      "$ MedianHourlySteps        \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 341.0, 285.0, 69.5, 80.0, 123.5, 10.5, 272.5,…\n",
      "$ MedianMinCalories        \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 0.94380, 0.78650, 0.94380, 0.78650, 0.78650, …\n",
      "$ AvgMinIntensity          \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 0.2979167, 0.2208333, 0.2034722, 0.2527778, 0…\n",
      "$ AvgMinMet                \u001b[3m\u001b[90m<dbl>\u001b[39m\u001b[23m 12, 10, 12, 10, 10, 10, 12, 12, 12, 12, 10, 1…\n"
     ]
    }
   ],
   "source": [
    "glimpse(new_activity_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 68,
   "id": "0a780997",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:01.976087Z",
     "iopub.status.busy": "2023-07-13T02:42:01.973415Z",
     "iopub.status.idle": "2023-07-13T02:42:02.003120Z",
     "shell.execute_reply": "2023-07-13T02:42:02.001719Z"
    },
    "papermill": {
     "duration": 0.075163,
     "end_time": "2023-07-13T02:42:02.004987",
     "exception": false,
     "start_time": "2023-07-13T02:42:01.929824",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 5</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>SleepDay</th><th scope=col>TotalSleepRecords</th><th scope=col>TotalMinutesAsleep</th><th scope=col>TotalTimeInBed</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>1</td><td>327</td><td>346</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/13/2016</td><td>2</td><td>384</td><td>407</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/15/2016</td><td>1</td><td>412</td><td>442</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/16/2016</td><td>2</td><td>340</td><td>367</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/17/2016</td><td>1</td><td>700</td><td>712</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/19/2016</td><td>1</td><td>304</td><td>320</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 5\n",
       "\\begin{tabular}{r|lllll}\n",
       "  & Id & SleepDay & TotalSleepRecords & TotalMinutesAsleep & TotalTimeInBed\\\\\n",
       "  & <dbl> & <chr> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 1 & 327 & 346\\\\\n",
       "\t2 & 1503960366 & 04/13/2016 & 2 & 384 & 407\\\\\n",
       "\t3 & 1503960366 & 04/15/2016 & 1 & 412 & 442\\\\\n",
       "\t4 & 1503960366 & 04/16/2016 & 2 & 340 & 367\\\\\n",
       "\t5 & 1503960366 & 04/17/2016 & 1 & 700 & 712\\\\\n",
       "\t6 & 1503960366 & 04/19/2016 & 1 & 304 & 320\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 5\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | SleepDay &lt;chr&gt; | TotalSleepRecords &lt;int&gt; | TotalMinutesAsleep &lt;int&gt; | TotalTimeInBed &lt;int&gt; |\n",
       "|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 1 | 327 | 346 |\n",
       "| 2 | 1503960366 | 04/13/2016 | 2 | 384 | 407 |\n",
       "| 3 | 1503960366 | 04/15/2016 | 1 | 412 | 442 |\n",
       "| 4 | 1503960366 | 04/16/2016 | 2 | 340 | 367 |\n",
       "| 5 | 1503960366 | 04/17/2016 | 1 | 700 | 712 |\n",
       "| 6 | 1503960366 | 04/19/2016 | 1 | 304 | 320 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         SleepDay   TotalSleepRecords TotalMinutesAsleep TotalTimeInBed\n",
       "1 1503960366 04/12/2016 1                 327                346           \n",
       "2 1503960366 04/13/2016 2                 384                407           \n",
       "3 1503960366 04/15/2016 1                 412                442           \n",
       "4 1503960366 04/16/2016 2                 340                367           \n",
       "5 1503960366 04/17/2016 1                 700                712           \n",
       "6 1503960366 04/19/2016 1                 304                320           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "min_slp_merged$SleepDay <- as.Date(min_slp_merged$SleepDay, \n",
    "                                   format = \"%m/%d/%Y\")\n",
    "min_slp_merged$SleepDay <- format(min_slp_merged$SleepDay,\"%m/%d/%Y\")\n",
    "head(min_slp_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 69,
   "id": "c2bd4951",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:02.087961Z",
     "iopub.status.busy": "2023-07-13T02:42:02.086153Z",
     "iopub.status.idle": "2023-07-13T02:42:02.112321Z",
     "shell.execute_reply": "2023-07-13T02:42:02.110799Z"
    },
    "papermill": {
     "duration": 0.069325,
     "end_time": "2023-07-13T02:42:02.114695",
     "exception": false,
     "start_time": "2023-07-13T02:42:02.045370",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 5</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>TotalSleepRecords</th><th scope=col>TotalMinutesAsleep</th><th scope=col>TotalTimeInBed</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>1</td><td>327</td><td>346</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/13/2016</td><td>2</td><td>384</td><td>407</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/15/2016</td><td>1</td><td>412</td><td>442</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/16/2016</td><td>2</td><td>340</td><td>367</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/17/2016</td><td>1</td><td>700</td><td>712</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/19/2016</td><td>1</td><td>304</td><td>320</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 5\n",
       "\\begin{tabular}{r|lllll}\n",
       "  & Id & ActivityDay & TotalSleepRecords & TotalMinutesAsleep & TotalTimeInBed\\\\\n",
       "  & <dbl> & <chr> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 1 & 327 & 346\\\\\n",
       "\t2 & 1503960366 & 04/13/2016 & 2 & 384 & 407\\\\\n",
       "\t3 & 1503960366 & 04/15/2016 & 1 & 412 & 442\\\\\n",
       "\t4 & 1503960366 & 04/16/2016 & 2 & 340 & 367\\\\\n",
       "\t5 & 1503960366 & 04/17/2016 & 1 & 700 & 712\\\\\n",
       "\t6 & 1503960366 & 04/19/2016 & 1 & 304 & 320\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 5\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | TotalSleepRecords &lt;int&gt; | TotalMinutesAsleep &lt;int&gt; | TotalTimeInBed &lt;int&gt; |\n",
       "|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 1 | 327 | 346 |\n",
       "| 2 | 1503960366 | 04/13/2016 | 2 | 384 | 407 |\n",
       "| 3 | 1503960366 | 04/15/2016 | 1 | 412 | 442 |\n",
       "| 4 | 1503960366 | 04/16/2016 | 2 | 340 | 367 |\n",
       "| 5 | 1503960366 | 04/17/2016 | 1 | 700 | 712 |\n",
       "| 6 | 1503960366 | 04/19/2016 | 1 | 304 | 320 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay TotalSleepRecords TotalMinutesAsleep TotalTimeInBed\n",
       "1 1503960366 04/12/2016  1                 327                346           \n",
       "2 1503960366 04/13/2016  2                 384                407           \n",
       "3 1503960366 04/15/2016  1                 412                442           \n",
       "4 1503960366 04/16/2016  2                 340                367           \n",
       "5 1503960366 04/17/2016  1                 700                712           \n",
       "6 1503960366 04/19/2016  1                 304                320           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "colnames(min_slp_merged)[2] <- \"ActivityDay\"\n",
    "head(min_slp_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 70,
   "id": "38aab94b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:02.187519Z",
     "iopub.status.busy": "2023-07-13T02:42:02.186306Z",
     "iopub.status.idle": "2023-07-13T02:42:02.201824Z",
     "shell.execute_reply": "2023-07-13T02:42:02.199324Z"
    },
    "papermill": {
     "duration": 0.054483,
     "end_time": "2023-07-13T02:42:02.204420",
     "exception": false,
     "start_time": "2023-07-13T02:42:02.149937",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "sum(is.na(min_slp_merged))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 71,
   "id": "82bbc9ad",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:02.278032Z",
     "iopub.status.busy": "2023-07-13T02:42:02.276593Z",
     "iopub.status.idle": "2023-07-13T02:42:02.293350Z",
     "shell.execute_reply": "2023-07-13T02:42:02.290882Z"
    },
    "papermill": {
     "duration": 0.056631,
     "end_time": "2023-07-13T02:42:02.295771",
     "exception": false,
     "start_time": "2023-07-13T02:42:02.239140",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "The total number of dissimilar Ids:  9 \n",
      "[1] 1624580081 2022484408 2873212765 3372868164 4057192912 6290855005 8253242879\n",
      "[8] 8583815059 8877689391\n"
     ]
    }
   ],
   "source": [
    "diff_find(new_activity_merged, min_slp_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 72,
   "id": "7ed21ede",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:02.369857Z",
     "iopub.status.busy": "2023-07-13T02:42:02.368048Z",
     "iopub.status.idle": "2023-07-13T02:42:02.422801Z",
     "shell.execute_reply": "2023-07-13T02:42:02.421092Z"
    },
    "papermill": {
     "duration": 0.095035,
     "end_time": "2023-07-13T02:42:02.425107",
     "exception": false,
     "start_time": "2023-07-13T02:42:02.330072",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 26</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>⋯</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedAverageIntensity</th><th scope=col>MedianHourlySteps</th><th scope=col>MedianMinCalories</th><th scope=col>AvgMinIntensity</th><th scope=col>AvgMinMet</th><th scope=col>TotalSleepRecords</th><th scope=col>TotalMinutesAsleep</th><th scope=col>TotalTimeInBed</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>⋯</td><td>76.0</td><td>13.0</td><td>0.2166670</td><td>341.0</td><td>0.9438</td><td>0.2979167</td><td>12</td><td> 1</td><td>327</td><td>346</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/13/2016</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>⋯</td><td>71.5</td><td>11.5</td><td>0.1916665</td><td>285.0</td><td>0.7865</td><td>0.2208333</td><td>10</td><td> 2</td><td>384</td><td>407</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/14/2016</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>⋯</td><td>62.5</td><td> 6.0</td><td>0.1000000</td><td> 69.5</td><td>0.9438</td><td>0.2034722</td><td>12</td><td>NA</td><td> NA</td><td> NA</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/15/2016</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>⋯</td><td>59.5</td><td> 6.5</td><td>0.1083335</td><td> 80.0</td><td>0.7865</td><td>0.2527778</td><td>10</td><td> 1</td><td>412</td><td>442</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/16/2016</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>⋯</td><td>63.5</td><td> 9.5</td><td>0.1583335</td><td>123.5</td><td>0.7865</td><td>0.2423611</td><td>10</td><td> 2</td><td>340</td><td>367</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/17/2016</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>⋯</td><td>53.5</td><td> 1.5</td><td>0.0250000</td><td> 10.5</td><td>0.7865</td><td>0.2208333</td><td>10</td><td> 1</td><td>700</td><td>712</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 26\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & Id & ActivityDay & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & ⋯ & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedAverageIntensity & MedianHourlySteps & MedianMinCalories & AvgMinIntensity & AvgMinMet & TotalSleepRecords & TotalMinutesAsleep & TotalTimeInBed\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <int> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & ⋯ & 76.0 & 13.0 & 0.2166670 & 341.0 & 0.9438 & 0.2979167 & 12 &  1 & 327 & 346\\\\\n",
       "\t2 & 1503960366 & 04/13/2016 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & ⋯ & 71.5 & 11.5 & 0.1916665 & 285.0 & 0.7865 & 0.2208333 & 10 &  2 & 384 & 407\\\\\n",
       "\t3 & 1503960366 & 04/14/2016 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & ⋯ & 62.5 &  6.0 & 0.1000000 &  69.5 & 0.9438 & 0.2034722 & 12 & NA &  NA &  NA\\\\\n",
       "\t4 & 1503960366 & 04/15/2016 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & ⋯ & 59.5 &  6.5 & 0.1083335 &  80.0 & 0.7865 & 0.2527778 & 10 &  1 & 412 & 442\\\\\n",
       "\t5 & 1503960366 & 04/16/2016 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & ⋯ & 63.5 &  9.5 & 0.1583335 & 123.5 & 0.7865 & 0.2423611 & 10 &  2 & 340 & 367\\\\\n",
       "\t6 & 1503960366 & 04/17/2016 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & ⋯ & 53.5 &  1.5 & 0.0250000 &  10.5 & 0.7865 & 0.2208333 & 10 &  1 & 700 & 712\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 26\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | ⋯ ⋯ | Median_Hourly_Calorie &lt;dbl&gt; | MedTotalIntensity &lt;dbl&gt; | MedAverageIntensity &lt;dbl&gt; | MedianHourlySteps &lt;dbl&gt; | MedianMinCalories &lt;dbl&gt; | AvgMinIntensity &lt;dbl&gt; | AvgMinMet &lt;dbl&gt; | TotalSleepRecords &lt;int&gt; | TotalMinutesAsleep &lt;int&gt; | TotalTimeInBed &lt;int&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | ⋯ | 76.0 | 13.0 | 0.2166670 | 341.0 | 0.9438 | 0.2979167 | 12 |  1 | 327 | 346 |\n",
       "| 2 | 1503960366 | 04/13/2016 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | ⋯ | 71.5 | 11.5 | 0.1916665 | 285.0 | 0.7865 | 0.2208333 | 10 |  2 | 384 | 407 |\n",
       "| 3 | 1503960366 | 04/14/2016 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | ⋯ | 62.5 |  6.0 | 0.1000000 |  69.5 | 0.9438 | 0.2034722 | 12 | NA |  NA |  NA |\n",
       "| 4 | 1503960366 | 04/15/2016 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | ⋯ | 59.5 |  6.5 | 0.1083335 |  80.0 | 0.7865 | 0.2527778 | 10 |  1 | 412 | 442 |\n",
       "| 5 | 1503960366 | 04/16/2016 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | ⋯ | 63.5 |  9.5 | 0.1583335 | 123.5 | 0.7865 | 0.2423611 | 10 |  2 | 340 | 367 |\n",
       "| 6 | 1503960366 | 04/17/2016 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | ⋯ | 53.5 |  1.5 | 0.0250000 |  10.5 | 0.7865 | 0.2208333 | 10 |  1 | 700 | 712 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay TotalSteps TotalDistance TrackerDistance\n",
       "1 1503960366 04/12/2016  13162      8.50          8.50           \n",
       "2 1503960366 04/13/2016  10735      6.97          6.97           \n",
       "3 1503960366 04/14/2016  10460      6.74          6.74           \n",
       "4 1503960366 04/15/2016   9762      6.28          6.28           \n",
       "5 1503960366 04/16/2016  12669      8.16          8.16           \n",
       "6 1503960366 04/17/2016   9705      6.48          6.48           \n",
       "  LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance\n",
       "1 0                        1.88               0.55                    \n",
       "2 0                        1.57               0.69                    \n",
       "3 0                        2.44               0.40                    \n",
       "4 0                        2.14               1.26                    \n",
       "5 0                        2.71               0.41                    \n",
       "6 0                        3.19               0.78                    \n",
       "  LightActiveDistance SedentaryActiveDistance ⋯ Median_Hourly_Calorie\n",
       "1 6.06                0                       ⋯ 76.0                 \n",
       "2 4.71                0                       ⋯ 71.5                 \n",
       "3 3.91                0                       ⋯ 62.5                 \n",
       "4 2.83                0                       ⋯ 59.5                 \n",
       "5 5.04                0                       ⋯ 63.5                 \n",
       "6 2.51                0                       ⋯ 53.5                 \n",
       "  MedTotalIntensity MedAverageIntensity MedianHourlySteps MedianMinCalories\n",
       "1 13.0              0.2166670           341.0             0.9438           \n",
       "2 11.5              0.1916665           285.0             0.7865           \n",
       "3  6.0              0.1000000            69.5             0.9438           \n",
       "4  6.5              0.1083335            80.0             0.7865           \n",
       "5  9.5              0.1583335           123.5             0.7865           \n",
       "6  1.5              0.0250000            10.5             0.7865           \n",
       "  AvgMinIntensity AvgMinMet TotalSleepRecords TotalMinutesAsleep TotalTimeInBed\n",
       "1 0.2979167       12         1                327                346           \n",
       "2 0.2208333       10         2                384                407           \n",
       "3 0.2034722       12        NA                 NA                 NA           \n",
       "4 0.2527778       10         1                412                442           \n",
       "5 0.2423611       10         2                340                367           \n",
       "6 0.2208333       10         1                700                712           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>943</li><li>26</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 943\n",
       "\\item 26\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 943\n",
       "2. 26\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 943  26"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "2240"
      ],
      "text/latex": [
       "2240"
      ],
      "text/markdown": [
       "2240"
      ],
      "text/plain": [
       "[1] 2240"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "new_activity_merged <- merge(new_activity_merged, min_slp_merged,\n",
    "                            by = c(\"Id\", \"ActivityDay\"), all = TRUE)\n",
    "head(new_activity_merged)\n",
    "dim(new_activity_merged)\n",
    "sum(is.na(new_activity_merged))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "4ac861ad",
   "metadata": {
    "papermill": {
     "duration": 0.035527,
     "end_time": "2023-07-13T02:42:02.496068",
     "exception": false,
     "start_time": "2023-07-13T02:42:02.460541",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Distribution of Null Values"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 73,
   "id": "ea48b1ce",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:02.570427Z",
     "iopub.status.busy": "2023-07-13T02:42:02.569068Z",
     "iopub.status.idle": "2023-07-13T02:42:02.586351Z",
     "shell.execute_reply": "2023-07-13T02:42:02.584958Z"
    },
    "papermill": {
     "duration": 0.057598,
     "end_time": "2023-07-13T02:42:02.588960",
     "exception": false,
     "start_time": "2023-07-13T02:42:02.531362",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>Median_Value</dt><dd>64.475079533404</dd><dt>Median_Hourly_Calorie</dt><dd>0.63626723223754</dd><dt>MedTotalIntensity</dt><dd>0.63626723223754</dd><dt>MedAverageIntensity</dt><dd>0.63626723223754</dd><dt>MedianHourlySteps</dt><dd>0.63626723223754</dd><dt>MedianMinCalories</dt><dd>0.63626723223754</dd><dt>AvgMinIntensity</dt><dd>0.63626723223754</dd><dt>AvgMinMet</dt><dd>0.63626723223754</dd><dt>TotalSleepRecords</dt><dd>56.203605514316</dd><dt>TotalMinutesAsleep</dt><dd>56.203605514316</dd><dt>TotalTimeInBed</dt><dd>56.203605514316</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[Median\\textbackslash{}\\_Value] 64.475079533404\n",
       "\\item[Median\\textbackslash{}\\_Hourly\\textbackslash{}\\_Calorie] 0.63626723223754\n",
       "\\item[MedTotalIntensity] 0.63626723223754\n",
       "\\item[MedAverageIntensity] 0.63626723223754\n",
       "\\item[MedianHourlySteps] 0.63626723223754\n",
       "\\item[MedianMinCalories] 0.63626723223754\n",
       "\\item[AvgMinIntensity] 0.63626723223754\n",
       "\\item[AvgMinMet] 0.63626723223754\n",
       "\\item[TotalSleepRecords] 56.203605514316\n",
       "\\item[TotalMinutesAsleep] 56.203605514316\n",
       "\\item[TotalTimeInBed] 56.203605514316\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "Median_Value\n",
       ":   64.475079533404Median_Hourly_Calorie\n",
       ":   0.63626723223754MedTotalIntensity\n",
       ":   0.63626723223754MedAverageIntensity\n",
       ":   0.63626723223754MedianHourlySteps\n",
       ":   0.63626723223754MedianMinCalories\n",
       ":   0.63626723223754AvgMinIntensity\n",
       ":   0.63626723223754AvgMinMet\n",
       ":   0.63626723223754TotalSleepRecords\n",
       ":   56.203605514316TotalMinutesAsleep\n",
       ":   56.203605514316TotalTimeInBed\n",
       ":   56.203605514316\n",
       "\n"
      ],
      "text/plain": [
       "         Median_Value Median_Hourly_Calorie     MedTotalIntensity \n",
       "           64.4750795             0.6362672             0.6362672 \n",
       "  MedAverageIntensity     MedianHourlySteps     MedianMinCalories \n",
       "            0.6362672             0.6362672             0.6362672 \n",
       "      AvgMinIntensity             AvgMinMet     TotalSleepRecords \n",
       "            0.6362672             0.6362672            56.2036055 \n",
       "   TotalMinutesAsleep        TotalTimeInBed \n",
       "           56.2036055            56.2036055 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Calculate the percentage of null values in each column\n",
    "null_percentages <- colMeans(is.na(new_activity_merged)) * 100\n",
    "null_percentages[null_percentages!=0]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 74,
   "id": "3f649560",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:02.664497Z",
     "iopub.status.busy": "2023-07-13T02:42:02.662885Z",
     "iopub.status.idle": "2023-07-13T02:42:02.680399Z",
     "shell.execute_reply": "2023-07-13T02:42:02.678822Z"
    },
    "papermill": {
     "duration": 0.057633,
     "end_time": "2023-07-13T02:42:02.683107",
     "exception": false,
     "start_time": "2023-07-13T02:42:02.625474",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>Id</dt><dd>0</dd><dt>ActivityDay</dt><dd>0</dd><dt>TotalSteps</dt><dd>0</dd><dt>TotalDistance</dt><dd>0</dd><dt>TrackerDistance</dt><dd>0</dd><dt>LoggedActivitiesDistance</dt><dd>0</dd><dt>VeryActiveDistance</dt><dd>0</dd><dt>ModeratelyActiveDistance</dt><dd>0</dd><dt>LightActiveDistance</dt><dd>0</dd><dt>SedentaryActiveDistance</dt><dd>0</dd><dt>VeryActiveMinutes</dt><dd>0</dd><dt>FairlyActiveMinutes</dt><dd>0</dd><dt>LightlyActiveMinutes</dt><dd>0</dd><dt>SedentaryMinutes</dt><dd>0</dd><dt>Calories</dt><dd>0</dd><dt>Median_Value</dt><dd>64.475079533404</dd><dt>Median_Hourly_Calorie</dt><dd>0.63626723223754</dd><dt>MedTotalIntensity</dt><dd>0.63626723223754</dd><dt>MedAverageIntensity</dt><dd>0.63626723223754</dd><dt>MedianHourlySteps</dt><dd>0.63626723223754</dd><dt>MedianMinCalories</dt><dd>0.63626723223754</dd><dt>AvgMinIntensity</dt><dd>0.63626723223754</dd><dt>AvgMinMet</dt><dd>0.63626723223754</dd><dt>TotalSleepRecords</dt><dd>56.203605514316</dd><dt>TotalMinutesAsleep</dt><dd>56.203605514316</dd><dt>TotalTimeInBed</dt><dd>56.203605514316</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[Id] 0\n",
       "\\item[ActivityDay] 0\n",
       "\\item[TotalSteps] 0\n",
       "\\item[TotalDistance] 0\n",
       "\\item[TrackerDistance] 0\n",
       "\\item[LoggedActivitiesDistance] 0\n",
       "\\item[VeryActiveDistance] 0\n",
       "\\item[ModeratelyActiveDistance] 0\n",
       "\\item[LightActiveDistance] 0\n",
       "\\item[SedentaryActiveDistance] 0\n",
       "\\item[VeryActiveMinutes] 0\n",
       "\\item[FairlyActiveMinutes] 0\n",
       "\\item[LightlyActiveMinutes] 0\n",
       "\\item[SedentaryMinutes] 0\n",
       "\\item[Calories] 0\n",
       "\\item[Median\\textbackslash{}\\_Value] 64.475079533404\n",
       "\\item[Median\\textbackslash{}\\_Hourly\\textbackslash{}\\_Calorie] 0.63626723223754\n",
       "\\item[MedTotalIntensity] 0.63626723223754\n",
       "\\item[MedAverageIntensity] 0.63626723223754\n",
       "\\item[MedianHourlySteps] 0.63626723223754\n",
       "\\item[MedianMinCalories] 0.63626723223754\n",
       "\\item[AvgMinIntensity] 0.63626723223754\n",
       "\\item[AvgMinMet] 0.63626723223754\n",
       "\\item[TotalSleepRecords] 56.203605514316\n",
       "\\item[TotalMinutesAsleep] 56.203605514316\n",
       "\\item[TotalTimeInBed] 56.203605514316\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "Id\n",
       ":   0ActivityDay\n",
       ":   0TotalSteps\n",
       ":   0TotalDistance\n",
       ":   0TrackerDistance\n",
       ":   0LoggedActivitiesDistance\n",
       ":   0VeryActiveDistance\n",
       ":   0ModeratelyActiveDistance\n",
       ":   0LightActiveDistance\n",
       ":   0SedentaryActiveDistance\n",
       ":   0VeryActiveMinutes\n",
       ":   0FairlyActiveMinutes\n",
       ":   0LightlyActiveMinutes\n",
       ":   0SedentaryMinutes\n",
       ":   0Calories\n",
       ":   0Median_Value\n",
       ":   64.475079533404Median_Hourly_Calorie\n",
       ":   0.63626723223754MedTotalIntensity\n",
       ":   0.63626723223754MedAverageIntensity\n",
       ":   0.63626723223754MedianHourlySteps\n",
       ":   0.63626723223754MedianMinCalories\n",
       ":   0.63626723223754AvgMinIntensity\n",
       ":   0.63626723223754AvgMinMet\n",
       ":   0.63626723223754TotalSleepRecords\n",
       ":   56.203605514316TotalMinutesAsleep\n",
       ":   56.203605514316TotalTimeInBed\n",
       ":   56.203605514316\n",
       "\n"
      ],
      "text/plain": [
       "                      Id              ActivityDay               TotalSteps \n",
       "               0.0000000                0.0000000                0.0000000 \n",
       "           TotalDistance          TrackerDistance LoggedActivitiesDistance \n",
       "               0.0000000                0.0000000                0.0000000 \n",
       "      VeryActiveDistance ModeratelyActiveDistance      LightActiveDistance \n",
       "               0.0000000                0.0000000                0.0000000 \n",
       " SedentaryActiveDistance        VeryActiveMinutes      FairlyActiveMinutes \n",
       "               0.0000000                0.0000000                0.0000000 \n",
       "    LightlyActiveMinutes         SedentaryMinutes                 Calories \n",
       "               0.0000000                0.0000000                0.0000000 \n",
       "            Median_Value    Median_Hourly_Calorie        MedTotalIntensity \n",
       "              64.4750795                0.6362672                0.6362672 \n",
       "     MedAverageIntensity        MedianHourlySteps        MedianMinCalories \n",
       "               0.6362672                0.6362672                0.6362672 \n",
       "         AvgMinIntensity                AvgMinMet        TotalSleepRecords \n",
       "               0.6362672                0.6362672               56.2036055 \n",
       "      TotalMinutesAsleep           TotalTimeInBed \n",
       "              56.2036055               56.2036055 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "null_percentages"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 75,
   "id": "ddaa4827",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:02.758038Z",
     "iopub.status.busy": "2023-07-13T02:42:02.756793Z",
     "iopub.status.idle": "2023-07-13T02:42:02.794312Z",
     "shell.execute_reply": "2023-07-13T02:42:02.792933Z"
    },
    "papermill": {
     "duration": 0.078436,
     "end_time": "2023-07-13T02:42:02.796919",
     "exception": false,
     "start_time": "2023-07-13T02:42:02.718483",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 22</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>ActivityDay</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>⋯</th><th scope=col>LightlyActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedAverageIntensity</th><th scope=col>MedianHourlySteps</th><th scope=col>MedianMinCalories</th><th scope=col>AvgMinIntensity</th><th scope=col>AvgMinMet</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>⋯</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>04/12/2016</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>⋯</td><td>328</td><td> 728</td><td>1985</td><td>76.0</td><td>13.0</td><td>0.2166670</td><td>341.0</td><td>0.9438</td><td>0.2979167</td><td>12</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>04/13/2016</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>⋯</td><td>217</td><td> 776</td><td>1797</td><td>71.5</td><td>11.5</td><td>0.1916665</td><td>285.0</td><td>0.7865</td><td>0.2208333</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>04/14/2016</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>⋯</td><td>181</td><td>1218</td><td>1776</td><td>62.5</td><td> 6.0</td><td>0.1000000</td><td> 69.5</td><td>0.9438</td><td>0.2034722</td><td>12</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td>04/15/2016</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>⋯</td><td>209</td><td> 726</td><td>1745</td><td>59.5</td><td> 6.5</td><td>0.1083335</td><td> 80.0</td><td>0.7865</td><td>0.2527778</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>04/16/2016</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>⋯</td><td>221</td><td> 773</td><td>1863</td><td>63.5</td><td> 9.5</td><td>0.1583335</td><td>123.5</td><td>0.7865</td><td>0.2423611</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td>04/17/2016</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>⋯</td><td>164</td><td> 539</td><td>1728</td><td>53.5</td><td> 1.5</td><td>0.0250000</td><td> 10.5</td><td>0.7865</td><td>0.2208333</td><td>10</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 22\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & Id & ActivityDay & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & ⋯ & LightlyActiveMinutes & SedentaryMinutes & Calories & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedAverageIntensity & MedianHourlySteps & MedianMinCalories & AvgMinIntensity & AvgMinMet\\\\\n",
       "  & <dbl> & <chr> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & ⋯ & <int> & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 04/12/2016 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & ⋯ & 328 &  728 & 1985 & 76.0 & 13.0 & 0.2166670 & 341.0 & 0.9438 & 0.2979167 & 12\\\\\n",
       "\t2 & 1503960366 & 04/13/2016 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & ⋯ & 217 &  776 & 1797 & 71.5 & 11.5 & 0.1916665 & 285.0 & 0.7865 & 0.2208333 & 10\\\\\n",
       "\t3 & 1503960366 & 04/14/2016 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & ⋯ & 181 & 1218 & 1776 & 62.5 &  6.0 & 0.1000000 &  69.5 & 0.9438 & 0.2034722 & 12\\\\\n",
       "\t4 & 1503960366 & 04/15/2016 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & ⋯ & 209 &  726 & 1745 & 59.5 &  6.5 & 0.1083335 &  80.0 & 0.7865 & 0.2527778 & 10\\\\\n",
       "\t5 & 1503960366 & 04/16/2016 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & ⋯ & 221 &  773 & 1863 & 63.5 &  9.5 & 0.1583335 & 123.5 & 0.7865 & 0.2423611 & 10\\\\\n",
       "\t6 & 1503960366 & 04/17/2016 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & ⋯ & 164 &  539 & 1728 & 53.5 &  1.5 & 0.0250000 &  10.5 & 0.7865 & 0.2208333 & 10\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 22\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | ActivityDay &lt;chr&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | ⋯ ⋯ | LightlyActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | Median_Hourly_Calorie &lt;dbl&gt; | MedTotalIntensity &lt;dbl&gt; | MedAverageIntensity &lt;dbl&gt; | MedianHourlySteps &lt;dbl&gt; | MedianMinCalories &lt;dbl&gt; | AvgMinIntensity &lt;dbl&gt; | AvgMinMet &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 04/12/2016 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | ⋯ | 328 |  728 | 1985 | 76.0 | 13.0 | 0.2166670 | 341.0 | 0.9438 | 0.2979167 | 12 |\n",
       "| 2 | 1503960366 | 04/13/2016 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | ⋯ | 217 |  776 | 1797 | 71.5 | 11.5 | 0.1916665 | 285.0 | 0.7865 | 0.2208333 | 10 |\n",
       "| 3 | 1503960366 | 04/14/2016 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | ⋯ | 181 | 1218 | 1776 | 62.5 |  6.0 | 0.1000000 |  69.5 | 0.9438 | 0.2034722 | 12 |\n",
       "| 4 | 1503960366 | 04/15/2016 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | ⋯ | 209 |  726 | 1745 | 59.5 |  6.5 | 0.1083335 |  80.0 | 0.7865 | 0.2527778 | 10 |\n",
       "| 5 | 1503960366 | 04/16/2016 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | ⋯ | 221 |  773 | 1863 | 63.5 |  9.5 | 0.1583335 | 123.5 | 0.7865 | 0.2423611 | 10 |\n",
       "| 6 | 1503960366 | 04/17/2016 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | ⋯ | 164 |  539 | 1728 | 53.5 |  1.5 | 0.0250000 |  10.5 | 0.7865 | 0.2208333 | 10 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         ActivityDay TotalSteps TotalDistance TrackerDistance\n",
       "1 1503960366 04/12/2016  13162      8.50          8.50           \n",
       "2 1503960366 04/13/2016  10735      6.97          6.97           \n",
       "3 1503960366 04/14/2016  10460      6.74          6.74           \n",
       "4 1503960366 04/15/2016   9762      6.28          6.28           \n",
       "5 1503960366 04/16/2016  12669      8.16          8.16           \n",
       "6 1503960366 04/17/2016   9705      6.48          6.48           \n",
       "  LoggedActivitiesDistance VeryActiveDistance ModeratelyActiveDistance\n",
       "1 0                        1.88               0.55                    \n",
       "2 0                        1.57               0.69                    \n",
       "3 0                        2.44               0.40                    \n",
       "4 0                        2.14               1.26                    \n",
       "5 0                        2.71               0.41                    \n",
       "6 0                        3.19               0.78                    \n",
       "  LightActiveDistance SedentaryActiveDistance ⋯ LightlyActiveMinutes\n",
       "1 6.06                0                       ⋯ 328                 \n",
       "2 4.71                0                       ⋯ 217                 \n",
       "3 3.91                0                       ⋯ 181                 \n",
       "4 2.83                0                       ⋯ 209                 \n",
       "5 5.04                0                       ⋯ 221                 \n",
       "6 2.51                0                       ⋯ 164                 \n",
       "  SedentaryMinutes Calories Median_Hourly_Calorie MedTotalIntensity\n",
       "1  728             1985     76.0                  13.0             \n",
       "2  776             1797     71.5                  11.5             \n",
       "3 1218             1776     62.5                   6.0             \n",
       "4  726             1745     59.5                   6.5             \n",
       "5  773             1863     63.5                   9.5             \n",
       "6  539             1728     53.5                   1.5             \n",
       "  MedAverageIntensity MedianHourlySteps MedianMinCalories AvgMinIntensity\n",
       "1 0.2166670           341.0             0.9438            0.2979167      \n",
       "2 0.1916665           285.0             0.7865            0.2208333      \n",
       "3 0.1000000            69.5             0.9438            0.2034722      \n",
       "4 0.1083335            80.0             0.7865            0.2527778      \n",
       "5 0.1583335           123.5             0.7865            0.2423611      \n",
       "6 0.0250000            10.5             0.7865            0.2208333      \n",
       "  AvgMinMet\n",
       "1 12       \n",
       "2 10       \n",
       "3 12       \n",
       "4 10       \n",
       "5 10       \n",
       "6 10       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "## Removing Columns with more than 30% Null Values\n",
    "new_activity_merged <- new_activity_merged%>%\n",
    "select(-matches(names(null_percentages)[null_percentages>30]))\n",
    "head(new_activity_merged)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f5442ca2",
   "metadata": {
    "papermill": {
     "duration": 0.036607,
     "end_time": "2023-07-13T02:42:02.869692",
     "exception": false,
     "start_time": "2023-07-13T02:42:02.833085",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Checking For Correlation"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 76,
   "id": "19763d37",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:02.945849Z",
     "iopub.status.busy": "2023-07-13T02:42:02.944467Z",
     "iopub.status.idle": "2023-07-13T02:42:02.958603Z",
     "shell.execute_reply": "2023-07-13T02:42:02.957224Z"
    },
    "papermill": {
     "duration": 0.054497,
     "end_time": "2023-07-13T02:42:02.961137",
     "exception": false,
     "start_time": "2023-07-13T02:42:02.906640",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>943</li><li>22</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 943\n",
       "\\item 22\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 943\n",
       "2. 22\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 943  22"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "dim(new_activity_merged)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 77,
   "id": "0275bf65",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:03.037197Z",
     "iopub.status.busy": "2023-07-13T02:42:03.035777Z",
     "iopub.status.idle": "2023-07-13T02:42:03.065224Z",
     "shell.execute_reply": "2023-07-13T02:42:03.063906Z"
    },
    "papermill": {
     "duration": 0.069116,
     "end_time": "2023-07-13T02:42:03.066992",
     "exception": false,
     "start_time": "2023-07-13T02:42:02.997876",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>943</li><li>21</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 943\n",
       "\\item 21\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 943\n",
       "2. 21\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 943  21"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "42"
      ],
      "text/latex": [
       "42"
      ],
      "text/markdown": [
       "42"
      ],
      "text/plain": [
       "[1] 42"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>937</li><li>21</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 937\n",
       "\\item 21\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 937\n",
       "2. 21\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] 937  21"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "0"
      ],
      "text/latex": [
       "0"
      ],
      "text/markdown": [
       "0"
      ],
      "text/plain": [
       "[1] 0"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "numeric_cols <- new_activity_merged[, sapply(new_activity_merged, is.numeric)]\n",
    "dim(numeric_cols)\n",
    "sum(is.na(numeric_cols))\n",
    "##Selecting All Non-Null Rows\n",
    "non_nulls <- numeric_cols[complete.cases(numeric_cols),]\n",
    "dim(non_nulls)\n",
    "sum(is.na(non_nulls))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 78,
   "id": "7a542711",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:03.143405Z",
     "iopub.status.busy": "2023-07-13T02:42:03.142091Z",
     "iopub.status.idle": "2023-07-13T02:42:03.213643Z",
     "shell.execute_reply": "2023-07-13T02:42:03.212325Z"
    },
    "papermill": {
     "duration": 0.111959,
     "end_time": "2023-07-13T02:42:03.215713",
     "exception": false,
     "start_time": "2023-07-13T02:42:03.103754",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 21</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>⋯</th><th scope=col>LightlyActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedAverageIntensity</th><th scope=col>MedianHourlySteps</th><th scope=col>MedianMinCalories</th><th scope=col>AvgMinIntensity</th><th scope=col>AvgMinMet</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>⋯</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>13162</td><td>8.50</td><td>8.50</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>25</td><td>⋯</td><td>328</td><td> 728</td><td>1985</td><td>76.0</td><td>13.0</td><td>0.2166670</td><td>341.0</td><td>0.9438</td><td>0.2979167</td><td>12</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>10735</td><td>6.97</td><td>6.97</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>21</td><td>⋯</td><td>217</td><td> 776</td><td>1797</td><td>71.5</td><td>11.5</td><td>0.1916665</td><td>285.0</td><td>0.7865</td><td>0.2208333</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>10460</td><td>6.74</td><td>6.74</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>30</td><td>⋯</td><td>181</td><td>1218</td><td>1776</td><td>62.5</td><td> 6.0</td><td>0.1000000</td><td> 69.5</td><td>0.9438</td><td>0.2034722</td><td>12</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td> 9762</td><td>6.28</td><td>6.28</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>29</td><td>⋯</td><td>209</td><td> 726</td><td>1745</td><td>59.5</td><td> 6.5</td><td>0.1083335</td><td> 80.0</td><td>0.7865</td><td>0.2527778</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>12669</td><td>8.16</td><td>8.16</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>36</td><td>⋯</td><td>221</td><td> 773</td><td>1863</td><td>63.5</td><td> 9.5</td><td>0.1583335</td><td>123.5</td><td>0.7865</td><td>0.2423611</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td> 9705</td><td>6.48</td><td>6.48</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>38</td><td>⋯</td><td>164</td><td> 539</td><td>1728</td><td>53.5</td><td> 1.5</td><td>0.0250000</td><td> 10.5</td><td>0.7865</td><td>0.2208333</td><td>10</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 21\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & Id & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & ⋯ & LightlyActiveMinutes & SedentaryMinutes & Calories & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedAverageIntensity & MedianHourlySteps & MedianMinCalories & AvgMinIntensity & AvgMinMet\\\\\n",
       "  & <dbl> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & ⋯ & <int> & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 13162 & 8.50 & 8.50 & 0 & 1.88 & 0.55 & 6.06 & 0 & 25 & ⋯ & 328 &  728 & 1985 & 76.0 & 13.0 & 0.2166670 & 341.0 & 0.9438 & 0.2979167 & 12\\\\\n",
       "\t2 & 1503960366 & 10735 & 6.97 & 6.97 & 0 & 1.57 & 0.69 & 4.71 & 0 & 21 & ⋯ & 217 &  776 & 1797 & 71.5 & 11.5 & 0.1916665 & 285.0 & 0.7865 & 0.2208333 & 10\\\\\n",
       "\t3 & 1503960366 & 10460 & 6.74 & 6.74 & 0 & 2.44 & 0.40 & 3.91 & 0 & 30 & ⋯ & 181 & 1218 & 1776 & 62.5 &  6.0 & 0.1000000 &  69.5 & 0.9438 & 0.2034722 & 12\\\\\n",
       "\t4 & 1503960366 &  9762 & 6.28 & 6.28 & 0 & 2.14 & 1.26 & 2.83 & 0 & 29 & ⋯ & 209 &  726 & 1745 & 59.5 &  6.5 & 0.1083335 &  80.0 & 0.7865 & 0.2527778 & 10\\\\\n",
       "\t5 & 1503960366 & 12669 & 8.16 & 8.16 & 0 & 2.71 & 0.41 & 5.04 & 0 & 36 & ⋯ & 221 &  773 & 1863 & 63.5 &  9.5 & 0.1583335 & 123.5 & 0.7865 & 0.2423611 & 10\\\\\n",
       "\t6 & 1503960366 &  9705 & 6.48 & 6.48 & 0 & 3.19 & 0.78 & 2.51 & 0 & 38 & ⋯ & 164 &  539 & 1728 & 53.5 &  1.5 & 0.0250000 &  10.5 & 0.7865 & 0.2208333 & 10\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 21\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | TotalSteps &lt;int&gt; | TotalDistance &lt;dbl&gt; | TrackerDistance &lt;dbl&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | VeryActiveMinutes &lt;int&gt; | ⋯ ⋯ | LightlyActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | Median_Hourly_Calorie &lt;dbl&gt; | MedTotalIntensity &lt;dbl&gt; | MedAverageIntensity &lt;dbl&gt; | MedianHourlySteps &lt;dbl&gt; | MedianMinCalories &lt;dbl&gt; | AvgMinIntensity &lt;dbl&gt; | AvgMinMet &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 13162 | 8.50 | 8.50 | 0 | 1.88 | 0.55 | 6.06 | 0 | 25 | ⋯ | 328 |  728 | 1985 | 76.0 | 13.0 | 0.2166670 | 341.0 | 0.9438 | 0.2979167 | 12 |\n",
       "| 2 | 1503960366 | 10735 | 6.97 | 6.97 | 0 | 1.57 | 0.69 | 4.71 | 0 | 21 | ⋯ | 217 |  776 | 1797 | 71.5 | 11.5 | 0.1916665 | 285.0 | 0.7865 | 0.2208333 | 10 |\n",
       "| 3 | 1503960366 | 10460 | 6.74 | 6.74 | 0 | 2.44 | 0.40 | 3.91 | 0 | 30 | ⋯ | 181 | 1218 | 1776 | 62.5 |  6.0 | 0.1000000 |  69.5 | 0.9438 | 0.2034722 | 12 |\n",
       "| 4 | 1503960366 |  9762 | 6.28 | 6.28 | 0 | 2.14 | 1.26 | 2.83 | 0 | 29 | ⋯ | 209 |  726 | 1745 | 59.5 |  6.5 | 0.1083335 |  80.0 | 0.7865 | 0.2527778 | 10 |\n",
       "| 5 | 1503960366 | 12669 | 8.16 | 8.16 | 0 | 2.71 | 0.41 | 5.04 | 0 | 36 | ⋯ | 221 |  773 | 1863 | 63.5 |  9.5 | 0.1583335 | 123.5 | 0.7865 | 0.2423611 | 10 |\n",
       "| 6 | 1503960366 |  9705 | 6.48 | 6.48 | 0 | 3.19 | 0.78 | 2.51 | 0 | 38 | ⋯ | 164 |  539 | 1728 | 53.5 |  1.5 | 0.0250000 |  10.5 | 0.7865 | 0.2208333 | 10 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         TotalSteps TotalDistance TrackerDistance LoggedActivitiesDistance\n",
       "1 1503960366 13162      8.50          8.50            0                       \n",
       "2 1503960366 10735      6.97          6.97            0                       \n",
       "3 1503960366 10460      6.74          6.74            0                       \n",
       "4 1503960366  9762      6.28          6.28            0                       \n",
       "5 1503960366 12669      8.16          8.16            0                       \n",
       "6 1503960366  9705      6.48          6.48            0                       \n",
       "  VeryActiveDistance ModeratelyActiveDistance LightActiveDistance\n",
       "1 1.88               0.55                     6.06               \n",
       "2 1.57               0.69                     4.71               \n",
       "3 2.44               0.40                     3.91               \n",
       "4 2.14               1.26                     2.83               \n",
       "5 2.71               0.41                     5.04               \n",
       "6 3.19               0.78                     2.51               \n",
       "  SedentaryActiveDistance VeryActiveMinutes ⋯ LightlyActiveMinutes\n",
       "1 0                       25                ⋯ 328                 \n",
       "2 0                       21                ⋯ 217                 \n",
       "3 0                       30                ⋯ 181                 \n",
       "4 0                       29                ⋯ 209                 \n",
       "5 0                       36                ⋯ 221                 \n",
       "6 0                       38                ⋯ 164                 \n",
       "  SedentaryMinutes Calories Median_Hourly_Calorie MedTotalIntensity\n",
       "1  728             1985     76.0                  13.0             \n",
       "2  776             1797     71.5                  11.5             \n",
       "3 1218             1776     62.5                   6.0             \n",
       "4  726             1745     59.5                   6.5             \n",
       "5  773             1863     63.5                   9.5             \n",
       "6  539             1728     53.5                   1.5             \n",
       "  MedAverageIntensity MedianHourlySteps MedianMinCalories AvgMinIntensity\n",
       "1 0.2166670           341.0             0.9438            0.2979167      \n",
       "2 0.1916665           285.0             0.7865            0.2208333      \n",
       "3 0.1000000            69.5             0.9438            0.2034722      \n",
       "4 0.1083335            80.0             0.7865            0.2527778      \n",
       "5 0.1583335           123.5             0.7865            0.2423611      \n",
       "6 0.0250000            10.5             0.7865            0.2208333      \n",
       "  AvgMinMet\n",
       "1 12       \n",
       "2 10       \n",
       "3 12       \n",
       "4 10       \n",
       "5 10       \n",
       "6 10       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(numeric_cols)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 79,
   "id": "c946d930",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:03.292959Z",
     "iopub.status.busy": "2023-07-13T02:42:03.291409Z",
     "iopub.status.idle": "2023-07-13T02:42:03.338729Z",
     "shell.execute_reply": "2023-07-13T02:42:03.336584Z"
    },
    "papermill": {
     "duration": 0.088134,
     "end_time": "2023-07-13T02:42:03.340673",
     "exception": false,
     "start_time": "2023-07-13T02:42:03.252539",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 21 × 21 of type dbl</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>TotalSteps</th><th scope=col>TotalDistance</th><th scope=col>TrackerDistance</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>⋯</th><th scope=col>LightlyActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedAverageIntensity</th><th scope=col>MedianHourlySteps</th><th scope=col>MedianMinCalories</th><th scope=col>AvgMinIntensity</th><th scope=col>AvgMinMet</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>Id</th><td> 1.00000000</td><td> 0.1943711631</td><td> 0.24963938</td><td> 0.24745662</td><td> 0.19336799</td><td> 0.31412866</td><td> 0.029223441</td><td> 0.02591688</td><td>-0.015240873</td><td> 0.31074899</td><td>⋯</td><td>-0.09420262</td><td>-0.04475190</td><td> 0.42502590</td><td> 0.35212391</td><td>-0.03879821</td><td>-0.03879815</td><td> 0.07119790</td><td> 0.3853881491</td><td> 0.138004580</td><td>-0.01191067</td></tr>\n",
       "\t<tr><th scope=row>TotalSteps</th><td> 0.19437116</td><td> 1.0000000000</td><td> 0.98520650</td><td> 0.98464805</td><td> 0.18307362</td><td> 0.73955440</td><td> 0.506600934</td><td> 0.68783202</td><td> 0.068202586</td><td> 0.66464981</td><td>⋯</td><td> 0.56273463</td><td>-0.33728265</td><td> 0.58607723</td><td> 0.34056789</td><td> 0.55312534</td><td> 0.55312543</td><td> 0.61227401</td><td>-0.0001388285</td><td> 0.877481446</td><td> 0.34261398</td></tr>\n",
       "\t<tr><th scope=row>TotalDistance</th><td> 0.24963938</td><td> 0.9852064999</td><td> 1.00000000</td><td> 0.99950059</td><td> 0.18989865</td><td> 0.79354843</td><td> 0.470505107</td><td> 0.65823637</td><td> 0.080051242</td><td> 0.67863301</td><td>⋯</td><td> 0.50961653</td><td>-0.29725668</td><td> 0.64346549</td><td> 0.40445934</td><td> 0.51851883</td><td> 0.51851891</td><td> 0.59904984</td><td> 0.0915843987</td><td> 0.842782598</td><td> 0.34122493</td></tr>\n",
       "\t<tr><th scope=row>TrackerDistance</th><td> 0.24745662</td><td> 0.9846480491</td><td> 0.99950059</td><td> 1.00000000</td><td> 0.16420694</td><td> 0.79329341</td><td> 0.470041698</td><td> 0.65760175</td><td> 0.072210714</td><td> 0.67815447</td><td>⋯</td><td> 0.50800025</td><td>-0.29855199</td><td> 0.64382041</td><td> 0.40430456</td><td> 0.51739310</td><td> 0.51739318</td><td> 0.59869127</td><td> 0.0924551315</td><td> 0.841523923</td><td> 0.34121226</td></tr>\n",
       "\t<tr><th scope=row>LoggedActivitiesDistance</th><td> 0.19336799</td><td> 0.1830736156</td><td> 0.18989865</td><td> 0.16420694</td><td> 1.00000000</td><td> 0.15406888</td><td> 0.075816575</td><td> 0.13655054</td><td> 0.153274687</td><td> 0.24167962</td><td>⋯</td><td> 0.09825287</td><td>-0.05058263</td><td> 0.21638083</td><td> 0.19472378</td><td> 0.14502543</td><td> 0.14502543</td><td> 0.15824480</td><td> 0.1169861983</td><td> 0.218792532</td><td> 0.11276077</td></tr>\n",
       "\t<tr><th scope=row>VeryActiveDistance</th><td> 0.31412866</td><td> 0.7395544003</td><td> 0.79354843</td><td> 0.79329341</td><td> 0.15406888</td><td> 1.00000000</td><td> 0.189551597</td><td> 0.15141767</td><td> 0.045218451</td><td> 0.82599372</td><td>⋯</td><td> 0.05235997</td><td>-0.06307100</td><td> 0.49674924</td><td> 0.22847223</td><td> 0.15584085</td><td> 0.15584093</td><td> 0.25050252</td><td> 0.1155159117</td><td> 0.572746312</td><td> 0.20625412</td></tr>\n",
       "\t<tr><th scope=row>ModeratelyActiveDistance</th><td> 0.02922344</td><td> 0.5066009336</td><td> 0.47050511</td><td> 0.47004170</td><td> 0.07581657</td><td> 0.18955160</td><td> 1.000000000</td><td> 0.23868372</td><td> 0.004054654</td><td> 0.22139542</td><td>⋯</td><td> 0.16031485</td><td>-0.22822320</td><td> 0.21515910</td><td> 0.07192191</td><td> 0.17131277</td><td> 0.17131283</td><td> 0.17826211</td><td>-0.0656491945</td><td> 0.459763076</td><td> 0.06142618</td></tr>\n",
       "\t<tr><th scope=row>LightActiveDistance</th><td> 0.02591688</td><td> 0.6878320197</td><td> 0.65823637</td><td> 0.65760175</td><td> 0.13655054</td><td> 0.15141767</td><td> 0.238683722</td><td> 1.00000000</td><td> 0.096714489</td><td> 0.14766210</td><td>⋯</td><td> 0.88367384</td><td>-0.42637280</td><td> 0.45501567</td><td> 0.45153598</td><td> 0.75329969</td><td> 0.75329970</td><td> 0.77661342</td><td> 0.0317404093</td><td> 0.714615010</td><td> 0.37442910</td></tr>\n",
       "\t<tr><th scope=row>SedentaryActiveDistance</th><td>-0.01524087</td><td> 0.0682025861</td><td> 0.08005124</td><td> 0.07221071</td><td> 0.15327469</td><td> 0.04521845</td><td> 0.004054654</td><td> 0.09671449</td><td> 1.000000000</td><td> 0.00685887</td><td>⋯</td><td> 0.12217553</td><td> 0.03652061</td><td> 0.03908309</td><td> 0.03811553</td><td> 0.08927714</td><td> 0.08927708</td><td> 0.03645231</td><td> 0.0021875204</td><td> 0.076099124</td><td>-0.01627962</td></tr>\n",
       "\t<tr><th scope=row>VeryActiveMinutes</th><td> 0.31074899</td><td> 0.6646498102</td><td> 0.67863301</td><td> 0.67815447</td><td> 0.24167962</td><td> 0.82599372</td><td> 0.221395419</td><td> 0.14766210</td><td> 0.006858870</td><td> 1.00000000</td><td>⋯</td><td> 0.04232910</td><td>-0.16859756</td><td> 0.62433862</td><td> 0.33847499</td><td> 0.19563348</td><td> 0.19563357</td><td> 0.27795814</td><td> 0.2067130494</td><td> 0.692917699</td><td> 0.30718456</td></tr>\n",
       "\t<tr><th scope=row>FairlyActiveMinutes</th><td> 0.05362383</td><td> 0.4975271543</td><td> 0.46186352</td><td> 0.46213198</td><td> 0.05262577</td><td> 0.20814995</td><td> 0.946973956</td><td> 0.21965912</td><td>-0.024000360</td><td> 0.30752414</td><td>⋯</td><td> 0.14595736</td><td>-0.24391218</td><td> 0.29638311</td><td> 0.13099599</td><td> 0.17857735</td><td> 0.17857744</td><td> 0.18618116</td><td>-0.0177562885</td><td> 0.514627147</td><td> 0.11247239</td></tr>\n",
       "\t<tr><th scope=row>LightlyActiveMinutes</th><td>-0.09420262</td><td> 0.5627346276</td><td> 0.50961653</td><td> 0.50800025</td><td> 0.09825287</td><td> 0.05235997</td><td> 0.160314846</td><td> 0.88367384</td><td> 0.122175529</td><td> 0.04232910</td><td>⋯</td><td> 1.00000000</td><td>-0.44987450</td><td> 0.26333232</td><td> 0.26998591</td><td> 0.82135802</td><td> 0.82135801</td><td> 0.70699403</td><td>-0.1830439282</td><td> 0.707638898</td><td> 0.31625017</td></tr>\n",
       "\t<tr><th scope=row>SedentaryMinutes</th><td>-0.04475190</td><td>-0.3372826500</td><td>-0.29725668</td><td>-0.29855199</td><td>-0.05058263</td><td>-0.06307100</td><td>-0.228223199</td><td>-0.42637280</td><td> 0.036520608</td><td>-0.16859756</td><td>⋯</td><td>-0.44987450</td><td> 1.00000000</td><td>-0.11832862</td><td>-0.15936298</td><td>-0.41552857</td><td>-0.41552864</td><td>-0.38922947</td><td> 0.1047560142</td><td>-0.472325089</td><td>-0.28261998</td></tr>\n",
       "\t<tr><th scope=row>Calories</th><td> 0.42502590</td><td> 0.5860772317</td><td> 0.64346549</td><td> 0.64382041</td><td> 0.21638083</td><td> 0.49674924</td><td> 0.215159104</td><td> 0.45501567</td><td> 0.039083093</td><td> 0.62433862</td><td>⋯</td><td> 0.26333232</td><td>-0.11832862</td><td> 1.00000000</td><td> 0.84459462</td><td> 0.34191662</td><td> 0.34191663</td><td> 0.44068414</td><td> 0.7210944311</td><td> 0.599656049</td><td> 0.36562526</td></tr>\n",
       "\t<tr><th scope=row>Median_Hourly_Calorie</th><td> 0.35212391</td><td> 0.3405678896</td><td> 0.40445934</td><td> 0.40430456</td><td> 0.19472378</td><td> 0.22847223</td><td> 0.071921910</td><td> 0.45153598</td><td> 0.038115530</td><td> 0.33847499</td><td>⋯</td><td> 0.26998591</td><td>-0.15936298</td><td> 0.84459462</td><td> 1.00000000</td><td> 0.49481758</td><td> 0.49481756</td><td> 0.57895026</td><td> 0.8211839867</td><td> 0.410084540</td><td> 0.42121932</td></tr>\n",
       "\t<tr><th scope=row>MedTotalIntensity</th><td>-0.03879821</td><td> 0.5531253355</td><td> 0.51851883</td><td> 0.51739310</td><td> 0.14502543</td><td> 0.15584085</td><td> 0.171312766</td><td> 0.75329969</td><td> 0.089277142</td><td> 0.19563348</td><td>⋯</td><td> 0.82135802</td><td>-0.41552857</td><td> 0.34191662</td><td> 0.49481758</td><td> 1.00000000</td><td> 1.00000000</td><td> 0.89890141</td><td>-0.0308027507</td><td> 0.697976745</td><td> 0.47950801</td></tr>\n",
       "\t<tr><th scope=row>MedAverageIntensity</th><td>-0.03879815</td><td> 0.5531254311</td><td> 0.51851891</td><td> 0.51739318</td><td> 0.14502543</td><td> 0.15584093</td><td> 0.171312829</td><td> 0.75329970</td><td> 0.089277081</td><td> 0.19563357</td><td>⋯</td><td> 0.82135801</td><td>-0.41552864</td><td> 0.34191663</td><td> 0.49481756</td><td> 1.00000000</td><td> 1.00000000</td><td> 0.89890142</td><td>-0.0308027950</td><td> 0.697976821</td><td> 0.47950797</td></tr>\n",
       "\t<tr><th scope=row>MedianHourlySteps</th><td> 0.07119790</td><td> 0.6122740085</td><td> 0.59904984</td><td> 0.59869127</td><td> 0.15824480</td><td> 0.25050252</td><td> 0.178262115</td><td> 0.77661342</td><td> 0.036452312</td><td> 0.27795814</td><td>⋯</td><td> 0.70699403</td><td>-0.38922947</td><td> 0.44068414</td><td> 0.57895026</td><td> 0.89890141</td><td> 0.89890142</td><td> 1.00000000</td><td> 0.0843603801</td><td> 0.677170071</td><td> 0.52519389</td></tr>\n",
       "\t<tr><th scope=row>MedianMinCalories</th><td> 0.38538815</td><td>-0.0001388285</td><td> 0.09158440</td><td> 0.09245513</td><td> 0.11698620</td><td> 0.11551591</td><td>-0.065649194</td><td> 0.03174041</td><td> 0.002187520</td><td> 0.20671305</td><td>⋯</td><td>-0.18304393</td><td> 0.10475601</td><td> 0.72109443</td><td> 0.82118399</td><td>-0.03080275</td><td>-0.03080279</td><td> 0.08436038</td><td> 1.0000000000</td><td>-0.001012379</td><td> 0.27313235</td></tr>\n",
       "\t<tr><th scope=row>AvgMinIntensity</th><td> 0.13800458</td><td> 0.8774814459</td><td> 0.84278260</td><td> 0.84152392</td><td> 0.21879253</td><td> 0.57274631</td><td> 0.459763076</td><td> 0.71461501</td><td> 0.076099124</td><td> 0.69291770</td><td>⋯</td><td> 0.70763890</td><td>-0.47232509</td><td> 0.59965605</td><td> 0.41008454</td><td> 0.69797674</td><td> 0.69797682</td><td> 0.67717007</td><td>-0.0010123793</td><td> 1.000000000</td><td> 0.41667528</td></tr>\n",
       "\t<tr><th scope=row>AvgMinMet</th><td>-0.01191067</td><td> 0.3426139828</td><td> 0.34122493</td><td> 0.34121226</td><td> 0.11276077</td><td> 0.20625412</td><td> 0.061426178</td><td> 0.37442910</td><td>-0.016279623</td><td> 0.30718456</td><td>⋯</td><td> 0.31625017</td><td>-0.28261998</td><td> 0.36562526</td><td> 0.42121932</td><td> 0.47950801</td><td> 0.47950797</td><td> 0.52519389</td><td> 0.2731323514</td><td> 0.416675282</td><td> 1.00000000</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 21 × 21 of type dbl\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & Id & TotalSteps & TotalDistance & TrackerDistance & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & ⋯ & LightlyActiveMinutes & SedentaryMinutes & Calories & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedAverageIntensity & MedianHourlySteps & MedianMinCalories & AvgMinIntensity & AvgMinMet\\\\\n",
       "\\hline\n",
       "\tId &  1.00000000 &  0.1943711631 &  0.24963938 &  0.24745662 &  0.19336799 &  0.31412866 &  0.029223441 &  0.02591688 & -0.015240873 &  0.31074899 & ⋯ & -0.09420262 & -0.04475190 &  0.42502590 &  0.35212391 & -0.03879821 & -0.03879815 &  0.07119790 &  0.3853881491 &  0.138004580 & -0.01191067\\\\\n",
       "\tTotalSteps &  0.19437116 &  1.0000000000 &  0.98520650 &  0.98464805 &  0.18307362 &  0.73955440 &  0.506600934 &  0.68783202 &  0.068202586 &  0.66464981 & ⋯ &  0.56273463 & -0.33728265 &  0.58607723 &  0.34056789 &  0.55312534 &  0.55312543 &  0.61227401 & -0.0001388285 &  0.877481446 &  0.34261398\\\\\n",
       "\tTotalDistance &  0.24963938 &  0.9852064999 &  1.00000000 &  0.99950059 &  0.18989865 &  0.79354843 &  0.470505107 &  0.65823637 &  0.080051242 &  0.67863301 & ⋯ &  0.50961653 & -0.29725668 &  0.64346549 &  0.40445934 &  0.51851883 &  0.51851891 &  0.59904984 &  0.0915843987 &  0.842782598 &  0.34122493\\\\\n",
       "\tTrackerDistance &  0.24745662 &  0.9846480491 &  0.99950059 &  1.00000000 &  0.16420694 &  0.79329341 &  0.470041698 &  0.65760175 &  0.072210714 &  0.67815447 & ⋯ &  0.50800025 & -0.29855199 &  0.64382041 &  0.40430456 &  0.51739310 &  0.51739318 &  0.59869127 &  0.0924551315 &  0.841523923 &  0.34121226\\\\\n",
       "\tLoggedActivitiesDistance &  0.19336799 &  0.1830736156 &  0.18989865 &  0.16420694 &  1.00000000 &  0.15406888 &  0.075816575 &  0.13655054 &  0.153274687 &  0.24167962 & ⋯ &  0.09825287 & -0.05058263 &  0.21638083 &  0.19472378 &  0.14502543 &  0.14502543 &  0.15824480 &  0.1169861983 &  0.218792532 &  0.11276077\\\\\n",
       "\tVeryActiveDistance &  0.31412866 &  0.7395544003 &  0.79354843 &  0.79329341 &  0.15406888 &  1.00000000 &  0.189551597 &  0.15141767 &  0.045218451 &  0.82599372 & ⋯ &  0.05235997 & -0.06307100 &  0.49674924 &  0.22847223 &  0.15584085 &  0.15584093 &  0.25050252 &  0.1155159117 &  0.572746312 &  0.20625412\\\\\n",
       "\tModeratelyActiveDistance &  0.02922344 &  0.5066009336 &  0.47050511 &  0.47004170 &  0.07581657 &  0.18955160 &  1.000000000 &  0.23868372 &  0.004054654 &  0.22139542 & ⋯ &  0.16031485 & -0.22822320 &  0.21515910 &  0.07192191 &  0.17131277 &  0.17131283 &  0.17826211 & -0.0656491945 &  0.459763076 &  0.06142618\\\\\n",
       "\tLightActiveDistance &  0.02591688 &  0.6878320197 &  0.65823637 &  0.65760175 &  0.13655054 &  0.15141767 &  0.238683722 &  1.00000000 &  0.096714489 &  0.14766210 & ⋯ &  0.88367384 & -0.42637280 &  0.45501567 &  0.45153598 &  0.75329969 &  0.75329970 &  0.77661342 &  0.0317404093 &  0.714615010 &  0.37442910\\\\\n",
       "\tSedentaryActiveDistance & -0.01524087 &  0.0682025861 &  0.08005124 &  0.07221071 &  0.15327469 &  0.04521845 &  0.004054654 &  0.09671449 &  1.000000000 &  0.00685887 & ⋯ &  0.12217553 &  0.03652061 &  0.03908309 &  0.03811553 &  0.08927714 &  0.08927708 &  0.03645231 &  0.0021875204 &  0.076099124 & -0.01627962\\\\\n",
       "\tVeryActiveMinutes &  0.31074899 &  0.6646498102 &  0.67863301 &  0.67815447 &  0.24167962 &  0.82599372 &  0.221395419 &  0.14766210 &  0.006858870 &  1.00000000 & ⋯ &  0.04232910 & -0.16859756 &  0.62433862 &  0.33847499 &  0.19563348 &  0.19563357 &  0.27795814 &  0.2067130494 &  0.692917699 &  0.30718456\\\\\n",
       "\tFairlyActiveMinutes &  0.05362383 &  0.4975271543 &  0.46186352 &  0.46213198 &  0.05262577 &  0.20814995 &  0.946973956 &  0.21965912 & -0.024000360 &  0.30752414 & ⋯ &  0.14595736 & -0.24391218 &  0.29638311 &  0.13099599 &  0.17857735 &  0.17857744 &  0.18618116 & -0.0177562885 &  0.514627147 &  0.11247239\\\\\n",
       "\tLightlyActiveMinutes & -0.09420262 &  0.5627346276 &  0.50961653 &  0.50800025 &  0.09825287 &  0.05235997 &  0.160314846 &  0.88367384 &  0.122175529 &  0.04232910 & ⋯ &  1.00000000 & -0.44987450 &  0.26333232 &  0.26998591 &  0.82135802 &  0.82135801 &  0.70699403 & -0.1830439282 &  0.707638898 &  0.31625017\\\\\n",
       "\tSedentaryMinutes & -0.04475190 & -0.3372826500 & -0.29725668 & -0.29855199 & -0.05058263 & -0.06307100 & -0.228223199 & -0.42637280 &  0.036520608 & -0.16859756 & ⋯ & -0.44987450 &  1.00000000 & -0.11832862 & -0.15936298 & -0.41552857 & -0.41552864 & -0.38922947 &  0.1047560142 & -0.472325089 & -0.28261998\\\\\n",
       "\tCalories &  0.42502590 &  0.5860772317 &  0.64346549 &  0.64382041 &  0.21638083 &  0.49674924 &  0.215159104 &  0.45501567 &  0.039083093 &  0.62433862 & ⋯ &  0.26333232 & -0.11832862 &  1.00000000 &  0.84459462 &  0.34191662 &  0.34191663 &  0.44068414 &  0.7210944311 &  0.599656049 &  0.36562526\\\\\n",
       "\tMedian\\_Hourly\\_Calorie &  0.35212391 &  0.3405678896 &  0.40445934 &  0.40430456 &  0.19472378 &  0.22847223 &  0.071921910 &  0.45153598 &  0.038115530 &  0.33847499 & ⋯ &  0.26998591 & -0.15936298 &  0.84459462 &  1.00000000 &  0.49481758 &  0.49481756 &  0.57895026 &  0.8211839867 &  0.410084540 &  0.42121932\\\\\n",
       "\tMedTotalIntensity & -0.03879821 &  0.5531253355 &  0.51851883 &  0.51739310 &  0.14502543 &  0.15584085 &  0.171312766 &  0.75329969 &  0.089277142 &  0.19563348 & ⋯ &  0.82135802 & -0.41552857 &  0.34191662 &  0.49481758 &  1.00000000 &  1.00000000 &  0.89890141 & -0.0308027507 &  0.697976745 &  0.47950801\\\\\n",
       "\tMedAverageIntensity & -0.03879815 &  0.5531254311 &  0.51851891 &  0.51739318 &  0.14502543 &  0.15584093 &  0.171312829 &  0.75329970 &  0.089277081 &  0.19563357 & ⋯ &  0.82135801 & -0.41552864 &  0.34191663 &  0.49481756 &  1.00000000 &  1.00000000 &  0.89890142 & -0.0308027950 &  0.697976821 &  0.47950797\\\\\n",
       "\tMedianHourlySteps &  0.07119790 &  0.6122740085 &  0.59904984 &  0.59869127 &  0.15824480 &  0.25050252 &  0.178262115 &  0.77661342 &  0.036452312 &  0.27795814 & ⋯ &  0.70699403 & -0.38922947 &  0.44068414 &  0.57895026 &  0.89890141 &  0.89890142 &  1.00000000 &  0.0843603801 &  0.677170071 &  0.52519389\\\\\n",
       "\tMedianMinCalories &  0.38538815 & -0.0001388285 &  0.09158440 &  0.09245513 &  0.11698620 &  0.11551591 & -0.065649194 &  0.03174041 &  0.002187520 &  0.20671305 & ⋯ & -0.18304393 &  0.10475601 &  0.72109443 &  0.82118399 & -0.03080275 & -0.03080279 &  0.08436038 &  1.0000000000 & -0.001012379 &  0.27313235\\\\\n",
       "\tAvgMinIntensity &  0.13800458 &  0.8774814459 &  0.84278260 &  0.84152392 &  0.21879253 &  0.57274631 &  0.459763076 &  0.71461501 &  0.076099124 &  0.69291770 & ⋯ &  0.70763890 & -0.47232509 &  0.59965605 &  0.41008454 &  0.69797674 &  0.69797682 &  0.67717007 & -0.0010123793 &  1.000000000 &  0.41667528\\\\\n",
       "\tAvgMinMet & -0.01191067 &  0.3426139828 &  0.34122493 &  0.34121226 &  0.11276077 &  0.20625412 &  0.061426178 &  0.37442910 & -0.016279623 &  0.30718456 & ⋯ &  0.31625017 & -0.28261998 &  0.36562526 &  0.42121932 &  0.47950801 &  0.47950797 &  0.52519389 &  0.2731323514 &  0.416675282 &  1.00000000\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 21 × 21 of type dbl\n",
       "\n",
       "| <!--/--> | Id | TotalSteps | TotalDistance | TrackerDistance | LoggedActivitiesDistance | VeryActiveDistance | ModeratelyActiveDistance | LightActiveDistance | SedentaryActiveDistance | VeryActiveMinutes | ⋯ | LightlyActiveMinutes | SedentaryMinutes | Calories | Median_Hourly_Calorie | MedTotalIntensity | MedAverageIntensity | MedianHourlySteps | MedianMinCalories | AvgMinIntensity | AvgMinMet |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| Id |  1.00000000 |  0.1943711631 |  0.24963938 |  0.24745662 |  0.19336799 |  0.31412866 |  0.029223441 |  0.02591688 | -0.015240873 |  0.31074899 | ⋯ | -0.09420262 | -0.04475190 |  0.42502590 |  0.35212391 | -0.03879821 | -0.03879815 |  0.07119790 |  0.3853881491 |  0.138004580 | -0.01191067 |\n",
       "| TotalSteps |  0.19437116 |  1.0000000000 |  0.98520650 |  0.98464805 |  0.18307362 |  0.73955440 |  0.506600934 |  0.68783202 |  0.068202586 |  0.66464981 | ⋯ |  0.56273463 | -0.33728265 |  0.58607723 |  0.34056789 |  0.55312534 |  0.55312543 |  0.61227401 | -0.0001388285 |  0.877481446 |  0.34261398 |\n",
       "| TotalDistance |  0.24963938 |  0.9852064999 |  1.00000000 |  0.99950059 |  0.18989865 |  0.79354843 |  0.470505107 |  0.65823637 |  0.080051242 |  0.67863301 | ⋯ |  0.50961653 | -0.29725668 |  0.64346549 |  0.40445934 |  0.51851883 |  0.51851891 |  0.59904984 |  0.0915843987 |  0.842782598 |  0.34122493 |\n",
       "| TrackerDistance |  0.24745662 |  0.9846480491 |  0.99950059 |  1.00000000 |  0.16420694 |  0.79329341 |  0.470041698 |  0.65760175 |  0.072210714 |  0.67815447 | ⋯ |  0.50800025 | -0.29855199 |  0.64382041 |  0.40430456 |  0.51739310 |  0.51739318 |  0.59869127 |  0.0924551315 |  0.841523923 |  0.34121226 |\n",
       "| LoggedActivitiesDistance |  0.19336799 |  0.1830736156 |  0.18989865 |  0.16420694 |  1.00000000 |  0.15406888 |  0.075816575 |  0.13655054 |  0.153274687 |  0.24167962 | ⋯ |  0.09825287 | -0.05058263 |  0.21638083 |  0.19472378 |  0.14502543 |  0.14502543 |  0.15824480 |  0.1169861983 |  0.218792532 |  0.11276077 |\n",
       "| VeryActiveDistance |  0.31412866 |  0.7395544003 |  0.79354843 |  0.79329341 |  0.15406888 |  1.00000000 |  0.189551597 |  0.15141767 |  0.045218451 |  0.82599372 | ⋯ |  0.05235997 | -0.06307100 |  0.49674924 |  0.22847223 |  0.15584085 |  0.15584093 |  0.25050252 |  0.1155159117 |  0.572746312 |  0.20625412 |\n",
       "| ModeratelyActiveDistance |  0.02922344 |  0.5066009336 |  0.47050511 |  0.47004170 |  0.07581657 |  0.18955160 |  1.000000000 |  0.23868372 |  0.004054654 |  0.22139542 | ⋯ |  0.16031485 | -0.22822320 |  0.21515910 |  0.07192191 |  0.17131277 |  0.17131283 |  0.17826211 | -0.0656491945 |  0.459763076 |  0.06142618 |\n",
       "| LightActiveDistance |  0.02591688 |  0.6878320197 |  0.65823637 |  0.65760175 |  0.13655054 |  0.15141767 |  0.238683722 |  1.00000000 |  0.096714489 |  0.14766210 | ⋯ |  0.88367384 | -0.42637280 |  0.45501567 |  0.45153598 |  0.75329969 |  0.75329970 |  0.77661342 |  0.0317404093 |  0.714615010 |  0.37442910 |\n",
       "| SedentaryActiveDistance | -0.01524087 |  0.0682025861 |  0.08005124 |  0.07221071 |  0.15327469 |  0.04521845 |  0.004054654 |  0.09671449 |  1.000000000 |  0.00685887 | ⋯ |  0.12217553 |  0.03652061 |  0.03908309 |  0.03811553 |  0.08927714 |  0.08927708 |  0.03645231 |  0.0021875204 |  0.076099124 | -0.01627962 |\n",
       "| VeryActiveMinutes |  0.31074899 |  0.6646498102 |  0.67863301 |  0.67815447 |  0.24167962 |  0.82599372 |  0.221395419 |  0.14766210 |  0.006858870 |  1.00000000 | ⋯ |  0.04232910 | -0.16859756 |  0.62433862 |  0.33847499 |  0.19563348 |  0.19563357 |  0.27795814 |  0.2067130494 |  0.692917699 |  0.30718456 |\n",
       "| FairlyActiveMinutes |  0.05362383 |  0.4975271543 |  0.46186352 |  0.46213198 |  0.05262577 |  0.20814995 |  0.946973956 |  0.21965912 | -0.024000360 |  0.30752414 | ⋯ |  0.14595736 | -0.24391218 |  0.29638311 |  0.13099599 |  0.17857735 |  0.17857744 |  0.18618116 | -0.0177562885 |  0.514627147 |  0.11247239 |\n",
       "| LightlyActiveMinutes | -0.09420262 |  0.5627346276 |  0.50961653 |  0.50800025 |  0.09825287 |  0.05235997 |  0.160314846 |  0.88367384 |  0.122175529 |  0.04232910 | ⋯ |  1.00000000 | -0.44987450 |  0.26333232 |  0.26998591 |  0.82135802 |  0.82135801 |  0.70699403 | -0.1830439282 |  0.707638898 |  0.31625017 |\n",
       "| SedentaryMinutes | -0.04475190 | -0.3372826500 | -0.29725668 | -0.29855199 | -0.05058263 | -0.06307100 | -0.228223199 | -0.42637280 |  0.036520608 | -0.16859756 | ⋯ | -0.44987450 |  1.00000000 | -0.11832862 | -0.15936298 | -0.41552857 | -0.41552864 | -0.38922947 |  0.1047560142 | -0.472325089 | -0.28261998 |\n",
       "| Calories |  0.42502590 |  0.5860772317 |  0.64346549 |  0.64382041 |  0.21638083 |  0.49674924 |  0.215159104 |  0.45501567 |  0.039083093 |  0.62433862 | ⋯ |  0.26333232 | -0.11832862 |  1.00000000 |  0.84459462 |  0.34191662 |  0.34191663 |  0.44068414 |  0.7210944311 |  0.599656049 |  0.36562526 |\n",
       "| Median_Hourly_Calorie |  0.35212391 |  0.3405678896 |  0.40445934 |  0.40430456 |  0.19472378 |  0.22847223 |  0.071921910 |  0.45153598 |  0.038115530 |  0.33847499 | ⋯ |  0.26998591 | -0.15936298 |  0.84459462 |  1.00000000 |  0.49481758 |  0.49481756 |  0.57895026 |  0.8211839867 |  0.410084540 |  0.42121932 |\n",
       "| MedTotalIntensity | -0.03879821 |  0.5531253355 |  0.51851883 |  0.51739310 |  0.14502543 |  0.15584085 |  0.171312766 |  0.75329969 |  0.089277142 |  0.19563348 | ⋯ |  0.82135802 | -0.41552857 |  0.34191662 |  0.49481758 |  1.00000000 |  1.00000000 |  0.89890141 | -0.0308027507 |  0.697976745 |  0.47950801 |\n",
       "| MedAverageIntensity | -0.03879815 |  0.5531254311 |  0.51851891 |  0.51739318 |  0.14502543 |  0.15584093 |  0.171312829 |  0.75329970 |  0.089277081 |  0.19563357 | ⋯ |  0.82135801 | -0.41552864 |  0.34191663 |  0.49481756 |  1.00000000 |  1.00000000 |  0.89890142 | -0.0308027950 |  0.697976821 |  0.47950797 |\n",
       "| MedianHourlySteps |  0.07119790 |  0.6122740085 |  0.59904984 |  0.59869127 |  0.15824480 |  0.25050252 |  0.178262115 |  0.77661342 |  0.036452312 |  0.27795814 | ⋯ |  0.70699403 | -0.38922947 |  0.44068414 |  0.57895026 |  0.89890141 |  0.89890142 |  1.00000000 |  0.0843603801 |  0.677170071 |  0.52519389 |\n",
       "| MedianMinCalories |  0.38538815 | -0.0001388285 |  0.09158440 |  0.09245513 |  0.11698620 |  0.11551591 | -0.065649194 |  0.03174041 |  0.002187520 |  0.20671305 | ⋯ | -0.18304393 |  0.10475601 |  0.72109443 |  0.82118399 | -0.03080275 | -0.03080279 |  0.08436038 |  1.0000000000 | -0.001012379 |  0.27313235 |\n",
       "| AvgMinIntensity |  0.13800458 |  0.8774814459 |  0.84278260 |  0.84152392 |  0.21879253 |  0.57274631 |  0.459763076 |  0.71461501 |  0.076099124 |  0.69291770 | ⋯ |  0.70763890 | -0.47232509 |  0.59965605 |  0.41008454 |  0.69797674 |  0.69797682 |  0.67717007 | -0.0010123793 |  1.000000000 |  0.41667528 |\n",
       "| AvgMinMet | -0.01191067 |  0.3426139828 |  0.34122493 |  0.34121226 |  0.11276077 |  0.20625412 |  0.061426178 |  0.37442910 | -0.016279623 |  0.30718456 | ⋯ |  0.31625017 | -0.28261998 |  0.36562526 |  0.42121932 |  0.47950801 |  0.47950797 |  0.52519389 |  0.2731323514 |  0.416675282 |  1.00000000 |\n",
       "\n"
      ],
      "text/plain": [
       "                         Id          TotalSteps    TotalDistance\n",
       "Id                        1.00000000  0.1943711631  0.24963938  \n",
       "TotalSteps                0.19437116  1.0000000000  0.98520650  \n",
       "TotalDistance             0.24963938  0.9852064999  1.00000000  \n",
       "TrackerDistance           0.24745662  0.9846480491  0.99950059  \n",
       "LoggedActivitiesDistance  0.19336799  0.1830736156  0.18989865  \n",
       "VeryActiveDistance        0.31412866  0.7395544003  0.79354843  \n",
       "ModeratelyActiveDistance  0.02922344  0.5066009336  0.47050511  \n",
       "LightActiveDistance       0.02591688  0.6878320197  0.65823637  \n",
       "SedentaryActiveDistance  -0.01524087  0.0682025861  0.08005124  \n",
       "VeryActiveMinutes         0.31074899  0.6646498102  0.67863301  \n",
       "FairlyActiveMinutes       0.05362383  0.4975271543  0.46186352  \n",
       "LightlyActiveMinutes     -0.09420262  0.5627346276  0.50961653  \n",
       "SedentaryMinutes         -0.04475190 -0.3372826500 -0.29725668  \n",
       "Calories                  0.42502590  0.5860772317  0.64346549  \n",
       "Median_Hourly_Calorie     0.35212391  0.3405678896  0.40445934  \n",
       "MedTotalIntensity        -0.03879821  0.5531253355  0.51851883  \n",
       "MedAverageIntensity      -0.03879815  0.5531254311  0.51851891  \n",
       "MedianHourlySteps         0.07119790  0.6122740085  0.59904984  \n",
       "MedianMinCalories         0.38538815 -0.0001388285  0.09158440  \n",
       "AvgMinIntensity           0.13800458  0.8774814459  0.84278260  \n",
       "AvgMinMet                -0.01191067  0.3426139828  0.34122493  \n",
       "                         TrackerDistance LoggedActivitiesDistance\n",
       "Id                        0.24745662      0.19336799             \n",
       "TotalSteps                0.98464805      0.18307362             \n",
       "TotalDistance             0.99950059      0.18989865             \n",
       "TrackerDistance           1.00000000      0.16420694             \n",
       "LoggedActivitiesDistance  0.16420694      1.00000000             \n",
       "VeryActiveDistance        0.79329341      0.15406888             \n",
       "ModeratelyActiveDistance  0.47004170      0.07581657             \n",
       "LightActiveDistance       0.65760175      0.13655054             \n",
       "SedentaryActiveDistance   0.07221071      0.15327469             \n",
       "VeryActiveMinutes         0.67815447      0.24167962             \n",
       "FairlyActiveMinutes       0.46213198      0.05262577             \n",
       "LightlyActiveMinutes      0.50800025      0.09825287             \n",
       "SedentaryMinutes         -0.29855199     -0.05058263             \n",
       "Calories                  0.64382041      0.21638083             \n",
       "Median_Hourly_Calorie     0.40430456      0.19472378             \n",
       "MedTotalIntensity         0.51739310      0.14502543             \n",
       "MedAverageIntensity       0.51739318      0.14502543             \n",
       "MedianHourlySteps         0.59869127      0.15824480             \n",
       "MedianMinCalories         0.09245513      0.11698620             \n",
       "AvgMinIntensity           0.84152392      0.21879253             \n",
       "AvgMinMet                 0.34121226      0.11276077             \n",
       "                         VeryActiveDistance ModeratelyActiveDistance\n",
       "Id                        0.31412866         0.029223441            \n",
       "TotalSteps                0.73955440         0.506600934            \n",
       "TotalDistance             0.79354843         0.470505107            \n",
       "TrackerDistance           0.79329341         0.470041698            \n",
       "LoggedActivitiesDistance  0.15406888         0.075816575            \n",
       "VeryActiveDistance        1.00000000         0.189551597            \n",
       "ModeratelyActiveDistance  0.18955160         1.000000000            \n",
       "LightActiveDistance       0.15141767         0.238683722            \n",
       "SedentaryActiveDistance   0.04521845         0.004054654            \n",
       "VeryActiveMinutes         0.82599372         0.221395419            \n",
       "FairlyActiveMinutes       0.20814995         0.946973956            \n",
       "LightlyActiveMinutes      0.05235997         0.160314846            \n",
       "SedentaryMinutes         -0.06307100        -0.228223199            \n",
       "Calories                  0.49674924         0.215159104            \n",
       "Median_Hourly_Calorie     0.22847223         0.071921910            \n",
       "MedTotalIntensity         0.15584085         0.171312766            \n",
       "MedAverageIntensity       0.15584093         0.171312829            \n",
       "MedianHourlySteps         0.25050252         0.178262115            \n",
       "MedianMinCalories         0.11551591        -0.065649194            \n",
       "AvgMinIntensity           0.57274631         0.459763076            \n",
       "AvgMinMet                 0.20625412         0.061426178            \n",
       "                         LightActiveDistance SedentaryActiveDistance\n",
       "Id                        0.02591688         -0.015240873           \n",
       "TotalSteps                0.68783202          0.068202586           \n",
       "TotalDistance             0.65823637          0.080051242           \n",
       "TrackerDistance           0.65760175          0.072210714           \n",
       "LoggedActivitiesDistance  0.13655054          0.153274687           \n",
       "VeryActiveDistance        0.15141767          0.045218451           \n",
       "ModeratelyActiveDistance  0.23868372          0.004054654           \n",
       "LightActiveDistance       1.00000000          0.096714489           \n",
       "SedentaryActiveDistance   0.09671449          1.000000000           \n",
       "VeryActiveMinutes         0.14766210          0.006858870           \n",
       "FairlyActiveMinutes       0.21965912         -0.024000360           \n",
       "LightlyActiveMinutes      0.88367384          0.122175529           \n",
       "SedentaryMinutes         -0.42637280          0.036520608           \n",
       "Calories                  0.45501567          0.039083093           \n",
       "Median_Hourly_Calorie     0.45153598          0.038115530           \n",
       "MedTotalIntensity         0.75329969          0.089277142           \n",
       "MedAverageIntensity       0.75329970          0.089277081           \n",
       "MedianHourlySteps         0.77661342          0.036452312           \n",
       "MedianMinCalories         0.03174041          0.002187520           \n",
       "AvgMinIntensity           0.71461501          0.076099124           \n",
       "AvgMinMet                 0.37442910         -0.016279623           \n",
       "                         VeryActiveMinutes ⋯ LightlyActiveMinutes\n",
       "Id                        0.31074899       ⋯ -0.09420262         \n",
       "TotalSteps                0.66464981       ⋯  0.56273463         \n",
       "TotalDistance             0.67863301       ⋯  0.50961653         \n",
       "TrackerDistance           0.67815447       ⋯  0.50800025         \n",
       "LoggedActivitiesDistance  0.24167962       ⋯  0.09825287         \n",
       "VeryActiveDistance        0.82599372       ⋯  0.05235997         \n",
       "ModeratelyActiveDistance  0.22139542       ⋯  0.16031485         \n",
       "LightActiveDistance       0.14766210       ⋯  0.88367384         \n",
       "SedentaryActiveDistance   0.00685887       ⋯  0.12217553         \n",
       "VeryActiveMinutes         1.00000000       ⋯  0.04232910         \n",
       "FairlyActiveMinutes       0.30752414       ⋯  0.14595736         \n",
       "LightlyActiveMinutes      0.04232910       ⋯  1.00000000         \n",
       "SedentaryMinutes         -0.16859756       ⋯ -0.44987450         \n",
       "Calories                  0.62433862       ⋯  0.26333232         \n",
       "Median_Hourly_Calorie     0.33847499       ⋯  0.26998591         \n",
       "MedTotalIntensity         0.19563348       ⋯  0.82135802         \n",
       "MedAverageIntensity       0.19563357       ⋯  0.82135801         \n",
       "MedianHourlySteps         0.27795814       ⋯  0.70699403         \n",
       "MedianMinCalories         0.20671305       ⋯ -0.18304393         \n",
       "AvgMinIntensity           0.69291770       ⋯  0.70763890         \n",
       "AvgMinMet                 0.30718456       ⋯  0.31625017         \n",
       "                         SedentaryMinutes Calories    Median_Hourly_Calorie\n",
       "Id                       -0.04475190       0.42502590  0.35212391          \n",
       "TotalSteps               -0.33728265       0.58607723  0.34056789          \n",
       "TotalDistance            -0.29725668       0.64346549  0.40445934          \n",
       "TrackerDistance          -0.29855199       0.64382041  0.40430456          \n",
       "LoggedActivitiesDistance -0.05058263       0.21638083  0.19472378          \n",
       "VeryActiveDistance       -0.06307100       0.49674924  0.22847223          \n",
       "ModeratelyActiveDistance -0.22822320       0.21515910  0.07192191          \n",
       "LightActiveDistance      -0.42637280       0.45501567  0.45153598          \n",
       "SedentaryActiveDistance   0.03652061       0.03908309  0.03811553          \n",
       "VeryActiveMinutes        -0.16859756       0.62433862  0.33847499          \n",
       "FairlyActiveMinutes      -0.24391218       0.29638311  0.13099599          \n",
       "LightlyActiveMinutes     -0.44987450       0.26333232  0.26998591          \n",
       "SedentaryMinutes          1.00000000      -0.11832862 -0.15936298          \n",
       "Calories                 -0.11832862       1.00000000  0.84459462          \n",
       "Median_Hourly_Calorie    -0.15936298       0.84459462  1.00000000          \n",
       "MedTotalIntensity        -0.41552857       0.34191662  0.49481758          \n",
       "MedAverageIntensity      -0.41552864       0.34191663  0.49481756          \n",
       "MedianHourlySteps        -0.38922947       0.44068414  0.57895026          \n",
       "MedianMinCalories         0.10475601       0.72109443  0.82118399          \n",
       "AvgMinIntensity          -0.47232509       0.59965605  0.41008454          \n",
       "AvgMinMet                -0.28261998       0.36562526  0.42121932          \n",
       "                         MedTotalIntensity MedAverageIntensity\n",
       "Id                       -0.03879821       -0.03879815        \n",
       "TotalSteps                0.55312534        0.55312543        \n",
       "TotalDistance             0.51851883        0.51851891        \n",
       "TrackerDistance           0.51739310        0.51739318        \n",
       "LoggedActivitiesDistance  0.14502543        0.14502543        \n",
       "VeryActiveDistance        0.15584085        0.15584093        \n",
       "ModeratelyActiveDistance  0.17131277        0.17131283        \n",
       "LightActiveDistance       0.75329969        0.75329970        \n",
       "SedentaryActiveDistance   0.08927714        0.08927708        \n",
       "VeryActiveMinutes         0.19563348        0.19563357        \n",
       "FairlyActiveMinutes       0.17857735        0.17857744        \n",
       "LightlyActiveMinutes      0.82135802        0.82135801        \n",
       "SedentaryMinutes         -0.41552857       -0.41552864        \n",
       "Calories                  0.34191662        0.34191663        \n",
       "Median_Hourly_Calorie     0.49481758        0.49481756        \n",
       "MedTotalIntensity         1.00000000        1.00000000        \n",
       "MedAverageIntensity       1.00000000        1.00000000        \n",
       "MedianHourlySteps         0.89890141        0.89890142        \n",
       "MedianMinCalories        -0.03080275       -0.03080279        \n",
       "AvgMinIntensity           0.69797674        0.69797682        \n",
       "AvgMinMet                 0.47950801        0.47950797        \n",
       "                         MedianHourlySteps MedianMinCalories AvgMinIntensity\n",
       "Id                        0.07119790        0.3853881491      0.138004580   \n",
       "TotalSteps                0.61227401       -0.0001388285      0.877481446   \n",
       "TotalDistance             0.59904984        0.0915843987      0.842782598   \n",
       "TrackerDistance           0.59869127        0.0924551315      0.841523923   \n",
       "LoggedActivitiesDistance  0.15824480        0.1169861983      0.218792532   \n",
       "VeryActiveDistance        0.25050252        0.1155159117      0.572746312   \n",
       "ModeratelyActiveDistance  0.17826211       -0.0656491945      0.459763076   \n",
       "LightActiveDistance       0.77661342        0.0317404093      0.714615010   \n",
       "SedentaryActiveDistance   0.03645231        0.0021875204      0.076099124   \n",
       "VeryActiveMinutes         0.27795814        0.2067130494      0.692917699   \n",
       "FairlyActiveMinutes       0.18618116       -0.0177562885      0.514627147   \n",
       "LightlyActiveMinutes      0.70699403       -0.1830439282      0.707638898   \n",
       "SedentaryMinutes         -0.38922947        0.1047560142     -0.472325089   \n",
       "Calories                  0.44068414        0.7210944311      0.599656049   \n",
       "Median_Hourly_Calorie     0.57895026        0.8211839867      0.410084540   \n",
       "MedTotalIntensity         0.89890141       -0.0308027507      0.697976745   \n",
       "MedAverageIntensity       0.89890142       -0.0308027950      0.697976821   \n",
       "MedianHourlySteps         1.00000000        0.0843603801      0.677170071   \n",
       "MedianMinCalories         0.08436038        1.0000000000     -0.001012379   \n",
       "AvgMinIntensity           0.67717007       -0.0010123793      1.000000000   \n",
       "AvgMinMet                 0.52519389        0.2731323514      0.416675282   \n",
       "                         AvgMinMet  \n",
       "Id                       -0.01191067\n",
       "TotalSteps                0.34261398\n",
       "TotalDistance             0.34122493\n",
       "TrackerDistance           0.34121226\n",
       "LoggedActivitiesDistance  0.11276077\n",
       "VeryActiveDistance        0.20625412\n",
       "ModeratelyActiveDistance  0.06142618\n",
       "LightActiveDistance       0.37442910\n",
       "SedentaryActiveDistance  -0.01627962\n",
       "VeryActiveMinutes         0.30718456\n",
       "FairlyActiveMinutes       0.11247239\n",
       "LightlyActiveMinutes      0.31625017\n",
       "SedentaryMinutes         -0.28261998\n",
       "Calories                  0.36562526\n",
       "Median_Hourly_Calorie     0.42121932\n",
       "MedTotalIntensity         0.47950801\n",
       "MedAverageIntensity       0.47950797\n",
       "MedianHourlySteps         0.52519389\n",
       "MedianMinCalories         0.27313235\n",
       "AvgMinIntensity           0.41667528\n",
       "AvgMinMet                 1.00000000"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "corr_matrix <- cor(non_nulls)\n",
    "corr_matrix"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 80,
   "id": "45f55eb9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:03.420034Z",
     "iopub.status.busy": "2023-07-13T02:42:03.418747Z",
     "iopub.status.idle": "2023-07-13T02:42:03.567389Z",
     "shell.execute_reply": "2023-07-13T02:42:03.565561Z"
    },
    "papermill": {
     "duration": 0.191006,
     "end_time": "2023-07-13T02:42:03.569985",
     "exception": false,
     "start_time": "2023-07-13T02:42:03.378979",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message in plot.window(...):\n",
      "“\"dendogram\" is not a graphical parameter”\n",
      "Warning message in plot.xy(xy, type, ...):\n",
      "“\"dendogram\" is not a graphical parameter”\n",
      "Warning message in title(...):\n",
      "“\"dendogram\" is not a graphical parameter”\n"
     ]
    },
    {
     "data": {
      "image/png": "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\nRK5CYII="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "#Heatmap.2 is a package in gplots\n",
    "par(mar = c(5, 6, 4, 4) + 0.1, pin = c(8, 6))\n",
    "heatmap.2(corr_matrix,\n",
    "         dendogram = \"none\",\n",
    "         trace = \"none\",\n",
    "         col = colorRampPalette(c(\"blue\", \"white\", \"red\")),\n",
    "         main = \"Correlation Heatmap\",\n",
    "         notecol = \"black\",\n",
    "         density.info = \"none\",\n",
    "         cexRow = 0.75,\n",
    "         cexCol = 0.75,\n",
    "          \n",
    "          \n",
    "         )"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "eafffc3b",
   "metadata": {
    "papermill": {
     "duration": 0.037805,
     "end_time": "2023-07-13T02:42:03.645620",
     "exception": false,
     "start_time": "2023-07-13T02:42:03.607815",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**We can see that some columns are highly correlated. From the highly correlated columns, keeping the threshold of correlation as 0.85, we are going to keep only the columns that are not highly correlated into consideration**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 81,
   "id": "081cd5e8",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:03.724544Z",
     "iopub.status.busy": "2023-07-13T02:42:03.723326Z",
     "iopub.status.idle": "2023-07-13T02:42:03.760736Z",
     "shell.execute_reply": "2023-07-13T02:42:03.759267Z"
    },
    "papermill": {
     "duration": 0.079316,
     "end_time": "2023-07-13T02:42:03.762611",
     "exception": false,
     "start_time": "2023-07-13T02:42:03.683295",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 14</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>TotalSteps</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedianMinCalories</th><th scope=col>AvgMinMet</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>13162</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>25</td><td> 728</td><td>1985</td><td>76.0</td><td>13.0</td><td>0.9438</td><td>12</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>10735</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>21</td><td> 776</td><td>1797</td><td>71.5</td><td>11.5</td><td>0.7865</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>10460</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>30</td><td>1218</td><td>1776</td><td>62.5</td><td> 6.0</td><td>0.9438</td><td>12</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td> 9762</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>29</td><td> 726</td><td>1745</td><td>59.5</td><td> 6.5</td><td>0.7865</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>12669</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>36</td><td> 773</td><td>1863</td><td>63.5</td><td> 9.5</td><td>0.7865</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td> 9705</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>38</td><td> 539</td><td>1728</td><td>53.5</td><td> 1.5</td><td>0.7865</td><td>10</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 14\n",
       "\\begin{tabular}{r|llllllllllllll}\n",
       "  & Id & TotalSteps & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & SedentaryMinutes & Calories & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedianMinCalories & AvgMinMet\\\\\n",
       "  & <dbl> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 13162 & 0 & 1.88 & 0.55 & 6.06 & 0 & 25 &  728 & 1985 & 76.0 & 13.0 & 0.9438 & 12\\\\\n",
       "\t2 & 1503960366 & 10735 & 0 & 1.57 & 0.69 & 4.71 & 0 & 21 &  776 & 1797 & 71.5 & 11.5 & 0.7865 & 10\\\\\n",
       "\t3 & 1503960366 & 10460 & 0 & 2.44 & 0.40 & 3.91 & 0 & 30 & 1218 & 1776 & 62.5 &  6.0 & 0.9438 & 12\\\\\n",
       "\t4 & 1503960366 &  9762 & 0 & 2.14 & 1.26 & 2.83 & 0 & 29 &  726 & 1745 & 59.5 &  6.5 & 0.7865 & 10\\\\\n",
       "\t5 & 1503960366 & 12669 & 0 & 2.71 & 0.41 & 5.04 & 0 & 36 &  773 & 1863 & 63.5 &  9.5 & 0.7865 & 10\\\\\n",
       "\t6 & 1503960366 &  9705 & 0 & 3.19 & 0.78 & 2.51 & 0 & 38 &  539 & 1728 & 53.5 &  1.5 & 0.7865 & 10\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 14\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | TotalSteps &lt;int&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | VeryActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | Median_Hourly_Calorie &lt;dbl&gt; | MedTotalIntensity &lt;dbl&gt; | MedianMinCalories &lt;dbl&gt; | AvgMinMet &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 13162 | 0 | 1.88 | 0.55 | 6.06 | 0 | 25 |  728 | 1985 | 76.0 | 13.0 | 0.9438 | 12 |\n",
       "| 2 | 1503960366 | 10735 | 0 | 1.57 | 0.69 | 4.71 | 0 | 21 |  776 | 1797 | 71.5 | 11.5 | 0.7865 | 10 |\n",
       "| 3 | 1503960366 | 10460 | 0 | 2.44 | 0.40 | 3.91 | 0 | 30 | 1218 | 1776 | 62.5 |  6.0 | 0.9438 | 12 |\n",
       "| 4 | 1503960366 |  9762 | 0 | 2.14 | 1.26 | 2.83 | 0 | 29 |  726 | 1745 | 59.5 |  6.5 | 0.7865 | 10 |\n",
       "| 5 | 1503960366 | 12669 | 0 | 2.71 | 0.41 | 5.04 | 0 | 36 |  773 | 1863 | 63.5 |  9.5 | 0.7865 | 10 |\n",
       "| 6 | 1503960366 |  9705 | 0 | 3.19 | 0.78 | 2.51 | 0 | 38 |  539 | 1728 | 53.5 |  1.5 | 0.7865 | 10 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         TotalSteps LoggedActivitiesDistance VeryActiveDistance\n",
       "1 1503960366 13162      0                        1.88              \n",
       "2 1503960366 10735      0                        1.57              \n",
       "3 1503960366 10460      0                        2.44              \n",
       "4 1503960366  9762      0                        2.14              \n",
       "5 1503960366 12669      0                        2.71              \n",
       "6 1503960366  9705      0                        3.19              \n",
       "  ModeratelyActiveDistance LightActiveDistance SedentaryActiveDistance\n",
       "1 0.55                     6.06                0                      \n",
       "2 0.69                     4.71                0                      \n",
       "3 0.40                     3.91                0                      \n",
       "4 1.26                     2.83                0                      \n",
       "5 0.41                     5.04                0                      \n",
       "6 0.78                     2.51                0                      \n",
       "  VeryActiveMinutes SedentaryMinutes Calories Median_Hourly_Calorie\n",
       "1 25                 728             1985     76.0                 \n",
       "2 21                 776             1797     71.5                 \n",
       "3 30                1218             1776     62.5                 \n",
       "4 29                 726             1745     59.5                 \n",
       "5 36                 773             1863     63.5                 \n",
       "6 38                 539             1728     53.5                 \n",
       "  MedTotalIntensity MedianMinCalories AvgMinMet\n",
       "1 13.0              0.9438            12       \n",
       "2 11.5              0.7865            10       \n",
       "3  6.0              0.9438            12       \n",
       "4  6.5              0.7865            10       \n",
       "5  9.5              0.7865            10       \n",
       "6  1.5              0.7865            10       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "corr_threshold <- 0.85\n",
    "highly_correlated <- which(corr_matrix>corr_threshold & corr_matrix<=1, arr.ind = TRUE)\n",
    "#Find the groups of highly correlated columns\n",
    "groups <- split(highly_correlated[,1], highly_correlated[,2])\n",
    "##Select the first column from each group to keep\n",
    "columns_to_keep <- names(sapply(groups, function(x)x[1]))\n",
    "columns_to_keep <- unlist(strsplit(columns_to_keep, \"\\\\s+\"))\n",
    "columns_to_keep <- unique(gsub(\"\\\\d+\\\\.\",\"\", columns_to_keep))\n",
    "final_non_nulls <- non_nulls[,columns_to_keep]\n",
    "head(final_non_nulls)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 82,
   "id": "fd57bcf6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:03.842738Z",
     "iopub.status.busy": "2023-07-13T02:42:03.841403Z",
     "iopub.status.idle": "2023-07-13T02:42:03.870882Z",
     "shell.execute_reply": "2023-07-13T02:42:03.869437Z"
    },
    "papermill": {
     "duration": 0.072304,
     "end_time": "2023-07-13T02:42:03.872940",
     "exception": false,
     "start_time": "2023-07-13T02:42:03.800636",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 14 × 14 of type dbl</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>TotalSteps</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedianMinCalories</th><th scope=col>AvgMinMet</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>Id</th><td> 1.00000000</td><td> 0.1943711631</td><td> 0.19336799</td><td> 0.31412866</td><td> 0.029223441</td><td> 0.02591688</td><td>-0.015240873</td><td> 0.31074899</td><td>-0.04475190</td><td> 0.42502590</td><td> 0.35212391</td><td>-0.03879821</td><td> 0.3853881491</td><td>-0.01191067</td></tr>\n",
       "\t<tr><th scope=row>TotalSteps</th><td> 0.19437116</td><td> 1.0000000000</td><td> 0.18307362</td><td> 0.73955440</td><td> 0.506600934</td><td> 0.68783202</td><td> 0.068202586</td><td> 0.66464981</td><td>-0.33728265</td><td> 0.58607723</td><td> 0.34056789</td><td> 0.55312534</td><td>-0.0001388285</td><td> 0.34261398</td></tr>\n",
       "\t<tr><th scope=row>LoggedActivitiesDistance</th><td> 0.19336799</td><td> 0.1830736156</td><td> 1.00000000</td><td> 0.15406888</td><td> 0.075816575</td><td> 0.13655054</td><td> 0.153274687</td><td> 0.24167962</td><td>-0.05058263</td><td> 0.21638083</td><td> 0.19472378</td><td> 0.14502543</td><td> 0.1169861983</td><td> 0.11276077</td></tr>\n",
       "\t<tr><th scope=row>VeryActiveDistance</th><td> 0.31412866</td><td> 0.7395544003</td><td> 0.15406888</td><td> 1.00000000</td><td> 0.189551597</td><td> 0.15141767</td><td> 0.045218451</td><td> 0.82599372</td><td>-0.06307100</td><td> 0.49674924</td><td> 0.22847223</td><td> 0.15584085</td><td> 0.1155159117</td><td> 0.20625412</td></tr>\n",
       "\t<tr><th scope=row>ModeratelyActiveDistance</th><td> 0.02922344</td><td> 0.5066009336</td><td> 0.07581657</td><td> 0.18955160</td><td> 1.000000000</td><td> 0.23868372</td><td> 0.004054654</td><td> 0.22139542</td><td>-0.22822320</td><td> 0.21515910</td><td> 0.07192191</td><td> 0.17131277</td><td>-0.0656491945</td><td> 0.06142618</td></tr>\n",
       "\t<tr><th scope=row>LightActiveDistance</th><td> 0.02591688</td><td> 0.6878320197</td><td> 0.13655054</td><td> 0.15141767</td><td> 0.238683722</td><td> 1.00000000</td><td> 0.096714489</td><td> 0.14766210</td><td>-0.42637280</td><td> 0.45501567</td><td> 0.45153598</td><td> 0.75329969</td><td> 0.0317404093</td><td> 0.37442910</td></tr>\n",
       "\t<tr><th scope=row>SedentaryActiveDistance</th><td>-0.01524087</td><td> 0.0682025861</td><td> 0.15327469</td><td> 0.04521845</td><td> 0.004054654</td><td> 0.09671449</td><td> 1.000000000</td><td> 0.00685887</td><td> 0.03652061</td><td> 0.03908309</td><td> 0.03811553</td><td> 0.08927714</td><td> 0.0021875204</td><td>-0.01627962</td></tr>\n",
       "\t<tr><th scope=row>VeryActiveMinutes</th><td> 0.31074899</td><td> 0.6646498102</td><td> 0.24167962</td><td> 0.82599372</td><td> 0.221395419</td><td> 0.14766210</td><td> 0.006858870</td><td> 1.00000000</td><td>-0.16859756</td><td> 0.62433862</td><td> 0.33847499</td><td> 0.19563348</td><td> 0.2067130494</td><td> 0.30718456</td></tr>\n",
       "\t<tr><th scope=row>SedentaryMinutes</th><td>-0.04475190</td><td>-0.3372826500</td><td>-0.05058263</td><td>-0.06307100</td><td>-0.228223199</td><td>-0.42637280</td><td> 0.036520608</td><td>-0.16859756</td><td> 1.00000000</td><td>-0.11832862</td><td>-0.15936298</td><td>-0.41552857</td><td> 0.1047560142</td><td>-0.28261998</td></tr>\n",
       "\t<tr><th scope=row>Calories</th><td> 0.42502590</td><td> 0.5860772317</td><td> 0.21638083</td><td> 0.49674924</td><td> 0.215159104</td><td> 0.45501567</td><td> 0.039083093</td><td> 0.62433862</td><td>-0.11832862</td><td> 1.00000000</td><td> 0.84459462</td><td> 0.34191662</td><td> 0.7210944311</td><td> 0.36562526</td></tr>\n",
       "\t<tr><th scope=row>Median_Hourly_Calorie</th><td> 0.35212391</td><td> 0.3405678896</td><td> 0.19472378</td><td> 0.22847223</td><td> 0.071921910</td><td> 0.45153598</td><td> 0.038115530</td><td> 0.33847499</td><td>-0.15936298</td><td> 0.84459462</td><td> 1.00000000</td><td> 0.49481758</td><td> 0.8211839867</td><td> 0.42121932</td></tr>\n",
       "\t<tr><th scope=row>MedTotalIntensity</th><td>-0.03879821</td><td> 0.5531253355</td><td> 0.14502543</td><td> 0.15584085</td><td> 0.171312766</td><td> 0.75329969</td><td> 0.089277142</td><td> 0.19563348</td><td>-0.41552857</td><td> 0.34191662</td><td> 0.49481758</td><td> 1.00000000</td><td>-0.0308027507</td><td> 0.47950801</td></tr>\n",
       "\t<tr><th scope=row>MedianMinCalories</th><td> 0.38538815</td><td>-0.0001388285</td><td> 0.11698620</td><td> 0.11551591</td><td>-0.065649194</td><td> 0.03174041</td><td> 0.002187520</td><td> 0.20671305</td><td> 0.10475601</td><td> 0.72109443</td><td> 0.82118399</td><td>-0.03080275</td><td> 1.0000000000</td><td> 0.27313235</td></tr>\n",
       "\t<tr><th scope=row>AvgMinMet</th><td>-0.01191067</td><td> 0.3426139828</td><td> 0.11276077</td><td> 0.20625412</td><td> 0.061426178</td><td> 0.37442910</td><td>-0.016279623</td><td> 0.30718456</td><td>-0.28261998</td><td> 0.36562526</td><td> 0.42121932</td><td> 0.47950801</td><td> 0.2731323514</td><td> 1.00000000</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 14 × 14 of type dbl\n",
       "\\begin{tabular}{r|llllllllllllll}\n",
       "  & Id & TotalSteps & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & SedentaryMinutes & Calories & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedianMinCalories & AvgMinMet\\\\\n",
       "\\hline\n",
       "\tId &  1.00000000 &  0.1943711631 &  0.19336799 &  0.31412866 &  0.029223441 &  0.02591688 & -0.015240873 &  0.31074899 & -0.04475190 &  0.42502590 &  0.35212391 & -0.03879821 &  0.3853881491 & -0.01191067\\\\\n",
       "\tTotalSteps &  0.19437116 &  1.0000000000 &  0.18307362 &  0.73955440 &  0.506600934 &  0.68783202 &  0.068202586 &  0.66464981 & -0.33728265 &  0.58607723 &  0.34056789 &  0.55312534 & -0.0001388285 &  0.34261398\\\\\n",
       "\tLoggedActivitiesDistance &  0.19336799 &  0.1830736156 &  1.00000000 &  0.15406888 &  0.075816575 &  0.13655054 &  0.153274687 &  0.24167962 & -0.05058263 &  0.21638083 &  0.19472378 &  0.14502543 &  0.1169861983 &  0.11276077\\\\\n",
       "\tVeryActiveDistance &  0.31412866 &  0.7395544003 &  0.15406888 &  1.00000000 &  0.189551597 &  0.15141767 &  0.045218451 &  0.82599372 & -0.06307100 &  0.49674924 &  0.22847223 &  0.15584085 &  0.1155159117 &  0.20625412\\\\\n",
       "\tModeratelyActiveDistance &  0.02922344 &  0.5066009336 &  0.07581657 &  0.18955160 &  1.000000000 &  0.23868372 &  0.004054654 &  0.22139542 & -0.22822320 &  0.21515910 &  0.07192191 &  0.17131277 & -0.0656491945 &  0.06142618\\\\\n",
       "\tLightActiveDistance &  0.02591688 &  0.6878320197 &  0.13655054 &  0.15141767 &  0.238683722 &  1.00000000 &  0.096714489 &  0.14766210 & -0.42637280 &  0.45501567 &  0.45153598 &  0.75329969 &  0.0317404093 &  0.37442910\\\\\n",
       "\tSedentaryActiveDistance & -0.01524087 &  0.0682025861 &  0.15327469 &  0.04521845 &  0.004054654 &  0.09671449 &  1.000000000 &  0.00685887 &  0.03652061 &  0.03908309 &  0.03811553 &  0.08927714 &  0.0021875204 & -0.01627962\\\\\n",
       "\tVeryActiveMinutes &  0.31074899 &  0.6646498102 &  0.24167962 &  0.82599372 &  0.221395419 &  0.14766210 &  0.006858870 &  1.00000000 & -0.16859756 &  0.62433862 &  0.33847499 &  0.19563348 &  0.2067130494 &  0.30718456\\\\\n",
       "\tSedentaryMinutes & -0.04475190 & -0.3372826500 & -0.05058263 & -0.06307100 & -0.228223199 & -0.42637280 &  0.036520608 & -0.16859756 &  1.00000000 & -0.11832862 & -0.15936298 & -0.41552857 &  0.1047560142 & -0.28261998\\\\\n",
       "\tCalories &  0.42502590 &  0.5860772317 &  0.21638083 &  0.49674924 &  0.215159104 &  0.45501567 &  0.039083093 &  0.62433862 & -0.11832862 &  1.00000000 &  0.84459462 &  0.34191662 &  0.7210944311 &  0.36562526\\\\\n",
       "\tMedian\\_Hourly\\_Calorie &  0.35212391 &  0.3405678896 &  0.19472378 &  0.22847223 &  0.071921910 &  0.45153598 &  0.038115530 &  0.33847499 & -0.15936298 &  0.84459462 &  1.00000000 &  0.49481758 &  0.8211839867 &  0.42121932\\\\\n",
       "\tMedTotalIntensity & -0.03879821 &  0.5531253355 &  0.14502543 &  0.15584085 &  0.171312766 &  0.75329969 &  0.089277142 &  0.19563348 & -0.41552857 &  0.34191662 &  0.49481758 &  1.00000000 & -0.0308027507 &  0.47950801\\\\\n",
       "\tMedianMinCalories &  0.38538815 & -0.0001388285 &  0.11698620 &  0.11551591 & -0.065649194 &  0.03174041 &  0.002187520 &  0.20671305 &  0.10475601 &  0.72109443 &  0.82118399 & -0.03080275 &  1.0000000000 &  0.27313235\\\\\n",
       "\tAvgMinMet & -0.01191067 &  0.3426139828 &  0.11276077 &  0.20625412 &  0.061426178 &  0.37442910 & -0.016279623 &  0.30718456 & -0.28261998 &  0.36562526 &  0.42121932 &  0.47950801 &  0.2731323514 &  1.00000000\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 14 × 14 of type dbl\n",
       "\n",
       "| <!--/--> | Id | TotalSteps | LoggedActivitiesDistance | VeryActiveDistance | ModeratelyActiveDistance | LightActiveDistance | SedentaryActiveDistance | VeryActiveMinutes | SedentaryMinutes | Calories | Median_Hourly_Calorie | MedTotalIntensity | MedianMinCalories | AvgMinMet |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| Id |  1.00000000 |  0.1943711631 |  0.19336799 |  0.31412866 |  0.029223441 |  0.02591688 | -0.015240873 |  0.31074899 | -0.04475190 |  0.42502590 |  0.35212391 | -0.03879821 |  0.3853881491 | -0.01191067 |\n",
       "| TotalSteps |  0.19437116 |  1.0000000000 |  0.18307362 |  0.73955440 |  0.506600934 |  0.68783202 |  0.068202586 |  0.66464981 | -0.33728265 |  0.58607723 |  0.34056789 |  0.55312534 | -0.0001388285 |  0.34261398 |\n",
       "| LoggedActivitiesDistance |  0.19336799 |  0.1830736156 |  1.00000000 |  0.15406888 |  0.075816575 |  0.13655054 |  0.153274687 |  0.24167962 | -0.05058263 |  0.21638083 |  0.19472378 |  0.14502543 |  0.1169861983 |  0.11276077 |\n",
       "| VeryActiveDistance |  0.31412866 |  0.7395544003 |  0.15406888 |  1.00000000 |  0.189551597 |  0.15141767 |  0.045218451 |  0.82599372 | -0.06307100 |  0.49674924 |  0.22847223 |  0.15584085 |  0.1155159117 |  0.20625412 |\n",
       "| ModeratelyActiveDistance |  0.02922344 |  0.5066009336 |  0.07581657 |  0.18955160 |  1.000000000 |  0.23868372 |  0.004054654 |  0.22139542 | -0.22822320 |  0.21515910 |  0.07192191 |  0.17131277 | -0.0656491945 |  0.06142618 |\n",
       "| LightActiveDistance |  0.02591688 |  0.6878320197 |  0.13655054 |  0.15141767 |  0.238683722 |  1.00000000 |  0.096714489 |  0.14766210 | -0.42637280 |  0.45501567 |  0.45153598 |  0.75329969 |  0.0317404093 |  0.37442910 |\n",
       "| SedentaryActiveDistance | -0.01524087 |  0.0682025861 |  0.15327469 |  0.04521845 |  0.004054654 |  0.09671449 |  1.000000000 |  0.00685887 |  0.03652061 |  0.03908309 |  0.03811553 |  0.08927714 |  0.0021875204 | -0.01627962 |\n",
       "| VeryActiveMinutes |  0.31074899 |  0.6646498102 |  0.24167962 |  0.82599372 |  0.221395419 |  0.14766210 |  0.006858870 |  1.00000000 | -0.16859756 |  0.62433862 |  0.33847499 |  0.19563348 |  0.2067130494 |  0.30718456 |\n",
       "| SedentaryMinutes | -0.04475190 | -0.3372826500 | -0.05058263 | -0.06307100 | -0.228223199 | -0.42637280 |  0.036520608 | -0.16859756 |  1.00000000 | -0.11832862 | -0.15936298 | -0.41552857 |  0.1047560142 | -0.28261998 |\n",
       "| Calories |  0.42502590 |  0.5860772317 |  0.21638083 |  0.49674924 |  0.215159104 |  0.45501567 |  0.039083093 |  0.62433862 | -0.11832862 |  1.00000000 |  0.84459462 |  0.34191662 |  0.7210944311 |  0.36562526 |\n",
       "| Median_Hourly_Calorie |  0.35212391 |  0.3405678896 |  0.19472378 |  0.22847223 |  0.071921910 |  0.45153598 |  0.038115530 |  0.33847499 | -0.15936298 |  0.84459462 |  1.00000000 |  0.49481758 |  0.8211839867 |  0.42121932 |\n",
       "| MedTotalIntensity | -0.03879821 |  0.5531253355 |  0.14502543 |  0.15584085 |  0.171312766 |  0.75329969 |  0.089277142 |  0.19563348 | -0.41552857 |  0.34191662 |  0.49481758 |  1.00000000 | -0.0308027507 |  0.47950801 |\n",
       "| MedianMinCalories |  0.38538815 | -0.0001388285 |  0.11698620 |  0.11551591 | -0.065649194 |  0.03174041 |  0.002187520 |  0.20671305 |  0.10475601 |  0.72109443 |  0.82118399 | -0.03080275 |  1.0000000000 |  0.27313235 |\n",
       "| AvgMinMet | -0.01191067 |  0.3426139828 |  0.11276077 |  0.20625412 |  0.061426178 |  0.37442910 | -0.016279623 |  0.30718456 | -0.28261998 |  0.36562526 |  0.42121932 |  0.47950801 |  0.2731323514 |  1.00000000 |\n",
       "\n"
      ],
      "text/plain": [
       "                         Id          TotalSteps    LoggedActivitiesDistance\n",
       "Id                        1.00000000  0.1943711631  0.19336799             \n",
       "TotalSteps                0.19437116  1.0000000000  0.18307362             \n",
       "LoggedActivitiesDistance  0.19336799  0.1830736156  1.00000000             \n",
       "VeryActiveDistance        0.31412866  0.7395544003  0.15406888             \n",
       "ModeratelyActiveDistance  0.02922344  0.5066009336  0.07581657             \n",
       "LightActiveDistance       0.02591688  0.6878320197  0.13655054             \n",
       "SedentaryActiveDistance  -0.01524087  0.0682025861  0.15327469             \n",
       "VeryActiveMinutes         0.31074899  0.6646498102  0.24167962             \n",
       "SedentaryMinutes         -0.04475190 -0.3372826500 -0.05058263             \n",
       "Calories                  0.42502590  0.5860772317  0.21638083             \n",
       "Median_Hourly_Calorie     0.35212391  0.3405678896  0.19472378             \n",
       "MedTotalIntensity        -0.03879821  0.5531253355  0.14502543             \n",
       "MedianMinCalories         0.38538815 -0.0001388285  0.11698620             \n",
       "AvgMinMet                -0.01191067  0.3426139828  0.11276077             \n",
       "                         VeryActiveDistance ModeratelyActiveDistance\n",
       "Id                        0.31412866         0.029223441            \n",
       "TotalSteps                0.73955440         0.506600934            \n",
       "LoggedActivitiesDistance  0.15406888         0.075816575            \n",
       "VeryActiveDistance        1.00000000         0.189551597            \n",
       "ModeratelyActiveDistance  0.18955160         1.000000000            \n",
       "LightActiveDistance       0.15141767         0.238683722            \n",
       "SedentaryActiveDistance   0.04521845         0.004054654            \n",
       "VeryActiveMinutes         0.82599372         0.221395419            \n",
       "SedentaryMinutes         -0.06307100        -0.228223199            \n",
       "Calories                  0.49674924         0.215159104            \n",
       "Median_Hourly_Calorie     0.22847223         0.071921910            \n",
       "MedTotalIntensity         0.15584085         0.171312766            \n",
       "MedianMinCalories         0.11551591        -0.065649194            \n",
       "AvgMinMet                 0.20625412         0.061426178            \n",
       "                         LightActiveDistance SedentaryActiveDistance\n",
       "Id                        0.02591688         -0.015240873           \n",
       "TotalSteps                0.68783202          0.068202586           \n",
       "LoggedActivitiesDistance  0.13655054          0.153274687           \n",
       "VeryActiveDistance        0.15141767          0.045218451           \n",
       "ModeratelyActiveDistance  0.23868372          0.004054654           \n",
       "LightActiveDistance       1.00000000          0.096714489           \n",
       "SedentaryActiveDistance   0.09671449          1.000000000           \n",
       "VeryActiveMinutes         0.14766210          0.006858870           \n",
       "SedentaryMinutes         -0.42637280          0.036520608           \n",
       "Calories                  0.45501567          0.039083093           \n",
       "Median_Hourly_Calorie     0.45153598          0.038115530           \n",
       "MedTotalIntensity         0.75329969          0.089277142           \n",
       "MedianMinCalories         0.03174041          0.002187520           \n",
       "AvgMinMet                 0.37442910         -0.016279623           \n",
       "                         VeryActiveMinutes SedentaryMinutes Calories   \n",
       "Id                        0.31074899       -0.04475190       0.42502590\n",
       "TotalSteps                0.66464981       -0.33728265       0.58607723\n",
       "LoggedActivitiesDistance  0.24167962       -0.05058263       0.21638083\n",
       "VeryActiveDistance        0.82599372       -0.06307100       0.49674924\n",
       "ModeratelyActiveDistance  0.22139542       -0.22822320       0.21515910\n",
       "LightActiveDistance       0.14766210       -0.42637280       0.45501567\n",
       "SedentaryActiveDistance   0.00685887        0.03652061       0.03908309\n",
       "VeryActiveMinutes         1.00000000       -0.16859756       0.62433862\n",
       "SedentaryMinutes         -0.16859756        1.00000000      -0.11832862\n",
       "Calories                  0.62433862       -0.11832862       1.00000000\n",
       "Median_Hourly_Calorie     0.33847499       -0.15936298       0.84459462\n",
       "MedTotalIntensity         0.19563348       -0.41552857       0.34191662\n",
       "MedianMinCalories         0.20671305        0.10475601       0.72109443\n",
       "AvgMinMet                 0.30718456       -0.28261998       0.36562526\n",
       "                         Median_Hourly_Calorie MedTotalIntensity\n",
       "Id                        0.35212391           -0.03879821      \n",
       "TotalSteps                0.34056789            0.55312534      \n",
       "LoggedActivitiesDistance  0.19472378            0.14502543      \n",
       "VeryActiveDistance        0.22847223            0.15584085      \n",
       "ModeratelyActiveDistance  0.07192191            0.17131277      \n",
       "LightActiveDistance       0.45153598            0.75329969      \n",
       "SedentaryActiveDistance   0.03811553            0.08927714      \n",
       "VeryActiveMinutes         0.33847499            0.19563348      \n",
       "SedentaryMinutes         -0.15936298           -0.41552857      \n",
       "Calories                  0.84459462            0.34191662      \n",
       "Median_Hourly_Calorie     1.00000000            0.49481758      \n",
       "MedTotalIntensity         0.49481758            1.00000000      \n",
       "MedianMinCalories         0.82118399           -0.03080275      \n",
       "AvgMinMet                 0.42121932            0.47950801      \n",
       "                         MedianMinCalories AvgMinMet  \n",
       "Id                        0.3853881491     -0.01191067\n",
       "TotalSteps               -0.0001388285      0.34261398\n",
       "LoggedActivitiesDistance  0.1169861983      0.11276077\n",
       "VeryActiveDistance        0.1155159117      0.20625412\n",
       "ModeratelyActiveDistance -0.0656491945      0.06142618\n",
       "LightActiveDistance       0.0317404093      0.37442910\n",
       "SedentaryActiveDistance   0.0021875204     -0.01627962\n",
       "VeryActiveMinutes         0.2067130494      0.30718456\n",
       "SedentaryMinutes          0.1047560142     -0.28261998\n",
       "Calories                  0.7210944311      0.36562526\n",
       "Median_Hourly_Calorie     0.8211839867      0.42121932\n",
       "MedTotalIntensity        -0.0308027507      0.47950801\n",
       "MedianMinCalories         1.0000000000      0.27313235\n",
       "AvgMinMet                 0.2731323514      1.00000000"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "corr_matrix <- cor(final_non_nulls)\n",
    "corr_matrix"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 83,
   "id": "161f1d1c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:03.953380Z",
     "iopub.status.busy": "2023-07-13T02:42:03.951953Z",
     "iopub.status.idle": "2023-07-13T02:42:03.981715Z",
     "shell.execute_reply": "2023-07-13T02:42:03.979460Z"
    },
    "papermill": {
     "duration": 0.07282,
     "end_time": "2023-07-13T02:42:03.984231",
     "exception": false,
     "start_time": "2023-07-13T02:42:03.911411",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 14</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>TotalSteps</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedianMinCalories</th><th scope=col>AvgMinMet</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>13162</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>25</td><td> 728</td><td>1985</td><td>76.0</td><td>13.0</td><td>0.9438</td><td>12</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>10735</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>21</td><td> 776</td><td>1797</td><td>71.5</td><td>11.5</td><td>0.7865</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>10460</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>30</td><td>1218</td><td>1776</td><td>62.5</td><td> 6.0</td><td>0.9438</td><td>12</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td> 9762</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>29</td><td> 726</td><td>1745</td><td>59.5</td><td> 6.5</td><td>0.7865</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>12669</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>36</td><td> 773</td><td>1863</td><td>63.5</td><td> 9.5</td><td>0.7865</td><td>10</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td> 9705</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>38</td><td> 539</td><td>1728</td><td>53.5</td><td> 1.5</td><td>0.7865</td><td>10</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 14\n",
       "\\begin{tabular}{r|llllllllllllll}\n",
       "  & Id & TotalSteps & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & SedentaryMinutes & Calories & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedianMinCalories & AvgMinMet\\\\\n",
       "  & <dbl> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 13162 & 0 & 1.88 & 0.55 & 6.06 & 0 & 25 &  728 & 1985 & 76.0 & 13.0 & 0.9438 & 12\\\\\n",
       "\t2 & 1503960366 & 10735 & 0 & 1.57 & 0.69 & 4.71 & 0 & 21 &  776 & 1797 & 71.5 & 11.5 & 0.7865 & 10\\\\\n",
       "\t3 & 1503960366 & 10460 & 0 & 2.44 & 0.40 & 3.91 & 0 & 30 & 1218 & 1776 & 62.5 &  6.0 & 0.9438 & 12\\\\\n",
       "\t4 & 1503960366 &  9762 & 0 & 2.14 & 1.26 & 2.83 & 0 & 29 &  726 & 1745 & 59.5 &  6.5 & 0.7865 & 10\\\\\n",
       "\t5 & 1503960366 & 12669 & 0 & 2.71 & 0.41 & 5.04 & 0 & 36 &  773 & 1863 & 63.5 &  9.5 & 0.7865 & 10\\\\\n",
       "\t6 & 1503960366 &  9705 & 0 & 3.19 & 0.78 & 2.51 & 0 & 38 &  539 & 1728 & 53.5 &  1.5 & 0.7865 & 10\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 14\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | TotalSteps &lt;int&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | VeryActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | Median_Hourly_Calorie &lt;dbl&gt; | MedTotalIntensity &lt;dbl&gt; | MedianMinCalories &lt;dbl&gt; | AvgMinMet &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 13162 | 0 | 1.88 | 0.55 | 6.06 | 0 | 25 |  728 | 1985 | 76.0 | 13.0 | 0.9438 | 12 |\n",
       "| 2 | 1503960366 | 10735 | 0 | 1.57 | 0.69 | 4.71 | 0 | 21 |  776 | 1797 | 71.5 | 11.5 | 0.7865 | 10 |\n",
       "| 3 | 1503960366 | 10460 | 0 | 2.44 | 0.40 | 3.91 | 0 | 30 | 1218 | 1776 | 62.5 |  6.0 | 0.9438 | 12 |\n",
       "| 4 | 1503960366 |  9762 | 0 | 2.14 | 1.26 | 2.83 | 0 | 29 |  726 | 1745 | 59.5 |  6.5 | 0.7865 | 10 |\n",
       "| 5 | 1503960366 | 12669 | 0 | 2.71 | 0.41 | 5.04 | 0 | 36 |  773 | 1863 | 63.5 |  9.5 | 0.7865 | 10 |\n",
       "| 6 | 1503960366 |  9705 | 0 | 3.19 | 0.78 | 2.51 | 0 | 38 |  539 | 1728 | 53.5 |  1.5 | 0.7865 | 10 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         TotalSteps LoggedActivitiesDistance VeryActiveDistance\n",
       "1 1503960366 13162      0                        1.88              \n",
       "2 1503960366 10735      0                        1.57              \n",
       "3 1503960366 10460      0                        2.44              \n",
       "4 1503960366  9762      0                        2.14              \n",
       "5 1503960366 12669      0                        2.71              \n",
       "6 1503960366  9705      0                        3.19              \n",
       "  ModeratelyActiveDistance LightActiveDistance SedentaryActiveDistance\n",
       "1 0.55                     6.06                0                      \n",
       "2 0.69                     4.71                0                      \n",
       "3 0.40                     3.91                0                      \n",
       "4 1.26                     2.83                0                      \n",
       "5 0.41                     5.04                0                      \n",
       "6 0.78                     2.51                0                      \n",
       "  VeryActiveMinutes SedentaryMinutes Calories Median_Hourly_Calorie\n",
       "1 25                 728             1985     76.0                 \n",
       "2 21                 776             1797     71.5                 \n",
       "3 30                1218             1776     62.5                 \n",
       "4 29                 726             1745     59.5                 \n",
       "5 36                 773             1863     63.5                 \n",
       "6 38                 539             1728     53.5                 \n",
       "  MedTotalIntensity MedianMinCalories AvgMinMet\n",
       "1 13.0              0.9438            12       \n",
       "2 11.5              0.7865            10       \n",
       "3  6.0              0.9438            12       \n",
       "4  6.5              0.7865            10       \n",
       "5  9.5              0.7865            10       \n",
       "6  1.5              0.7865            10       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "new_activity_merged_final <- new_activity_merged[,colnames(new_activity_merged)%in%colnames(final_non_nulls)]\n",
    "head(new_activity_merged_final)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 84,
   "id": "eea9b092",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:04.065354Z",
     "iopub.status.busy": "2023-07-13T02:42:04.064150Z",
     "iopub.status.idle": "2023-07-13T02:42:04.092689Z",
     "shell.execute_reply": "2023-07-13T02:42:04.090804Z"
    },
    "papermill": {
     "duration": 0.07162,
     "end_time": "2023-07-13T02:42:04.094956",
     "exception": false,
     "start_time": "2023-07-13T02:42:04.023336",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 15</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>TotalSteps</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedianMinCalories</th><th scope=col>AvgMinMet</th><th scope=col>ActivityDay</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>13162</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>25</td><td> 728</td><td>1985</td><td>76.0</td><td>13.0</td><td>0.9438</td><td>12</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>10735</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>21</td><td> 776</td><td>1797</td><td>71.5</td><td>11.5</td><td>0.7865</td><td>10</td><td>04/13/2016</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>10460</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>30</td><td>1218</td><td>1776</td><td>62.5</td><td> 6.0</td><td>0.9438</td><td>12</td><td>04/14/2016</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td> 9762</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>29</td><td> 726</td><td>1745</td><td>59.5</td><td> 6.5</td><td>0.7865</td><td>10</td><td>04/15/2016</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>12669</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>36</td><td> 773</td><td>1863</td><td>63.5</td><td> 9.5</td><td>0.7865</td><td>10</td><td>04/16/2016</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td> 9705</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>38</td><td> 539</td><td>1728</td><td>53.5</td><td> 1.5</td><td>0.7865</td><td>10</td><td>04/17/2016</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 15\n",
       "\\begin{tabular}{r|lllllllllllllll}\n",
       "  & Id & TotalSteps & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & SedentaryMinutes & Calories & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedianMinCalories & AvgMinMet & ActivityDay\\\\\n",
       "  & <dbl> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 13162 & 0 & 1.88 & 0.55 & 6.06 & 0 & 25 &  728 & 1985 & 76.0 & 13.0 & 0.9438 & 12 & 04/12/2016\\\\\n",
       "\t2 & 1503960366 & 10735 & 0 & 1.57 & 0.69 & 4.71 & 0 & 21 &  776 & 1797 & 71.5 & 11.5 & 0.7865 & 10 & 04/13/2016\\\\\n",
       "\t3 & 1503960366 & 10460 & 0 & 2.44 & 0.40 & 3.91 & 0 & 30 & 1218 & 1776 & 62.5 &  6.0 & 0.9438 & 12 & 04/14/2016\\\\\n",
       "\t4 & 1503960366 &  9762 & 0 & 2.14 & 1.26 & 2.83 & 0 & 29 &  726 & 1745 & 59.5 &  6.5 & 0.7865 & 10 & 04/15/2016\\\\\n",
       "\t5 & 1503960366 & 12669 & 0 & 2.71 & 0.41 & 5.04 & 0 & 36 &  773 & 1863 & 63.5 &  9.5 & 0.7865 & 10 & 04/16/2016\\\\\n",
       "\t6 & 1503960366 &  9705 & 0 & 3.19 & 0.78 & 2.51 & 0 & 38 &  539 & 1728 & 53.5 &  1.5 & 0.7865 & 10 & 04/17/2016\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 15\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | TotalSteps &lt;int&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | VeryActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | Median_Hourly_Calorie &lt;dbl&gt; | MedTotalIntensity &lt;dbl&gt; | MedianMinCalories &lt;dbl&gt; | AvgMinMet &lt;dbl&gt; | ActivityDay &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 13162 | 0 | 1.88 | 0.55 | 6.06 | 0 | 25 |  728 | 1985 | 76.0 | 13.0 | 0.9438 | 12 | 04/12/2016 |\n",
       "| 2 | 1503960366 | 10735 | 0 | 1.57 | 0.69 | 4.71 | 0 | 21 |  776 | 1797 | 71.5 | 11.5 | 0.7865 | 10 | 04/13/2016 |\n",
       "| 3 | 1503960366 | 10460 | 0 | 2.44 | 0.40 | 3.91 | 0 | 30 | 1218 | 1776 | 62.5 |  6.0 | 0.9438 | 12 | 04/14/2016 |\n",
       "| 4 | 1503960366 |  9762 | 0 | 2.14 | 1.26 | 2.83 | 0 | 29 |  726 | 1745 | 59.5 |  6.5 | 0.7865 | 10 | 04/15/2016 |\n",
       "| 5 | 1503960366 | 12669 | 0 | 2.71 | 0.41 | 5.04 | 0 | 36 |  773 | 1863 | 63.5 |  9.5 | 0.7865 | 10 | 04/16/2016 |\n",
       "| 6 | 1503960366 |  9705 | 0 | 3.19 | 0.78 | 2.51 | 0 | 38 |  539 | 1728 | 53.5 |  1.5 | 0.7865 | 10 | 04/17/2016 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         TotalSteps LoggedActivitiesDistance VeryActiveDistance\n",
       "1 1503960366 13162      0                        1.88              \n",
       "2 1503960366 10735      0                        1.57              \n",
       "3 1503960366 10460      0                        2.44              \n",
       "4 1503960366  9762      0                        2.14              \n",
       "5 1503960366 12669      0                        2.71              \n",
       "6 1503960366  9705      0                        3.19              \n",
       "  ModeratelyActiveDistance LightActiveDistance SedentaryActiveDistance\n",
       "1 0.55                     6.06                0                      \n",
       "2 0.69                     4.71                0                      \n",
       "3 0.40                     3.91                0                      \n",
       "4 1.26                     2.83                0                      \n",
       "5 0.41                     5.04                0                      \n",
       "6 0.78                     2.51                0                      \n",
       "  VeryActiveMinutes SedentaryMinutes Calories Median_Hourly_Calorie\n",
       "1 25                 728             1985     76.0                 \n",
       "2 21                 776             1797     71.5                 \n",
       "3 30                1218             1776     62.5                 \n",
       "4 29                 726             1745     59.5                 \n",
       "5 36                 773             1863     63.5                 \n",
       "6 38                 539             1728     53.5                 \n",
       "  MedTotalIntensity MedianMinCalories AvgMinMet ActivityDay\n",
       "1 13.0              0.9438            12        04/12/2016 \n",
       "2 11.5              0.7865            10        04/13/2016 \n",
       "3  6.0              0.9438            12        04/14/2016 \n",
       "4  6.5              0.7865            10        04/15/2016 \n",
       "5  9.5              0.7865            10        04/16/2016 \n",
       "6  1.5              0.7865            10        04/17/2016 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "new_activity_merged_final$ActivityDay <- new_activity_merged$ActivityDay\n",
    "head(new_activity_merged_final)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 85,
   "id": "a02b5275",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:04.176622Z",
     "iopub.status.busy": "2023-07-13T02:42:04.175427Z",
     "iopub.status.idle": "2023-07-13T02:42:04.190803Z",
     "shell.execute_reply": "2023-07-13T02:42:04.188952Z"
    },
    "papermill": {
     "duration": 0.059356,
     "end_time": "2023-07-13T02:42:04.193801",
     "exception": false,
     "start_time": "2023-07-13T02:42:04.134445",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>Id</dt><dd>0</dd><dt>TotalSteps</dt><dd>0</dd><dt>LoggedActivitiesDistance</dt><dd>0</dd><dt>VeryActiveDistance</dt><dd>0</dd><dt>ModeratelyActiveDistance</dt><dd>0</dd><dt>LightActiveDistance</dt><dd>0</dd><dt>SedentaryActiveDistance</dt><dd>0</dd><dt>VeryActiveMinutes</dt><dd>0</dd><dt>SedentaryMinutes</dt><dd>0</dd><dt>Calories</dt><dd>0</dd><dt>Median_Hourly_Calorie</dt><dd>6</dd><dt>MedTotalIntensity</dt><dd>6</dd><dt>MedianMinCalories</dt><dd>6</dd><dt>AvgMinMet</dt><dd>6</dd><dt>ActivityDay</dt><dd>0</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[Id] 0\n",
       "\\item[TotalSteps] 0\n",
       "\\item[LoggedActivitiesDistance] 0\n",
       "\\item[VeryActiveDistance] 0\n",
       "\\item[ModeratelyActiveDistance] 0\n",
       "\\item[LightActiveDistance] 0\n",
       "\\item[SedentaryActiveDistance] 0\n",
       "\\item[VeryActiveMinutes] 0\n",
       "\\item[SedentaryMinutes] 0\n",
       "\\item[Calories] 0\n",
       "\\item[Median\\textbackslash{}\\_Hourly\\textbackslash{}\\_Calorie] 6\n",
       "\\item[MedTotalIntensity] 6\n",
       "\\item[MedianMinCalories] 6\n",
       "\\item[AvgMinMet] 6\n",
       "\\item[ActivityDay] 0\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "Id\n",
       ":   0TotalSteps\n",
       ":   0LoggedActivitiesDistance\n",
       ":   0VeryActiveDistance\n",
       ":   0ModeratelyActiveDistance\n",
       ":   0LightActiveDistance\n",
       ":   0SedentaryActiveDistance\n",
       ":   0VeryActiveMinutes\n",
       ":   0SedentaryMinutes\n",
       ":   0Calories\n",
       ":   0Median_Hourly_Calorie\n",
       ":   6MedTotalIntensity\n",
       ":   6MedianMinCalories\n",
       ":   6AvgMinMet\n",
       ":   6ActivityDay\n",
       ":   0\n",
       "\n"
      ],
      "text/plain": [
       "                      Id               TotalSteps LoggedActivitiesDistance \n",
       "                       0                        0                        0 \n",
       "      VeryActiveDistance ModeratelyActiveDistance      LightActiveDistance \n",
       "                       0                        0                        0 \n",
       " SedentaryActiveDistance        VeryActiveMinutes         SedentaryMinutes \n",
       "                       0                        0                        0 \n",
       "                Calories    Median_Hourly_Calorie        MedTotalIntensity \n",
       "                       0                        6                        6 \n",
       "       MedianMinCalories                AvgMinMet              ActivityDay \n",
       "                       6                        6                        0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "colSums(is.na(new_activity_merged_final))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "3d9496d2",
   "metadata": {
    "papermill": {
     "duration": 0.039117,
     "end_time": "2023-07-13T02:42:04.272173",
     "exception": false,
     "start_time": "2023-07-13T02:42:04.233056",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Imputing the Null Values"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 86,
   "id": "25e6cc74",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:04.353665Z",
     "iopub.status.busy": "2023-07-13T02:42:04.352382Z",
     "iopub.status.idle": "2023-07-13T02:42:04.381023Z",
     "shell.execute_reply": "2023-07-13T02:42:04.379016Z"
    },
    "papermill": {
     "duration": 0.073001,
     "end_time": "2023-07-13T02:42:04.383370",
     "exception": false,
     "start_time": "2023-07-13T02:42:04.310369",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 15</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Id</th><th scope=col>TotalSteps</th><th scope=col>LoggedActivitiesDistance</th><th scope=col>VeryActiveDistance</th><th scope=col>ModeratelyActiveDistance</th><th scope=col>LightActiveDistance</th><th scope=col>SedentaryActiveDistance</th><th scope=col>VeryActiveMinutes</th><th scope=col>SedentaryMinutes</th><th scope=col>Calories</th><th scope=col>Median_Hourly_Calorie</th><th scope=col>MedTotalIntensity</th><th scope=col>MedianMinCalories</th><th scope=col>AvgMinMet</th><th scope=col>ActivityDay</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1503960366</td><td>13162</td><td>0</td><td>1.88</td><td>0.55</td><td>6.06</td><td>0</td><td>25</td><td> 728</td><td>1985</td><td>76.0</td><td>13.0</td><td>0.9438</td><td>12</td><td>04/12/2016</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1503960366</td><td>10735</td><td>0</td><td>1.57</td><td>0.69</td><td>4.71</td><td>0</td><td>21</td><td> 776</td><td>1797</td><td>71.5</td><td>11.5</td><td>0.7865</td><td>10</td><td>04/13/2016</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1503960366</td><td>10460</td><td>0</td><td>2.44</td><td>0.40</td><td>3.91</td><td>0</td><td>30</td><td>1218</td><td>1776</td><td>62.5</td><td> 6.0</td><td>0.9438</td><td>12</td><td>04/14/2016</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1503960366</td><td> 9762</td><td>0</td><td>2.14</td><td>1.26</td><td>2.83</td><td>0</td><td>29</td><td> 726</td><td>1745</td><td>59.5</td><td> 6.5</td><td>0.7865</td><td>10</td><td>04/15/2016</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1503960366</td><td>12669</td><td>0</td><td>2.71</td><td>0.41</td><td>5.04</td><td>0</td><td>36</td><td> 773</td><td>1863</td><td>63.5</td><td> 9.5</td><td>0.7865</td><td>10</td><td>04/16/2016</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1503960366</td><td> 9705</td><td>0</td><td>3.19</td><td>0.78</td><td>2.51</td><td>0</td><td>38</td><td> 539</td><td>1728</td><td>53.5</td><td> 1.5</td><td>0.7865</td><td>10</td><td>04/17/2016</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 15\n",
       "\\begin{tabular}{r|lllllllllllllll}\n",
       "  & Id & TotalSteps & LoggedActivitiesDistance & VeryActiveDistance & ModeratelyActiveDistance & LightActiveDistance & SedentaryActiveDistance & VeryActiveMinutes & SedentaryMinutes & Calories & Median\\_Hourly\\_Calorie & MedTotalIntensity & MedianMinCalories & AvgMinMet & ActivityDay\\\\\n",
       "  & <dbl> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <int> & <int> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & 1503960366 & 13162 & 0 & 1.88 & 0.55 & 6.06 & 0 & 25 &  728 & 1985 & 76.0 & 13.0 & 0.9438 & 12 & 04/12/2016\\\\\n",
       "\t2 & 1503960366 & 10735 & 0 & 1.57 & 0.69 & 4.71 & 0 & 21 &  776 & 1797 & 71.5 & 11.5 & 0.7865 & 10 & 04/13/2016\\\\\n",
       "\t3 & 1503960366 & 10460 & 0 & 2.44 & 0.40 & 3.91 & 0 & 30 & 1218 & 1776 & 62.5 &  6.0 & 0.9438 & 12 & 04/14/2016\\\\\n",
       "\t4 & 1503960366 &  9762 & 0 & 2.14 & 1.26 & 2.83 & 0 & 29 &  726 & 1745 & 59.5 &  6.5 & 0.7865 & 10 & 04/15/2016\\\\\n",
       "\t5 & 1503960366 & 12669 & 0 & 2.71 & 0.41 & 5.04 & 0 & 36 &  773 & 1863 & 63.5 &  9.5 & 0.7865 & 10 & 04/16/2016\\\\\n",
       "\t6 & 1503960366 &  9705 & 0 & 3.19 & 0.78 & 2.51 & 0 & 38 &  539 & 1728 & 53.5 &  1.5 & 0.7865 & 10 & 04/17/2016\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 15\n",
       "\n",
       "| <!--/--> | Id &lt;dbl&gt; | TotalSteps &lt;int&gt; | LoggedActivitiesDistance &lt;dbl&gt; | VeryActiveDistance &lt;dbl&gt; | ModeratelyActiveDistance &lt;dbl&gt; | LightActiveDistance &lt;dbl&gt; | SedentaryActiveDistance &lt;dbl&gt; | VeryActiveMinutes &lt;int&gt; | SedentaryMinutes &lt;int&gt; | Calories &lt;int&gt; | Median_Hourly_Calorie &lt;dbl&gt; | MedTotalIntensity &lt;dbl&gt; | MedianMinCalories &lt;dbl&gt; | AvgMinMet &lt;dbl&gt; | ActivityDay &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 1503960366 | 13162 | 0 | 1.88 | 0.55 | 6.06 | 0 | 25 |  728 | 1985 | 76.0 | 13.0 | 0.9438 | 12 | 04/12/2016 |\n",
       "| 2 | 1503960366 | 10735 | 0 | 1.57 | 0.69 | 4.71 | 0 | 21 |  776 | 1797 | 71.5 | 11.5 | 0.7865 | 10 | 04/13/2016 |\n",
       "| 3 | 1503960366 | 10460 | 0 | 2.44 | 0.40 | 3.91 | 0 | 30 | 1218 | 1776 | 62.5 |  6.0 | 0.9438 | 12 | 04/14/2016 |\n",
       "| 4 | 1503960366 |  9762 | 0 | 2.14 | 1.26 | 2.83 | 0 | 29 |  726 | 1745 | 59.5 |  6.5 | 0.7865 | 10 | 04/15/2016 |\n",
       "| 5 | 1503960366 | 12669 | 0 | 2.71 | 0.41 | 5.04 | 0 | 36 |  773 | 1863 | 63.5 |  9.5 | 0.7865 | 10 | 04/16/2016 |\n",
       "| 6 | 1503960366 |  9705 | 0 | 3.19 | 0.78 | 2.51 | 0 | 38 |  539 | 1728 | 53.5 |  1.5 | 0.7865 | 10 | 04/17/2016 |\n",
       "\n"
      ],
      "text/plain": [
       "  Id         TotalSteps LoggedActivitiesDistance VeryActiveDistance\n",
       "1 1503960366 13162      0                        1.88              \n",
       "2 1503960366 10735      0                        1.57              \n",
       "3 1503960366 10460      0                        2.44              \n",
       "4 1503960366  9762      0                        2.14              \n",
       "5 1503960366 12669      0                        2.71              \n",
       "6 1503960366  9705      0                        3.19              \n",
       "  ModeratelyActiveDistance LightActiveDistance SedentaryActiveDistance\n",
       "1 0.55                     6.06                0                      \n",
       "2 0.69                     4.71                0                      \n",
       "3 0.40                     3.91                0                      \n",
       "4 1.26                     2.83                0                      \n",
       "5 0.41                     5.04                0                      \n",
       "6 0.78                     2.51                0                      \n",
       "  VeryActiveMinutes SedentaryMinutes Calories Median_Hourly_Calorie\n",
       "1 25                 728             1985     76.0                 \n",
       "2 21                 776             1797     71.5                 \n",
       "3 30                1218             1776     62.5                 \n",
       "4 29                 726             1745     59.5                 \n",
       "5 36                 773             1863     63.5                 \n",
       "6 38                 539             1728     53.5                 \n",
       "  MedTotalIntensity MedianMinCalories AvgMinMet ActivityDay\n",
       "1 13.0              0.9438            12        04/12/2016 \n",
       "2 11.5              0.7865            10        04/13/2016 \n",
       "3  6.0              0.9438            12        04/14/2016 \n",
       "4  6.5              0.7865            10        04/15/2016 \n",
       "5  9.5              0.7865            10        04/16/2016 \n",
       "6  1.5              0.7865            10        04/17/2016 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(new_activity_merged_final)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 87,
   "id": "a21545ad",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:04.465318Z",
     "iopub.status.busy": "2023-07-13T02:42:04.464056Z",
     "iopub.status.idle": "2023-07-13T02:42:04.478458Z",
     "shell.execute_reply": "2023-07-13T02:42:04.477151Z"
    },
    "papermill": {
     "duration": 0.057298,
     "end_time": "2023-07-13T02:42:04.480273",
     "exception": false,
     "start_time": "2023-07-13T02:42:04.422975",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>Id</dt><dd>0</dd><dt>TotalSteps</dt><dd>0</dd><dt>LoggedActivitiesDistance</dt><dd>0</dd><dt>VeryActiveDistance</dt><dd>0</dd><dt>ModeratelyActiveDistance</dt><dd>0</dd><dt>LightActiveDistance</dt><dd>0</dd><dt>SedentaryActiveDistance</dt><dd>0</dd><dt>VeryActiveMinutes</dt><dd>0</dd><dt>SedentaryMinutes</dt><dd>0</dd><dt>Calories</dt><dd>0</dd><dt>Median_Hourly_Calorie</dt><dd>6</dd><dt>MedTotalIntensity</dt><dd>6</dd><dt>MedianMinCalories</dt><dd>6</dd><dt>AvgMinMet</dt><dd>6</dd><dt>ActivityDay</dt><dd>0</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[Id] 0\n",
       "\\item[TotalSteps] 0\n",
       "\\item[LoggedActivitiesDistance] 0\n",
       "\\item[VeryActiveDistance] 0\n",
       "\\item[ModeratelyActiveDistance] 0\n",
       "\\item[LightActiveDistance] 0\n",
       "\\item[SedentaryActiveDistance] 0\n",
       "\\item[VeryActiveMinutes] 0\n",
       "\\item[SedentaryMinutes] 0\n",
       "\\item[Calories] 0\n",
       "\\item[Median\\textbackslash{}\\_Hourly\\textbackslash{}\\_Calorie] 6\n",
       "\\item[MedTotalIntensity] 6\n",
       "\\item[MedianMinCalories] 6\n",
       "\\item[AvgMinMet] 6\n",
       "\\item[ActivityDay] 0\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "Id\n",
       ":   0TotalSteps\n",
       ":   0LoggedActivitiesDistance\n",
       ":   0VeryActiveDistance\n",
       ":   0ModeratelyActiveDistance\n",
       ":   0LightActiveDistance\n",
       ":   0SedentaryActiveDistance\n",
       ":   0VeryActiveMinutes\n",
       ":   0SedentaryMinutes\n",
       ":   0Calories\n",
       ":   0Median_Hourly_Calorie\n",
       ":   6MedTotalIntensity\n",
       ":   6MedianMinCalories\n",
       ":   6AvgMinMet\n",
       ":   6ActivityDay\n",
       ":   0\n",
       "\n"
      ],
      "text/plain": [
       "                      Id               TotalSteps LoggedActivitiesDistance \n",
       "                       0                        0                        0 \n",
       "      VeryActiveDistance ModeratelyActiveDistance      LightActiveDistance \n",
       "                       0                        0                        0 \n",
       " SedentaryActiveDistance        VeryActiveMinutes         SedentaryMinutes \n",
       "                       0                        0                        0 \n",
       "                Calories    Median_Hourly_Calorie        MedTotalIntensity \n",
       "                       0                        6                        6 \n",
       "       MedianMinCalories                AvgMinMet              ActivityDay \n",
       "                       6                        6                        0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "colSums(is.na(new_activity_merged_final))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 88,
   "id": "cc95fdbe",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:04.562436Z",
     "iopub.status.busy": "2023-07-13T02:42:04.561092Z",
     "iopub.status.idle": "2023-07-13T02:42:04.653898Z",
     "shell.execute_reply": "2023-07-13T02:42:04.652579Z"
    },
    "papermill": {
     "duration": 0.136088,
     "end_time": "2023-07-13T02:42:04.655716",
     "exception": false,
     "start_time": "2023-07-13T02:42:04.519628",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 3 × 5 of type dbl</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>MTI</th><th scope=col>MHC</th><th scope=col>MMC</th><th scope=col>AMM</th><th scope=col></th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>937</th><td>1</td><td>1</td><td>1</td><td>1</td><td> 0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0</td><td>0</td><td>0</td><td>0</td><td> 4</td></tr>\n",
       "\t<tr><th scope=row></th><td>6</td><td>6</td><td>6</td><td>6</td><td>24</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 3 × 5 of type dbl\n",
       "\\begin{tabular}{r|lllll}\n",
       "  & MTI & MHC & MMC & AMM & \\\\\n",
       "\\hline\n",
       "\t937 & 1 & 1 & 1 & 1 &  0\\\\\n",
       "\t6 & 0 & 0 & 0 & 0 &  4\\\\\n",
       "\t & 6 & 6 & 6 & 6 & 24\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 3 × 5 of type dbl\n",
       "\n",
       "| <!--/--> | MTI | MHC | MMC | AMM | <!----> |\n",
       "|---|---|---|---|---|---|\n",
       "| 937 | 1 | 1 | 1 | 1 |  0 |\n",
       "| 6 | 0 | 0 | 0 | 0 |  4 |\n",
       "| <!----> | 6 | 6 | 6 | 6 | 24 |\n",
       "\n"
      ],
      "text/plain": [
       "    MTI MHC MMC AMM   \n",
       "937 1   1   1   1    0\n",
       "6   0   0   0   0    4\n",
       "    6   6   6   6   24"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\ni+GTl75PsfcFRSLsyEbnXpesVln29K8eqXd85B9uyeXKL9lv9Uymiq1453zUpcdNr8l//893\nbdxyqXd35CrOuvioPfbY4/1Xpi3388ewHOf/Wz3EFpZVYeEp971fUt7hqh902/ni3VJKT/7y\nwaXvVex9QZEIO7JRUtbu8u1XmTry9PEL65Y4nD/znvfarvmbLVpXZDZZXMU753+75Z2U0nkH\nr/mlt659xDVDhw69fN+m/lNtOc7/t3qILSyjaaPPHDmnustWV3SvLO3c+9KVK0qnjjz93/Nr\n692t2PuCIhF2ZGb7S/rla2cOGPb5yxazJ1z+7MyFm/3+iAyniu3bnvP/vHjeQV/mxslzl7zb\nvVPnl1V2376tn1vfYDm+55f9IbawjJ7+5T0ppX6X755SKinrdNlWXfJ1c04ZOmHpexZ1X1Ak\nwo7MdNzkorWalz1z+gOLj7x+/s25kvJLXFQomm97zud+NOzeLzNiTvXndyrUfLCwrrSye7GH\nD2A5vueX9SG2sGzyNR+fPOyj8ubr/qnXp29D/MElu6WUXjjjr0vfuYj7gqIRdmQmV9rq8p27\nTR/1m3cWLHrZIn/W3eParnnW5q3KM54srm97zr/+t2I/e9LylctL6qo/XBFfwHfccnzPL+tD\nbGHZTH7+Fx8trOu+11WtSnOLjnTe/NKVK0pnvHP+C7Or6925iPuCohF2ZGm7i/vn6+YMePzD\nlNLsiVcMm7Fw89//T9ZDBVeMc75nh2a1C8Y/O6v+z8VFFs54Yv/99z/s2Jv+y88Sw3Kc/2V8\niC0si8GnPp5SGnffnov/vHlpRefJ1XWFQs2vBo1b+v7F2xcUibAjS+03vGCDFuXPn3FvSumN\nC27KlZRf2m+1rIcKrhjn/Pj+q6eUzv7bu1966+Rn//TAAw88897K/+VniWE5zv8yPsQWvlHt\n/LG/fn1aacUqx33RUYdukVJ67fdXL/2Q4u0LikTYkaVcSfM/77bq9LFnj5lXc/Zd77Vd65xe\nXrAosmKc814XXNGitORfpx3w8sylLhcVFp5/4vCU0p4XbvFffpYYluP8L+NDbOEbjX/w5Ll1\n+a47XXPjF91y+6OrVpbN+ejaB6ctqPeQ4u0LikTYkbGtLzy4UDf/xzf96qkZC3qff1jW4zQJ\nDX7OK9vtOuS3O9XMG7PTJv3ue+nzt3nVzvvw4h9tddOE2W3WOOLaLbv8958ohuU4/8vyEFv4\n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\nYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh\n7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCE\nHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISw\nAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2\nAABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIO\nACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgB\nAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsA\ngCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcA\nEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAA\nghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBA\nEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAI\nQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABB\nCDsAgCCEHQBAEMIOACAIYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAI\nYQcAEISwAwAIQtgBAAQh7AAAghB2AABBCDsAgCCEHQBAEMIOACAIYQcAEISwAwAI4v8BLiTd\nsClxINkAAAAASUVORK5CYII="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "null_cols <- new_activity_merged_final%>%\n",
    "select(\"MedTotalIntensity\",\"Median_Hourly_Calorie\",\"MedianMinCalories\",\"AvgMinMet\")%>%\n",
    "rename(\"MTI\" = \"MedTotalIntensity\",\n",
    "      \"MHC\" = \"Median_Hourly_Calorie\",\n",
    "      \"MMC\" = \"MedianMinCalories\",\n",
    "      \"AMM\" = \"AvgMinMet\")\n",
    "\n",
    "md.pattern(null_cols)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ca0ac686",
   "metadata": {
    "papermill": {
     "duration": 0.040317,
     "end_time": "2023-07-13T02:42:04.737042",
     "exception": false,
     "start_time": "2023-07-13T02:42:04.696725",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### Imputing Null Values in Different Columns"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 89,
   "id": "42434de9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:04.820559Z",
     "iopub.status.busy": "2023-07-13T02:42:04.819235Z",
     "iopub.status.idle": "2023-07-13T02:42:04.830478Z",
     "shell.execute_reply": "2023-07-13T02:42:04.829102Z"
    },
    "papermill": {
     "duration": 0.054731,
     "end_time": "2023-07-13T02:42:04.832231",
     "exception": false,
     "start_time": "2023-07-13T02:42:04.777500",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "imputer_func <- function(dataframe, column){\n",
    "    data_without_nulls <- dataframe[,colSums(is.na(dataframe))==0]\n",
    "    column_index <- which(colnames(dataframe)==column)\n",
    "    data_without_nulls <- cbind(data_without_nulls, dataframe[,column_index])\n",
    "    colnames(data_without_nulls)[ncol(data_without_nulls)] <- column\n",
    "    \n",
    "    ## Imputing the value based on different methods\n",
    "    value_imputed <- data.frame(original = data_without_nulls[,column],\n",
    "    imputed_zero = replace(data_without_nulls[,column],\n",
    "                           is.na(data_without_nulls[,column]),0),\n",
    "    #imputed_pmm = complete(mice(dataframe, method = \"pmm\"))$column,\n",
    "    imputed_cart = complete(mice(data_without_nulls, method = \"cart\"))[,column],\n",
    "    #imputed_lasso = complete(mice(dataframe, method = \"lasso.norm\"))$column,\n",
    "    imputed_missforest = missForest(data_without_nulls)$ximp[,column])\n",
    "    \n",
    "    return(value_imputed)\n",
    "    \n",
    "}"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 90,
   "id": "cd5e9c09",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:04.914542Z",
     "iopub.status.busy": "2023-07-13T02:42:04.913140Z",
     "iopub.status.idle": "2023-07-13T02:42:15.486878Z",
     "shell.execute_reply": "2023-07-13T02:42:15.484766Z"
    },
    "papermill": {
     "duration": 10.618106,
     "end_time": "2023-07-13T02:42:15.489790",
     "exception": false,
     "start_time": "2023-07-13T02:42:04.871684",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      " iter imp variable\n",
      "  1   1  MedTotalIntensity\n",
      "  1   2  MedTotalIntensity\n",
      "  1   3  MedTotalIntensity\n",
      "  1   4  MedTotalIntensity\n",
      "  1   5  MedTotalIntensity\n",
      "  2   1  MedTotalIntensity\n",
      "  2   2  MedTotalIntensity\n",
      "  2   3  MedTotalIntensity\n",
      "  2   4  MedTotalIntensity\n",
      "  2   5  MedTotalIntensity\n",
      "  3   1  MedTotalIntensity\n",
      "  3   2  MedTotalIntensity\n",
      "  3   3  MedTotalIntensity\n",
      "  3   4  MedTotalIntensity\n",
      "  3   5  MedTotalIntensity\n",
      "  4   1  MedTotalIntensity\n",
      "  4   2  MedTotalIntensity\n",
      "  4   3  MedTotalIntensity\n",
      "  4   4  MedTotalIntensity\n",
      "  4   5  MedTotalIntensity\n",
      "  5   1  MedTotalIntensity\n",
      "  5   2  MedTotalIntensity\n",
      "  5   3  MedTotalIntensity\n",
      "  5   4  MedTotalIntensity\n",
      "  5   5  MedTotalIntensity\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“Number of logged events: 25”\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n",
      "Warning message:\n",
      "“\u001b[1m\u001b[22mRemoved 6 rows containing non-finite values (`stat_bin()`).”\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      " iter imp variable\n",
      "  1   1  Median_Hourly_Calorie\n",
      "  1   2  Median_Hourly_Calorie\n",
      "  1   3  Median_Hourly_Calorie\n",
      "  1   4  Median_Hourly_Calorie\n",
      "  1   5  Median_Hourly_Calorie\n",
      "  2   1  Median_Hourly_Calorie\n",
      "  2   2  Median_Hourly_Calorie\n",
      "  2   3  Median_Hourly_Calorie\n",
      "  2   4  Median_Hourly_Calorie\n",
      "  2   5  Median_Hourly_Calorie\n",
      "  3   1  Median_Hourly_Calorie\n",
      "  3   2  Median_Hourly_Calorie\n",
      "  3   3  Median_Hourly_Calorie\n",
      "  3   4  Median_Hourly_Calorie\n",
      "  3   5  Median_Hourly_Calorie\n",
      "  4   1  Median_Hourly_Calorie\n",
      "  4   2  Median_Hourly_Calorie\n",
      "  4   3  Median_Hourly_Calorie\n",
      "  4   4  Median_Hourly_Calorie\n",
      "  4   5  Median_Hourly_Calorie\n",
      "  5   1  Median_Hourly_Calorie\n",
      "  5   2  Median_Hourly_Calorie\n",
      "  5   3  Median_Hourly_Calorie\n",
      "  5   4  Median_Hourly_Calorie\n",
      "  5   5  Median_Hourly_Calorie\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“Number of logged events: 25”\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n",
      "Warning message:\n",
      "“\u001b[1m\u001b[22mRemoved 6 rows containing non-finite values (`stat_bin()`).”\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      " iter imp variable\n",
      "  1   1  MedianMinCalories\n",
      "  1   2  MedianMinCalories\n",
      "  1   3  MedianMinCalories\n",
      "  1   4  MedianMinCalories\n",
      "  1   5  MedianMinCalories\n",
      "  2   1  MedianMinCalories\n",
      "  2   2  MedianMinCalories\n",
      "  2   3  MedianMinCalories\n",
      "  2   4  MedianMinCalories\n",
      "  2   5  MedianMinCalories\n",
      "  3   1  MedianMinCalories\n",
      "  3   2  MedianMinCalories\n",
      "  3   3  MedianMinCalories\n",
      "  3   4  MedianMinCalories\n",
      "  3   5  MedianMinCalories\n",
      "  4   1  MedianMinCalories\n",
      "  4   2  MedianMinCalories\n",
      "  4   3  MedianMinCalories\n",
      "  4   4  MedianMinCalories\n",
      "  4   5  MedianMinCalories\n",
      "  5   1  MedianMinCalories\n",
      "  5   2  MedianMinCalories\n",
      "  5   3  MedianMinCalories\n",
      "  5   4  MedianMinCalories\n",
      "  5   5  MedianMinCalories\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“Number of logged events: 25”\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n",
      "Warning message:\n",
      "“\u001b[1m\u001b[22mRemoved 6 rows containing non-finite values (`stat_bin()`).”\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n"
     ]
    },
    {
     "data": {
      "image/png": "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\nEd2LTPcPLzrFrlIPowu/DA7kXvxVRIzB19idW5GP0sGhs+lTveiPK7JVVxHJPHnAmV1cJch1\njpHrrLnu0hvM+bd/p1FpZkvtm1/9fHTLCh6Bgr9i5z9xB+HZpTPZKVECS7uH984SssfFg+XP\nHk4eHFf9iOxyPidr7ckTVmOfbPL+pN/Hbz3z0Y01Dy2eJSK9Xu1UfDFVzRMRg3+98U/eZ3c7\nNW6oqljPy+yNGxBZtlvES7zxWtErImLJLfHCUdIfi9t2GXUkPS8q7tqb2rW98Y6BDRs1bd5g\nY9sbZpclgEK7c5Izh8j5LQfX7f39wTO/ffvZl+u+27T51982fbX9p7VzXprQe9KnX7xShhPZ\n/jPaTrznm/+8vPP5JTfufGm+iHR+c6iD5e8fOizDfOXwNosOEhFRDM/Fho/elzR/+d9DnmlR\n0rqq+eLU38+JyO2D6xecbij5RlrVki0iSrEvjaI4dcbm+DC69svgwImvfxKRsIYP2J1bkY/S\nwaGzUYodA0VnEhFF53DcL/WqGzyFXOcAue5SrhMRkQUDbvzuXJZ/RKcf14y3G32ZjkDhX7Gz\nn7iD8Fyo2HnNpeyhWhzemuowezh5cFz3I7LD+ZyszcIu7qFJMqnfTxO/lS1D3553QG+q+eo1\nUcUXM/jHVjXqky2Zr7z6akk/09S/m4l8e27L7yJF0+X3Dh/6VoQp5Aa9omSnfGMWKfLf+5GN\nZ0SkVvMSTwFH3/bkkfS8pz76bfbAK9elLx7d5vzey82ZQ1Q2iun6WwZef8tAETFnnf3h08UP\nPDRl7Wt9P3oq4/6qzo7VGXPrm/66DUc/f97y/g/jVh7RG6u8c3NtB8u/s/h9u9Pveqv36J7L\ndr784JHHtzbwt1917X3vvl3puQFRt0+pX7zlwj5T8HUikp36o8jUgtOzL/zk5BYc8NSXwTJ7\nxh4Raf/89SUu4oqPsiRfns1qH1LoskTK3p9EJKxZfAlriIjkZSVUcL8+h1znKtrOdfuX3D/2\ni2OKLmDWz1+UNLpTuY+A8594SeG51tozmV3DCo3OnbrvJxEJiil/9nDy4ATXc82PyJ4y5GQN\nNsWKSEDUPfdXCzz3x4TjZ9e/fzqj2vVvRBa/RiwiinFi43Bz7tnJ284WnmEZ0zK2Zs2aXyRl\nh9R+KtKoS/37ue+SCn0qyX+9sqksT9fW+8cOqR6Yn3V44tZCzznOzzr09B/nFZ1pXGP77VOq\n+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\nyYqq1NiWl7eCj42L91cu/J2Tfu7k4eQ1y15Zu3zhoJfWr3yiuycjqWrIdZVUpb6PHgumXuP4\nADu/51SRn3mq1OdSLlUoclUTUg7cKyKKzk9Eeq/5u9RpvhkYJyIGnSIi36blVn6lrzYOF5Ev\nzuWU7Mo594WI6I11KrDY/MxfRSS0/tPlmmv3S1eJSPe1f9tanm8YJiK3Jp30wNpd5ezOz5Yv\nX77xZLbHginIPnBteICINLh+1PrtyRdazdl7Nn3Qr1WkiIQ1Hplrcc26nH87Ffvs3Mrln4WD\nr4+VNUH9mplftDHz+L7Fk+82KIqI3Pfx30W7im08WkWuI9dVTKBOEZGf0vPctwqXcHIoNJ8k\ny8yQDlSRGt01whpN0SvKjmn/LaVPLZy6/oh/aKce4f4ejwvOimrfZ/jw4T1rBXpsje/e2evH\ntNx6Nz97YNPbvTvEX2jVBbbqfs9HP+/qFuZ//tA7D2j96J4PCapzxdjE1dsW9ROR94bdeqrI\nsXLPbzxeRK7zddVqc4WHaaqwM4Z0nFQ/JPXg08k5hcW60v995ZeM/Pp3vKAXpdR5qx9LVm7x\nUaryS3ax3HPrxn51VG+ss+7jJ0sentD7x857pLmIfDlxY6VWo+addt25eqo5OyffXIEZLfm5\nPnUKjSNXjv1waK2ggux9Y78+6u1YvINcVx7kOjdzaYqrPJKkpgo7ERk5rbXFnD1pc/GfWP73\n/LsiMuiZdqXOdXjr+yP6Xh9TM8LfFN6k1dXjnn3zz+zLvq6WgtNvPf3g1U1jg/39o+s2vnP0\ntP+l5VcoQMv3/3nx9uta1wgPNgaFNWrZedwzbx3Pu7QJrroi2hjcXkTS/31OUZSoZu9Y21Xz\n+ffnTurRoXlUWJCfMbBGbNPegx/+6sD5cq07+d3rFEW5Lzn1lxXTWtYLDw40+PkHNWrddfqS\njY7XXuYQlblkm3O/f/HwoJvj60T5G4xhUfW63jZy1faTtt5dz15pO6G41GD+WXOLoigNb/+i\n2GL3L75WUZSEUZvLNyBvP1egqjE9FrUNMpQ6QcvJb69du/bt2VfYWpz5IA4suVZRlAl/pWUe\nXn9P1+bBRtOK09kOxrbsOK3De/D00il31gwOM/n7BUfU7NpvzI6zuSLm9QsndbqifrC/ITS6\nQe8RTxX9T/9QTIghMK4gY+9jd3QKMwUZ9H4RtWJvGjRhU3J60eVvG9tcUZS79l92RYJqPq8o\n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\nHTx288KP1jTw11tbVt1/z5dRk5cntre+3LdvX2Zmpohs2LDh5ZdfLigoyMtz6jEm/fr1W7t2\nbZnPGLA3QWV6mZ3ZHcxe6oy+wt0P7ejbt++aNWsquZCqyd25rsyHR9mboDK9zM7sDmYvdUZf\nUcmnsZXJZblOrXrS/prVp0+fjEKLrWXjmHsHj/vR9nLUqFFXXpSQkGA0Gp1cct++fV0wZAA8\nqG/fvi5OMVUGuQ6AjatyXVU8FKszBopIaqElWH9hLzalwKwPN1Z+yR07dnQ8gePfSyvTy+zM\nzuzlnd2qzK+t7yLXMTuzM7uNq3JdVSzsDEGtRLYczCmMvXh4IjmnMKxLuG2Cl156KT8/X0RW\nr149depURVGcXLJWz9QB4IvIdQBcripeVh8QfkNdo/6rraetLwuydu3IyG/fs7Ztgho1asTE\nxMTExISGhhYU+Pb5SQCqLXIdAJerioWdKMZJ/RP+XD7zm50HTxz6fdmMuaY6PYbVC/Z2WADg\nUuQ6AK5WFQ/Fikj8wNnj8uavmjcjJVeJa9Nt9qzRVbICBYBKIdcBcK0qWtiJou81fGKv4d4O\nAwDcilwHwKXYOQQAANAICjsAAACNoLADAADQCAo7AAAAjaCwAwAA0AgKOwAAAI2gsAMAANCI\nqnofu/Iwm82JiYnejgKAl4WHhz/44IPejsKNyHUApMxcp/qy9evXd+jQocJDYzQaQ0NDQ0JC\nKrwElCowMDA0NNRkMnk7EK0JDg4ODQ319/f3diBVVOPGjb2dk9yFXFc1kevchFznmONc59u/\n2PXu3bt27do9evSo2OyhoaHR0dGqqv7999+uDayaq1mzZnBwcHZ29smTJ70di6bUr1/fz88v\nNTU1NTXV27FURWFhYd4OwV3IdVUTuc5NyHWOOc51iqqqHgulqvnoo48SExNNJtOWLVu8HYum\nTJs27auvvurcufOCBQu8HYum3HrrradOnRo3btyoUapF+44AAA/ISURBVKO8HQt8CbnOTch1\nbkKuqwwungAAANAICjsAAACNqNaHYo8ePXrgwAG9Xn/DDTd4OxZN+f3330+ePBkVFdWuXTtv\nx6IpW7duzc3NjYuLa9SokbdjgS8h17kJuc5NyHWVUa0LOwAAAC3hUCwAAIBGUNgBAABohG/f\nx65yLJtXLV635dcjGfqElh1GPDSysak6j4YLLB87PGDWm/fUCCzSxiBXnFqYuuatJRt+2p2S\n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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      " iter imp variable\n",
      "  1   1  AvgMinMet\n",
      "  1   2  AvgMinMet\n",
      "  1   3  AvgMinMet\n",
      "  1   4  AvgMinMet\n",
      "  1   5  AvgMinMet\n",
      "  2   1  AvgMinMet\n",
      "  2   2  AvgMinMet\n",
      "  2   3  AvgMinMet\n",
      "  2   4  AvgMinMet\n",
      "  2   5  AvgMinMet\n",
      "  3   1  AvgMinMet\n",
      "  3   2  AvgMinMet\n",
      "  3   3  AvgMinMet\n",
      "  3   4  AvgMinMet\n",
      "  3   5  AvgMinMet\n",
      "  4   1  AvgMinMet\n",
      "  4   2  AvgMinMet\n",
      "  4   3  AvgMinMet\n",
      "  4   4  AvgMinMet\n",
      "  4   5  AvgMinMet\n",
      "  5   1  AvgMinMet\n",
      "  5   2  AvgMinMet\n",
      "  5   3  AvgMinMet\n",
      "  5   4  AvgMinMet\n",
      "  5   5  AvgMinMet\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“Number of logged events: 25”\n",
      "Warning message in randomForest.default(x = obsX, y = obsY, ntree = ntree, mtry = mtry, :\n",
      "“The response has five or fewer unique values.  Are you sure you want to do regression?”\n",
      "Warning message in randomForest.default(x = obsX, y = obsY, ntree = ntree, mtry = mtry, :\n",
      "“The response has five or fewer unique values.  Are you sure you want to do regression?”\n",
      "Warning message in randomForest.default(x = obsX, y = obsY, ntree = ntree, mtry = mtry, :\n",
      "“The response has five or fewer unique values.  Are you sure you want to do regression?”\n",
      "Warning message in randomForest.default(x = obsX, y = obsY, ntree = ntree, mtry = mtry, :\n",
      "“The response has five or fewer unique values.  Are you sure you want to do regression?”\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n",
      "Warning message:\n",
      "“\u001b[1m\u001b[22mRemoved 6 rows containing non-finite values (`stat_bin()`).”\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n",
      "\u001b[1m\u001b[22m`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.\n"
     ]
    },
    {
     "data": {
      "image/png": "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\n/go34fOPwKbC77Jf81wadGW/HTt4LL9tW0c7v0l0k0P9Wjt6r/O5vn27Rzs2b/fTt0tFHd63\n3cbGXenOZ4WdLqS9yIa9BcWxgecyWmpBcUT3yJIFmjVr9tlnn9n+7tu3b1ZWlusrV/PV1gDU\nosI0+MorrxiNRhFZtWrVxIkTFUVxcc3kQKDG8tlt9UGR1zfUa9f9esr20pS3bVOO8fLeDUoW\n0Ov1MedZrVaz2eyjSAHAIypMg3Xr1rXlwPDw8MpeYAegZvLdeEmKfvzdCfvfnfb95r1pB3a8\nPWWOIbrX4EahPosHALyMNAjA3Xw5QHGLe2eOKpq/ct6U9EIlrmPPmdNHMCwngBqFNAjAvXz6\n7BpF22fIuD5DfBkCAPgSaRCAW/HjEAAAQCUo7AAAAFSCwg4AAEAlKOwAAABUgsIOAABAJSjs\nAAAAVILCDgAAQCV8Oo5dJf3xxx9JSUm+jgJANRUZGfnYY4/5OgoPMpvN5EAAFeQ6qz947LHH\noqOjvbjT3ECj0YSHh4eHh2u1Wl/H4n6hoaHh4eGBgYG+DsT9AgMDw8PDQ0JCfB2I+2m1Wluf\n1GhUeKg+LCysVatWJ0+e9HW68oi1a9d27ty5yjtHr9eHh4eHhYW5cYf7I9u3OzS0pj+0LSgo\nKDw83GAw+DoQHzMYDOHh4cHBwb4OpNKaN2/uJF34xxG7JUuWaDSalStX+jqQStDpdLGxsSJy\n7NixoqIiX4fjZrGxsTqdLjMzMzMz09exuFnt2rUjIiKMRuPRo0d9HYubBQcH234gHT58uLi4\n2NfhuFnTpk01Gs369evvueceX8fifrfcckuDBg169epVtbeHh4fXqVPHarUePHjQvYH5l6io\nqKioKJPJdOTIEV/H4kt169YNCwsrKChIS0vzdSy+FB0dHRwcnJube+rUKV/HUjkRERFO5vpH\nYSciixcvXrx4sa+jqITDhw/fddddIvLtt9+2b9/e1+G42YABAw4dOjRu3LhRo0b5OhY3e+21\n15YvX962bdvt27f7OhY327Jly6OPPioif/31l98dAq/Qtddem5+f7+soPKhTp04ZGRlVe+9H\nH32UlJQUEhJS5TWowxtvvPHWW2/FxcX99ddfvo7Fl6ZPn/7555/3GsPiIgAAIABJREFU6NFj\nyZIlvo7Fl5544omNGzcOHDhwxowZvo7FnVR4RgYAAKBmorADAABQCcVqtfo6BnXKz8///fff\nReSqq65yfjrcH/3+++/5+fnNmjWLi4vzdSxulpqaeujQodDQ0C5duvg6FjfLzMzcvHmziHTv\n3j0oKMjX4bjZTz/9ZDabW7VqZbu2FaUdPXp0z549Wq32+uuv93UsvvTPP/8cPHjQYDB069bN\n17H40q5du44fP16rVq3LL7/c17H40tatW9PT0xs0aNCuXTtfx+JOFHYAAAAqwalYAAAAlaCw\nAwAAUAm/Ge7ELxz87eMVa3/ftfdYRKPWA4Y/1btdlIiIWNavXPzFhi1HcrQJ7ToPfeLh5gY/\n2+3morQP33jzt+17T+VKi449hj/1SHyo7vxMP27du48PCZq+5L66F0antBZnfvrm0q9//yu9\nUBMdG3/HoJE3dWogIv7YzDKtO7lx0oiX/y69wLB3VverHaSCplmLM794Z8nXG3eeLtA2iWs3\n8LFRXWJLxpe+0LrVy9/0VcC+5n8fsVs47vNSc/ZJ+SznuO1q3icu50NRwX7ws3CrszOb3x47\n68ubHx41eXD0vvXvvT71mYbL32xjCDjwyeR5qw49NHrMsKjir5YumvS0ccXS0f50pNRqXvLM\nuF9MCY+Peq6BLn/dB4smjz27/M1EvSIi4rets6b+8tanx7MGXnyN6bcvjV+xK3zoo08mNAzZ\n/sOHi6eNLnj9vX6xof7WTDuty9qWFVy771Mj2pZMaRKmE//7BO007YeXxr+3K2rEU+Obh5nX\nr349adzEpSteq6fTyMWt813MPuZvH7HbOOrzUlP2if0s56jt6t0nlciHoo794J3n4dQELzww\nYMybO86/Ms+bOnnZ3xlWS9Hogf2eXrXfNrUw85e+ffu+fzTXV0FWQe7xd/r27bs+o8D2srjo\n2JC77py/N9Nqtfpp607+Pm/o/QP69u3bt2/f5SfzSqYXFx7ud8cd83ZknJ9gWTh44JCJG/2r\nmY5at2HMQ4/O2lF2af9vmsVSePedd0zeeO5JYsUF+/r27TvrwFmrtWzraii/+ojdy36ft9aI\nfeIoDzhsu0r3SeXyoVUlfcPPytBqy5iz8c8c420DSsb+0IydNuORdlFFZzccLjT36RNjmxoY\n2b1TqH7z+hO+irMKcg+mKprgnlHnRsfQ6ht2Cw/cs/a4iPhp6yLbDpw0/ZXZSYllppsL/23S\nrNmtzcPPT1A6RQSasnL9q5mOWrctuyiqU6S5IPvEqayS362qaJrVYhVt4PlUpglRFMVitUq5\n1tVM/vURu5fdPi81Y584ygOO2q7WfVKpfChq6RucinUPY/YfIlJ/51eJH375z4mC+k3ibh/8\nxC2XNTDmbReRNoaSK9KktSHgm+1n5UGfhVpZQQ3qWi1//5ljvDJMLyJWc9bWHGPO/rMi4qet\n04fHtAgXs7HsQG76iB7z5/coeWnK3fP28dwmD7cy5n0k/tNMR63bmmuy/rrgnoV7TFZrQEjd\nmx546rG+HfzrE7TbNEUJeur62IVzF258bkizMMvPq2brw9s9Ehsm9vpnDeRfH7F72e3zUjP2\niaM84KjtxuvUuU8qlQ9FLX2Dws49zEXZIjJr8S/3PPr4sPqBu39evWTq40WvL7/elCcitQMu\nHBmto9MW5xb6LNDKC28yvEP4r/OeX/DEw7fX0uT+9MmS9GKLzmIUEUuR37fOkUN/rl3w2tum\n5rdMurlR8SG/b6bZeCxXq2tap1vSiumR1pyUtW+/+ubkwPj3++v9vmki0vWRsZ8nJ748cayI\nKIpmwPPT6ug0Yq9/1kAq/pI656jPD02IrLH7RBz3hxq1T1TfNyjs3EMToBWR66ZM7Z8QJSKt\nWnc8vvGeNYt39BodLCKZxZZQrda2ZLrJrI3U+zDUylK0oc8vnPbfhcuXzpqcZ43oeufw+44t\n+MwQIiIavd+3rjxj5t63Fy74emtGz7sff/GBG4IUJcf/m6nVx6xevfr8q8Ae907Y983mH5ft\nGDDW75tmNqZNGjmxqNuDbzzYp57Bsuu3z2a8OEb38rL7EyLL988aSJVfUlc46vNDZ3evsftE\nHPeHGrVPVN83avRvWTcKMMSLSLfGoSVTukQbis4c14W0F5G9BRfuyEstKI5oF+n9CC9FYFS7\nJ6YkvbPi49UfvPX0vV135JuirqglIupoXWk5h34Y8+jEv6TjrDffeebBXkGKImpspoh0qh9s\nyj6tgqZl/P3G3jzNS6P7x9QO0wVHdOw9eFTj4C8XbhJ7H1wNpIKP2F1sfV5q9j5x1PaavE9E\ndX2Dws49gqJuigrQ/Lgv+9xrq3n9sfywuLigyOsb6rXrfj1lm2zK27Ypx3h57wY+C7TyLMYT\n06ZN+yHz3LHogjPr/swx9urTUERU0LrSrJb8FxMXB/Z6cvGUR1vVuXBNhgqambVv0SPDR58w\nWs5PsPx8PD+yTUsVNE0bGChW01lzSdMko7BYGxgo5T64mkkFH3HVOOrzUoP3iThue43aJ6rv\nGxR27qFowxL7xa9/aeqaX/7cv3f7RwsSN+Tqho5MEEU//u6E/e9O+37z3rQDO96eMscQ3Wtw\no9CK11htaPQNmmbtXzZp4aadqdtTfnpx3LK6Vw7va6t7/L91peWfWrEr33RDe8PmPy/YtjNL\nBc0Mb35v7fyTidOW/rFjb+rObSvnT9iQF/bo8JYqaFpkwmMJodr/TF64cduu/Xv+/uLtmctP\nGO8Y00mkbP/0daQ+4v8fcdU47PNSc/eJiOO216R9ovq+oVgvHroQVWctXrd8wSffbUo36pvE\ntb59yKgbWkWIiFjN370/f9V3m9ILlbiOPUc+M6JFiJ9d2mguPPDOvCUb/vrHqIu6/No7Rg7r\nG65Vzs3z29aZjUf73z3qnmUrH6pnsE058eukR2f9XWax8Nj//G9RF79rZvnWFWXufGfJit/+\nSi3UhjWPb9dv2KNdbVcO+H/TjFl73ln6vy17DqYXaBs1adHn3kdvu/z8L+xSrfv045U+C9q3\n/O0jdheHfV5qyj4p/2URcdx29e6TSuRDUcN+oLADAABQCU7FAgAAqASFHQAAgEpQ2AEAAKgE\nhR0AAIBKUNgBAACoBIUdAACASlDYAQAAqASFHaqjKU0iwqJHeGJh5+bFRRlq3+6WVQHwL27M\nJN6XfWiyoigP7s3wdSDwPQo7VEeagABtgKuds1ILA4BdPswkp1Im9+3b9/f/Z+++45uo/weO\nvy9p0jbdi9myC2UPBQuCKENErYIIishSUERUFKQoCIizOFAUxK9bfihuXDhRRIQWQRCZVpFd\nVil0N01yvz8CpdA0TUuTNNfX8+Efzd3n7t6f3PH2nRufyzZ7ZevQGP53iJpozr+ZJ/e/6o7G\nAOCQFzNJ/uF1X3311eFiq1e2Do2hsEPNYrOcrKbcphYW26pnTQBqM9VcZHH13Zuq1WytHe/p\nrL5cjWpGYQdPOJL24YiB3WPCg41BYS279pv79qrSc99qFRXRfH7RyfW3Xt4m2D8y16o+2TS8\n9M0uGWveuenqy2LDTTGxbSc+u2LP530VRTl8pm4r3XhZ6+iwxrMyfl7UpXFEoFEfFNXwkqtG\n/3ggr2RVO75YOOjyLtFhQX7GwPrNO4yetuCEyykbgIadl3bsyeT3/z0QGxYcaNSH12l268Pv\n2kQ2vJ3cuUndQP/gpm0umfP+dntjk17XY/GfL993bXSQyaA3xsS1HTVt4fFSvy2nxYWGxk0r\nvbnNj16kKMqeIuuTTcObDvpJRIZEm0ra5O5dPfnmAY1iwv2DIhM693n01RXn/U79fdnT/S5u\nERJgjKoff/N9Lxw1u/o7VrWeUhwZsiOzwk2XzdVSUXqH5/l5OwBo37ENz7bsmVzg3+KW0Xc3\nCyn49fMls8de8eu/q354rHdJG5vlxOhOV2X2GvnkgnsDdUrpxU9seTHhigesdXuMmZDsn5W+\n5OHrVrQNdbI5c/aargNXNxs2cX6PhONbvp336pLruxzPPvq1XmT/13e3G/RKaKve4+5JjjRa\ntv/26bvP3LfuUPO//+8ad3UegM/KP7q056SsEZMfuSTO/4tFTy19avSu3W9sW5n/wAMzR1n/\ne/GJl+aOvLjfNSd7hhpFZMfLA+/dfqz/0NHd4sO3rP54yTOTfli378CvKfqKtjL8nU9jV04Z\nPXfzzA+/uLxOKxHJO7S8U+th+5SGI8aObxGt/3PVR3MmXLN87Vub3hljX2TLwpu7TfogIKrz\n8PFToi0HPn9jWrdfGrvYKUVnevvtt0tP+b9pE1cet/YLD3Bl0+flalfSOzxNBdzLNqyOyWBq\nvTojz/7ZWnxsSudoRRew+lSRfcqbLSMVRRnw0saSZZ5oEhZcb5z977ENg/1DL9mZV2z/eGzD\ny4qiiEiG2Vq28fsJUSJyyZxVJav6bFgzEfk+q1BV1XfaRvsFNNpbaCmZe3/DkMCopJKPzzcL\nD4y8plq7D8A3lM4k6plkMnXlQfvHgsyvRETv32BNVqF9yj/v9RGRYduOq6pq/zl670c7Ti9s\nK35zQjsRGbPq9OIPxoaExD5YenOb5nQRkf8KLaqq/re8j4h8cjzfPmtO2yiDqfXa4wUljT97\noJOIPP7vSVVVLQXpdYx6U92krdlm+9zcAytbmQwicsvOzMr2ev38QSIy6IXfXdl0mVxdcXqH\n53EpFu5VcPzTD4/mtxr/Vq96JvsUnV/0jPfGqLbC2d8dONtO8X/3zk5lFy888eVbB3PbTH6l\nlen02eXoi+6e2SjEyRZ1etNnD/Uq+dhxWGMRybHaROTGNbuOHNreyP/0T2jVllekqqo1/0I6\nCECrDKaEZ/o0sP8dEHlNiF4X3e6FS8P97VNievQSkYIz11uD6o588caE00sqfiPnf2bS6757\naG1lN2rJ3/bY9hMJd73TPSqgZOLVs14UkQ9e+VtEjv3x0FGz9cp3FrYNMZzedMM+SyYmOFyb\n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\nO4QQQgihLuJ/WblfmRFSjTQAAAAASUVORK5CYII="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\n2X8kOUtaXNd1xHPDo4JUcpvNlaMH+01d/Egdf4e9toK0z5Yu+frXfSl52gaNo+4fOOquDio5\nP8b5wM9tnzjy9T+Ktgxbsa5PbT+3hFa1ylzjG1Ys/nr7n+dzdU2at+3/1NMxjQPdHKH3U5RV\nFE/mdcoel4q3LzvnW5l6V/0lToav+lVfSFVr1Lsc/3TS3LUnnxgzdlhYwVdLFk58wbR6yZji\ne1BtlsX/evFnc/Top1+qr8/59qOFk56/+MHSOIPGIyG7kC3x5/c+O5Pev/RTPL+bOW71wZAh\nTz4b3TBw/w8fL5oyJvftVX0aB7kzyipQ9sDT96b71+793Mg2hS1NglVQypc98B9mjlt1MGzk\nc+Migy1b1r0d/+KEJavfqqvnqEI5KMoqiifzOkrGpdLty67srUytq15Eyhy+qlf9VSjsPMRm\nmrP2UPNHZ/fv0VxEWszS9B80a/XpIQMjrtpFkX32g29PZb24any3MD8RaXFto98fffqdxPTn\nWho9E7YrJG+fF7dgW0qWyck0lvxTi3df6DZzdu82YSISFd0uaeeA9YsO9Hk9xl1hup6SgYtI\n8sEMY+vY2Ng2zifzIkoGbrPlL/n9QusJr98dU1dEmrd4+cuHX1z1T9b/NQtxV5jeT1lWUTqZ\n11E2LvVtX3aK0otaV72y4at11Zeklkrd2+Rf3Pp3nqVnzwj7S19jlw5Bht1bzhabLOtEokbr\nb6/qRERnaBgb4nt4o2uev+Qpxjb9J059Y3Z8nJNpLHl/NWnW7J7Iwv/UNR1Cfc3p3v04ICUD\nF5G9GflhHYyW3IyzyenquGRd2cBtVpvofC9nJG2gRqOxcs1+eSjMKgon8zoKx6W+7ctOyVam\n1lUvyoav1lVfEnvsPMOUvV9EWgdc2Q98bYDPN/svyuNXTeZXv47N+seuTNONwQYRsVnS92Sa\nMo9ddG+wLmYIiWgRIhaTszMbDKFd583rWvjSnHV4+ZmsJkNbVX10VUjJwEVkT5bZtm3+wwsO\nm202n8A6dz323FO927snwiqiZOAajd9ztzdeMGfB9pcGNwu2/rR2tiGk7fDGNfSh9RWjMKso\nnMzrKByX+rYvOyVbmVpXvSgbvlpXfUkUdp5hzc8Wkdo+V/aYhut1BVl5xSYLaTKifci2ua/M\nf2bofbW0WT9+ujilwKq3lnEsT2VO7to4/63l5sheE+9W/8P+LKbTWTp90/DY+NVTjbbMHRuX\n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\nSUVORK5CYII="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\nABrx//ew8ElnhOg8AAAAAElFTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "set.seed(101)\n",
    "null_cols <- new_activity_merged_final%>%\n",
    "select(\"MedTotalIntensity\",\"Median_Hourly_Calorie\",\"MedianMinCalories\",\"AvgMinMet\")\n",
    "\n",
    "for (col in colnames(null_cols)){\n",
    "    value_imputed <- imputer_func(subset(new_activity_merged_final, \n",
    "                        select = -ActivityDay),col)\n",
    "\n",
    "    h1 <- ggplot(value_imputed, aes(x = original))+\n",
    "    geom_histogram(fill = \"#ad1538\", color = \"#000000\", position = \"identity\")+\n",
    "    ggtitle(paste(col,\"-Original Distribution\"))+\n",
    "    theme_classic()\n",
    "\n",
    "\n",
    "    h2 <- ggplot(value_imputed, aes(x = imputed_zero))+\n",
    "    geom_histogram(fill = \"#15ad4f\", color = \"#000000\", position = \"identity\")+\n",
    "    ggtitle(paste(col, \"-Zero-Imputed Distribution\"))+\n",
    "    theme_classic()\n",
    "\n",
    "\n",
    "    h3 <- ggplot(value_imputed, aes(x = imputed_cart))+\n",
    "    geom_histogram(fill = \"#1543ad\", color = \"#000000\", position = \"identity\")+\n",
    "    ggtitle(paste(col,\"-Cart-Imputed Distribution\"))+\n",
    "    theme_classic()\n",
    "\n",
    "    h4 <- ggplot(value_imputed, aes(x = imputed_missforest))+\n",
    "    geom_histogram(fill = \"#ad8415\", color = \"#000000\", position = \"identity\")+\n",
    "    ggtitle(paste(col, \"-Forest Imputed\"))+\n",
    "    theme_classic()\n",
    "\n",
    "\n",
    "    print(plot_grid(h1,h2,h3,h4,nrow = 2, ncol = 2))\n",
    "    \n",
    "    }"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "9c818843",
   "metadata": {
    "papermill": {
     "duration": 0.044023,
     "end_time": "2023-07-13T02:42:15.578147",
     "exception": false,
     "start_time": "2023-07-13T02:42:15.534124",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "From the above plots, we have decided the method of imputation for each column as below:\n",
    "\n",
    "MedTotalIntensity : Cart\n",
    "\n",
    "MedianHourlyCalorie: Cart\n",
    "\n",
    "MedianMinCalorie: MissForest\n",
    "\n",
    "AverageMinMet: Cart"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 91,
   "id": "59aa7364",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:15.693113Z",
     "iopub.status.busy": "2023-07-13T02:42:15.691857Z",
     "iopub.status.idle": "2023-07-13T02:42:17.273145Z",
     "shell.execute_reply": "2023-07-13T02:42:17.271153Z"
    },
    "papermill": {
     "duration": 1.629737,
     "end_time": "2023-07-13T02:42:17.276179",
     "exception": false,
     "start_time": "2023-07-13T02:42:15.646442",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      " iter imp variable\n",
      "  1   1  MedTotalIntensity\n",
      "  1   2  MedTotalIntensity\n",
      "  1   3  MedTotalIntensity\n",
      "  1   4  MedTotalIntensity\n",
      "  1   5  MedTotalIntensity\n",
      "  1   6  MedTotalIntensity\n",
      "  1   7  MedTotalIntensity\n",
      "  1   8  MedTotalIntensity\n",
      "  1   9  MedTotalIntensity\n",
      "  1   10  MedTotalIntensity\n",
      "  2   1  MedTotalIntensity\n",
      "  2   2  MedTotalIntensity\n",
      "  2   3  MedTotalIntensity\n",
      "  2   4  MedTotalIntensity\n",
      "  2   5  MedTotalIntensity\n",
      "  2   6  MedTotalIntensity\n",
      "  2   7  MedTotalIntensity\n",
      "  2   8  MedTotalIntensity\n",
      "  2   9  MedTotalIntensity\n",
      "  2   10  MedTotalIntensity\n",
      "  3   1  MedTotalIntensity\n",
      "  3   2  MedTotalIntensity\n",
      "  3   3  MedTotalIntensity\n",
      "  3   4  MedTotalIntensity\n",
      "  3   5  MedTotalIntensity\n",
      "  3   6  MedTotalIntensity\n",
      "  3   7  MedTotalIntensity\n",
      "  3   8  MedTotalIntensity\n",
      "  3   9  MedTotalIntensity\n",
      "  3   10  MedTotalIntensity\n",
      "  4   1  MedTotalIntensity\n",
      "  4   2  MedTotalIntensity\n",
      "  4   3  MedTotalIntensity\n",
      "  4   4  MedTotalIntensity\n",
      "  4   5  MedTotalIntensity\n",
      "  4   6  MedTotalIntensity\n",
      "  4   7  MedTotalIntensity\n",
      "  4   8  MedTotalIntensity\n",
      "  4   9  MedTotalIntensity\n",
      "  4   10  MedTotalIntensity\n",
      "  5   1  MedTotalIntensity\n",
      "  5   2  MedTotalIntensity\n",
      "  5   3  MedTotalIntensity\n",
      "  5   4  MedTotalIntensity\n",
      "  5   5  MedTotalIntensity\n",
      "  5   6  MedTotalIntensity\n",
      "  5   7  MedTotalIntensity\n",
      "  5   8  MedTotalIntensity\n",
      "  5   9  MedTotalIntensity\n",
      "  5   10  MedTotalIntensity\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“Number of logged events: 50”\n"
     ]
    }
   ],
   "source": [
    "non_nulls <- new_activity_merged_final[,colSums(is.na(new_activity_merged_final))==0]\n",
    "non_nulls <- subset(non_nulls, select = -ActivityDay)\n",
    "non_null_mti <- cbind(non_nulls, new_activity_merged_final$MedTotalIntensity)\n",
    "colnames(non_null_mti)[ncol(non_null_mti)] <- \"MedTotalIntensity\"\n",
    "imputed_mti <- complete(mice(non_null_mti,m = 10, method = \"cart\"))\n",
    "new_activity_merged_final$MedTotalIntensity <- imputed_mti$MedTotalIntensity"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 92,
   "id": "f192779c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:17.369309Z",
     "iopub.status.busy": "2023-07-13T02:42:17.367879Z",
     "iopub.status.idle": "2023-07-13T02:42:19.681514Z",
     "shell.execute_reply": "2023-07-13T02:42:19.679565Z"
    },
    "papermill": {
     "duration": 2.361932,
     "end_time": "2023-07-13T02:42:19.683700",
     "exception": false,
     "start_time": "2023-07-13T02:42:17.321768",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      " iter imp variable\n",
      "  1   1  Median_Hourly_Calorie\n",
      "  1   2  Median_Hourly_Calorie\n",
      "  1   3  Median_Hourly_Calorie\n",
      "  1   4  Median_Hourly_Calorie\n",
      "  1   5  Median_Hourly_Calorie\n",
      "  1   6  Median_Hourly_Calorie\n",
      "  1   7  Median_Hourly_Calorie\n",
      "  1   8  Median_Hourly_Calorie\n",
      "  1   9  Median_Hourly_Calorie\n",
      "  1   10  Median_Hourly_Calorie\n",
      "  2   1  Median_Hourly_Calorie\n",
      "  2   2  Median_Hourly_Calorie\n",
      "  2   3  Median_Hourly_Calorie\n",
      "  2   4  Median_Hourly_Calorie\n",
      "  2   5  Median_Hourly_Calorie\n",
      "  2   6  Median_Hourly_Calorie\n",
      "  2   7  Median_Hourly_Calorie\n",
      "  2   8  Median_Hourly_Calorie\n",
      "  2   9  Median_Hourly_Calorie\n",
      "  2   10  Median_Hourly_Calorie\n",
      "  3   1  Median_Hourly_Calorie\n",
      "  3   2  Median_Hourly_Calorie\n",
      "  3   3  Median_Hourly_Calorie\n",
      "  3   4  Median_Hourly_Calorie\n",
      "  3   5  Median_Hourly_Calorie\n",
      "  3   6  Median_Hourly_Calorie\n",
      "  3   7  Median_Hourly_Calorie\n",
      "  3   8  Median_Hourly_Calorie\n",
      "  3   9  Median_Hourly_Calorie\n",
      "  3   10  Median_Hourly_Calorie\n",
      "  4   1  Median_Hourly_Calorie\n",
      "  4   2  Median_Hourly_Calorie\n",
      "  4   3  Median_Hourly_Calorie\n",
      "  4   4  Median_Hourly_Calorie\n",
      "  4   5  Median_Hourly_Calorie\n",
      "  4   6  Median_Hourly_Calorie\n",
      "  4   7  Median_Hourly_Calorie\n",
      "  4   8  Median_Hourly_Calorie\n",
      "  4   9  Median_Hourly_Calorie\n",
      "  4   10  Median_Hourly_Calorie\n",
      "  5   1  Median_Hourly_Calorie\n",
      "  5   2  Median_Hourly_Calorie\n",
      "  5   3  Median_Hourly_Calorie\n",
      "  5   4  Median_Hourly_Calorie\n",
      "  5   5  Median_Hourly_Calorie\n",
      "  5   6  Median_Hourly_Calorie\n",
      "  5   7  Median_Hourly_Calorie\n",
      "  5   8  Median_Hourly_Calorie\n",
      "  5   9  Median_Hourly_Calorie\n",
      "  5   10  Median_Hourly_Calorie\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“Number of logged events: 50”\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>Id</dt><dd>0</dd><dt>TotalSteps</dt><dd>0</dd><dt>LoggedActivitiesDistance</dt><dd>0</dd><dt>VeryActiveDistance</dt><dd>0</dd><dt>ModeratelyActiveDistance</dt><dd>0</dd><dt>LightActiveDistance</dt><dd>0</dd><dt>SedentaryActiveDistance</dt><dd>0</dd><dt>VeryActiveMinutes</dt><dd>0</dd><dt>SedentaryMinutes</dt><dd>0</dd><dt>Calories</dt><dd>0</dd><dt>Median_Hourly_Calorie</dt><dd>0</dd><dt>MedTotalIntensity</dt><dd>0</dd><dt>MedianMinCalories</dt><dd>6</dd><dt>AvgMinMet</dt><dd>6</dd><dt>ActivityDay</dt><dd>0</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[Id] 0\n",
       "\\item[TotalSteps] 0\n",
       "\\item[LoggedActivitiesDistance] 0\n",
       "\\item[VeryActiveDistance] 0\n",
       "\\item[ModeratelyActiveDistance] 0\n",
       "\\item[LightActiveDistance] 0\n",
       "\\item[SedentaryActiveDistance] 0\n",
       "\\item[VeryActiveMinutes] 0\n",
       "\\item[SedentaryMinutes] 0\n",
       "\\item[Calories] 0\n",
       "\\item[Median\\textbackslash{}\\_Hourly\\textbackslash{}\\_Calorie] 0\n",
       "\\item[MedTotalIntensity] 0\n",
       "\\item[MedianMinCalories] 6\n",
       "\\item[AvgMinMet] 6\n",
       "\\item[ActivityDay] 0\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "Id\n",
       ":   0TotalSteps\n",
       ":   0LoggedActivitiesDistance\n",
       ":   0VeryActiveDistance\n",
       ":   0ModeratelyActiveDistance\n",
       ":   0LightActiveDistance\n",
       ":   0SedentaryActiveDistance\n",
       ":   0VeryActiveMinutes\n",
       ":   0SedentaryMinutes\n",
       ":   0Calories\n",
       ":   0Median_Hourly_Calorie\n",
       ":   0MedTotalIntensity\n",
       ":   0MedianMinCalories\n",
       ":   6AvgMinMet\n",
       ":   6ActivityDay\n",
       ":   0\n",
       "\n"
      ],
      "text/plain": [
       "                      Id               TotalSteps LoggedActivitiesDistance \n",
       "                       0                        0                        0 \n",
       "      VeryActiveDistance ModeratelyActiveDistance      LightActiveDistance \n",
       "                       0                        0                        0 \n",
       " SedentaryActiveDistance        VeryActiveMinutes         SedentaryMinutes \n",
       "                       0                        0                        0 \n",
       "                Calories    Median_Hourly_Calorie        MedTotalIntensity \n",
       "                       0                        0                        0 \n",
       "       MedianMinCalories                AvgMinMet              ActivityDay \n",
       "                       6                        6                        0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "non_nulls <- new_activity_merged_final[,colSums(is.na(new_activity_merged_final))==0]\n",
    "non_nulls <- subset(non_nulls, select = -ActivityDay)\n",
    "non_null_mti <- cbind(non_nulls, new_activity_merged_final$Median_Hourly_Calorie)\n",
    "colnames(non_null_mti)[ncol(non_null_mti)] <- \"Median_Hourly_Calorie\"\n",
    "imputed_mti <- complete(mice(non_null_mti,m = 10, method = \"cart\"))\n",
    "new_activity_merged_final$Median_Hourly_Calorie <- imputed_mti$Median_Hourly_Calorie\n",
    "colSums(is.na(new_activity_merged_final))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 93,
   "id": "afb93514",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:19.792421Z",
     "iopub.status.busy": "2023-07-13T02:42:19.791135Z",
     "iopub.status.idle": "2023-07-13T02:42:20.671427Z",
     "shell.execute_reply": "2023-07-13T02:42:20.669973Z"
    },
    "papermill": {
     "duration": 0.929652,
     "end_time": "2023-07-13T02:42:20.673416",
     "exception": false,
     "start_time": "2023-07-13T02:42:19.743764",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>Id</dt><dd>0</dd><dt>TotalSteps</dt><dd>0</dd><dt>LoggedActivitiesDistance</dt><dd>0</dd><dt>VeryActiveDistance</dt><dd>0</dd><dt>ModeratelyActiveDistance</dt><dd>0</dd><dt>LightActiveDistance</dt><dd>0</dd><dt>SedentaryActiveDistance</dt><dd>0</dd><dt>VeryActiveMinutes</dt><dd>0</dd><dt>SedentaryMinutes</dt><dd>0</dd><dt>Calories</dt><dd>0</dd><dt>Median_Hourly_Calorie</dt><dd>0</dd><dt>MedTotalIntensity</dt><dd>0</dd><dt>MedianMinCalories</dt><dd>0</dd><dt>AvgMinMet</dt><dd>6</dd><dt>ActivityDay</dt><dd>0</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[Id] 0\n",
       "\\item[TotalSteps] 0\n",
       "\\item[LoggedActivitiesDistance] 0\n",
       "\\item[VeryActiveDistance] 0\n",
       "\\item[ModeratelyActiveDistance] 0\n",
       "\\item[LightActiveDistance] 0\n",
       "\\item[SedentaryActiveDistance] 0\n",
       "\\item[VeryActiveMinutes] 0\n",
       "\\item[SedentaryMinutes] 0\n",
       "\\item[Calories] 0\n",
       "\\item[Median\\textbackslash{}\\_Hourly\\textbackslash{}\\_Calorie] 0\n",
       "\\item[MedTotalIntensity] 0\n",
       "\\item[MedianMinCalories] 0\n",
       "\\item[AvgMinMet] 6\n",
       "\\item[ActivityDay] 0\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "Id\n",
       ":   0TotalSteps\n",
       ":   0LoggedActivitiesDistance\n",
       ":   0VeryActiveDistance\n",
       ":   0ModeratelyActiveDistance\n",
       ":   0LightActiveDistance\n",
       ":   0SedentaryActiveDistance\n",
       ":   0VeryActiveMinutes\n",
       ":   0SedentaryMinutes\n",
       ":   0Calories\n",
       ":   0Median_Hourly_Calorie\n",
       ":   0MedTotalIntensity\n",
       ":   0MedianMinCalories\n",
       ":   0AvgMinMet\n",
       ":   6ActivityDay\n",
       ":   0\n",
       "\n"
      ],
      "text/plain": [
       "                      Id               TotalSteps LoggedActivitiesDistance \n",
       "                       0                        0                        0 \n",
       "      VeryActiveDistance ModeratelyActiveDistance      LightActiveDistance \n",
       "                       0                        0                        0 \n",
       " SedentaryActiveDistance        VeryActiveMinutes         SedentaryMinutes \n",
       "                       0                        0                        0 \n",
       "                Calories    Median_Hourly_Calorie        MedTotalIntensity \n",
       "                       0                        0                        0 \n",
       "       MedianMinCalories                AvgMinMet              ActivityDay \n",
       "                       0                        6                        0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "non_nulls <- new_activity_merged_final[,colSums(is.na(new_activity_merged_final))==0]\n",
    "non_nulls <- subset(non_nulls, select = -ActivityDay)\n",
    "non_null_mti <- cbind(non_nulls, new_activity_merged_final$MedianMinCalories)\n",
    "colnames(non_null_mti)[ncol(non_null_mti)] <- \"MedianMinCalories\"\n",
    "imputed_mti <- missForest(non_null_mti)$ximp[,\"MedianMinCalories\"]\n",
    "new_activity_merged_final$MedianMinCalories <- imputed_mti\n",
    "colSums(is.na(new_activity_merged_final))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 94,
   "id": "e146738c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:20.767335Z",
     "iopub.status.busy": "2023-07-13T02:42:20.765808Z",
     "iopub.status.idle": "2023-07-13T02:42:23.235200Z",
     "shell.execute_reply": "2023-07-13T02:42:23.232367Z"
    },
    "papermill": {
     "duration": 2.518281,
     "end_time": "2023-07-13T02:42:23.237557",
     "exception": false,
     "start_time": "2023-07-13T02:42:20.719276",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      " iter imp variable\n",
      "  1   1  AvgMinMet\n",
      "  1   2  AvgMinMet\n",
      "  1   3  AvgMinMet\n",
      "  1   4  AvgMinMet\n",
      "  1   5  AvgMinMet\n",
      "  1   6  AvgMinMet\n",
      "  1   7  AvgMinMet\n",
      "  1   8  AvgMinMet\n",
      "  1   9  AvgMinMet\n",
      "  1   10  AvgMinMet\n",
      "  2   1  AvgMinMet\n",
      "  2   2  AvgMinMet\n",
      "  2   3  AvgMinMet\n",
      "  2   4  AvgMinMet\n",
      "  2   5  AvgMinMet\n",
      "  2   6  AvgMinMet\n",
      "  2   7  AvgMinMet\n",
      "  2   8  AvgMinMet\n",
      "  2   9  AvgMinMet\n",
      "  2   10  AvgMinMet\n",
      "  3   1  AvgMinMet\n",
      "  3   2  AvgMinMet\n",
      "  3   3  AvgMinMet\n",
      "  3   4  AvgMinMet\n",
      "  3   5  AvgMinMet\n",
      "  3   6  AvgMinMet\n",
      "  3   7  AvgMinMet\n",
      "  3   8  AvgMinMet\n",
      "  3   9  AvgMinMet\n",
      "  3   10  AvgMinMet\n",
      "  4   1  AvgMinMet\n",
      "  4   2  AvgMinMet\n",
      "  4   3  AvgMinMet\n",
      "  4   4  AvgMinMet\n",
      "  4   5  AvgMinMet\n",
      "  4   6  AvgMinMet\n",
      "  4   7  AvgMinMet\n",
      "  4   8  AvgMinMet\n",
      "  4   9  AvgMinMet\n",
      "  4   10  AvgMinMet\n",
      "  5   1  AvgMinMet\n",
      "  5   2  AvgMinMet\n",
      "  5   3  AvgMinMet\n",
      "  5   4  AvgMinMet\n",
      "  5   5  AvgMinMet\n",
      "  5   6  AvgMinMet\n",
      "  5   7  AvgMinMet\n",
      "  5   8  AvgMinMet\n",
      "  5   9  AvgMinMet\n",
      "  5   10  AvgMinMet\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Warning message:\n",
      "“Number of logged events: 50”\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>Id</dt><dd>0</dd><dt>TotalSteps</dt><dd>0</dd><dt>LoggedActivitiesDistance</dt><dd>0</dd><dt>VeryActiveDistance</dt><dd>0</dd><dt>ModeratelyActiveDistance</dt><dd>0</dd><dt>LightActiveDistance</dt><dd>0</dd><dt>SedentaryActiveDistance</dt><dd>0</dd><dt>VeryActiveMinutes</dt><dd>0</dd><dt>SedentaryMinutes</dt><dd>0</dd><dt>Calories</dt><dd>0</dd><dt>Median_Hourly_Calorie</dt><dd>0</dd><dt>MedTotalIntensity</dt><dd>0</dd><dt>MedianMinCalories</dt><dd>0</dd><dt>AvgMinMet</dt><dd>0</dd><dt>ActivityDay</dt><dd>0</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[Id] 0\n",
       "\\item[TotalSteps] 0\n",
       "\\item[LoggedActivitiesDistance] 0\n",
       "\\item[VeryActiveDistance] 0\n",
       "\\item[ModeratelyActiveDistance] 0\n",
       "\\item[LightActiveDistance] 0\n",
       "\\item[SedentaryActiveDistance] 0\n",
       "\\item[VeryActiveMinutes] 0\n",
       "\\item[SedentaryMinutes] 0\n",
       "\\item[Calories] 0\n",
       "\\item[Median\\textbackslash{}\\_Hourly\\textbackslash{}\\_Calorie] 0\n",
       "\\item[MedTotalIntensity] 0\n",
       "\\item[MedianMinCalories] 0\n",
       "\\item[AvgMinMet] 0\n",
       "\\item[ActivityDay] 0\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "Id\n",
       ":   0TotalSteps\n",
       ":   0LoggedActivitiesDistance\n",
       ":   0VeryActiveDistance\n",
       ":   0ModeratelyActiveDistance\n",
       ":   0LightActiveDistance\n",
       ":   0SedentaryActiveDistance\n",
       ":   0VeryActiveMinutes\n",
       ":   0SedentaryMinutes\n",
       ":   0Calories\n",
       ":   0Median_Hourly_Calorie\n",
       ":   0MedTotalIntensity\n",
       ":   0MedianMinCalories\n",
       ":   0AvgMinMet\n",
       ":   0ActivityDay\n",
       ":   0\n",
       "\n"
      ],
      "text/plain": [
       "                      Id               TotalSteps LoggedActivitiesDistance \n",
       "                       0                        0                        0 \n",
       "      VeryActiveDistance ModeratelyActiveDistance      LightActiveDistance \n",
       "                       0                        0                        0 \n",
       " SedentaryActiveDistance        VeryActiveMinutes         SedentaryMinutes \n",
       "                       0                        0                        0 \n",
       "                Calories    Median_Hourly_Calorie        MedTotalIntensity \n",
       "                       0                        0                        0 \n",
       "       MedianMinCalories                AvgMinMet              ActivityDay \n",
       "                       0                        0                        0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "non_nulls <- new_activity_merged_final[,colSums(is.na(new_activity_merged_final))==0]\n",
    "non_nulls <- subset(non_nulls, select = -ActivityDay)\n",
    "non_null_mti <- cbind(non_nulls, new_activity_merged_final$AvgMinMet)\n",
    "colnames(non_null_mti)[ncol(non_null_mti)] <- \"AvgMinMet\"\n",
    "imputed_mti <- complete(mice(non_null_mti,m = 10, method = \"cart\"))\n",
    "new_activity_merged_final$AvgMinMet <- imputed_mti$AvgMinMet\n",
    "colSums(is.na(new_activity_merged_final))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 95,
   "id": "52eff532",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-13T02:42:23.347318Z",
     "iopub.status.busy": "2023-07-13T02:42:23.346095Z",
     "iopub.status.idle": "2023-07-13T02:42:23.452983Z",
     "shell.execute_reply": "2023-07-13T02:42:23.450996Z"
    },
    "papermill": {
     "duration": 0.157312,
     "end_time": "2023-07-13T02:42:23.455617",
     "exception": false,
     "start_time": "2023-07-13T02:42:23.298305",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nOzdeVxU1f/H8c+dGYYBkU3EBRdEEXHJfZlc+UqpaLa4lKaVW5pmhSZqsmjGIpiQ\n5a6ppebyK78uYWpZloKVWn3TFHdyzcwFXJBl5vfHGCGaG+CFy+v5hw/m3HPP51xUfHvP3DOK\n1WoVAAAAlHw6tScAAACAwkGwAwAA0AiCHQAAgEYQ7AAAADTCoPYEgH9kZmbGxMT4+fnpdPyX\n4+GxWCx79uypX78+3/aHzGKxpKSkjBs3zmg0qj0XABpBsEMxEhsbGxERofYsgIdKp9OFhoaq\nPQsAGkGwQzHi6+srIsHBwWazWe25lCLcsVNLcnJyfHy87Y89ABQKgh2KEVuwMJvNvXr1Unsu\npcuzzz6r9hRKqfj4ePI0gELEDxQAAACNINgBAABoBMEOAABAIwh2AAAAGkGwAwAA0AiCHQAA\ngEYQ7AAAADSCYAcAAKARBDsAAACNINgBAABoBMEOAABAIwh2AAAAGkGwAwAA0AiCHQAAgEYQ\n7AAAADSCYAcAAKARBDsAAACNINgBAABoBMEOAABAIwh2AAAAGkGwAwAA0AiCHQAAgEYQ7AAA\nADSCYAcAAKARBDsAAACNINgBAABoBMEOAABAIwh2AAAAGkGwAwAA0AiCHQAAgEYQ7AAAADSC\nYAcAAKARBDsAAACNINgBAABoBMEOAABAIwh2AAAAGkGwAwAA0AiCHQAAgEYQ7AAAADSCYAcA\nAKARBDsAAACNINgBAABoBMEOAABAIwh2AAAAGmFQewIANCgzMzMmJsbPz0+n43+P/yopKSn3\nV9yBxWJJSUkZN26c0WhUey5AcUewA1D4YmNjIyIi1J5FyZCQkJCQkKD2LEoAnU4XGhqq9iyA\n4o5gB6Dw+fr6ikhwcLDZbFZ7LsVXdnb2+vXru3XrZjDwo/hOkpOT4+PjbX+oANwZP00AFD7b\nCqzZbO7Vq5facynW+vTpo/YUSob4+HiW9YF7wd8TAAAAjeCOHe5Pkb4pvujeS86brwEApQHB\nDvfnIbwpvujeS86brwEA2kaww/0p0jfFF917yXnzNQCgNCDY4f4U9Zvii+695Lz5GgCgefw7\nBwAAoBEEOwAAAI0g2AEAAGgEwQ4AAEAjCHYAAAAaQbADAADQCIIdAACARhDsAAAANIJgBwAA\noBEEOwAAAI0g2AEAAGgEwQ4AAEAjCHYAAAAaYVB7AgCAopWZmRkTE+Pn56fTlcj/zCclJeX+\nWhJZLJaUlJRx48YZjUa15wLtI9gBgMbFxsZGRESoPYuCSkhISEhIUHsWD06n04WGhqo9C2gf\nwQ4ANM7X11dEgoODzWaz2nN5ENnZ2evXr+/WrZvBUCL/zUpOTo6Pj7f9LgBFrUT+JQEA3Dvb\nCqzZbO7Vq5fac3lAffr0UXsKBRIfH19C18FR4vDnDAAAQCMIdgAAABpBsAMAANAIgh0AAIBG\nEOwAAAA0gqdiAQClzsPctPmhbbDMTsgQgh0AoBR6+Js2P7QNltkJuZQj2AEASp2HuWnzQ9tg\nmZ2QIQQ7QMNU/IRQFT/ck9Uo3IuHvGnzQ9tgmZ2QQbADNEv1TwhV8cM9WY0CUDoR7ADNUvET\nQlX8cE9WowCUZgQ7QLPU/YRQFT/ck9UoAKUWP/sAAAA0gmAHAACgESzFosQoyDOeBXxIkwct\nAQAlAsEOJUbBn/Es4EOaPGgJACjmCHYoMQryjGcBH9LkQUsAQIlAsEOJUcBnPAv4kCYPWgIA\nij/+oQIAANAIgh0AAIBGEOwAAAA0gmAHAACgETw8ARRrau3ex9Z9AFASEeyAYk3d3fvYug8A\nShaCHVCsqbV7H1v3AUBJRLADijUVd+9j676HqSBr7ndVwI/UuwOW7IHihmAHAOor+Jr7XRXw\nI/XugCV7oPgg2AGA+gqy5n5XBfxIvTtgyR4obgh2AKC+Aq6531UBP1LvDliyB4oV/jYCAABo\nBMEOAABAIwh2AAAAGkGwAwAA0AgengAA4OEpuj0Li27DQmHPwpKDYAcAwMNT1HsWFt2GhcKe\nhSUBwQ4AgIen6PYsLLoNC4U9C0sOgh0AAA9Pke5ZWHQbFgp7FpYQ/A4BAABoBMEOAABAIwh2\nAAAAGkGwAwAA0AiCHQAAgEYQ7AAAADSCYAcAAKARBDsAAACNINgBAABoBMEOAABAIwh2AAAA\nGkGwAwAA0AiCHQAAgEYQ7AAAADTCoPYEAOAmmZmZMTExfn5+Ot2D/M8zKSkp99f7ZbFYUlJS\nxo0bZzQaH+B0AFAdwQ5A8RIbGxsREVHAQRISEhISEh7sXJ1OFxoaWsAJAIAqCHYAihdfX18R\nCQ4ONpvND3B6dnb2+vXru3XrZjDc98+35OTk+Ph42wQAoCQi2AEoXmwrsGazuVevXg82Qp8+\nfR64enx8/IMtAQNAccDPLwAAAI0g2AEAAGgEwQ4AAEAjCHYAAAAawcMTAFCqFWTjwILsGihs\nHAgUAYIdAJRqBd84sCC7BgobBwKFimAHAKVaQTYOLMiugcLGgUARINgBQKlWwI0DC7JroLBx\n4MOl1rI7a+4PE8EOAIBSQd1ld9bcHw6CHQAApYJay+6suT9MBDsAAEoFFZfdWXN/aPguAwAA\naATBDgAAQCMIdgAAABpBsAMAANAIgh0AAIBGEOwAAAA0gmAHAACgEQQ7AAAAjSDYAQAAaATB\nDgAAQCMIdgAAABpBsAMAANAIgh0AAIBGEOwAAAA0gmAHAACgEQQ7AAAAjSDY4f44ODjk/kpp\nDZcuhZdMaUpTWmN1SykrcD+ys7M3btyYnZ1NaW2XLoWXTGlKU1pjdUsnxWq1qp0tAQAAUAhY\nigUAANAIgh0AAIBGEOwAAAA0gmAHAACgEQa1JwC1fK9K1eyT/1OlrojknDugVmnr2R1qlVY8\nW6lVWsWrzvphm1ql7Vq0Uau0ir/XpVDm+qlqlc46olZluazaD1ERkWrf8aznPeGOHQAAgEYQ\n7AAAADSCYAcAAKARBDsAAACNINgBAABoBMEOAABAIwh2AAAAGkGwAwAA0AiCHQAAgEYQ7AAA\nADSCYAcAAKARBDsAAACNINgBAIAS7K89oxRFqf/ajlsPXT27VFGUap1WF1HpzLTtBp1OUZTH\nPjlckHFGepV1qxlfwMlsMFdWFIVgBwAASjD3upH+jnaHl0y89dChhQki8sSUtkVU+sjycTlW\nq4jsDFtyXyee/iZywIAB57Ittpdl3MuVc3colCkR7AAAQAmm6BymdamacWHjnNNX8h2aN32/\nweQd06BcEZWePfkXg6lGXAOPS0cjd1/OuvcTL6UkLlq06HKO1fYy5tdjh34cVvD56PROBDsA\nAFCytYrqIyIzpv2WtzEzLWnm6SuV2r5bVq/c12g51y/eS7frFzdPP3m5UvtpvaNbWS1ZIWtT\n76tKkVDsCHYAAKBkc/WNaOJkPLTwnbyNxxPDLVZr1zzrsBf2rBvYvW0FNycHF89GbXvMWpeS\neyiqhmuFxuvTj6wJauTt6tX/17gWiqJ8fj4jt0PWlV9Mep3/0G25LYcWhlmt1u5T2lTqEGWn\nU3aF51+NPfjFrG6t67mWMTp7eD3+3Bs7zlzLreU/LElEapgMlc0bRCSkqrPtPXZL23npDWUO\nZ+TkDmLJOlPeaPBs/P5dL8GGYAcAAEo4xW7qU9Wv/bV20R9Xc9s+m/STwb5azCMetpcX98/3\na/L08u+v9X1l7NujB1ZJ2zriyXoDF/wTjLKu7gtsNtipTd+pcSNqDRwvIpGfHMk9mvrfUdct\n1tciGuW2vBe312CqEV2/nF2ZBmOqOV86ErUzz2rs8fWj6wWNSErzHjouatTAoP1rZnTw73Ds\neo6I9F/++Uej6ovI8k1bPp3ZMu91BMZ1suRcDdl+Jrfljx2jz2XldJ7e814uQUQUq9VakO8k\nHo7MzMyYmBg/Pz+d7r6zuMlkCgoK0uv1Nzd/X1hzuy/ZJ/+nSl0RyTl3QK3S1rO3eVbr4VA8\nW6lVWsWrzvph2907FQ27Fm3UKq3i73UplLl+qlqls47cvU8RuazaD1ERkWrf3SWupB2Lcakx\nvuFbO3+ObCoiORlHXZxqubVfcfyrnrYOI7xdPkxrvPfUVz4mvYiIJWN0kyrT9zucSE+tYKeL\nquE64dill9cem/NEdVv/5yuUWW8acSk11vZygo9rQnrHK39+anuZ8dcaB4+nqnZa/fsXT4nI\nvpmP1h2RHPDxwS39aomI1XKlhav7wfIvHNw/p7ydTkT+/HGSZ4uJ/1l68Ku+tURk/5zW/sOS\njmZke9vrRSSkqvM846QLh4Ot2eerOnlmN5x/5vuXbIUWmSsN+dnxz/RDrgblzpewwVy5284M\nQyF9w1G0YmNjIyIiHvj0zZs3BwYGFuJ8AAAoVpy9Q9q6TNw1L0YiV4nIHzvGXsmxPB/b3nY0\n89LWmalp5pmzbkQiEdGZxn4YOK3piviT6THeLiJicPCZ0a167oCjh9b+5J34Hy9HNneyy0zb\nNuVYWqPJ4blHU2ZPFpHuU278X67Gc+NkxJO7IxZLv8kikv57zM70zO6rI8r//Z638s3D5sws\nX8azzJ2vQjG4T3u0Yt/t485nv+Bu0FmyzozZ9We1J9e5GpR7uQQRIdiVDL6+viISHBxsNpvv\n91yTyRQQEFAEkwIAoPjQRffxaTP7/5b9ea1veYevJ2wz2FeZ0vDGOmzGhU0ikjy8rjI8/2kp\naTfWT+1dOhjyPGVRZ8Tr1skD3ko8vrm3z+Fl4ywik4f75R6Nnb5PUfRVti6fse3GOdVMhuNH\nY35ID2tR1nhx7w4R6VrPLe/0Xn7lltq3ExDXNafZ3PG//jWncfk/vn/zXFbOm7Gt7/EShGBX\nUthWYM1mc69evdSeCwAAxVHD0Fdk9mvvzkzpE1pj7K6zFR5d5pqb1HRGETHPXh1dxy3fWe7e\nzrYvFJ1j3nbHCi89UW749omfSe83Z0b+r2zV4C5uJtuhq38uW3b2qoiMf31kvtHGfpb69Yu+\nlkyLiBiV+3sa18ajUWw104dfvJUsG7pvCvnKwb1rSA3ne7wE4eEJAACgDU5eIzu7m1JmTj2/\nL+zk9ZzOsR1yDzm4dxOR62e92+fRpErmiRMnPB3+9SZXaP+aFw9M/O3UuhknLzeb/M8+c/sT\n4kSk37enrHlc/XOViPw0abGIuNSrKyIbj6TlHW3iK0NeC99116tQ9C7xbSud/nbs1etnxuz8\ns25wpHI/l0CwAwAAGjFpgO+Vs0snjFilt68c26h8brudU9M3vJ33xA3Zc+XGqqU1J33M470G\nDpvmZvjXLFT3zZctOVd6vjpCFFN8D+/c9rfnpOjtveLNFfJ2dvDo+VKFMmnHpuxIz3SpEebj\nYNg0KPpi9o1nPs7vSZg0e/73ZY15T/m351fbxXbPurp/5LLB57Il5tU693UJBDsAAKAR9ccE\ni8icb89UbDXN3XDTSmh44hSnjN0tfFoNGRUxfeo7T7f0nXs07cW5K43/vl7q5PVqe1f7fauP\nl6sX+UgZO1vjlTPz1vx1rXL79zxuSYSjRte1WrPHfXpMZ+eZOLPvhf3v12r+dGh0QlTYa81b\nhti7NFv8qr+tp8HJICKx85as2XDq1rrlGsT4OBgWDk50qflWoKv9fV0CwQ4AAGiEY4UBPT0c\nRaRTnnVYGzf/YSlJK55ubPhsftzYyBmp9i3nJu6d26fmHcdT3ulZQ0QCpv3zBvc9U6aLSI93\n848vIr6DJiqK8vOkhSLi99Li3SumNDbsfW/SmMjpq6p2HrJp79Y6f6+ZVu06KcC/8oLgIWM/\n2Hebqnqn+AAvq8Xaduqg+70E9rErGVatWtW7d++VK1cW3sMT7GP38LCP3UPGPnYoauxj9/Dd\ndR+7IrKhZ80n1l0+kX66orFk3AvjqVgAAIDbyLme+urnv1d89OOSkuqEYAcAAJCfNXv0hEnn\nv//wSEZ27JzOas/mPhDsAAAA8rF8sWTG79dchk39akxtV7Uncx8IdgAAADdTjHt/P6/2JB5E\niVkzBgAAwJ0R7AAAADSCYAcAAKARBDsAAACNINgBAABoBMEOAABAIwh2AAAAGsE+doUsMzMz\nJibGz89PpyvM0JyUlCQi2dnZhTgmAADQGIJdIYuNjY2IiCiiwRMTE/v06VNEgwMAgJKOYFfI\nfH19RSQ4ONhsNhfisElJSQkJCUFBQYU24pULhTYUcDuKZyu1SuurblOrtIpXjYcp64hqpX/7\nRrXSdTuoVhr3jmBXyGwrsGazuVevXoU7ckJCgsHA7xcAAPhXPDwBAACgEQQ7AAAAjSDYAQAA\naATBDgAAQCMIdgAAABpBsAMAANAIgh0AAIBGEOwAAAA0gmAHAACgEQQ7AAAAjSDYAQAAaATB\nDgAAlGB/7RmlKEr913bceujq2aWKolTrtLqISmembTfodIqiPPbJ4YKMM9KrrFvN+AJO5tTW\nLoqiEOwAAEAJ5l430t/R7vCSibceOrQwQUSemNK2iEofWT4ux2oVkZ1hS+7rxNPfRA4YMOBc\ntsX2sox7uXLuDoUyJYIdAAAowRSdw7QuVTMubJxz+kq+Q/Om7zeYvGMalCui0rMn/2Iw1Yhr\n4HHpaOTuy1n3fuKllMRFixZdzrHaXsb8euzQj8MKZUoEOwAAULK1iuojIjOm/Za3MTMtaebp\nK5XavltWr9zXaDnXL95Lt+sXN08/eblS+2m9o1tZLVkha1Pvq0oRIdgBAICSzdU3oomT8dDC\nd/I2Hk8Mt1itXfOsw17Ys25g97YV3JwcXDwbte0xa11K7qGoGq4VGq9PP7ImqJG3q1f/X+Na\nKIry+fmM3A5ZV34x6XX+Q7flthxaGGa1WrtPaVOpQ5SdTtkVnn819uAXs7q1rudaxujs4fX4\nc2/sOHMtt5b/sCQRqWEyVDZvEJGQqs6299gtbeelN5Q5nJGTO4gl60x5o8Gz8ft3vQQbgh0A\nACjhFLupT1W/9tfaRX9czW37bNJPBvtqMY942F5e3D/fr8nTy7+/1veVsW+PHlglbeuIJ+sN\nXPBPMMq6ui+w2WCnNn2nxo2oNXC8iER+ciT3aOp/R123WF+LaJTb8l7cXoOpRnT9cnZlGoyp\n5nzpSNTOPKuxx9ePrhc0IinNe+i4qFEDg/avmdHBv8Ox6zki0n/55x+Nqi8iyzdt+XRmy7zX\nERjXyZJzNWT7mdyWP3aMPpeV03l6z3u5BBExFOTbiIfGYrGISHJy8gOcazKZgoKC9Hp9YU8K\nAIDiounkgbJkfML0fS9FNhWRnIyjkw5erNh+jsvf67ATOo9Od2qzN/UrH5NeRMaEThzdpMr0\nEYHRL6RWsNOJyIUDIY3WHpvzRHVb/76ejutjF8mIWNvLhWG7HD2eeaWyk+1lxl9r5p2+XLXT\nx7Z13n5j6kaNSA75b+qWfrVExGq58kzfDxxrDErZPae8nU5ERvSq4tli4qBPj37Vt1bVlq2b\n/+wsIi3btfO2v+lfZ8+mU73sP9r+1mb5/iVby8aQLQaTz3RzxXu5BCHYlRQHDx4Ukfj4+Pj4\nB3kcevPmzYGBgYU9KQAAigtn75C2LhN3zYuRyFUi8seOsVdyLM/Htrcdzby0dWZqmnnmLFsk\nEhHRmcZ+GDit6Yr4k+kx3i4iYnDwmdGteu6Ao4fW/uSd+B8vRzZ3sstM2zblWFqjyeG5R1Nm\nTxaR7lPa2F7WeG6cjHhyd8Ri6TdZRNJ/j9mZntl9dUT5v/NW+eZhc2aWL+NZ5s5XoRjcpz1a\nse/2ceezX3A36CxZZ8bs+rPak+tcDcq9XIIQ7EqKkJAQi8Xi5+en09336rnJZAoICCiKWQEA\nUGzoovv4tJn9f8v+vNa3vMPXE7YZ7KtMaXhjHTbjwiYRSR5eVxme/7SUtBvrp/YuHQx5nrKo\nM+J16+QBbyUe39zb5/CycRaRycP9co/GTt+nKPoqW5fP2HbjnGomw/GjMT+kh7Uoa7y4d4eI\ndK3nlnd6L79yS+3bCYjrmtNs7vhf/5rTuPwf3795LivnzdjW93gJQrArKYxGY3h4+N37AQBQ\nWjUMfUVmv/buzJQ+oTXG7jpb4dFlrrlJTWcUEfPs1dF13PKd5e7tbPtC0TnmbXes8NIT5YZv\nn/iZ9H5zZuT/ylYN7uJmsh26+ueyZWevisj410fmG23sZ6lfv+hrybSIiFG5v6dxbTwaxVYz\nffjFW8myofumkK8c3LuG1HC+x0sQHp4AAADa4OQ1srO7KWXm1PP7wk5ez+kc2yH3kIN7NxG5\nfta7fR5NqmSeOHHC0+Ffb3KF9q958cDE306tm3HycrPJ/+wztz8hTkT6fXvKmsfVP1eJyE+T\nFouIS726IrLxSFre0Sa+MuS18F13vQpF7xLfttLpb8devX5mzM4/6wZHKvdzCQQ7AACgEZMG\n+F45u3TCiFV6+8qxjcrntts5NX3D23lP3JA9V26sWlpz0sc83mvgsGluhn/NQnXffNmSc6Xn\nqyNEMcX38M5tf3tOit7eK95cIW9nB4+eL1Uok3Zsyo70TJcaYT4Ohk2Doi9m39iC+PyehEmz\n539f1pj3FKv19nXbxXbPurp/5LLB57Il5tU693UJBDsAAKAR9ccEi8icb89UbDXN3XDTSmh4\n4hSnjN0tfFoNGRUxfeo7T7f0nXs07cW5K43/vl7q5PVqe1f7fauPl6sX+UgZO1vjlTPz1vx1\nrXL79zxuSYSjRte1WrPHfXpMZ+eZOLPvhf3v12r+dGh0QlTYa81bhti7NFv8qr+tp8HJICKx\n85as2XDq1rrlGsT4OBgWDk50qflWoKv9fV0CwQ4AAGiEY4UBPT0cRaRTnnVYGzf/YSlJK55u\nbPhsftzYyBmp9i3nJu6d26fmHcdT3ulZQ0QCpvXKbdozZbqI9Hg3//gi4jtooqIoP09aKCJ+\nLy3evWJKY8Pe9yaNiZy+qmrnIZv2bq3z95pp1a6TAvwrLwgeMvaDfbepqneKD/CyWqxtpw66\n30tQrP92HxAPZNWqVb179165cmWvXr3u3ltFV75QpWz2xeOq1BWRnHMH1CptPbtDrdKKZyu1\nSqso55epapXWN3xTrdJ4mK5MV+3P2G/fqFVZ6nZQrbSIuC9QJ65s6FnziXWXT6SfrmgsGffC\neCoWAADgNnKup776+e8VH/24pKQ6KeXBLjMzMyYm5sE2h/s3SUlJIpKdnV1YAwIAgIfNmj16\nwqTz3394JCM7dk5ntWdzH0p1sIuNjY2IiCiKkRMTE/v06VMUIwMAgKJn+WLJjN+vuQyb+tWY\n2q5qT+Y+lOpg5+vrKyLBwcFms7mwxkxKSkpISAgKCiqsAQEAwMOmGPf+fl7tSTyIUh3sbCuw\nZrO5cB90SEhIMBhK9TcWAACoosS8GRAAAAB3RrADAADQCIIdAACARhDsAAAANIJgBwAAoBEE\nOwAAAI0g2AEAAGgEwQ4AAEAj2Ee3tCrjpk7di8fVqasqxbOVWqX1HrXVKp3920dqlVaR9ewO\ntUpbTm9TpW6Oen+n9VVVK335gGqlGw5UrTRKBO7YAQAAaATBDgAAQCMIdgAAABpBsAMAANAI\ngh0AAIBGEOwAAAA0gmAHAACgEQQ7AAAAjSDYAQAAaATBDgAAQCMIdgAAABpBsAMAANAIgh0A\nACjBNgZUUf5dmfK9CrFWeHUXl+rhuS8tWWfnvv3qo4/UdCljMpUtV7Nuq+Fh753IzCnEivfL\noGJtAACAAqrZ//XQNmm2rzPTtsVO/8br8aEDWpS3tdiVqXfn009/E/nW4kNx8xZ4GO7vbpcl\n62zfBn4rD1x6pNPzI3rUczNe37/r6wVRwUs++vyXlA01TPqCDP7ACHYAAKAEqzVwzOS/v04/\nHhk7/ZsqQSMnv36XPJfrUkriokVJEbPne9xnJto/p8eKlIvPL/51yQv1/26LmPTVO9UfC+/8\nyjcpCzsWZPAHxlIsAADAfds9c5+iGOb3q5+3sUrH0AEVHI+vn1GQka1ZWdYHPZdgBwAANC71\nywVPBzR2L2tycC7X5D89Fm753dYeVcPVf1iSiNQwGSqbN9gakz6KeqxlXVcnk52Dk0/91m++\nt/62YzqVtbNasxcduJivfWrSzz8nJ/zb4Bf2rBvYvW0FNycHF89GbXvMWpdy4zTrdUVRAj//\neWK/tmUdTAY7xyp1zCEzv8gdNuf68djXnqtTtZy9wehWqVaP4dEnMy23zopgBwAAtOzUllC/\nTkM27XfoPzJswvC+xj0bBj3mF7H1tIj0X/75R6Pqi8jyTVs+ndlSRA4ufrb1ixP2GeuPDo2M\nDh/TqOyRd9944vl1v986bIuYHiLyasM6A0JiErf976rlxl021xq1ateqdtvBL+6f79fk6eXf\nX+v7yti3Rw+skrZ1xJP1Bi5IyR1z55iAySv2Pjk4ePK4YfUMKXEjunQM+852aFK7ZuNnft6w\n+8tRU6MGdq752ay3WvdYcuuseI9dIbNYLCKSnJys9kT+YTKZgoKC9Hq92hMBAOChs2YP7Pmu\n4hK4+1CiXxmDiIydMLRj1WZxPYZFnFtTtWXr5j87i0jLdu287fUi8sXkzfau7fd/s8JJr4iI\nNSTYy9F926wD8kS1fANXDvjg29n2Q8JmLYobvyhuvMHR0xwQ+HinJ14Y0LOak0FEbh18QufR\n6U5t9qZ+5WPSi8iY0Imjm1SZPiIw+oXUCgYRkbT9l+K2nx5triAi4yLeGt2szvTooN1jzzdQ\n9k7+4Wy917evSHhURETerHOkfuRv74u8kG9WBLtCdvDgQRGJj4+Pj49Xey7/2Lx5c2BgoNqz\nAADgYbt6dunGCxnmGe/ZUp2I2JWt/8H4Bg3HrV197loPD4d8/Yf8dOxFxWRLdSKSfe2MiORc\nu/0OJm2Hvrv/5SkHdm798quvvvzyyy2bln/3+bJJIWOn/HfbqE5V83XOvLR1ZmqaeeYsW6oT\nEdGZxn4YOK3piviT6THVTSLiUiPClupERGfwCPtkYELduAnbz6xv72zUKcgOGUQAACAASURB\nVH98+8mvfzRuUMFBRIZs3TPkdlMi2BWykJAQi8Xi5+en0xWXZW6TyRQQEKD2LAAAUEHGxc0i\n0ujxSnkbqz5VT8bt3HQh49ZgZyrrfOK71TM3bt974NCxo4f3/LLvYlaO1x0KKIbazTvWbt5x\n+LionOt/rp0bM3h0Qkj3ll0v/u7ncFPKyriwSUSSh9dVhucfIyUtS8QkIpUCH8/b7uw9WCTu\n5Jdn9J2aJ0569omIGQ0rza7Z6NG2bdsEdn7q2S7Nb12MI9gVMqPRGB4efvd+AADgYVHyvdYZ\nRCT7do+eLhve+vlZSdVbdnkqoKW5c+/6jc3jO/in3tItJ+NQvwFh3j2io3t65zbq7cs/PfLd\nahe+aRax++2jl5bWLXdzUaOImGevjq7jlm80d29nEatI/mcfFMVORKxZVhHpGPrJuQHjVn22\nfss3W79e8u7C6VEhrYf+tnWWs/6miyPYAQAAzTK5Boos/enL01LLNbfxVOIeEenoZp+vc+al\nb/vPTq49cFXKgp65jdettwmAOjvPdatWOh3tGN1zcL5Dbv7OIuJizH83zcG9m8jE62e92w9t\nlNuYfnjz2h1n6zxqEMkSkTNffS1i/ufo8YUiUqGDZ1b6of8duFS5QeMXRzZ8ceQEsWaun/LY\nE+PnvHkwam4d97xVtB/sMjMzY2Jibrs2mpSUJCLZ2dlqzAsAABQ5R89+gW6vbA8ddfjFdTUd\nDCKSfSXltYm/OLh3fa68Y243W3jLurrHYrV6tnskt/3c7nk/Xc6qdMuwit45rnXFEd+9Era6\nzeSn6+S252QcC3ljp8HkE1HdOd/gdk5N3/B2nhk3ZM+opPpl7ETEmpM+5vFeC8/WTO/7vK3n\nxUOh7+98eWQzDxGxZl+MeX6OorMPD6h8+dSrzZrNC1x2aHOfmiIiirFZu5oi316+nn/HE+0H\nu9jY2IiIiDt0SExM7NOnz0ObDwAAeHgUw6IVb/h0ntLQt+OwQV3LW8+smTtnR5oS/vV82/0e\ng5NBRGLnLelc67Huj/dr4Tzq++FPhV0M9ne1/LZz4/QPd9cyGU7uX/zF1uqd29fJO/CgdWs+\nrdPhnWf8V3foHtisrouj4cKpw1+uXr3/fM5rn2yuYKfLN/iTXSqHJ075qOGIFj6tnn++W4PK\ndluWf7D2aNrgpSuNyo2VWKcavsGP1t01dHC98jlbP1vw+S9/tR6zuZ2L0eIY2crlo69fNPff\nMahxrcqXT/xv4fSPHcq1e9ffPd/laj/Y+fr6ikhwcLDZbM53KCkpKSEhISgoSI15AQCAh8Hr\nsej9G3zeeOf9+e+GZYijf/POCz5JGNCuou1o1a6TAvyfXxA85OtOG57s0nHTjyuGDH17XsRr\n2c7Vm7fqvOXYMmXBix0nrRr4et1TP4fmHdbo3Gzjkf1zI6M/Wbvxo9mb0q6LW4VqTTsOmBg8\noXcrr9sNXtnNf1hKksfroXGfzY9bonepU7fl3MSYwZ1r5o7p03vZHN8VwyYv+OTEpXLejwTH\nf/juG4EiorMrv/mXz4Nfn5j48fufXLpe1rNa62dH/d+7kyoZ869GKtbbrRxryapVq3r37r1y\n5cpevXrd+6FS4HtVqmaf/J8qdUUk59wBtUqrSO9RW63S2b99pFZpy+ltapXWVWqjVmm1rjrn\nuCplRUT0+XeTeHjOzVOttFtn1Uqrq+wEjccVsV5XdKaG43b+HN20IMMUly05AAAAUEAEOwAA\nAI3Q/nvsAAAAij39q6++6vWoZwFHIdgBAACoTTG8//77BR+GpVgAAACNINgBAABoBMEOAABA\nIwh2AAAAGkGwAwAA0AiCHQAAgEYQ7AAAADSCYAcAAKARBDsAAACN4JMnSqsrF1Qpm3PugCp1\n8fApnq3UKq3if1hL5VVvU6vwpy8b1Sr9VFimWqXtWrRRqzRKBO7YAQAAaATBDgAAQCMIdgAA\nABpBsAMAANAIgh0AAIBGEOwAAAA0gmAHAACgEQQ7AAAAjSDYAQAAaATBDgAAQCMIdgAAABpB\nsAMAANAIgh0AACjZNpgrK4ri4NbRerujm3rWVBTFWKbeA4+/971WiqKcybI88AiFIry6i0v1\n8Dv3IdgBAAAtyLi4Zdapy/lbrdnjN55QYzr35PQ3kQMGDDiXXWiRkWAHAABKPJ3eqaaDYfa0\nffna036P3X0585EyRlVmdVeXUhIXLVp0Oee2txofBMEOAACUfIpdXNtKhxZF5mv+NXqJ0anJ\n6CpOD39GOdcvPvyiBDsAAKAFbaK7XPtrzZKzV/M2vr3yaJVO0UZFydc59csFTwc0di9rcnAu\n1+Q/PRZu+T3v0S/nTmhTr5qj0VTBu9HwmJX5bqhd2LNuYPe2FdycHFw8G7XtMWtdSu6hqBqu\nFRqvTz+yJqiRt6tXf1tj0kdRj7Ws6+pksnNw8qnf+s331ud29h+WJCI1TIbK5g13HTzXr3Et\nFEX5/HxGbkvWlV9Mep3/0G0EOwAAoAUej8RUMurj5xzIbblyZsGmCxnPTG6er+epLaF+nYZs\n2u/Qf2TYhOF9jXs2DHrML2LradvR5Hc6PzY0ak927ZdDwvp3qrcyvG/Xuftzz724f75fk6eX\nf3+t7ytj3x49sEra1hFP1hu44J/4lXV1X2CzwU5t+k6NGyEiBxc/2/rFCfuM9UeHRkaHj2lU\n9si7bzzx/LrfRaT/8s8/GlVfRJZv2vLpzJb3MrhNrYHjRSTykyO5Lan/HXXdYn0topGhEL6R\nJZbFYhGR5ORktSdStEwmU1BQkF6vV3siAAAUIcXgNrWF58szEiRska0lZcYHBoeak/xc1+bt\nZ80e2PNdxSVw96FEvzIGERk7YWjHqs3iegyLOLcm58ovnSdtdvN/5bdfPqhopxORsQMf9Xp0\nZO7ZEzqPTndqszf1Kx+TXkTGhE4c3aTK9BGB0S+kVrDTiciFAyGN1h6b80R1W/8vJm+2d22/\n/5sVTnpFRKwhwV6O7ttmHZAnqlVt2br5z84i0rJdO297/b0MbuNQ7um+no7rYxfJiFhby8Kw\nXY4ez7xS2alUB7uDBw+KSHx8fHx8vNpzKVqbN28ODAxUexYAABSt/8R0vNJm8frzs7u5m0Qk\nYd7BSm0/dtTdtA579ezSjRcyzDPes6U6EbErW/+D8Q0ajlu7+ty1Vv8LTcu2DF/2dsW/g1T5\nliNiaoeP3n9eRDIvbZ2ZmmaeOcsWvEREdKaxHwZOa7oi/mR6jLeLiBgcfGZ0q55bbshPx15U\nTLZUJyLZ186ISM61nFsnfy+D5xo9tPYn78T/eDmyuZNdZtq2KcfSGk0OF5FSHexCQkIsFouf\nn59Op+UlaZPJFBAQoPYsAAAocp7NY93tlr3z8eFur9fLOL/+4z+uDIluk69PxsXNItLo8Up5\nG6s+VU/G7dx0IcPnu5Mi8lKtm1JU225esv+8iGRc2CQiycPrKsPzl05Jy7J9Ye/SwZAnSZrK\nOp/4bvXMjdv3Hjh07OjhPb/su5iV43W7yd/L4LnqjHjdOnnAW4nHN/f2ObxsnEVk8nA/KeXB\nzmg0hoffZaM/AABQUuiMlWIe8RgdN1def+/I0ii9sWLMI+Vu2zP/wxQ6g4hkW0Wn18ktz5Ya\nXf/eLUVnFBHz7NXRddzyDeDu7XxjZJ1j3vZlw1s/PyupessuTwW0NHfuXb+xeXwH/9R/mf1d\nB8/lWOGlJ8oN3z7xM+n95szI/5WtGtzFzSSlPNgBAACN6RLdZminD7Zeilsft7d80w/cDfkX\n5UyugSJLf/rytNRyzW08lbhHRDq62Xu2ryKy66OjaU0b/JMI/5d4yvaFg3s3kYnXz3q3H9oo\n92j64c1rd5yt8+htMlXmpW/7z06uPXBVyoKeuY3Xrbffte5+Bw/tX9P8/sTfTvnNOHk5YNEw\nW6OWlyABAEBpU6ltXBmdjF20PP5Eeofojrd2cPTsF+hm+jl01OFr2baW7Cspr038xcG963Pl\nHcs3jXIx6Jb0nXTu7w8Qu5Sy4uUdZ2xf2zk1fcPbeU/ckD1XbqyNWnPSxzzea+CwaW63JEgR\nybq6x2K1erZ7JLfl3O55P13Ov65qS3r3O3jdN1+25Fzp+eoIUUzxPbxtjdyxAwAA2qE3+bzt\n5/bmmCGiLxvbqsJteiiGRSve8Ok8paFvx2GDupa3nlkzd86ONCX86/k6EZ1j3S8iAs1h7/s2\nPDD42f/YXzjw0ezFzZ/3++7jGzuehCdO+ajhiBY+rZ5/vluDynZbln+w9mja4KUrjfkXd0VE\nHD37tXAe9f3wp8IuBvu7Wn7buXH6h7trmQwn9y/+Ymv1zu3rGJwMIhI7b0nnWo892aXyfQ3u\n5PVqe9cxW1cf92gw7ZEydrZG7tgBAABNeTqyhSUr071uVFX722/15fVY9P4Nczr6XJj/bljE\ntIXX/Dsv+DJlYruKtqOtQjdunD2+rrJ3RmTo7FVJ3aI2/ndCk9xz3fyHpSSteLqx4bP5cWMj\nZ6Tat5ybuHdun5q3LaTonTf9uOKpFg7zIl57LSx+1x/Vthzbvyz8acPFVQNf/z8Rqdp1UoB/\n5QXBQ8Z+sO9+BxdR3ulZQ0QCpvX6p8n6Lwu9mrFq1arevXuvXLmyV69ed+9delz5QpWy1w99\npUrdUkvvUVut0jnnDty9U9Gwnt2hVmnFs5VapdW6asvpbarUFZFPX1bt0z+fCstUq7Rdi/zP\neJYSpse+U3sKxdGGnjWfWHf5RPrpisYbt+pYigUAACh5cq6nvvr57xUf/Tg31QnBDgAAoISx\nZo+eMOn89x8eyciOndM57xGCHQAAQMli+WLJjN+vuQyb+tWY2q55DxDsAAAAShTFuPf387c9\nwlOxAAAAGkGwAwAA0AiCHQAAgEYQ7AAAADSCYAcAAKARBDsAAACNINgBAABoBMEOAABAIwh2\nAAAAGsEnT5RWZdzUnkEpoveorfYUVJDzy1S1p6ACFf+vfHX5NlXqXj6gSlkRkV7rWqhVOusH\ndb7bIqJ4tlKrNEoE7tgBAABoBMEOAABAIwh2AAAAGkGwAwAA0AiCHQAAgEYU96diMzMzY2Ji\n/Pz8dLoHzKBJSUkikp2dXajzAgAAKHaKe7CLjY2NiIgo+DiJiYl9+vQp+DgAAADFVnEPdr6+\nviISHBxsNpsfbISkpKSEhISgoKBCnRcAAECxU9yDnW0F1mw29+rV64EHSUhIMBiK+5UCAAAU\nEA9PAAAAaATBDgAAQCMIdgAAABpBsAMAACVb8it1FUX57K9rtz060qusW834exknvqZbWa+R\nDzCBzLTtBp1OUZTHPjn8AKfb3Ps874BgBwAAtKyMe7ly7g6FMtTpbyIHDBhwLtuSr/3I8nE5\nVquI7Axb8sCjFco8CXYAAEDLYn49dujHYYUy1KWUxEWLFl3OseZrnz35F4OpRlwDj0tHI3df\nznqw0QplngQ7AACAB3f94ubpJy9Xaj+td3QrqyUrZG2qipMh2AEAAC0Lqeqc971rBxOnP9Wx\nRXlHR6/ard5etffLLtXzva/uwt7/9ujQwKWM0b2yz+P93zp2PcfWHlXD1X9YkojUMBkqmzfk\n9j+0MMxqtXaf0qZShyg7nbIrPP9q7MEvZnVrXc+1jNHZw+vx597YcebabUfLnefSdl56Q5nD\nGTm5I1iyzpQ3Gjwbv39jhnvWDezetoKbk4OLZ6O2PWatS8ntyba9xVrBPypXREwmU1BQkF6v\nL8SJAQBQEp35NqL+E5PLPtJt6ISe11J/iHquoY+7nRj/6ZCZ/kPzlotbDh0VP8Br74b505ZE\nB6Q1Obqmp4j0X/551ZXDXpi2Z/mmLdU8Guae8l7cXoOpRnT9cnZ6jzHVnKOPRO28PKGZk53t\n6PH1o+t1j3eq12XouAEO6Skfvj+jw8bk/WeS/m00EQmM62RptTBk+5lPO3rZWv7YMfpcVk7/\n6T1F5OL++X5Nhl12azT0lbGVTVe2fjp/xJP1fpy398NBfkKwK+YK66NyN2/eHBgYWPBxAAAo\nySwvPxNn59kn5cePyxl0IjKk/TN1+612qvxPj8z0H5osP7D0WV8RkReHZG1znvfdXJGeIlK1\nZevmPzuLSMt27bztb9wuyfhrzbzTl6t2+risXhGRfmPqRo1IDvlv6pZ+tUTEarnyTN8PHGsM\nStk9p7ydTkRG9Kri2WLioE+PftX3NqPZeDad6mX/0fa3Nsv3L9laNoZsMZh8ppsrisiEzqPT\nndrsTf3Kx6QXkTGhE0c3qTJ9RGD0C6kV7HQEu2Kt4B+VKyImkykgIKDwJgUAQIl09Y/F6/66\n9p8Vk22pTkTqPLe4+uB1f+XpY+fg+3Fv39yXnb3KzN1/9Q5jpsyeLCLdp7Sxvazx3DgZ8eTu\niMXSb7KIpP8eszM9s/vqCFuqE5HyzcPmzCxfxrPMHcZUDO7THq3Yd/u489kvuBt0lqwzY3b9\nWe3Jda4GJfPS1pmpaeaZs2ypTkREZxr7YeC0piviT6bHeLsQ7Iq1QvmoXAAAICJXz64XkdYt\nPXJbFH3Zbu6mxXn62LsG2Cv/vFR0eV7cTuz0fYqir7J1+YxtN3pWMxmOH435IT2sRVnjxb07\nRKRrPbc8Z+hefmX4XacaENc1p9nc8b/+Nadx+T++f/NcVs6bsa1FJOPCJhFJHl5XuWWMlLQs\nYSkWAACUEpas22xEYlAUybt7iWK8tc+/ufrnsmVnr4rI+Nfzb2s89rPUr1/0tWRaRMSo3CUd\n3sqjUWw104dfvJUsG7pvCvnKwb1rSA1nERGdUUTMs1dH13HLd4q7t7PwVCwAACglHDzbiEjS\nzn+WXq2Wq5+fv/3nVdyL/QlxItLv21PWPK7+uUpEfpq0WERc6tUVkY1H0vKeNfGVIa+F77rz\nyIreJb5tpdPfjr16/cyYnX/WDY60ZUMH924icv2sd/s8mlTJPHHihKeDQQh2AACglHCqPLK1\ni/33IyMu/b0n8MFVLx26ln2/41j/vsP39pwUvb1XvLlC3qMOHj1fqlAm7diUHemZLjXCfBwM\nmwZFX8y+cc75PQmTZs//vqzx1tHyaRfbPevq/pHLBp/LlphX69ga7ZyavuHtvCduyJ4rN+4+\nWnPSxzzea+CwaW4GnbAUCwAAtGFlbNSvjjcFG5Nrx7Gvt8l9qegcVv7fm7U6R/marw7v2Toj\n9YfZnxzr5GZK1jveYwmDk0FEYuct6VzrscDGn6/561rVx9/zMOS/TTZqdN1FIT+O+/TYNy/V\nTpzZ13/g+7Wapw7r3cHx6pEF02bbuzRb/Kp/vtGe7FI53yDlGsT4OMxZODjRpWZooKt9bnt4\n4pSPGo5o4dPq+ee7Nahst2X5B2uPpg1eutKoiBDsAACANqyIfSdfi4u3Xd5gJyKVA9859HW1\nAWM/iA/fUK5++yU/b1nWvILevuo9lqjadVKA//MLgod83WnD4trTRaTHux1u7eY7aKIyttvP\nkxbKS9F+Ly3eXab+mNi570363GLv0bzzkIXT4+o4GPKNdmuwU/RO8QFeTyamtp06KG+7m/+w\nlCSP10PjPpsft0TvUqduy7mJMYM717QdJdgBAICSzTzrN+usfz0aezwt1vaVNXvO3AWutZ/c\nmPTy3w0Xh1y8XqF7E9vL4MMXgm8+t0vyqYw8L+1dO2z57eTfr361xsttmdyDLBZL7stGvcZs\n7jXm1m43j5Znnn/r/vmx267TejTrufSLnrctzXvsAABA6aAY9kwd99Izz278KfV6tiX97OEP\nXg04m+MQNrmR2jMrNNyxAwAApUXs9v+e7NK3cxNv20tTuXqTVu3qW/Fe32NX/BHsAABAaeHg\n2f6zXSdPH913+Ohpg2vlxo3r2N/3HnPFGsEOAACULpVq+Feq4a/2LIoE77EDAADQCIIdAACA\nRhDsAAAANIJgBwAAoBEEOwAAAI0g2AEAAGgEwQ4AAEAj2MfuAWVmZsbExPj5+el0RRiOk5KS\nRCQ7O7voSgAAAM0g2D2g2NjYiIiIh1MrMTGxT58+D6cWAAAouQh2D8jX11dEgoODzWZz0VVJ\nSkpKSEgICgoquhKA9ugqtVGrtOX0NrVKXz6gTl2n2urUFRHFs5VqtUW132gVWc/uUHsKuDuC\n3QOyrcCazeZevXoVaaGEhASDgd8mAABwdzw8AQAAoBEEOwAAAI0g2AEAAGgEwQ4AAEAjCHYA\nAAAaQbADAADQCIIdAACARhDsAAAANIJgBwAAoBEEOwAAAI0g2AEAAGgEwQ4AAJRsG8yVFUVx\ncOtovd3RTT1rKopiLFPvgcff+14rRVHOZFk2BlRR/l2Z8oX58fHh1V1cqofbvr765zJFUeq+\nknzXs/h0eQAAoAUZF7fMOnV5eGWnm1qt2eM3niisEjX7vx7aJs32dWbattjp33g9PnRAi/K2\nFrs7ZsfT30S+tfhQ3LwFHoYivK1GsAMAACWeTu9Uw5gxe9q+4VOb521P+z129+XMR8oY9932\nbt59qjVwzOS/v04/Hhk7/ZsqQSMnv35P9wIvpSQuWpQUMXu+R1GGL5ZiAQBAyafYxbWtdGhR\nZL7mX6OXGJ2ajK7idNuTSjxrdlbOTYmVYAcAALSgTXSXa3+tWXL2at7Gt1cerdIp2qgo+Tpf\n2LNuYPe2FdycHFw8G7XtMWtdSt6jX86d0KZeNUejqYJ3o+ExK3Pu+W5f6pcLng5o7F7W5OBc\nrsl/eizc8rutPaqGq/+wJBGpYTJUNm+wNSZ9FPVYy7quTiY7Byef+q3ffG/9PVaJr+nm4b98\n7yfhvp5l7e307pV9ug2LTL2eIyzFFnMWi0VEkpPv/mbJOzCZTEFBQXq9vpAmBQBAceTxSEwl\n44L4OQf6hTWytVw5s2DThYw3JzeXZ27qeXH/fL8mwy67NRr6ytjKpitbP50/4sl6P87b++Eg\nPxFJfqfzY2EbXWp3fDlkqOHP3xaF911X655u+J3aEurXKUrv2WrwyLDyljPrP1ww6LHEY1uO\nTGpfqf/yz6uuHPbCtD3LN22p5tFQRA4ufrb1Syu92vQaHTrIwXo5ae3sd9944rRP6tInqt1L\nrSt/LGzxwrbur4aMa+i1b8O8d+eE7jlV69jaZwl2xdrBgwdFJD4+Pj4+viDjbN68OTAwsJAm\nBQBAcaQY3Ka28Hx5RoKELbK1pMz4wOBQc5Kf69qbe07oPDrdqc3e1K98THoRGRM6cXSTKtNH\nBEa/kOqe+WvnSZvd/F/57ZcPKtrpRGTswEe9Hh159/LW7IE931VcAncfSvQrYxCRsROGdqza\nLK7HsIhza6q2bN38Z2cRadmunbe9XkS+mLzZ3rX9/m9WOOkVEbGGBHs5um+bdUDuLdhlXNjU\ne/mBT571FRF5acj1bc7zvp0hQrAr3kJCQiwWi5+fn0734IvmJpMpICCgEGcFAEDx9J+Yjlfa\nLF5/fnY3d5OIJMw7WKntx466m9ZhMy9tnZmaZp45y5bqRER0prEfBk5ruiL+ZPrII6Fp2Zbh\ny962pToRKd9yREzt8NH7z9+59NWzSzdeyDDPeM+W6kTErmz9D8Y3aDhu7epz13p4OOTrP+Sn\nYy8qJluqE5Hsa2dEJOdazj1eqZ1D7SW9ff9+pXSv5zY3+YqwFFvMGY3G8PBwtWcBAEDJ4Nk8\n1t1u2TsfH+72er2M8+s//uPKkOg2+fpkXNgkIsnD6yrD85+ekpZ19ruTIvJSLZe87W27ecnd\ngl3Gxc0i0ujxSnkbqz5VT8bt3HQh49ZgZyrrfOK71TM3bt974NCxo4f3/LLvYlaO1z1ep4jR\n2WyXJ68qfwdEgh0AANAInbFSzCMeo+PmyuvvHVkapTdWjHmk3K2dRMQ8e3V0Hbd8R9y9nS16\nndzybKnR1XiPE8j/jIbOICLZt3v2Ytnw1s/PSqresstTAS3NnXvXb2we38E/9R7LiCiK3W3b\nCXYAAEA7ukS3Gdrpg62X4tbH7S3f9AP3W3YDdnDvJjLx+lnv9kMb5TamH968dsfZOo8aLO2r\niOz66Gha0wb/JML/JZ66a12Ta6DI0p++PC21XHMbTyXuEZGObvb5Omde+rb/7OTaA1elLOiZ\n23jdWghb7bHdCQAA0I5KbePK6GTsouXxJ9I7RHe8tYOdU9M3vJ33xA3ZcyXL1mLNSR/zeK+B\nw6a5GXTlm0a5GHRL+k46l2WxHb2UsuLlHWfuWtfRs1+gm+nn0FGHr2XbWrKvpLw28RcH967P\nlXfM7WYLb1lX91isVs92j+S2n9s976fLWQ94zXlwxw4AAGiH3uTztp/bm2OGiL5sbKsKt+0T\nnjjlo4YjWvi0ev75bg0q221Z/sHao2mDl640KiKOdb+ICDSHve/b8MDgZ/9jf+HAR7MXN3/e\n77uP99+lsGJYtOINn85TGvp2HDaoa3nrmTVz5+xIU8K/nm+7i2ZwMohI7LwlnWs91v3xfi2c\nR30//Kmwi8H+rpbfdm6c/uHuWibDyf2Lv9havXP7Og98+dyxAwAAmvJ0ZAtLVqZ73aiq9rff\nw9XNf1hK0oqnGxs+mx83NnJGqn3LuYl75/apaTvaKnTjxtnj6yp7Z0SGzl6V1C1q438nNLmX\nul6PRe/fMKejz4X574ZFTFt4zb/zgi9TJraraDtateukAP/KC4KHjP1gn6J33vTjiqdaOMyL\neO21sPhdf1Tbcmz/svCnDRdXDXz9/wpy7dyxAwAAJVuX5FN5twnxfiox39vVntt37rmbT/Fo\n1nPpFz3lXzw+NOrxoVF5Gv5jtS7N16ds1QlW64R8jTUeH7Lm8SG3HdPetcOW307mvnSp/eTK\nr5+8qce4FRfH/fPq7dRLb//9tWP5vlZr39xDwYcvBN88eOCG1Osiwh07AAAAzdD+HbtC+VSu\nWyUlJYlIdnZ24Q4LAADwwLQf7ArrU7luKzExsU+fPoU+LAAAwAPQfrArlE/lulVSUlJCQkJQ\nUFAhjgkAAFAQ2g92RfepXAkJCQaD9r+BAACgpODhCQAAAI0g2AEAImxxqQAAIABJREFUAGgE\nwQ4AAEAjCHYAAAAaQbADAADQCIIdAACARhDsAAAANIJgBwAAoBHsr4uHSu9RW63SOecOqFVa\nRdm/faT2FFRgOb1NrdK7J6lVWRoOVKeuvqo6ddWl4lVbz+5QrTZKAu7YAQAAaATBDgAAQCMI\ndgAAABpBsAMAANAIgh0AAIBGEOwAAAA0gmAHAACgEQQ7AAAAjSDYAQAAaATBDgAAQCMIdgAA\nABpBsAMAANAIgh0AANCIzLTtBp1OUZTHPjlcWGNuMFdWFMXBraP1dkc39aypKIqxTD3by5Fe\nZd1qxhfFyPeIYAcAADTiyPJxOVariOwMW1K4I2dc3DLr1OX8rdbs8RtP5G0o416unLtDUYx8\nZ6e/iRwwYMC5bAvBDgAAaMTsyb8YTDXiGnhcOhq5+3JWYQ2r0zvVdDDMnrYvX3va77G7L2c+\nUsaY2xLz67FDPw4ripHv7FJK4qJFiy7nWAl2AABAC65f3Dz95OVK7af1jm5ltWSFrE0ttKEV\nu7i2lQ4tiszX/Gv0EqNTk9FVnO5yujU7K+e2y60FHvkWBDsAAKAFhxaGWa3W7lPaVOoQZadT\ndoX/sxq7tJ2X3lDmcEZObosl60x5o8Gz8fu2lwcTpz/VsUV5R0ev2q3eXrX3yy7Vy3qNzDt4\nm+gu1/5as+Ts1byNb688WqVTtFFRcltCqjrnvscuvqabh//yvZ+E+3qWtbfTu1f26TYsMvV6\njtzsHkcWkQt71g3s3raCm5ODi2ejtj1mrUuxtUfVcPUfliQiNUwGw318w5CHxWIRkeTkZLUn\ncncmkykoKEiv16s9EQAAitB7cXsNphrR9cvZ6T3GVHOOPhK18/KEZk52IhIY18nSamHI9jOf\ndvSydf5jx+hzWTn9p/cUkTPfRtR/YnLZR7oNndDzWuoPUc819HG3k5tXQT0eialkXBA/50C/\nsEa2litnFmy6kPHm5ObyzL9O6cofC1u8sK37qyHjGnrt2zDv3Tmhe07VOrb22QcY+eL++X5N\nhl12azT0lbGVTVe2fjp/xJP1fpy398NBfv2Xf1515bAXpu1ZvmkLwe4BHTx4UETi4+Pj4+/1\n4RcVbd68OTAwUO1ZAABQVDL+WjPv9OWqnT4uq1dEpN+YulEjkkP+m7qlXy0R8Ww61cv+o+1v\nbZbvX7L13xiyxWDymW6uKGJ5+Zk4O88+KT9+XM6gE5Eh7Z+p22+1U+WbxlcMblNbeL48I0HC\nFtla/p+9O4+LOf/jAP7+zkzTTLollCOlUjlyG3KkkMSyxDrXlZJ1Rlgdrg6FYh3JfYv9rXVF\nwrJssa61W1SOtO5YpUTHNPP7Y2hHJbFN3/r2ev6xj5nP9/P9vD/fGd9+r9/3+53vN3ntGoHY\nbJGl7uEyZpVxcui+lL3DzImIxrrlXdDe+Otaog+CXTlHXuDkla1pl5h22lTEJ6I5Pgu92jRY\nPcUxaExaw45d2v+hTUQdu3VDsPtC3t7eMpnM0tKSx6vqp7NFIpG9vT3bswAAAFCh5IglRDRg\nmZ3ibZNv5tGUr675b6dRS4iIEeiv7FxvxG/zXkrH6At4soKnc64+b/TVEV0B8+bZtiP/vO0Z\ntUSR6oio2TfbG0888k+JEj2DHXLsth99GeGiLyKi8I2363fdqcFjSnT8l5rYYtdQ8/fvmAE2\nepHxOSW7fXLk/Ffn1qVlSdatV6Q6IiKeaO4Wx5Vto8IeZQeb6BT1RLD7QkKh0M/Pj+1ZAAAA\nABFRyOpbDMNvcG7f2gvv8lAjkeBBavDv2b4dtIREZB/ar7Bd5Py//tnQus6zS7NfFBTODulC\nRG/SjxJRl44GRUMxfC0XfdH2EiUM24foq+1ZuvOuy3Sb3JdHdz7LcQuyK3tWQm2JmlLwY/il\np8BPjpybcZKI4j2tGc/i6yZnffDj3+LBLj8/Pzg4uOociIqLiyMiqVTK9kQAAACginrzfM+e\n9DdENH/61GKL5v6U9su35kRkYBvSSLTlxPfxdHzASe/TYv1+3k20iUhWUMpdUQQMQyV+xsoT\n1g9uaeAVGknTV93bHcgX1gtuWbvsiTGMWnnm/+mReUIikkQcDGqmV2xdfRPtD2ZebHFISIi/\nv395JlGZoqOjhw8fzvYsAAAAoCpKCg8lolG/Pt7ZtX5R49sXP2rUcb2+aDt9u5SIGL5OWNf6\n3/w6901ehzlXnlv7BSiOnokN7YiOxF35hxq/S0hy2ZtjL99S8QRFRNQ3yM69z5pzr0KPhibW\nabtGX1BhR8HKHlms70K0MC/dpLu7bVFj9t3YwxfTm3X+IMsVD3bm5uZENHPmTIlEUlFz/S/i\n4uLCw8OdnZ3ZnggAAABUUYs3JPPVjcMkdZUbxQZDxtattf3+sovZfp20hETULWRAQeu1U/dM\nfCGlPd81U3TTNJraRcfv0lT/VwO36/AZIrp9YOydt1LN0oJd/a6htXg/z92278rDbNedDhW4\nCWWPrKbZdoaJ9rpQt4RZcc1rqRGRvDB7Tm/Xrelm2SNGFnWTy0sEO8UZWIlE4urqWoHT/S/C\nw8MFuC0LAAAAlCbn6cZD/7xt2HuVQYnjZ7O8rLd5X573v/tnx1oQUe0WwabiDVsnRuuY+Tjq\nqiv6MDzx/h9nN3UKNJe88RzSJTft94i99/voieL5GiVr8UWmiy31Zs9xI75WSKe6JTt8sU+O\n7Be9bEerKR1MO40c6dLCSO3MvjWHU7Mm7t4vZIiIBJoCIgrZuKtKXEgHAAAA8GUSlq0mosEr\nepRcZD5hIcMwfyzaqnjL8DXD7I3lMnnX5ROUuxk5Lr3zS0RrQUqYn8/+S692/XFGX43HV29Y\narlBAR1kBfn61oEN1Sv4BrFlj6xn5ZEcFzWoteCnTaFzA9amqXeMjE6MHG6mWNqw3yJ7K6PN\nM91wJAwAAACqsY5hf8k/cktZkb6z4oECRQYcu1/8RxFy6YbIzboWX8XETXrfkOmWmVd3QBvF\n277xj5UfFmEyMFr+4RDf3HrxzfvXIQ+yQt6/nnk3Y+aHpRyPp+Upvf2skYnIoN2Q3SeGlNhK\nIiJ13R5nbj4iPFIMAAAAajRGkLB83tivh8VcT8uTyrLT7675zj69UOy7xPbT61Y9OGIHAAAA\nNVrIbz8/6jvCqY2J4q2ots2iA1dH1CvlGruqD8EOAAAAajSxYfefrj56knrrbuoTga5R69bN\n1Mt6nESVhmAHAAAAQPWbWNVvYsX2LP4rXGMHAAAAwBEIdgAAAAAcgWAHAAAAwBEIdgAAAAAc\ngWAHAAAAwBEIdgAAAAAcgWAHAAAAwBEIdgAAAAAcgWAHAAAAwBF48gRUKoFuQ7anwALpzR1s\nlS74/QJrpe+xVZlep7BWuv1Ps1mrzRJ5+kW2SvMNLNgqXchWYVbJnrD29wTKD0fsAAAAADgC\nwQ4AAACAIxDsAAAAADgCwQ4AAACAIxDsAAAAADgCwQ4AAACAIxDsAAAAADgCwQ4AAACAIxDs\nAAAAADgCwQ4AAACAIxDsAAAAADgCwQ4AAACAIxDsAAAAgAsKXt/9Yd6kzs2b6Gqqi2ppN23V\nZUbgtkypvJyr+zXW0Wns98XVpxpr6ZmFffHqFUXA9gQAAAAA/qucR0d7tnK9/LKgtcPX3zo1\nyf/n778unV61YNzuH39L+T1ST8CoegK19GvXFolVXeWTEOwAAACgepMXvhonGXH1tf76sxfd\nuzV83yz76fvug4M2OQd5xvu2VvUcgv+6H6zqGuWAU7EAAABQvd0/+O2BB9kDN/+qlOqIiPd1\nwJkOWsLrK2aotHphXqZKx/8sCHYAAABQve30PisQm239xrT4AkZtz47tG1aNf1347kq7uB2B\nvTpa62qK1MSaps27zF51tIxh005tHmTfWl9LJNau3abn4K1n/i5aFNhEt27ro9n3Djnbmuga\njyYi74baytfYZSQcGT+ga109TbGOoW3XweuPJBctKsx7EDLtm2YNa6sLhHr1mw72DHqUL/vP\nn8E7OBVbJeTn5wcHB1taWvJ4FR+1RSKRs7Mzn8+v8JEBAADYJ88Pe5CtbRqoxS/lQjqzgd+Y\nvX99e/uwLmP3G9u5evlMEMtfxx2OWDGj/xPTtN39G5Vc8fEZH8s+gXzDThOn+taRPT26ZfOE\nXtH3z9xb1L2+okPBm1uO7UIaj3Bb3rZbsXUzkzZZtvF4rWfrPnmukSjn3P82TfnK5vLGxC0T\nLIloUbd2AVffDHH/zs289uMbsSvXf3/1gfH9I2Mq5MNAsKsSQkJC/P39VTd+bGyso6Oj6sYH\nAABgi/TtnUyprJGpxSd7nlgSq67bPelslCafISK590xjDf0L61OoZLCTS8cPWcHoOF67E21Z\nS0BEcxe4OzRsFzrYw//FIcUxmIwUb9vD9zf0b1yy0AInr2xNu8S006YiPhHN8Vno1abB6imO\nQWPS9PP/XPJ7us3036LCOxMR0exm95oH3PyBCMGOQ8zNzYlo5syZEomkwgcXiUT29vYVPiwA\nAEBVIJcXEBGV42evbtfvf8uINN8f2JO+fUpEhW8LS/Z8k747JiNXsnaVItURkZpW8zXzW7Sa\nd/jgi7eDDcREJBCbrnUpJdXlvzq3Li1Lsm69ItUREfFEc7c4rmwbFfYoO6CetpDHPPt171/P\nWreoKyYit3MJbp+7zR+HYFclKM7ASiQSV1dXtucCAABQnaiJLUQ85vXd20SlnJvKfX7l3LV/\nDDvbt9YSirS0H54/uC7mt8SUO/dT7ybcuJVZUGhc2pi5mbFEZNu7vnJjw4E2NO/KyYxcRbBT\n1+lR6k1UcjNOElG8pzXjWXxRclYB38Q0etGw/v5rW9WPMLPt3LWrnaPTwGF921fU9VIIdgAA\nAFCd8cSeRpqrHyx/VeihU+Iyu+t+Y5wibi1Oy2qtJdzj2WXk+rjGHfsOtO8ocRravLVkfg+r\ntI8PXHwsnoCIim54zPA0PjIfIRFJIg4GNdMrtkTfRJuIHHz2vhg378BPR8+cPffLrhVbVwd6\nd3G/eW69dmnXCH4uBDsAAACo3twWtFs5+Zcx21MOjbf8YIE8f2FUqkC9wTRjzfxXv46OiLcY\nfyB585Ci5Xny0p9LIdJ1JNp9/dQTaqpb1Pg4OoGIHPTUy56MWN+FaGFeukl3d9uixuy7sYcv\npjfrLCjIvvNnyiujFq2/ndrq26kLSJ5/dFmv/vM3zL4dGNlM//M3vTjc7gQAAACqN4sJe3oa\niI95dA0/eUepuTDq+54nM3It3bbr8JmCNwkyudywW8uixS+ubbz+uqDUATUMRznqif7wmXX3\nrVTRIs1Jnrbwhli/3zd1PnKg7j01zbYzTLQTQt0Sct4NLi/MntPbdbzHSj0B7/XjkHbt2o35\nX+q73oywXTczInqdVzF3PMEROwAAAKjeeGr1Dl7c3Ln12FlOFlu6D3Rsb6VWkPl77I9nE9Nr\n2445vbIHEWkYjuqgPeuS50DfzJlWurKbV2JWb7nWVCR4lLT9xLnGTt2bfTAiI9gWNcPUaVkr\ncwePCf3qyJ8eitxwMYvx+2VTeQ6J+UUv29FqSgfTTiNHurQwUjuzb83h1KyJu/cLGRKYBnTS\n2fHLt5LRFye0bmr0+uGfW1fvFNfutsKqAg7XEY7YAQAAAAdomw2/cu/3pd8N5z+4FLk6ZNXG\n3Q+FzWYEb7tzeVtdNR4RMXztk5ejBnYQb/SfNs037OqzRmfuJ+3xGyTIPDB++o8lBzTuFZR0\nfIODacamFb7+K7e+tXLafCp5Ybd65ZmMnpVHclzUoNaCnzaFzg1Ym6beMTI6MXK4GRHx1OrE\n3jg2ztnyzM4fvGfMCttxxmbYrPPJMfWFFRPJcMQOAAAAuEBk0Or71bu/X/3RDjoWX+3/5asP\nmuZFZc5793Jx2qvFH/Zv0tvtUO/Sb0XyfWrm9x+2hDzIClF6a9BuyO4TQ6g0mo0dNv7s8NFZ\n/jc4YgcAAADAEQh2AAAAAByBYAcAAADAEQh2AAAAAByBYAcAAADAEQh2AAAAAByBYAcAAADA\nEQh2AAAAAByBYAcAAADAEQh2AAAAAByBYAcAAADAEXhWLBFRfn5+cHCwpaUlj8dO0o2LiyMi\nqVTKSnUAAADgBgQ7IqKQkBB/f3+2Z0HR0dHDhw9nexYAAABQXSHYERGZm5sT0cyZMyUSCSsT\niIuLCw8Pd3Z2ZqV6ZZJmPmCrdOGLFLZKs6jgHmulX7P3eWtasFZann6RrdKyJxdYqcurb8dK\nXXaxuNWMYSe2SuPirWoBwY6ISHEGViKRuLq6sjWH8PBwgQBfBwAAAHw55G8AAAAAjkCwAwAA\nAOAIBDsAAAAAjkCwAwAAAOAIBDsAAAAAjkCwAwAAAOAIBDsAAAAAjkCwAwAAAOAIBDsAAAAA\njkCwAwAAAOAIBDsAAAAAjkCwAwAAgOrtuMSIYRixnoO8tKUnh5gxDCOsZfPF4yeu6sQwzNMC\nGRFNNdbSMwv74qHK789l7RmGWfHodclFNrWE2g29S10LwQ4AAAC4IDfzzPrHJWKQXDo/5mEF\nVqmlX7u2vrgCB6xYCHYAAABQ7fH4mmZiQcTKW8Xas/4OufY6v2UtYUUVCv7r/p3LHhU1WoVD\nsAMAAIDqj1EL7Vr/zraAYs1/Be0SarbxaqDJyqTekUsLCks9S1zxEOwAAACAC+yC+r7959Cu\n9DfKjYv3pzboEyRkmGKdMxKOjB/Qta6epljH0Lbr4PVHkpWXnopcYGfTSEMoqmti6xm8XzmV\neTfUVr7GLm5HYK+O1rqaIjWxpmnzLrNXHS1aFGamZ2C1L3Gvn7mhlroaX9/I1MUjIC2vsAI3\nWSHt1OZB9q31tURi7dqCCh8dvoBMJiOi+Ph4VQwuEomcnZ35fL4qBgcAAKgiDFoG1xduDtuQ\nMsrXVtGS83TzyYzc2Uva09cf9MxM2mTZxuO1nq375LlGopxz/9s05SubyxsTt0ywJKL4pU69\nfGN0LBwmebsLnt/c5jfiSNPSD/jd3j6sy9j9xnauXj4TxPLXcYcjVszo/8Q0bXf/Ru8m8Gxr\nhzEXBnznPa+V8a3jG1ds8El43PT+4WEVuNWPz/hY9gnkG3aaONW3juwpgl2VcPv2bSIKCwsL\nC1PJD21iY2MdHR1VMTIAAEAVwQj0lncwnLQ2nHy3KVqS164RiM0WWeoe/rDnAievbE27xLTT\npiI+Ec3xWejVpsHqKY5BY9L08/9yWhSrZzX55o019dR4RDR3fGfjzlNLrXhiSay6bveks1Ga\nfIaI5N4zjTX0L6xPoffBLjfj5NB9KXuHmRMRjXXLu6C98de1RJ8R7GY30JpdWruWPhERyaXj\nh6xgdByv3Ym2rCUgIgS7KsHb21smk1laWvJ4FX9yXCQS2dvbV/iwAAAAVU3PYIccu+1HX0a4\n6IuIKHzj7fpdd2rwPjgPm//q3Lq0LMm69YpUR0TEE83d4riybVTYo+yp93yypDLPPYsVqY6I\n6nScEmzh55X0smQ5t+v3v2VEilRHRNK3T4mo8O2/J1vVxBa7hpq/f8cMsNGLjM/5rC1ynO7d\nSav4Lz82LAvKJSKiN+m7YzJyJWtXKVIdIdhVEUKh0M/Pj+1ZAAAAVG+G7UP01fYs3XnXZbpN\n7sujO5/luAXZFeuTm3GSiOI9rRnP4qsnZxWkn39ERGOb6ii3d3UxptKCnUhL++H5g+tifktM\nuXM/9W7CjVuZBYXGSh2E2hI1pVTJ8Itf6vdJTnN8vYyLnwj+aeWyB4ptyYwlItve9YsWIdgB\nAAAAR/CE9YNbGniFRtL0Vfd2B/KF9YJb1i7ZiYgkEQeDmukVW6Jvoi3j86jEb0uFuqXfLWWP\nZ5eR6+Mad+w70L6jxGlo89aS+T2s0pQ6MIzaf9qe8lFOiwh2AAAAwB19g+zc+6w59yr0aGhi\nnbZr9AXFr3ES67sQLcxLN+nublvUmH039vDF9GadBbLuDYiu7kjNatvi30T4Z/TjkoXyX/06\nOiLeYvyB5M1Dihrz5JV0WxMFka4j0e7rp55QU11FC253AgAAANxRv2toLR7N3bYv7GF2jyCH\nkh3UNNvOMNFOCHVLyClQtMgLs+f0dh3vsVJPwKvTNlBHwNs1YtGLApli6avkqEkXn5Ycp+BN\ngkwuN+zWsqjlxbWN118XqGCbPkrDcJSjnugPn1l330oVLThiBwAAANzBF5kuttSbPceN+Foh\nneqW2scvetmOVlM6mHYaOdKlhZHamX1rDqdmTdy9X8gQaVif8HeU+P5g3ipl4rCe6hkpOyK2\ntx9peX5nUrFBNAxHddCedclzoG/mTCtd2c0rMau3XGsqEjxK2n7iXGOn7s1Uv61EjGBb1AxT\np2WtzB08JvSrI3+KI3YAAADAKYMCOsgK8vWtAxuql34PVz0rj+S4qEGtBT9tCp0bsDZNvWNk\ndGLkcDPF0k4+MTER862ZxLUBPhEH4lwCY35e0KbkIAxf++TlqIEdxBv9p03zDbv6rNGZ+0l7\n/AYJMg+Mn/6jCjfvQ8a9gpKOb3Awzdi0wtd/5VYcsQMAAIDqrW/8Y+XnOZgMjC52qds3t158\n8+EqBu2G7D4xhD6it3tgb/dApYaecvluxauQB1kh71t1LL7a/8tXH6w5Lypz3ruXM+9mzPxw\nWMfjaXllboiylnMvy+eWvigxJ1/5bZPebod6uyle44gdAAAAAEfgiB0AAABA5XkQ49ph7IUy\nOpgNO3QhvMOXDY5gBwAAAFB5GvY58OSJqgbHqVgAAAAAjkCwAwAAAOAIBDsAAAAAjkCwAwAA\nAOAIBDsAAAAAjkCwAwAAAOAIBDsAAAAAjqjq97GTyWREFB8fr9IqcXFxRCSVSlVaBQAAAECl\nqnqwu337NhGFhYWFhYWpulZ0dPTw4cNVXQUAAABARap6sPP29pbJZJaWljyeCs8ax8XFhYeH\nOzs7q65EVZN340dW6vINLFipyy7Zk7IeHaNSN8+yVZkaGbFWumYSOkSyUrfwRQorddklsB7D\nVuma+YFD+VX1YCcUCv38/CqhUHh4uEBQ1T8NAAAAgDLgxxMAAAAAHIFgBwAAAMARCHYAAAAA\nHIFgBwAAAMARCHYAAAAAHIFgBwAAAMARCHYAAAAAHIFgBwAAAMARCHYAAAAAHIFgBwAAAMAR\nCHYAAAAAHIFgBwAAANXbcYkRwzBiPQd5aUtPDjFjGEZYy+aLx09c1YlhmKcFMiKaaqylZxb2\nxUMV+dw5l7Mugh0AAABwQW7mmfWPXxdvlUvnxzyswCq19GvX1hdX1Gjln3M56yLYAQAAQLXH\n42uaiQURK28Va8/6O+Ta6/yWtYQVVSj4r/t3LntUyFCfNedy1kWwAwAAgOqPUQvtWv/OtoBi\nzX8F7RJqtvFqoMnKpN6RSwsKSzvj+t/nXGJkBDsAAADgArugvm//ObQr/Y1y4+L9qQ36BAkZ\npljnjIQj4wd0raunKdYxtO06eP2RZOWlpyIX2Nk00hCK6prYegbvV85O3g21la91i9sR2Kuj\nta6mSE2sadq8y+xVR4sWhZnpGVjtS9zrZ26opa7G1zcydfEISMsr/LI5K9ctY2QEOwAAAOAC\ng5bB9YX8sA0pRS05TzefzMj9ekn7Yj0zkzZZthm079LbEZPnLvYa3yDr3JSvbMZvfpft4pc6\n9XIPTJBaTPL2Hd3HZr/fiH6RSaVWvL19WJdvF9wSNvfyCQjym2OrdW/FjP4jj/z97wSebe0w\nZkW7Ud4bt0SM71r72Aaf7q4/ftmci/nYyIJPf06gJD8/Pzg42NLSkserNplYJBI5Ozvz+Xy2\nJwIAAKBCjEBveQfDSWvDyXeboiV57RqB2GyRpe7hD3sucPLK1rRLTDttKuIT0RyfhV5tGqye\n4hg0Jk0//y+nRbF6VpNv3lhTT41HRHPHdzbuPLXUiieWxKrrdk86G6XJZ4hI7j3TWEP/wvoU\n6t9I0SE34+TQfSl7h5kTEY11y7ugvfHXtUTDvmDOxXxsZAS7zxMSEuLv78/2LD5bbGyso6Mj\n27MAAABQrZ7BDjl224++jHDRFxFR+Mbb9bvu1OB9cE4z/9W5dWlZknXrFamOiIgnmrvFcWXb\nqLBH2VPv+WRJZZ57FitSHRHV6Tgl2MLPK+llyXJu1+9/y4gUqY6IpG+fElHh239PtqqJLXYN\nNX//jhlgoxcZn/MFcy7pYyMj2H0ec3NzIpo5c6ZEImF7LuUlEons7e3ZngUAAIDKGbYP0Vfb\ns3TnXZfpNrkvj+58luMWZFesT27GSSKK97RmPIuvnpxVkH7+ERGNbaqj3N7VxZhKC3YiLe2H\n5w+ui/ktMeXO/dS7CTduZRYUGit1EGpL1JQSGsMvJa6VZ84lfWxkBLvPozgDK5FIXF1d2Z4L\nAAAAfIAnrB/c0sArNJKmr7q3O5AvrBfcsnbJTkQkiTgY1Eyv2BJ9E20Zn0clfoIg1C39bil7\nPLuMXB/XuGPfgfYdJU5Dm7eWzO9hlabUgWHUKmbOJXxsZAQ7AAAA4I6+QXbufdacexV6NDSx\nTts1+oLi18SL9V2IFualm3R3ty1qzL4be/hierPOAln3BkRXd6RmtW3xb7r6M/pxyUL5r34d\nHRFvMf5A8uYhRY158lIfJPFf51x+1eYXAAAAAACfVL9raC0ezd22L+xhdo8gh5Id1DTbzjDR\nTgh1S8gpULTIC7Pn9HYd77FST8Cr0zZQR8DbNWLRiwKZYumr5KhJF5+WHKfgTYJMLjfs1rKo\n5cW1jddfF6hizuWHI3YAAADAHXyR6WJLvdlz3IivFdKpbql9/KKX7Wg1pYNpp5EjXVoYqZ3Z\nt+ZwatbE3fuFDJGG9Ql/R4nvD+atUiYO66mekbIjYnv7kZbndxa/44mG4agO2rMueQ70zZxp\npSu7eSVm9ZZrTUWCR0nbT5xr7NS9WcXOuZyKH7GTyWRF/wUAAACodgYFdJAV5OtbBzZUL/1W\nX3pWHslxUYNaC37aFDo3YG2aesfI6MTI4WaKpZ18YmIi5lsIBnTcAAAgAElEQVQziWsDfCIO\nxLkExvy8oE3JQRi+9snLUQM7iDf6T5vmG3b1WaMz95P2+A0SZB4YP/3Hkv3/45zLqfgRu5s3\nbxb9FwAAAKDq6xv/WPl5DiYDo4td6vbNrRfffLiKQbshu08MoY/o7R7Y2z1QqaGnXL5b8Srk\nQVbI+1Ydi6/2//LVB2vOi8qc9+7lzLsZMz8c1vF4Wt6Xzlm5bhkjFz9iZ21tXfRfAAAAAKhG\nigc7xe08qtFjFQAAAABAAQEOAAAAgCMQ7AAAAAA4AsEOAAAAgCMQ7AAAAAA4AsEOAAAAgCMQ\n7AAAAAA4AsEOAAAAgCMQ7AAAAAA4AsEOAAAAgCOKPyu2ZpLJZEQUHx//yZ5xcXFEJJVKVT4n\nAAAAgM+EYEdEdPv2bSIKCwsLCwsrT//o6Ojhw4ereFIAAAAAnwfBjojI29tbJpNZWlp+8iG5\ncXFx4eHhzs7OlTMx1eEbWLA9hcomT7/IVun/TRKyVXpwZD5bpWsmgfUYtqdQ2Vj8Y1L4IoWt\n0iz+PZE9ucBWaagWEOyIiIRCoZ+fXzk7h4eHCwT43AAAAKDKwY8nAAAAADgCwQ4AAACAIxDs\nAAAAADgCwQ4AAACAIxDsAAAAADgCwQ4AAACAIxDsAAAAADgCwQ4AAACAIxDsAAAAADgCwQ4A\nAACAIxDsAAAAADgCwQ4AAACqtzfP9zAMYz05/mMdEld1YhjmaYGsMmfFCgQ7AAAAAI5AsAMA\nAADgCAQ7AAAAAI5AsAMAAACuORW5wM6mkYZQVNfE1jN4f6Gc7QlVFgHbEwAAAACoSPFLnXr5\nxuhYOEzydhc8v7nNb8SRpppsT6qSINh9HplMRkTx8R/93U0VJBKJnJ2d+Xw+2xMBAABQuYKc\nG06LYvWsJt+8saaeGo+I5o7vbNx5KtvzqiQIdp/n9u3bRBQWFhYWFsb2XD5DbGyso6Mj27MA\nAABQufRLPllSmeeexYpUR0R1Ok4JtvDzSnrJ7sQqB4Ld5/H29pbJZJaWljxetbk8USQS2dvb\nsz0LAACAypB+/hERjW2qo9zY1cWYEOygJKFQ6Ofnx/YsAAAAoHQ8Po9K/DhUqCtkZTKVr9oc\ndgIAAAD4JMPuDYhoR2qWcuOf0Y9Zmk5lQ7ADAAAA7qjTNlBHwNs1YtGL9w8Qe5UcNeniU3Zn\nVWkQ7AAAAIA7BBrWJ/wdXyb8YN7Kec6iEJ8ZE1u0GtV+pCXb86okCHYAAADAKZ18YmIi5lsz\niWsDfCIOxLkExvy8oA3bk6ok+PEEAAAAVG8adUbI5SOUW3q7B/Z2D1Rq6CmX767kWbECR+wA\nAAAAOALBDgAAAIAjEOwAAAAAOALBDgAAAIAjEOwAAAAAOALBDgAAAIAjEOwAAAAAOALBDgAA\nAIAjEOwAAAAAOALBDgAAAIAjEOwAAAAAOALBDgAAAIAjEOwAAAAAOELA9gSgZpHe3MFW6cDe\nz9gq/f3JDmyVZgw7sVVann6RrdIsKnyRwvYUgON49e3YngJUaThiBwAAAMARCHYAAAAAHIFg\nBwAAAMARCHYAAAAAHIFgBwAAAMARCHYAAAAAHIFgBwAAAMARCHYAAAAAHIFgBwAAAMARCHYA\nAAAAHIFgBwAAAMARCHYAAAAAHIFgBwAAANVb/GRrhmF++uct2xP5tMRVnRiGeVogU27Mz/pN\nwOMxDNNr790vHnmqsZaeWRiCHQAAAACb7u2bVyiXE9EV313lX+vJ2YBx48a9kL7LiLX0a9fW\nFyPYAQAAALApYskNgahJaAuDV6kB114XlHOtV8nR27Zte10oV7wN/uv+ncseCHYAAAAArMnL\njF396HX97iuHBnWSywq8D6f9l9EQ7AAAAIDj0k5tHmTfWl9LJNau3abn4K1n/i7W4Xb06oEO\nHepoaBhbdFp8IPFU38ZaxlPLuTQj4cj4AV3r6mmKdQxtuw5efyRZeeRTkQvsbBppCEV1TWw9\ng/e/P772rztbfeVy+YBldvV7BKrxmKt+xc/G3j6x3qWLjW4tobaBce9vZlx8+paIApvoWnnE\nEVETkcBIcpyIvBtq65mFCf7jJwUAAABQlT0+42PZJ5Bv2GniVN86sqdHt2ye0Cv6/pl7i7rX\nV3R4+qt/8/5LtFq6uC8Y8jbt98BvWpnqq5GQyrM0M2mTZRuP13q27pPnGolyzv1v05SvbC5v\nTNwywZKI4pc69fKN0bFwmOTtLnh+c5vfiCNNNYtNb1VookDUJKh5bTW+wZxG2kH3Aq+8XtBO\nU02x9MFRL5sBYZo2fd3njRNnJ2/5YW2PmPikp3Gj9x1ruN9jzMqEfSfPNDJoVTQagl3p8vPz\ng4ODLS0tebxqf1BTJBI5Ozvz+Xy2JwIAAFDp5NLxQ1YwOo7X7kRb1hIQ0dwF7g4N24UO9vB/\ncYhHRCSb9HWomuHw5Ms7awt4ROTW/WvrUQc1jRTrl72UFjh5ZWvaJaadNhXxiWiOz0KvNg1W\nT3EMGpOmn/+X06JYPavJN2+sqafGI6K54zsbd56qPLvcfw5tfPK6YZ+dWnyGiEbNsQ6cEu/9\nc9qZUU2JSC7L+XrEGo0mE5KvbaijxiOiKa4NDDssnPC/1NMjurT/Q5uIOnbrZqL+7//EI9iV\nLiQkxN/fn+1ZVJjY2FhHR0e2ZwEAAFDZ3qTvjsnIlaxdpUh1RKSm1XzN/Bat5h0++OLtYAPx\nm2fbj/zztmfUEkVuI6Jm32xvPPHIP4rVy1ya/+rcurQsybr1ilRHRMQTzd3iuLJtVNij7Kn3\nfLKkMs89ixWpjojqdJwSbOHnlfSyaHrJEUuIaMAyO8XbJt/MoylfXfPfTqOWEFH238FXsvMH\nHPSvUzRCe98N6+rUMqz1se1FsCudubk5Ec2cOVMikbA9l/9KJBLZ29uzPQsAAAAW5GbGEpFt\n7/rKjQ0H2tC8KyczcgcbiN+kHyWiLh0NipYyfC0XfdF2IiIqe2luxkkiive0ZjyL103OKkg/\n/4iIxjbVUW7v6mJMSsEuZPUthuE3OLdv7QVG0dJIJHiQGvx7tm8HLWFm4kUi6mejpzQAb9Lk\nEsWUINiVTnEGViKRuLq6sj0XAAAA+E+YYu95AiKSyomIZAWl3F5EwDBUjqXEExKRJOJgUDO9\nYn30TbRlfB6V+JmqUFdY9PrN8z170t8Q0fzpUz/sRXN/SvvlW3NZvoyIhEzx6Zeh2l9ABgAA\nAPAxIl1HIrp+6oly4+PoBCJy0FMnIrGhHRHFXfmnaKlc9ubYy3cPsfjEUn0XIspLN+mupE2D\n/IcPHxqKBYbdGxDRjtQs5dJ/Rj8uep0UHkpEo359LFfy5vkBIrq+aDsR6dhYE1HMvQ9GWDjZ\nbZrf1Y9tL4IdAAAAcJaG4ShHPdEfPrPuvpUqWqQ5ydMW3hDr9/umjgYRaRpN7aKjfmmq/6v3\ndyK5fWDsnfedy16qptl2hol2QqhbQs67A3vywuw5vV3He6zUE/DqtA3UEfB2jVj04v0DxF4l\nR026+LRobos3JPPVjcMkdZUnLDYYMrZuraz7yy5m5+s08TUVC05OCMqUvqv+MiF8UcSmS1r/\nHvaTf3j/FJyKBQAAAC7YHxL4l8YHwUak6zB3ut22qBmmTstamTt4TOhXR/70UOSGi1mM3y+b\nFAe3GJ54/4+zmzoFmkveeA7pkpv2e8Te+330RPF8jU8uJSK/6GU7Wk3pYNpp5EiXFkZqZ/at\nOZyaNXH3fiFDpGF9wt9R4vuDeauUicN6qmek7IjY3n6k5fmdSUSU83TjoX/eNuy9ykBQ/Cjb\nLC/rbd6X5/3v/tmxFtHrRliN/6Fp+zSPoT003tzbvDJCXafd9u+siEigKSCikI27nJr2+qrv\nu5/pItgBAAAAF0SFLC3WomOiNne6nXGvoKTjpjOW/rBphW8uaVi1d9q8N3xct3pF3Ywcl975\npdG4uWvC/I7Xbt591x9n9rSvy1dvWJ6lelYeyXEG031Cf9oUuouv08y6Y2R08EQnM8XSTj4x\nMXW+X7R659qAMxp1mg4NjFnab3PtnUlElLBsNRENXtGj5IaYT1jIzHX5Y9FWGhtkOXb7tVrN\n54RErlp0TKZu0N7Jbevq0GZiARE17LfI3mrk5pluv/Q5jmAHAAAAHCFZf1O+vqwOTXq7Hert\nVvoyuXRD5GZdi69i4ia9b8h0y8yrO6DNp5cSEZFBuyG7Twz5WOne7oG93QOVGnrK5buJqF7Y\nX/Kw0lcR6TvLZLKit7auc2Jd55Tspq7b48zNR0VvQx5kheAaOwAAAKjRGEHC8nljvx4Wcz0t\nTyrLTr+75jv79EKx7xLbTy+tenDEDgAAAGq0kN9+ftR3hFMbE8VbUW2bRQeujqinUZ6lVQ2C\nHQAAANRoYsPuP1199CT11t3UJwJdo9atm6kz5V1a1SDYAQAAAFD9Jlb1m1h92dKqA9fYAQAA\nAHAEgh0AAAAARyDYAQAAAHAEgh0AAAAARyDYAQAAAHAEgh0AAAAARyDYAQAAAHBENbuPXX5+\nfnBwsKWlJY+n2kgaFxdHRFKpVKVVAAAAACpQNQt2ISEh/v7+lVYuOjp6+PDhlVYOAAAA4L+o\nZsHO3NyciGbOnCmRSFRaKC4uLjw83NnZWaVVWFT4IoWVuoG9n7FSl4i+P1mXrdKMYSe2SrOo\nZm41i+TpF9meQmWrmf/GauZWQ/lVs2CnOAMrkUhcXV1VXSs8PFwgqGafDwAAANRk+PEEAAAA\nAEcg2AEAAABwBIIdAAAAAEcg2AEAAABwBIIdAAAAAEcg2AEAAABwBIIdAAAAAEcg2AEAAABw\nBIIdAAAAAEcg2AEAAABwBIIdAAAAAEcg2AEAAEC1JytIj1z8XeeWZjq1RCKt2mbWnTx9Vz3M\nL/wvYyau6sQwzNMCWUVNUqXys34T8HgIdgAAAFC9yQrSR7Sw9Fi47o1x5yneC5d8P62HtWhz\n4Exr876puf8p21WIJ2cDxo0b90Kq2oB4b9+8QrlcoNIaAAAAAKqWtGFwVHLmyO1/7RrT/H2b\n/6LTSxv38nOafDZ5qwObkyN6lRy9bVucf8QmA1XGroglNwSiJjhiBwAAANXbtXW3GEawaVRz\n5cYGDj7j6mo8OLq2UqcilxYUyitqsMK8zHL2zMuMXf3odf3uKxHsAAAAoHrT1FKTy6XbUorH\noOVxf/wRH67ckpFwZPyArnX1NMU6hrZdB68/kqy89FTkAjubRhpCUV0TW8/g/cUSWhnrhpnp\nGVjtS9zrZ26opa7G1zcydfEISMsrJKLAJrpWHnFE1EQkMJIcV/SP2xHYq6O1rqZITaxp2rzL\n7FVHi4YKbKJbt/XR7HuHnG1NdI1HE9FfoR0Yhjn2MreoT0HODRGfZ+V+oajlzlZfuVw+YJkd\ngh0AAABUbx2CBxPRd62ajfMOjr7w5xvZu0Sm26SpRdNGRd0ykzZZthm079LbEZPnLvYa3yDr\n3JSvbMZvfpfP4pc69XIPTJBaTPL2Hd3HZr/fiH6RSeVcl4hynm3tMGZFu1HeG7dEjO9a+9gG\nn+6uPxLR6H3HdsxqTkT7Tp7537qORHR7+7Au3y64JWzu5RMQ5DfHVuveihn9Rx75u2iogje3\nHNtN1LQbsTx0ChE1HT+fiAL23ivqkPbzrDyZfJq/bVHLqtBEgahJUPPauMaudDKZjIji4+PZ\nnkgFEIlEzs7OfD6f7YkAAACohJH9ml8j1N18128Lnb8tdL5Aw1Bi79i7T/8x44Y00vw36ixw\n8srWtEtMO20q4hPRHJ+FXm0arJ7iGDQmTT//L6dFsXpWk2/eWFNPjUdEc8d3Nu48tTzr1lXj\nEVFuxsmh+1L2DjMnIhrrlndBe+Ova4mGNezYpf0f2kTUsVs3E3U+EZ1YEquu2z3pbJQmnyEi\nufdMYw39C+tTqP+7DJqR4m17+P6G/o0Vb8W1B40w1Dgaso2mhChatvpe1TD4erKRpuJt7j+H\nNj553bDPTi0+g2BXutu3bxNRWFhYWFgY23OpALGxsY6OjmzPAgAAQFW6uq9ImrQs5cq5U6dP\nnzp16szJfeeP7VnkPXfZzxdm9WlIRPmvzq1Ly5KsW69IZkREPNHcLY4r20aFPcqees8nSyrz\n3LNYkeqIqE7HKcEWfl5JLz+5brCJDhGpiS12DTV/Px1mgI1eZHxOqVN1u37/W0akSHVEJH37\nlIgK3/77612B2HStS2PlVbzcLfYuDbv8OqC9plp+1oVl97Nsl/gVLU2OWEJEA5bZERGCXem8\nvb1lMpmlpSUH7ggjEons7e3ZngUAAICKMQKL9g4W7R085wUW5j0/HBk80Svce0DHfpl/W4oF\nuRkniSje05rxLL5eclZB+vlHRDS2qY5ye1cXY0p6SURlr6t4IdSWqDFKc+Ezxbu+J9LSfnj+\n4LqY3xJT7txPvZtw41ZmQaGxUgd1nR6CD9duNmW6fMm476MfxA41vbtnnoxoiadl0dKQ1bcY\nht/g3L61F3DE7iOEQqGfn9+n+wEAAACrCnPvjBrnazI4KGiISVEjX73OoKkrGmWcbed/bXHq\nq93WtYknJCJJxMGgZnrFRtA30ZbxeVTisQ1CXeG7V2Wuq3jBMGrlnPAezy4j18c17th3oH1H\nidPQ5q0l83tYpSl1YHgaxVbRqDu2f23P3xb+RENnrwv4U6vhzL56IsWiN8/37El/Q0Tzp08l\nHLEDAACAao2nZnjkwH7NVIegIROLLdKz0iYiHSGfiMT6LkQL89JNurv/+5uD7Luxhy+mN+ss\nkHVvQHR1R2pW2xa1i5b+Gf1Y8aLsdT9rtvmvfh0dEW8x/kDy5iFFjXnyT98hxWe0meSHhTcf\nW6599Np+m0dRe1J4KBGN+vXxzq71CY8UAwAAgGqN4WuHdqmX/vtk34NJyu2Fufe9Z1wRiEz9\nG2sTkZpm2xkm2gmhbgk5706eyguz5/R2He+xUk/Aq9M2UEfA2zVi0Yv3DxB7lRw16eJTxeuy\n1y3nPBXhreBNgkwuN+zWsqj9xbWN118XfHJ169mTZIU5Q76bQowobLBJUfviDcl8deMwSV3F\nWxyxAwAAgOptwpFD/2vWY+nXVgd7DHBsZ62jIch4fPfUwYNJLwun7Y2t+/73EH7Ry3a0mtLB\ntNPIkS4tjNTO7FtzODVr4u79QoZIw/qEv6PE9wfzVikTh/VUz0jZEbG9/UjL8zuTPr3upwg0\nBUQUsnGXU9NeA3qP6qA965LnQN/MmVa6sptXYlZvudZUJHiUtP3EucZO3Zt9bBBN4++66845\nd/CBQYuVLWu9O+2b83TjoX/eNuy9yuB9vsQROwAAAKjehNrtYu4lrfPx1H+ZuCMiPCBo+d4T\nVxs5jNsXlxo+zLSom56VR3Jc1KDWgp82hc4NWJum3jEyOjFyuJliaSefmJiI+dZM4toAn4gD\ncS6BMT8vaFPOdcvWsN8ieyujzTPd5q65xfC1T16OGthBvNF/2jTfsKvPGp25n7THb5Ag88D4\n6T+WOQyzdEgTIrJf6VrUlLBsNRENXtHj307yD0/rHjhwYOjQofv373d1daWqp4pPrxrJuzGH\nlboBtodYqUtE35+sy1ZpxrATW6Wh5pCnX2R7CpWNxT2LxU+7xv49UW8VyvYU2Hd8iFn/I68f\nZj+pJ/zogTmcigUAAACo6grz0r479ne9zjvLSHVUMthV8ScuxMXFEZFUKmV7IgAAAACVQi71\nWrDo5aUt93KlIRucyu5bPNhViycuREdHDx8+nO1ZAAAAAFQC2Ylda/9+q+Ox/PQcC92yuxYP\ndlX8iQtxcXHh4eHOzs5sTwQAAACgUjDCxL9flrNv8WBX9Z+4EB4eLhDg0kAAAACA4qriYTkA\nAAAA+AIIdgAAAAAcgWAHAAAAwBEIdgAAAAAcgWAHAAAAwBEIdgAAAAAcgWAHAAAAwBEIdgAA\nAAAcgTv91lABtodYqTtv+21W6hIRUV22CsvTL7JVWvbkAlulefXt2CrNIsawE1ulBdZj2CrN\nlsIXKWyVZvHTlt7cwVZpFv95Q/nhiB0AAAAARyDYAQAAAHAEgh0AAAAARyDYAQAAAHAEgh0A\nAAAARyDYAQAAAHAEgh0AAAAARyDYAQAAAHAEgh0AAAAARyDYAQAAAHAEgh0AAAAARyDYAQAA\nAHAEgh0AAABUe7KC9MjF33VuaaZTSyTSqm1m3cnTd9XD/ML/Mmbiqk4MwzwtkFXUJFXhuMSI\nYRixnoOciBDsAAAAoLqTFaSPaGHpsXDdG+POU7wXLvl+Wg9r0ebAmdbmfVNz/1O2qxBPzgaM\nGzfuhVSFATE388z6x68JwQ4AAACqu6QNg6OSM0ds+/OP4zsD/efNme+/+cezd08uznlwymny\nWbZnR6+So7dt2/a6UK6i8Xl8TTOxIGLlLUKwAwAAgOru2rpbDCPYNKq5cmMDB59xdTUeHF1b\nqVORSwsqLsAV5mWWqx+jFtq1/p1tAYRgBwAAANWdppaaXC7dllI8Bi2P++OP+HDlloyEI+MH\ndK2rpynWMbTtOnj9kWTlpaciF9jZNNIQiuqa2HoG7y+W0MpYN8xMz8BqX+JeP3NDLXU1vr6R\nqYtHQFpeIREFNtG18ogjoiYigZHkuKJ/3I7AXh2tdTVFamJN0+ZdZq86WjRUYBPduq2PZt87\n5Gxroms8moj+Cu3AMMyxl7lFfQpyboj4PCv3C0UtdkF93/5zaFf6G8EXfHwskslkRBQfH8/2\nRKoTkUjk7OzM5/PZnggAAIBKdAgeTD3Xfteq2aXpM1wHOPfo3EKDxxCRbpOmukrdMpM2Wbbx\neK1n6z55rpEo59z/Nk35yubyxsQtEyyJKH6pUy/fGB0Lh0ne7oLnN7f5jTjSVLOc6xJRzrOt\nHcZcGPCd97xWxreOb1yxwSfhcdP7h4eN3nes4X6PMSsT9p0808igFRHd3j6sy9j9xnauXj4T\nxPLXcYcjVszo/8Q0bXf/RoqhCt7ccmwX0niE2/K23Yio6fj55P11wN57/aZYKzqk/TwrTyaf\n5m9bND2DlsH1hZvDNqQwcrmqzviqwtKlS319fdmeRfUTGxvr6Oio3OLHWLAyk3nbb7NSl4h4\n9e3YKs0i2ZMLn+6kGjXzA2cMO7FVmm/Azk7NosIXKWyVZvHTlt7cwVZpFv95E5F6q9CyO5zf\n4OXmuz75+VsiEmgYSuwde/fpP2bckEaa/x7DmmKisyWrdeLj06YiPhGRLNerTYPVSeKH2Wn6\n+X8Z6Lbhm7vfvLGmnhqPiJ5fWmvceWqBTP4kv7CeGq+Mdeuq8cLM9Gbdyxy6LyVqmDkREcmn\nGmtvzGmdm/krESVt6GLlEZeaKzVR5xPRD0315/zT8sWLXzT5DBHJC7OMNfTVHE6kRTsSUWAT\n3QX3X006fH9D/8ZFMx9Zt9ZR0ZRXaSGKtwtMdcOzHXKe/4+IjkuMXK7kFha83NPVaNLt3tXs\niJ23t7dMJrO0tOTxcBK5vEQikb29PduzAAAAUKGu7iuSJi1LuXLu1OnTp06dOnNy3/ljexZ5\nz13284VZfRoSUf6rc+vSsiTr1r9LZkTEE83d4riybVTYo+yp93yypDLPPYsVqY6I6nScEmzh\n55X08pPrBpvoEJGa2GLXUPP302EG2OhFxueUOlW36/e/ZUSKVEdE0rdPiajw7b+/3hWITde6\nNFZexcvdYu/SsMuvA9prquVnXVh2P8t2iV+xYXsGO+TYba9mwU4oFPr5Fd8SAAAAAGIEFu0d\nLNo7eM4LLMx7fjgyeKJXuPeAjv0y/7YUC3IzThJRvKc141l8veSsgvTzj4hobFMd5fauLsaU\n9JKIyl5X8UKoLVFjlObCZ4p3fU+kpf3w/MF1Mb8lpty5n3o34catzIJCY6UO6jo9BB+u3WzK\ndPmScd9HP4gdanp3zzwZ0RJPy2LDGrYP0VfbU82CHQAAAICywtw7o8b5mgwOChpiUtTIV68z\naOqKRhln2/lfW5z6ard1beIJiUgScTComV6xEfRNtGV8HpX4SalQV/juVZnrKl4wjFo5J7zH\ns8vI9XGNO/YdaN9R4jS0eWvJ/B5WaUodGJ5GsVU06o7tX9vzt4U/0dDZ6wL+1Go4s6+eqFgf\nnrB+cEsDBDsAAACoxnhqhkcO7NdMdQgaMrHYIj0rbSLSEfKJSKzvQrQwL92ku/u/vznIvht7\n+GJ6s84CWfcGRFd3pGa1bVG7aOmf0Y8VL8pe97Nmm//q19ER8RbjDyRvHlLUmFeOHzz4jDaT\n/LDw5mPLtY9e22/zKLVP3yA7XKkGAAAA1RjD1w7tUi/998m+B5OU2wtz73vPuCIQmfo31iYi\nNc22M0y0E0LdEnLenTyVF2bP6e063mOlnoBXp22gjoC3a8SiF+8fIPYqOWrSxaeK12WvW855\nKsJbwZsEmVxu2K1lUfuLaxuvvy745OrWsyfJCnOGfDeFGFHYYJNS+9TvGoojdgAAAFC9TThy\n6H/Neiz92upgjwGO7ax1NAQZj++eOngw6WXhtL2xdd//HsIvetmOVlM6mHYaOdKlhZHamX1r\nDqdmTdy9X8gQaVif8HeU+P5g3ipl4rCe6hkpOyK2tx9peX5n0qfX/RSBpoCIQjbucmraa0Dv\nUR20Z13yHOibOdNKV3bzSszqLdeaigSPkrafONfYqXuzjw2iafxdd9055w4+MGixsmWt0k/7\n8kWmOGIHAAAA1ZtQu13MvaR1Pp76LxN3RIQHBC3fe+JqI4dx++JSw4eZFnXTs/JIjosa1Frw\n06bQuQFr09Q7RkYnRg43Uyzt5BMTEzHfmklcG+ATcSDOJTDm5wVtyrlu2Rr2W2RvZbR5ptvc\nNbcYvvbJy1EDO4g3+k+b5ht29VmjM/eT9vgNEmQeGD/9xzKHYZYOaUJE9itdy+pUve5jBxUF\n97GrIXAfu0qG+9hVJtzHrpJV8fvY1QTHh5j1P/L6YfaTesKPHpjDqVgAAACAqq4wL+27Y3/X\n67yzjFRHCHYAAAAAVZpc6rVg0ctLW+7lSkM2OJXdF/+4mUoAACAASURBVMEOAAAAoCqTndi1\n9u+3Oh7LT8+x0C27K4IdAAAAQBXGCBP/flnOvvhVLAAAAABHINgBAAAAcASCHQAAAABHINgB\nAAAAcASCHQAAAABHINgBAAAAcASCHQAAAABHINgBAAAAcASCHQAAAABHMHK5nO05AAAAAEAF\nwBE7AAAAAI5AsAMAAADgCAQ7AAAAAI5AsAMAAADgCAQ7AAAAAI5AsAMAAADgCAQ7AAAAAI5A\nsAMAAADgCP7ChQvZngNUT7K3Z48funovo07jBrX4TCUUlOY8jv/11/hLlwtMrerKXxbwK6ds\npZbOyckpKB+hUKiSGZSqJn3X/6rErR49erSsW19rDbVi7ZnJoZPnnxg4oKfqSo/1CqxVp5FZ\nfV3VlShDTdipy4I9i4XyNYAcoHwK858GjutjbtpL8W6+nZHin5C2Wb9LWXmqrn4xYnYDkUBR\nccH9V08v9hMb2vhsv6LqupVcuorsuTXzu678rS54nZWZmZmZmUlEs/98kFlcxsWNnXkCHVWU\nLqLOY4ioTrMuM5asu3w3Q6W1iqkhO7Uy7FmVv9U1EIIdlFf0aHMishu8QC6Xv0zyJiKHpXtO\nH1zfRCQw+epnlZZ++tsCPsM07Prtxl0/Kf4k5Tz96ev2hgzDm336EZdKBysLWtpWT8Tw1Nr3\nHjr7e/8lfnO/dbUX8Rg9myE/HlTtB14zv+vK3+oTPYw/meBr1RutitJF3qYn71mzeICdNZ9h\nGIax6NRv0Q97br/IVWlReU3aqZVhz6rkra6ZEOygvNpoChs571O8PjfKXE1snimVyeXyC5Oa\nCbU6qLT09011tRqNeVsol8vlij9JcrlcJn01obG2duPZXC39x7KefHWjHZefKTdmJB1qKhbY\nL72q0tI187uu/K1OjdqwfPny5cuXE5HjgqXLS1gZHhH/5I0qSpeU/eDGluXf925nyjAMwxN3\n7Dtq1a7jz3KlKipXM3dq7FmVvNU1E4IdlJeYx3SOvKV47VZf07DNDsXr5K12DE+s0tK6Al7H\n8ATF66I/SXK5PHFNJ56aPldLO+qJmrmdL9l+aXpzdZ1uKi1dM79rFre6R48em57mqLRE+T29\n9j8XG33F8UK+ep0+I6buPZNS4VVq5k6NPauSt7pmwq9iobxsNYXPTv9NRPlZcVuf5rSa10XR\nfufYY4GosUpL6wp4Ba8KSrbnPsvl8TS5Wvr37HxNM+2S7bVMahXk/KHS0jXzu2Zxq3/55ZcJ\ndTWkOY9/O3Usau/u6zkFsrzn+Z9xyWUFePssKSoi+Js+Hczaux5NfKndqNXYmYu9v+1668iG\n4T0thob9WbHlauZOjT2rkre6hmI7WUK1ETvOksfXmvT90vFd6vIE2pey8gvznhzYuFBHwKvX\nKVKlpde2MVTXsbv3VipX+v+a+VkJXbTVDVqGc7X00Doamkajs6Qy5UaZNHtcQy0NwxEqLV0z\nv2sWt1rO3oXtL25f3hjyvbPESsAwRGRg3sF93rKTl+8U/bMrzHs2t5WBULNVxdatmTs19qzK\n37NqIAQ7KC9p3gOvfjZ8hmF46mNCLsnl8teP1xCR2KDtMRWfRcq6v6OOGr9W/c7zAlYT0eD1\nW9cEzmxZW8RT09905xVXS6dsHUxE9SQjdx47m5T6+HFq8rnoXaO7GBGR6/bbKi1dM79rFrea\nxQvbFVHSyKbrVL/wszcelNonfrK1moZ1xdatmTs19qxK3uqaCcEOPk9+5pN/cgoUrwve3Dpw\n+Jf0/MJKqJv+++5+7RoqH2xu0rH/7ovPPr1mdS7906LRWvwPrpfgCbTHLDlYCaXlNfK7lrO0\n1Sxe2D47YH18UvonOhUWFhbKPtHn89XMnVqOPatyt7oGYuSfc+ssAGnO40vx1x8+z7QYMLSV\nIFMqrCOsxBtMZvx9M/HeEylf3KBpi6b1tSqvMHul814kHTl2Oin1aQFPZGRm4+Ds3FSvkm5N\nXDO/a1a2Wk+Nb7n8z4vTbYiIYZgF918tbaxNRDfXSlrMTCnM/0flM2BPDdyp2VWj9qwaiu1k\nCdUJizcUhUpWM79rtrbaRCRos+i64jUp/WLxqq+tQL2RSkuPGjXqwPNS7qiSkRQydqKPSkvX\nWG+f39q/5Qe/BfPmzPNZuWH3H4+4fzqyZv49YYug0pMkVFfP4ny6TF5hZDdmo/tXbqO+JiIt\nkwl9G3sEjO2Q2+BBaE8jlVaXvvl7d+SOrG4eU9sYENEfflP2iFu4T51gpln8KUzVuvScOXPK\n2TM0NLTCqxep5O+6V69eAlHj40c2KV6X0TM2NrZiSytj8V/4HGv9WSunpnqfbSLiFzUWZCdO\nW3VL13KZKipKc7JzpDIi2rVrVz3voF5qxY7cyJPP/7xjW+LWjUtUUf3dHGrGTl3MAb8R4wKj\ncgplRS0MTzTYe9P+oJGqPoDF1laz+78dNRHbyRKqDRYvA8p9+UsHfRER9TxwT9FydpgNEYn0\n2p568ZZLpavInlvJ33W7du062bkqXncqU4WXVsbiv/DKv7Cd9Yde1JydWllS5AAiatBjXNSp\n35/88yrj6f2LZw5MdGhERP3W31RpaRa3msU9q2ZCsIPyYvH+lrt7NhCIGkWeuaV8qW3abzvM\nxAKjblu4VDqh3Cq8tDIWv2sWsbvVlXxhO+sPvag5O7WyIQYaWg3H5xT7JUrhG3cTbbHBIJWW\nZnGra+bfExYh2EF5sXgZkKWGmpXHhZLtl7xaCMRNuVqaRSx+1yyqClv9Mi3x/C+nfvn1t9uP\nsyqnIlsPvaiRO3WhmMe0D/mz5IKEVR15Am1VlmbzA68Ke1aNgidPQHnNsdZPXDk1NbdQufH9\nZUCzVFr6eUGhjo1eyXZtCy2Z9CVXS7OIre9aLn3ZzMJidOxD1ZUoA4v/wovoNbK26+HQo2vn\nSvu5ouKhF5VTS1kN3KnlslyGYbJTXpVclJWcLdTurLrSxOoHXhX2rJqF7WQJ1QaL97ec00hb\nu8mk1x+ev5AVvplipqNlPJWrpVnE4nc9oYFW0+ExKi3xMSxudSVzdHR0cplQ9LoMqptDzdyp\nNw804asb7bj8wRn29Gu7G6oLnH9Q7fUVLG51zdmzqggEO/gMbN3f8ukFHwHDGLYbvGbX/9s7\n84AaszeOn/du1b3dFrptbpuKKDslikJqiNRFSkUjsox1soxkLI3GTjTIGJKtUjdibPlVsk4S\n0Y4iqYR21d3e3x+XJmmqGfd9z9X7fv56nY77Pc/bfc55Ostz4tMePs7KzLgUc9hzZA8EQZZc\naTtXfheQhgus33X107hBHE5w9F2h7BPidgyeVmt0GplLy8NpFWI6dfiBX/uyGQiFPtRhytxF\nK378Yd6U8cMUKAhDuV/gur/ZHV0oc2m4XRnc3MhEg0xQTPKvgZLfMisqePriLdkVDc0ldGX9\npbvObJ9r3YWloYP/79rDw0NYmxt78aGCeo9eBloKtM+2i6SlpeHQBnysRhAEAKDIMR03wpzW\nbqILPp+PURvgQkCnlv7SO8RkRkrB6VEyV4felREzIzT+kIEdSWfx9vZ22R0+VUOpVXlV3vbl\nO2owzXclBRXXpacmZxa8ahDTtA3NRo0ZwWHgtEkUojTRsLe3b+enSUlJuLUEa36a786Pv5BX\n/oGpZTbJ1ZXn5uY8dogSBXYyfklD8uWL76g6o8ZYc+iYf8mJ5tRisbjjSgAgFCpGXwQoVkMf\nO4gGGdiRdEBzIlM1NbWAzOJ1+q0TmebGTByxIEssrILSPBKSbxhUlHXrMp/Pj+PzMworGar6\nTlPc3NzcJn83Uh37oEqKRFi+1X/W0RRJ/rOrAEjW2uqF3HwNAFAxnngtI86SjdP9dYSCIJdr\nkWMHLMjAjqQDrthznZJL2q/D0vauKz2OXRvEgpKQ+QvPJD941yD68qelpaVdUhpn5OT6h09I\nSvIfZj8vbRDTdIz6DOmrj1GYIz9Wv3iYHBcXx+fzU5+8oilq2k2a4ubm5jp5rDYT2/uBLvn0\nmhBZYMMLTD0bXJm3upvZtrHBp9aaV/t5LEYdzxbGu2CkS1invndo5dRle141igAAgUXVi8s8\njSYX/bg9YrPPEEx18bdaHsYOYkJeKUbSAb0XrN/hXAsACAgIGBcY7KSu2KoChaZs7e6DaRsS\nvrcLOvlUb/h4J3P99ncjdSVpnKmqqqIpfsyGUFdXB7ElT/8MnbVs4+2Cv1MwqJmM2LQvcrFT\nT5lryY/VBgPtlg+0W74p9G1BGp/Pj4uLW+x5+Acq29rJ5WYChiPfOv4L/QlnUs+6AwAeB/Pp\nSqaxa2aoUpFIn71jTm8BAKvAjphODfFyLfytloexg6DAPbtB8g0BK5EpiqI9FWnc8WEwTknC\nlCYmFQ9CFCgIU3towJbQ2PN/XroQH7Z1taUuC6Eo7Xj0Dnbr8KOmODNs1VRFCoJ1L61EQUaE\n50if5+ooaw4+Ln3OO2qDUJSw0yWmU0O8XAui1RDHDmJCBnYk8o5E/AEA4Hj9FaGkISIRvutt\naup1FU4yl00makrdHZ82iFoWihqef6ehpN57C3a6cK1u5m1BWvjWNY6WphQEoVCVLR09tobH\nYKporaJg7H4FRdGm6ls0BHGIfiYtvzi1J51phpEoYZ0a1uVaxOzKCAu5FEvSWQYNGtTOTzMy\nMjDSRRC6OYtecvEFGNPxteVdRhoiCK2bTUNZytFs4MDFX/3Ay9q+67caK1JbFlIVjbaushgU\ntB+AnzDShWv166ybsbGxcbGxyZnFFLq6zQSX3RG73KY4ctl0rKU38Qwdj0/1D1wtStknobKD\nnfQkgrK444f84ou6Dz2IkShhnVqNRhFWC78sbyxvpFCUsdOFazWssYOwkCkbSDoLtxU9tCmC\nqocPHz7OLh8+yg5DYYR27o8FhfsnbYy4LsT5qA9EaajsSo5gJ3r9EnNPhLvVEgCQtjI9IDQE\noJ1KFfGfwd/qwvTEHYELrXtr9rCwXfHrabrZxINRV0trKlLijy7xdsYhqgMA2B9MXO6kfyQk\n6OidKq8t1yzZ9IZ3sdPmbhCoDToSPxMrVaI6NbTLtaBaDW3sICrkqViSr6IwJWKckx9t8sG8\nqDnYqbi6ur5JT7xdXMdgc3oa6ipSPxv4Mf2DD6I0RCBmCf7ZWH1HrW1uMV9P4e9JO7GgZJp+\nryRWQOWzjdhJ42z1ICP1h0VVDBU9xyluPB7PZYKNGrzjOcLqslq6RjcmDQAgasiNTywb7TQK\n0zx2xHTq2heRxqa+HzSsFv8w49fAJbwDR+0rM8N3HnhSwwzPKZxjrIKdtLx1ZfiMHcSEDOxI\nvpbMX4cNXJueVSfog1leBoh5KOQg8QcEIGYJrrj/i55VEF1v5LIl3sPNjRVAY2H2vci9e24W\nN22692rdUA520jhbLb2EgMpQ7DB8amho6KDGNwhhnboi7ZTvwjUX7xc3lxhZTQre+7unlSam\nunLYleEwdhATMrAj+Vpep37HHX3leYPQUIHacW0Sko7IP7/Ta+mmtKKa5hK2wdD1e08EuPSG\n2CqZ4+3t3cmakZGR2DWDOJka5Qryci1Ajh2YQQZ2JF8HKtgxxmjtX6qC+mz8xWuLQyb4ZKYm\nnSaUNI7glCW4DVDRs8d/5RSWNgEFHcM+lv2NcVylhGc1DOK9TF1PPtUbPn5sW+nNDh8+jHN7\nurZTy+HlWtBeONSxo2tDBnYknWXSpElflElKC+6m573vu/BaVtg4TNXvnQqLupFR2fTZpuPS\n++cS86giQUVXlYYInlmC5QcCWm2sRBeM2vvyykL89/cRx6nl5HItWC8c7thBQMiFbZLO8urV\nqy8LqWr956x03xUyFlPppyfch3tH01kcVVD5tl7E5XJRSVNp6VuqkrHvJmxnFCBKQ+Rtxq8W\nk9ZSNYcEbNlgbWHCpAieZ92J2Lt/6UQLQcarH/t3k62cra1tJ2umpqbKVrolOFvdEljroaik\n4XmjyHG1C/5RHaGc+rpzn+bLtXb019vRVh2WdmeX5v8bEF84xLGDmJAzdiTfALO1leOZs14U\n7Gc15WqqWuwpqfXRZJbfCTcft/HI8wIXLWaXlIbIZlP1kEqrx68utswnJ24snKRnfrd70Ptc\nGSeTk5PADmerWwJtPRQVWbCZiH/y450jsJL4Bwjl1EXR4bHFHV+uNVy79RKtDCFmV0ZQYGZH\nJiHpHCo0iuXOx9LnhbrK4z9dD5A4u5fOyCNdVRoiOgzqkOCHX5ZnbhtGVdDFvz34ANFqiNc9\nPY1awmJ023AsUYCvPDGdGuLlWsTsyohJ194WTNJFYCAI8inrkr0WsyTh46KGxQLTinRstxtD\nlIYIxCzB/0RtcYitvQemErCslq6HmsNYDwUABJx+OUBLsGH2OGVVzT79Bw76HOx0ienUSUlJ\ncz7NjYnqX6Rc5ifey/ogwWPdjJhdGTEhAzuSziIWlAR/72LRU0+nLTCV9tRk5oUdqZegAICe\n3+m+jDspLX+f/l4irmn3v37D0hDx57Kzd68r/nyTtVhQsn7rEzbXH2v1e6fCVsz38/2caRO2\n37mViKkuLKv/vu4JBnV1dczew8eNGzfKagBXi6PxOdjpEsqpxQ1FIYvczU17XqpslJaUJoX0\n0jK1+87NYbiFmorx+tNZWOi2BOILhzh2EBTYU4Yk3wz8mSYAAL3h42fP8fsSTKULY2cDAFQM\nB5QJxNVF2wAAjkuDw0OD+zLp3cw2dVVpiLxJC1agIMoGNut2HrpwOfHa5Qvhu4JsDdgIhbE5\n7Q2m0gWR0wEAdBZHg0UDAHC53B66HAqC0JkmfiFJmEpDtBrWeihEiOPUosaXTrosBEG4vQal\nVjehKCpqeKavQKPQuy36JTR85wbHXqoIQt+fXyVz6ZZAfOEQxw5iQgZ2JJ0F4jYgFEVTjm5w\nGjW8pEmMougf820pCAIAYOnaxBXVdmFpiOSd2zHM8LMLjtgGQ7fH52KtO0uLpWq0sEokEdZn\nq9MoEeX1KIqW3T7Unakbj/3mJFhWT5kyZYSeMgCAweaY9Rsw8HOwVkdRVFhXcvPahTOnTjyo\nE4gb3zTh4ucEceq01QMQisLm2KzmkoLjYwAAjgc/loganvdUpPUYfVrm0q2A9cLhjh0EhDwV\nS9IpUEkDhcp0vP7q8pgesNsCAACVhTnP6ujm5sZKbW2K6qrSeAMjS7AqnWq29dG9FRYAgEU9\n2E+P5Vxx4AIArvv29i5Y/frm95i3AIbVcK97undo5dRle141igAAgUXVi8s8jSYX/bg9YrPP\nEEx1W9FVndpTi5XUM6z0zuzmkt/6aSzOFRfVvW2+EDnBjjvtYc/GqhsyV28HfF64vI0dhAB2\nZEnyjSARmrPoFituQRH38vKKqfjwZXll7rbZfuu6qjQx0aBTrfY8kT7HDNI0X3xX+lx2byJN\n0RBeu7osZbcCqQiiZzvr8Ik4AEBgUXV9WZzbME0EoQRcL8FOlzhOrcOgNh9HRVFUIq7TYVDV\nTbe1rHNvuQWFqixz6ZZAe+FQxw5iQs7YkXSWZ9FLB3ifWBkevdZnLB2Xv6ghpmuXk0zxeCIn\nyeSWclWOM/1e5e5kUZAHgYPsImxrXoUCAHIOjLBYmicWvJOtnJxYDZFAU/V9gslvCiMUKQBB\nkMCi6mADFVRcM9dYLwbMqy7aLls5Ajp1dwbVMCg9PWig9J81RZtUjX622v3k7jLz5jq35/YZ\nHVkvbHwpW2kgH10Z/mMHwSEDO5LO4urq+iY98XZxHYPN6Wmoq0j9zEEzMjJkrnjFntucrv2f\nYGl715Ue70rSsJCTEKcozteId0zFcEB+/gOl1ztVDVc5Lg3mGYM9azaW6Qe9ywmSrRxEqx0c\nHGiKBpcSfgdQl2LV6dTeOzLvLjUH4O/ADgCQHWbdb3m+zCNpAjq1l5byFe2fKx6tlP7zxtw+\no3/P3VtSu0RXubnOOkO1vU3Taktln4laHroy/McOgkNeKUbSWT6mReiNn2LvBet3OHecrr2L\nScNCTmakDN2Ophw1DDl6WYwCFYOVf8xP8AsNuoKiLF2byMvLZS4H0eqqqiqaorr0ua6uDlYz\n1GgUYbXwy/LG8kYKRfnL8q+EgE693N/sVPDqhQcGh/jZ1z0+O/14gYKq7UKdv99tfvzqX15U\nDwlaKHNpIB9dGf5jB9GBvRZMQtIxENO1Q5SWQ2pebrGxm4Gz6Pvn2WmZBR/E0A7VQbEaN8IG\nayqo2jxvEKEoCgAILKpGUVRQ82SkioJG/z3Y6RLHqcWC0mm91AAACPIxcaz3kTzpj3LDNvlM\nHoYgCEtnbHGTCNNmkF0ZcSCXYkm+QSQNyZcvvqPqjBpjzaHjm2QbojS+3DsVFnUjo/LzbL2l\n988l5lFFggrsdD+IUOanY6jCuvSURxSr4QPZVJw25sCyGiK1LyKNTX0/aFgt/mHGr4FLeAeO\n2ldmhu888KSGGZ5TOMdYpeOPkAld2qklwjfHd+++cCtTwtIaPXXhUreh0vILg7RcHtfZeSza\nvj94sCoDC+l/bhNRujICQgZ2JO0hJ9uAJMLyrf6zjqZI8p9dBUCy1lYv5OZrAICK8cRrGXGW\nbAw7RIjSEHl6wt3UO5rO4qiCyrf1Ii6Xi0qaSkvfUpWMZwUdPrzGTuaKqKgyYsu63UdO6R7P\nujRaV1pY9ewHdZMwOkvXbf7K0JAlmhgPPzhbzeFwOlmzogLbmLIi7ZTvwjUX7xc3lxhZTQre\n+7unlSZ2oqRTAwAay8uF3ThsXOIqnK2Wk7GDmJB77EjaQ062AV2ZY7s2ssCGFwgAqMz7KeTm\n67HBp9aaV/t5LHb3vlQY79IlpSESHHBR1Wjhi4L9rKZcTVWLX9LzfDSZ5XfCzcdtdPa1lLkc\nKqryG97rj/S3KgaDeJy/9wAxOTM2rpJciDkVtXN5YmLms/QjqlhO3eFs9du3bwEAihzTcSPM\ncUiV1w6cYZ4X0jwrX2ZnPS8VUZW4Jv1MdNgd/7evg3RqAICillbrLW+YgbPVcjJ2EBTYa8Ek\nJB0zWJmhP+GM9DnFy5SuZFolkqAoenOeGYNt2VWlIaJCozRn3lqoqzz+arH0OXF2L52RR2Qu\n93CLNQBg3NoTbV+oJWmKXG0LALDZ9UTm0i3B2eo1/tN7azEBAEwtM/f5P0VfTYOyjxBWejPi\nOLVNp5G5dEuI2ZURE3JlneQbIOeDkDtlgPT5xPVS9T5B0pkbjrWGsP5xV5WGCANBkE9zY/Za\nzJKEj+kSLBaYVqRvlrnczr2ZTM70K7/MbDvHFcLw+jXJncN8uH2/zKVbgrPVIQejckurn6Qm\n/DRzRP6Vg9PHD1PrZugye3nE+dRKoUTmcq0Q1ddWV1dXV1efOHHiXum76tZU5aXGHz+2D7sG\nkE6NM8S0mqDAjixJ5BqNToNpM6xVFIzdr6Ao2lR9i4YgDtHPpOUXp/akM826qjRElvRgq5ku\nrxNLUBRNXzuQ3WOxtDz7N2sKvZvM5brRKcbTktuvc8PblMrQlrl0S3C2uhVFGUm7ghbbWnAB\nADRFzXHT5v12+nJpvRAjuct2Hd/vxNL2xkgdJZ0ad3C2Wk7GDmJC7rEjaQ852Qa0iWfoeHyq\nf+BqUco+CZUd7KQnEZTFHT/kF1/UfejBrioNkeWhvFDebl3j/+XnPzCZ51m7ZZXTMi2eMdiz\n5r6asYxTBAMAqABhdO9g7zadTUcljTKXbgnOVrfCYKDd8oF2yzeFvi1I4/P5cXFxiz0P/0Bl\nWzu53EyQffJY6OnNSKduSW1xyASfzNSk09hJ4Gy1nIwdBAV2ZEki18jJNiBRU/GPE82pCIJQ\nFHy23UNRtO71fgCAksaQixhnZoIoDZeUoxucRg0vaRKjKPrHfFsKggAAWLo2cUW1Mtfy1GR2\nM9vWfp2fjdWUuk+SuXQr8LS6fWqKM8NWTVWkIFj30rDSmxHWqe+e3L/cf87sz3G0UKfSsZ27\nwtlqORk7iAkZ2JF0hET4JDVh84rvBxmpAwAYqvqTZy07du7Ge4EY54YIqkrffVqZEn7IiTmf\n9AavNkCUlhMwzRL8V0B/BKHtul/xTxVKkn5GEKT3nBQs1NsB/9zIbwvSwreucbQ0pSAIhaps\n6eixNTwGN3X8IZpTF0ROBwDQWRwNFg0AwOVye+hyKAhCZ5r4hSRhrY7ibLXcjB1EgwzsSP4F\nOG8DIoFFvfDvUEZQe//azQc1IgyDG+GHnOFqClSFHuuPXK39XEgiqr4QtpJDp9JZ/f6qFWDX\nBhR3q1tS8iQ1dOMyu/56AAAKXX2Uy+y9xxOKa7C1V4qo6dVm38nmRlzttsChAYRilhZL1Whh\nlUgirM9Wp1EiyutRFC27fag7Uze+S68AkGMHnpAJikn+C83bgK79lY9isw0IYn5LwqbWhJgl\nuO7FZffxM/7Mr2ao6Y8YMcxIl6OICCpeP7+Xeru4RsDStY24dp7XVw0LaYhWF6YnxsbFxZ49\neze/gqakZT/Jlcdzc508RlORioVcm8R7mbqefKo3fPxYc/0v90IdPizLa+lJp1alU822Prq3\nwgIAsKgH++mxnCsOXADAdd/e3gWrX9/8XrZycmJ1S3AYO0jIwxMk/wUN02FzVw2b4ekRuW/T\njztib12IBEDGzgkxvyUxU2vCzRKsbOB0IfvFhT9CD53gp17lJ4skAACEomA2dNSqGXN+XDRd\nk4FJaAXR6kFG6g+Lqhgqeo5TPI9t57lMsFGDscn8x9gi7viwF1cW4qBNOnWrlDopCSXAgQuk\nKXVGbwZAxoGdnFjdEhzGDhJyKZbkX0O0bUAEQU6yBKMoikoElRWlJWVvG4Vtr4TuWB0gKymI\nVkt7YCpDsUNkLt2MRPwBAOB4/RV2EiQtgZtSBzrk2IEP5FIsSWd5nXUzNjY2LjY2ObOYQle3\nmeDC4/Hcpjhy2XQc1GsrSt+8r2wCCurdNHU4mN93JCfSeOKjrRwrmVj7JuqfZ8bEMzRVLtJ8\nal8fwLFdbTCErZBe2ySTj4Jotbe3dydrRkZGnC9/ugAAEzRJREFUylb6b1CRBZuJ+Cc/3jkC\nK4l/hoBOXRTna8Q7pmI4ID//gdLrnaqGqxyXBvOMwZ41G8v0g97lYJtVB5bVcMcOIgI7siSR\nd57fv7Z97YLhvTgAAJqSlsP0+QejrpY3iPBRr8q7tnaem4mOassvraqOidu8tYn51V1VGgpy\nkiW4MwxWZsjqo74hqzHiadQSFqPbhmOJbc9ZYgDBnRr/lDqwrIY7dhAZcsaOpD1abANy4/Hw\n3gaUfnih3YJDdWKJwUDbkUP6czXVGUBQVVGS+eB2akYRQmH5H0z5zW9wF5OGhSaDpjEnNfuA\ndTt17i4yHxn+WiysxK1VbSLDGbtvyGqMcHV1fZOeeLu4jsHm9DTUVfx8K2FGRoZs5UinbkVl\nYc6zOrq5ubESBZOuFZbVcMcOogM7siSRa6RfEijbgN492UVFEBUj53MPSr/8afmjBBcTVQSh\n7n7yritJQ0R+sgR3iAxn7OTE6qH/gKWVtf34yf7LN159/B4j6XHtIlst0qm9vLxiKj58WV6Z\nu2223zqZy0G0GuLYQULO2JG0B8RtQL8N0lySw7j15rmVStuXTQlr0000hzeYhb7JWNBlpCGS\ntnKA1c7snWmly4dotFnhdfIG7phNvb5Pzv19FM5ta4UMZ+zkxOq5c+fePh2RXS9kqOr0NdVX\nBILiZ9kllU0qJoN7qwiLcnPeNSmuic/+xVkPuzbgAGGdWlRfWy+SAADU1NQCMovX6bfa34bm\nxkwcsSBLLKySrS5Eq+ViCylhgR1ZkpC0TW8mXccmuv06fLseWFxfDVEaInKSJbgzyHDGTk6s\nfnrCm0JTXX8ipbG5CZKm1FMbNNgmx3IqxcLK3/z6MNhDmr7xO5kI69SX7Xp0OBaztL1lrkvM\nroyEzGNH0llm/7hl5syZDoMN8JHLbxCZD+tAS89aQ5TyuCtJQ4SmZHbtYbz7+Bmb5oz/9ce2\nswSfvnZ+mHKXOsgmJ1YHLDtrMvPCxpktJgURho3HzzH/O+PiuH7Wi1C/XccW/m51vLzeT5v1\n9XIrV67sZM3t27d/vVwzhHXq3gvW73CuBQAEBASMCwx2UldsVYFCU7Z295G5rlx1ZaL61/fu\nZLyqqOo1efoAWpWIwWGQm+4wAnZkSfLNoEBBAAAcs5HLNv+W9qwSazkAwIA199uvk7FhMBbf\nYYjS0JGIqs6Hb5o4apAK7WMCEISi0Mdy3Kpdp8ub5OWGRxnO2EmBbrUqjWL9W/aX5Xl/2FBo\naiiKSkS1AICA51UykYM1QJBObWdn9zuOV4fJidUoit49GMBV/DiRFFhUXXZ3opKm+bqIDtpG\n8t8gZ+xIOktVWS4/OurMmTP71i/au36RqdWEmTNnenq4mXRXgN00EpmBUFUnzQ2aNDcIoMKq\nd+8+iOndu3dT6OrH2aBbPZ3DjNkVVu+/j9XiaCQqaTi4LUup+yQAQN3rEwCAESqy8bUnT57I\n5HNI/i1JSUkAAAAkJfkPs5+XNohpOkZ9hvTVx+RaFbmh/Pa6kQt26tr4HPZ3mevlBgBgG875\nzmD+L7MtG7nF28fowm5gV4MM7Eg6iyKnl8eiII9FQXWvMmOios6cObNhycwNSxUtHXmeM2fO\nmOqgqSDjCy6rcq/Hxha1U6EwW8Z7jeVBWl5A6Goa2phczirPQLJ648mlx8Zt6Wn5atV898G9\nDRSA4GXeg5jw7fz8ujXXfq3M2j9hzCpVY3/X7q2X8P4b5ubmMvmc/wDp1E//DJ21bOPtgvfN\nJWomIzbti1zs1BMLOXmwOnRWGFPPOz/5mCIFzPUCAACmluvZO2PnGuuFf797e5Esl/tJAOiK\na0kkuFH2INbZvJv0i0RV4Dh6Lj79v3xZfTjE7zDpPqKmV5t9J5sbcbXbAlPpWSt+uZpe1H6d\n2COHMW0DFAoS9lgbfxZSMnUHbj+fh6Jo0TmHvjYeae8bYbfxayGduuJBiAIFYWoPDdgSGnv+\nz0sX4sO2rrbUZSEUpR2PsMo5At1qNRrFas+T5iYFFn3Mipy1fzgRLlLDH3LGjuRf01Cee54f\nz+fHXbieXi+WqOgPcOPxdOofnjx9yOPUvrhdj6KX9/96lWPHjn39h3xz0nJCwvd2QSef6g0f\n72Suj/My7Jk96yJ2BXLMRs6cOXOmp8fQnm1Mn7l974drm3DBxHnpbefFzx7dzcx/WS+mahuY\njbSykCatNZh0JWuyLH8Ntra2nayZmpoqQ13SqQ9M30pRH59ZeNFY8dP6xkQX/yX+k/TMf5l+\n6Mfcn2QrJydWq9Eowmrhl+WN5Y0UijL+7enykHnsSDrLu6f3+Xw+n8+/ejdXhKIappY8Ho/H\n440baiwdcySCN2stzXc/69FU+xByW0m+DmMlumDU3pdXFuK/t66xIl+6lfPirRwJAATZymk9\nafYsHx8PN3tVKh6vHFZgR6KrQNNdn34/cECr8sfbLQcFlYgaS6C0Cmt+G6K14lmvnLJkI0Uq\ngiCBRdXBBirC2ix77pA8w60Vj5bCbmBXgwzsSDoLgiAAAF1zW2k8N7o/98s6dxeaj4oAgvos\n3FtHIjNQSQOFynS8/urymI6Tb2FH81bOa+mFAMFwK6c80F2B9l4gZrD1J3t6+cya5Wzdq4sf\nVyEq2go0vQ0P0n5qvabxZLfVwDUvRE1lUFqFNbUvIo1NfT9oWC3+YcavgUt4B47aV2aG7zzw\npIYZnlM4x1gFdgO7GmRgR9JZVm45yOPxhvfmtFdJIpEAhILNpYdykQZJ0pB8+eI7qs6oMdYc\nehc9yoaKLNhMxD/58c4RsJsCAADlGXF+3nMvZL0HAFAVOON4M2b7LZ5hbwq7XbJE3Pjmf+fi\nomOi+Qk33gnE3UysvH18fHy8Bht08TEPolNDkf7ZWH1HrW1uMV+vxd8nYkHJNP1eSayAymcb\nsW4ArBdekXbKd+Gai/eLm0uMrCYF7/3d00oTD3miAXmPHwlJ54CVBkksKNvi62ja00H6r59s\nPp7MVzGeeK+mCWt1WDyNWsJidNtwLFEA76qDD2U5Zw6EuI8fxqJSAAAq+gNmL9/00zw3fTYD\nADBt1yNoLcMSUeObq2cOzOWN6c6gIgjVYrTbtj/OQWlJzcstNnYzMJWAmNsMlvSbtGAFCqJs\nYLNu56ELlxOvXb4QvivI1oCNUBib095grQ49mdz7F1mpSYlJN24VvK7BTZSAkIEdSaeQCN/1\nNjX1uloMRb3sViAVQfRsZx0+ESftkurL4tyGaSIIJeB6CabSf3qbAgBseIEoir7PXQUAGBt8\n6jr/gJEizdAlHlNpiEyZMmWEnjIAgMHmmPUbMPBzMJV+W5B2eNvaCdZ9aAgCANAwtfRfs/Vq\n2tPmCFPcVL56gAZDeQCmzYCO8MOLbfMdqQiCw5/fd0/uX+4/Z/bnOFqoU+ka2IlCdGqcpc3M\nzFx2Pmn+Z965HcMMP5uIZRsM3R6fK3PdVkB84cOdZx2Ivl4l+sZvxPt2IAM7ks4yh8s28bgC\nRXqtiRpb36dBjKItTstLRNVzDFRUDAIwlR6szNCfcEb6nOJlSlcylXZPN+eZMdiWmEpDZFy7\nYCotHep0zW0Xr9+T/KjtPyTuLOhLZ/bFtBmwEAve3zgXsXz2FCN1BQAAg63nMnsFpooFkdMB\nAHQWR4NFAwBwudweuhwKgtCZJn4hSdjpQnRqnKXBl9c/SIRPH91KiD97Nj7h1sOnQlwCHogv\nvBuDCgBgsPWn+q89fzuPjO+whgzsSDpL9dO4QRxOcPRdfLqhlkBMg6REQUaE50if5+ooaw4+\nLn3OO2qDUJQwlSYmAb8cuJPb0ZqUWCwWd6nRQVD98kLkvjluYziKNAAAnaXr7L30eMKtWuwn\nOWZpsVSNFlaJJML6bHUaJaK8HkXRstuHujN147G8/AqiU+Ms3UZgBwOIL1zUUH71zAE/nn13\nBhUA0M3EaummsPRPDSCROWQeO5LO4r8uuqdlj3XTh29W79HLQEuB9tnRgbS0NOykIaZBGqjM\nKL/+Esw1E9TcPlpWb793pLT86cXXNMUObtcm+Q9sXzu/40oUShc7t6LezbBeLKEpaY9z83ef\n7u7qbINP3hMAAP9dg9mqBapUBDD7eGgyTz567+PA1LKeFzV9pzfvjMvN7zHShejUxEyrBtFq\nqqKmg/t8B/f5B5sq/hcfGxMTcyJ4SejPS8xHufjMmrXSdzKm6gSEDOxIOktZWRkAanZ2dvhL\nr+zbbcWuxYWrko0U/z5KJqzNWrI3R633VkylN/EMHY9P9Q9cLUrZJ6Gyg530JIKyuOOH/OKL\nug89iKk0zjg4ONAUDS4l/C59bqfmtWvXZCtNplUbMXWe+3R3t8mj1Gl4h6wMBEE+BZH2WsyU\nhBLgwAUAWCwwrRi9GQCsAjuITo2/9Ju7EVu3JnZYbfXq1VioS4H4wpuhKnCkEd5vDS93r5j3\n0yH+qpS4lb5kag4ZQwZ2JJ3l0/XVEPCO27HB1Ldfz1GLf5gBAMi9FBcmTYPUwAqP88VU2v5g\n4vI3TntCgiQIw/vXG5Zsen1p7LS5G5Q0hpyKn4mpNM5UVVXRFNWlz3V1dXAbQzSunjnwZeGH\n0uy4mJjomOjzqRgmhvTUZB4PO1K/eCeLgvT8TvdlxEkQagUAeJ/+XiKuwU4XolPjL12avG9N\ncsfVMA3sIL7wZiTCyluXEvh8fvy5S4WVTQy2njNvGj7SxAL2WjDJNw8OaRFQFH3z18mJQ/Va\nfnWNrCadvFuOta4UQVXpu3qh9Fn4ISfmfNIbgRgfaRKi8aE0+0Toxsm25tJzwVj30oWxswEA\nKoYDygTi6qJtAADHpcHhocF9mfRuZpswlYbo1HhKAwBMvH6/2QmwUG8JrBcOcQspMSFn7Ej+\nBfdOhUXdyKhsErcsLL1/7k4etpcBSC9cOnn3haQkJ+t5qYiqxDXpZ6LDxlS0JQhNknP7yqes\nnt0nO5tByI1MAFDR+z59hw8L+1+kQxv3mnRtGspz+WdjoqOj/0zNEqIoAIDbb7S7u7u7uzum\nuoZuR1OOGoYcvSxGgYrByj/mJ/iFBl1BUZauTeTl5djpQnRq/KVZ3IEjRw7B7vM7A8QXDnEL\nKUGBHVmSfDPASouAwj4tDz2rJz5odBpMmwExqw4UGspzT4Vtdh3dn/5pfk6dowgAuJVTBqtJ\n759np2UWfMD43DFEp8ZZGsjHqViIL9zBff7vsUnvheQqB06QgR1JZ4GVFgGFeloeYlZPnJFG\nFYocU2eXKe2DaTMgZtXBmdO/BbvZDaBTEAAAQqFb2DgHbj/8V/6bp2dG4/knt5eXV0zFhy/L\nK3O3zfZbh50uRKfGWVpOAjsy5whxIO+KJeksqnSq2dZH91ZYAAAW9WA/PZZzxYELALju29u7\nYPVrzNIitET86bR8XELKeyHA4bR8oKn6PsHkN4URihSAIEhgUXWwgQoqrplrrBcD5lUXbcdO\nGmd+mu/Oj7+QV/6BqWU2ydWV5+bmPHaIEjbX/raDh4eHsDY39uJDBdyz6uAMgiAAgIETvL15\nU1wmTzTWUJCWP4uyM5mRgnXPLKqvrRdJAABqamoBmcXr9FstyaG5MRNHLMgSC6swbQaA4dQ4\nS/v6+upN/HnTVEPZfux/Bh+rIZ6yJyEDO5LOwmHQjLc/urvUHABwdrDWBpvzT0KtAADlfzlz\nR2cJGwrxbIzo42n5q9LJfeyE1OnU3jsypVY3B3YAgOww637L88WCd9hJQwAVZd26zOfz4/j8\njMJKhqq+0xQ3Nze3yd+NVKfjlIbD3t6+nZ9CPJotc2gUihhF6Wy979ymTps+bYrjcGUqAvAK\n7K7Yc52SS9qvw9L2ris9jmkzWoKbU8uVNEQwtXrYsGE0RaM7qdEAAGtr63Zq3rlzR7bSJOTh\nCZLOAistQkvwPy1PrFymCM3cxtncxnndziMvHibHxcXx+WdnR+yhKWraTZri5ubmOnmsNhPb\nTqMrhW7tU/XyYUxUdFRUVMLxPecjdjdHeP3EeAQWvRes3+FcCwAICAgYFxjspK7YqgKFpmzt\n7oNDSyCmwCBm9g18rG45uU6GbniD/+ovyTcKxLQIEE/Lhw3WVFC1ed4gQlvcwyOoeTJSRUGj\n/x6s1eWBivy/wrf+5GTVm4ogFJrKSGdv2C3qalQ+v38oZNWYgR8vMpGmCz4Qff09Lil17Ozs\nfsd4j2ybQHRqYmbfgGg1rH2chIVciiX5F9w4tjHk6OUj127pMihHF4zyO3RTIk2LcPuSqwGG\n01fKNOrH0/KuPJxPy9e+iDQ29f2gYbX4hxm/Bi7hHThqL83qWcMMzymcY6yCTzOgU/vqceS+\nTT/uiG2UoJh2GoMGDWrnpxkZGdhJQ+dt/r0zZ85ERUXdzC4FANCUdJymzfD09PRwHIq9uKQk\n/2H289IGMU3HqM+QvvpYL71DdGqI0hDB32r52cdJOCAHliTfMvikRUBhn5aHmxsZLm8L0sK3\nrnG0NKUgCIWqbOnosTU8BlNF51ZMdBrc1xAAQGXozF+yDFNp+aHk8Y1d6xZZ9dLAp5cuuLh3\nhGm3lt9wNZMRoZeeYSoK0amJmX0Df6sv2/XoMAJhaZMrALLn/2BLeWjgFjXUAAAAAElFTkSu\nQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "heatmap(cor(subset(new_activity_merged_final, select = -ActivityDay)))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "23ac827d",
   "metadata": {
    "papermill": {
     "duration": 0.046257,
     "end_time": "2023-07-13T02:42:23.548895",
     "exception": false,
     "start_time": "2023-07-13T02:42:23.502638",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "We prepared the data for analysis.\n",
    "In this notebook, we showed how to handle the collinearity problem\n",
    "and the different ways for null values imputation"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "b1bc9a70",
   "metadata": {
    "papermill": {
     "duration": 0.045479,
     "end_time": "2023-07-13T02:42:23.641155",
     "exception": false,
     "start_time": "2023-07-13T02:42:23.595676",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 153.420973,
   "end_time": "2023-07-13T02:42:23.807861",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-07-13T02:39:50.386888",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
