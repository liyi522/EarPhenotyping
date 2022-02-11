# Ear Phenotyping

**发布日期** 2021-9-18

**版本** V1.0.0

**作者** Li yi, liyi@big.ac.cn

**依赖** Linux; openCV; R (>= 3.1.0), R packages (data.table;shapes)

**功能描述** The pipeline can help you cut the ear from face profile photo and locate 55 landmarks from the input ear profile photos, extract coordinates of 17 special landmarks, and calculate 136 ear phenotypes. Details see in this article: #############。



## Steps:

#### 1. Installation of openCV

+ Download installation package:

  (We used the OpenCV 3.4.0) (https://opencv.org/releases/page/3/)

+ Execute these command:

  ```shell
  unzip opencv x.x.x
  cd opencv x.x.x
  mkdir build && cd build
  cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/YourPath/opencv34 -D WITH_TBB=ON -D WITH_V4L=ON -D BUILD_TIFF=ON -D BUILD_EXAMPLES=ON -D WITH_OPENGL=ON -D WITH_EIGEN=ON -D WITH_CUDA=ON -D WITH_CUBLAS=ON ..
  make -j4
  make install
  ```

- Setting environment variables:

  - Add library path

    ```shell
    vi /etc/ld.so.conf.d/opencv.conf
    ##input:/usr/local/lib
    ##save and exit.
    ```

  - Add environment variables

    ```shell
    vim ~/.bashrc
    ##Add the following information to the back of the file. There is a small problem here. It is better to put the path of opencv after the path of cuda
    ##input:
    ## PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/yourPath/opencv/lib/pkgconfig
    ## export PKG_CONFIG_PATH
    ## export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/yourPath/opencv34/lib64/
    source ~/.bashrc
    ## Update the system library cache
    ldconfig
    ```

- Test.

  ```shell
  pkg-config --modversion opencv 
  ## If the version number is displayed, the installation and configuration is complete.
  pkg-config—cflags opencv
  ## If there are no errors, the installation was successful.
  pkg-config—libs opencv
  ## If there are no errors, the installation was successful.
  ```



#### 2. Installation of punctuation program

+ Please copy the folder named ‘landmark’ to your directory

+ ```shell
  cd your-directory/landmark
  g++ -std=c++11 your directory/landmark/demo5.cpp -o demo5 `pkg-config --cflags --libs opencv`
  ## If there are no errors, the installation was successful.
  ```



#### 3. Extract landmarks’ coordinates

+ Create the input ear photos folder and the corresponding output folder

+ Add execute permissions to all files in landmark folder and modify the typical information in the `PerformSample_newest.R` script.

+ Use of `PerformSample_newest.R`

  - Description of input ear images:

    Ear images which should not include too many non-ear parts. (All background region of the following 3 examples are ok, but the first is best. Note: you can manually cut the accurate ear images from the raw images based on Matlab, the `getEarPicture.m` is useful and user-friendly.)

    ![examples-background region](G:\facial_features\EAR\EarLandmark\method\ear-landmark-method-new\pipelined\photo\examples-background region.png)

  - Description of output ear images:

    Examples of output files all in the folder: out-example

    `fileIDlist.txt`: This file records the names of all the input images (without suffixes).

    `All_Sample_ladnmarks.txt`: This file records the coordinates of 55 landmarks of all the input images (It is in the same order as the fileIDlist.txt.)

    `sample1_landmarks`: The coordinates of 55 landmarks for each input image.

    `sample1_eng5raw.PNG`: Intermediate files. The pre-processed image.

    `sample1_point.PNG`: The 55 landmarks are showed in the pre-processed image which cannot be converted to the original input image because of the incomplete information.

    `Sample1_num.PNG`: The only difference between it and the sample1_point.PNG file is the order of points added ( 0 ..54 represents that 1..55). 

  

#### 4. Quality control of output results

​    Please extract all the sample1_point.PNG files and sample1_landmarks and save them to a new folder, browse through them one by one and delete two files of samples with inaccurate landmarks (If you just focus on the accurancy of 17 landmarks is OK).



#### 5. Follow-up analysis

​    The folder created from step 4 can be used to extract the coordinates of samples left, GPA analysis (R package "shapes") and calculate the euclidean distance for pairs of 55 landmarks. Then, the 17 landmarks were selected as listed in the Selected17Landmarks.xlsx file. Finally, the 136 Euclidean distances derived from pairs of 17 landmarks were normalized (Z-score transformed) for the subsequent GWAS analysis. (More details please see and cite the article: ####### )
