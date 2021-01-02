# MRI_Brain_Image_Processing

Image Processing
                                               M. Boddam, E. Lockhart, D. Toghani
Bioinstrumentation Laboratory
Department of Bioengineering, University of Washington, Seattle

## Introduction
Presently, there are multiple ways to image a living being’s internal organs, namely imaging with x-rays, computed tomography, nuclear medicine, ultrasound, magnetic resonance, and more. In this lab report, our goal is to explore and understand magnetic resonance image processing techniques. Most of the techniques we use below can be applied to images from other modalities too. Following is a description of the processing technique.
First, we processed simple wave images to understand those techniques. Then, we processed a MRI. The technique starts with taking a spatial (2 - dimensional) fourier transform of the array of pixel values in an image. This produces horizontal and vertical spatial frequency arrays and an array of magnitude values mapped to those spatial frequency arrays. We didn’t observe the phase plots in the spatial frequency domain because they don’t give us the information required for our analysis. In this spatial frequency domain, we constructed a 2-D magnitude plot called k-space where the x-axis is horizontal contribution frequencies and y-axis the vertical contribution frequencies and the intensities of colors at each point of intersection, the magnitude. We then applied various filters to this plot. We reconstructed an image from this filtered spatial frequency magnitude plot. Comparing this with the original image helped us analyze how different filters affect an image. 
