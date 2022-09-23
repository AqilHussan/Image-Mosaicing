1.Image mosaicing is the alignment and stitching of a collection of images having overlapping regions
into a single image. In this assignment, you have been given three images which were captured
by panning the scene left to right. These images (img1.png, img2.png and img3.png) capture
overlapping regions of the same scene from dierent viewpoints. The task is to determine the
geometric transformations (homographies) between these images and stitch them into a single image
.........................................................................................................

	1.1 Getting Started

		. Run the "Image_mosaicing" Matlab code
		. "BilinearInterp","RANSAC","sift_corresp" are functions.


2.Use your mobile phone camera to capture images (three or more), and run your code to generate
the mosaic. Ensure that there is adequate overlap between successive images, and the camera is
imaging a far-away scene (think why). Bring down the resolution of the input images such that the
width < 1000 pixels, and convert them to grayscale before using them for mosaicing. (In MATLAB,
use `imresize' to reduce the image resolution, and `rgb2gray' for conversion to grayscale)
................................................................................................

	2.1 Getting Started

		. Run the "MyOwnData" Matlab code
		. "BilinearInterp","RANSAC","sift_corresp" are functions.