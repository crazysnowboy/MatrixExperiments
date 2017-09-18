function SaveMat2Txt(file,Mat)

    disp(file)
    fid = fopen(file,'wt');
    [row,col]=size(Mat);
    for h=1:row
        for w=1:col          
            fprintf(fid,'%6.4f ',Mat(h,w));
      
        end
        fprintf(fid,'\n'); 

    end
    fclose(fid); 
end
