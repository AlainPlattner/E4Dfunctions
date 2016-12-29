function boundaryTopo(fname,outname,depth,bptsIn,bptsOut)
% boundaryTopo(fname,outname,depth,bptsIn,bptsOut)
% 
% Prepares the bounding boxes depending on the electrode point files.
% This does not work well with topography. For topography we need to find
% the bounding points ourselves, otherwise we mess up topography
%
%
% INPUT:
%
% fname         filename containing the points (topo, elec, etc)
% outname       filename to write the outer boundary points
% depth         min z value minus depth will be the bottom of the inner 
%               grid zone
% bptsIn        4x3 matrix containing the 4 boundary points for the inner 
%               zone [x y z] values
%               They need to be in sequence to draw a rectangle!!!
% bptsOut       4x3 matrix containing the 4 boundary points for the outer 
%               zone [x y z] values
%               They need to be in sequence to draw a rectangle!!!
%
% Last modified by plattner-at-alumni.ethz.ch, 1/10/2016

[nr,xp,yp,zp,flag,st1,st2]=textread(fname,'%d %f %f %f %d %s %s\n');


fout=fopen(outname,'w');

% Print grid depth:
% Outer zone boundary
%fprintf('%f  bottom of inner Zone mesh elevation (m_bot)\n',min(zp)-max(paddingZ2,depth));
flag=2;
fprintf(fout,'%d %f %f %f %d    Outer Zone control point\n',max(nr)+1,bptsOut(1,1),bptsOut(1,2),bptsOut(1,3),flag);
fprintf(fout,'%d %f %f %f %d    Outer Zone control point\n',max(nr)+2,bptsOut(2,1),bptsOut(2,2),bptsOut(2,3),flag);
fprintf(fout,'%d %f %f %f %d    Outer Zone control point\n',max(nr)+3,bptsOut(3,1),bptsOut(3,2),bptsOut(3,3),flag);
fprintf(fout,'%d %f %f %f %d    Outer Zone control point\n',max(nr)+4,bptsOut(4,1),bptsOut(4,2),bptsOut(4,3),flag);


% Inner zone boundary here from the given points
% Overwrite the loaded x and y and z points with the provided boundary
% points
% xp=bptsIn(:,1);
% yp=bptsIn(:,2);
% zp=bptsIn(:,3);
% %paddingZ1=0;
% % find smallest x and y points
% [minx,minx_ind]=min(xp);
% [miny,miny_ind]=min(yp);
% [maxx,maxx_ind]=max(xp);
% [maxy,maxy_ind]=max(yp);

% Smallest, second smallest, largest, second largest
%[xsrt,indx]=sort(bptsIn(:,1),'ascend');

fprintf(fout,'\n');
% Inner zone boundary
% Surface
flag=1;
% Minx point 
fprintf(fout,'%d %f %f %f %d    Inner Zone control point Surface\n',max(nr)+5,bptsIn(1,1),bptsIn(1,2),bptsIn(1,3),flag);
% Maxx point 
fprintf(fout,'%d %f %f %f %d    Inner Zone control point Surface\n',max(nr)+6,bptsIn(2,1),bptsIn(2,2),bptsIn(2,3),flag);
% Miny point 
fprintf(fout,'%d %f %f %f %d    Inner Zone control point Surface\n',max(nr)+7,bptsIn(3,1),bptsIn(3,2),bptsIn(3,3),flag);
% Maxy point 
fprintf(fout,'%d %f %f %f %d    Inner Zone control point Surface\n',max(nr)+8,bptsIn(4,1),bptsIn(4,2),bptsIn(4,3),flag);


fprintf(fout,'\n');
% Depth
flag=0;
% Minx point 
fprintf(fout,'%d %f %f %f %d    Inner Zone control point depth\n',max(nr)+9,bptsIn(1,1),bptsIn(1,2),bptsIn(1,3)-depth,flag);
% Maxx point 
fprintf(fout,'%d %f %f %f %d    Inner Zone control point depth\n',max(nr)+10,bptsIn(2,1),bptsIn(2,2),bptsIn(2,3)-depth,flag);
% Miny point 
fprintf(fout,'%d %f %f %f %d    Inner Zone control point depth\n',max(nr)+11,bptsIn(3,1),bptsIn(3,2),bptsIn(3,3)-depth,flag);
% Maxy point 
fprintf(fout,'%d %f %f %f %d    Inner Zone control point depth\n',max(nr)+12,bptsIn(4,1),bptsIn(4,2),bptsIn(4,3)-depth,flag);


fprintf(fout,'\n');
% Case 1

fprintf(fout,'5   number of internal planes\n');
fprintf(fout,'4 10   number of points, boundary number\n');
fprintf(fout,'%d %d %d %d\n',max(nr)+5,max(nr)+6,max(nr)+10,max(nr)+9);
fprintf(fout,'4 10   number of points, boundary number\n');
fprintf(fout,'%d %d %d %d\n',max(nr)+6,max(nr)+7,max(nr)+11,max(nr)+10);
fprintf(fout,'4 10   number of points, boundary number\n');
fprintf(fout,'%d %d %d %d\n',max(nr)+7,max(nr)+8,max(nr)+12,max(nr)+11);
fprintf(fout,'4 10   number of points, boundary number\n');
fprintf(fout,'%d %d %d %d\n',max(nr)+8,max(nr)+5,max(nr)+9,max(nr)+12);
fprintf(fout,'4 10   number of points, boundary number\n');
fprintf(fout,'%d %d %d %d',max(nr)+9,max(nr)+10,max(nr)+11,max(nr)+12);



% % Now write planes for inner zone
% fprintf(fout,'5   number of internal planes\n');
% fprintf(fout,'4 10   number of points, boundary number\n');
% fprintf(fout,'%d %d %d %d\n',max(nr)+7,max(nr)+6,max(nr)+10,max(nr)+11);
% fprintf(fout,'4 10   number of points, boundary number\n');
% fprintf(fout,'%d %d %d %d\n',max(nr)+6,max(nr)+8,max(nr)+12,max(nr)+10);
% fprintf(fout,'4 10   number of points, boundary number\n');
% fprintf(fout,'%d %d %d %d\n',max(nr)+8,max(nr)+5,max(nr)+9,max(nr)+12);
% fprintf(fout,'4 10   number of points, boundary number\n');
% fprintf(fout,'%d %d %d %d\n',max(nr)+7,max(nr)+5,max(nr)+9,max(nr)+11);
% fprintf(fout,'4 10   number of points, boundary number\n');
% fprintf(fout,'%d %d %d %d',max(nr)+10,max(nr)+12,max(nr)+9,max(nr)+11);







% fprintf(fout,'\n');
% % Surface
% flag=1;
% fprintf(fout,'%d %f %f %f %d    Inner Zone control point surface\n',max(nr)+5,bptsIn(1,1),bptsIn(1,2),bptsIn(1,3),flag); 
% fprintf(fout,'%d %f %f %f %d    Inner Zone control point surface\n',max(nr)+6,bptsIn(2,1),bptsIn(2,2),bptsIn(2,3),flag); 
% fprintf(fout,'%d %f %f %f %d    Inner Zone control point surface\n',max(nr)+7,bptsIn(3,1),bptsIn(3,2),bptsIn(3,3),flag);
% fprintf(fout,'%d %f %f %f %d    Inner Zone control point surface\n',max(nr)+8,bptsIn(4,1),bptsIn(4,2),bptsIn(4,3),flag);
% 
% 
% 
% fprintf(fout,'\n');
% % Depth
% flag=0;
% fprintf(fout,'%d %f %f %f %d    Inner Zone control point depth\n',max(nr)+9,bptsIn(1,1),bptsIn(1,2),bptsIn(1,3)-depth,flag);
% fprintf(fout,'%d %f %f %f %d    Inner Zone control point depth\n',max(nr)+10,bptsIn(2,1),bptsIn(2,2),bptsIn(2,3)-depth,flag);
% fprintf(fout,'%d %f %f %f %d    Inner Zone control point depth\n',max(nr)+11,bptsIn(3,1),bptsIn(3,2),bptsIn(3,3)-depth,flag); 
% fprintf(fout,'%d %f %f %f %d    Inner Zone control point depth\n',max(nr)+12,bptsIn(4,1),bptsIn(4,2),bptsIn(4,3)-depth,flag);
% 
% 
% fprintf(fout,'\n');
% Now write planes for inner zone
% fprintf(fout,'5   number of internal planes\n');
% fprintf(fout,'4 10   number of points, boundary number\n');
% fprintf(fout,'%d %d %d %d\n',max(nr)+7,max(nr)+6,max(nr)+10,max(nr)+11);
% fprintf(fout,'4 10   number of points, boundary number\n');
% fprintf(fout,'%d %d %d %d\n',max(nr)+6,max(nr)+8,max(nr)+12,max(nr)+10);
% fprintf(fout,'4 10   number of points, boundary number\n');
% fprintf(fout,'%d %d %d %d\n',max(nr)+8,max(nr)+5,max(nr)+9,max(nr)+12);
% fprintf(fout,'4 10   number of points, boundary number\n');
% fprintf(fout,'%d %d %d %d\n',max(nr)+5,max(nr)+7,max(nr)+11,max(nr)+9);
% fprintf(fout,'4 10   number of points, boundary number\n');
% fprintf(fout,'%d %d %d %d',max(nr)+10,max(nr)+12,max(nr)+9,max(nr)+11);





fclose(fout);




