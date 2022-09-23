function V=BilinearInterp(i,j,srcImage)
imagesize=size(srcImage); %%Find the size of the image%%
V=0;                        %Defining the defult value 
%%%Find X' Y'%%%%
x=floor(i);
y=floor(j);
%%%#Find the deviations from the actual point%%%
a=i-x;                                       
b=j-y;
if (x>1)&&(x<imagesize(1))&&(y>1)&&(y<imagesize(2)) %%Check whether cordinates  falls within the corresponding image bounds
%#Applying bilinear nterpolation
V=(1-a)*(1-b)*srcImage(x,y)+(1-a)*(b)*srcImage(x,y+1)+(a)*(1-b)*srcImage(x+1,y)+(a)*(b)*srcImage(x+1,y+1);
end